package com.ljh.footballaround.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ljh.footballaround.dto.Attr;
import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.dto.Punishment;
import com.ljh.footballaround.dto.ResultData;
import com.ljh.footballaround.service.AttrService;
import com.ljh.footballaround.service.MemberService;
import com.ljh.footballaround.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private AttrService attrService;
	@Autowired
	private AttrService adminService;

	@RequestMapping("/usr/member/join")
	public String showWrite() {
		return "member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	public String doWrite(@RequestParam Map<String, Object> param, Model model) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		ResultData checkLoginIdJoinableResultData = memberService.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));
		ResultData checkNicknameJoinableResultData = memberService.checkNicknameAbleToUse(Util.getAsStr(param.get("nickname")));
		ResultData checkEmailJoinableResultData = memberService.checkEmailAbleToUse(Util.getAsStr(param.get("email")));

		

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}
		
		if (checkNicknameJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkNicknameJoinableResultData.getMsg());
			return "common/redirect";
		}
		
		if (checkEmailJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkEmailJoinableResultData.getMsg());
			return "common/redirect";
		}

		int newMemberId = memberService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	@RequestMapping("/usr/member/login")
	public String showLogin() {
		return "member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	public String doLogin(String loginId, String loginPwReal, String redirectUri, Model model, HttpSession session) throws ParseException {
		String loginPw = loginPwReal;
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("redirectUri", "/usr/member/login");
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("redirectUri", "/usr/member/login");
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}
		
		Attr attr = attrService.get("member__" + member.getId() + "__extra__AccountSuspension");
		if (attr != null) {
			Date now = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Calendar cal = Calendar.getInstance();
			cal.setTime(now);
			Date valueDate = format.parse(attr.getValue());
			if (valueDate.after(now)) {
				model.addAttribute("redirectUri", "/usr/home/main");
				model.addAttribute("alertMsg", "["+attr.getValue()+"] 까지 활동이 정지된 회원입니다.");
				return "common/redirect";
			} else if (valueDate.before(now)) {
				attrService.deleteAttr(attr.getId());
			}
		}

		session.setAttribute("loggedInMemberId", member.getId());

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("%s님 반갑습니다.", member.getNickname()));

		return "common/redirect";
	}

	@RequestMapping("/usr/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUri) {
		session.removeAttribute("loggedInMemberId");

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/myInfo")
	public String showMyInfo(HttpSession session,  Model model) {
		
		int memberId = (int)session.getAttribute("loggedInMemberId");
		List<Punishment> pnsh = memberService.getPunishment(memberId);
		
		if (pnsh.size() > 0) {
			model.addAttribute("punishments", pnsh);
		}
		
		return "member/myInfo";
	}
	
	@RequestMapping("/usr/member/checkPw")
	public String checkPw() {
		return "member/checkPw";
	}
	
	@RequestMapping("/usr/member/doCheckPw")
	public String doCheckPw(String loginPwReal, String redirectUri, Model model, HttpSession session) {
		String loginPw = loginPwReal;
		int memberId = (int)session.getAttribute("loggedInMemberId");
		Member member = memberService.getMemberById(memberId);

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/usr/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("비밀번호가 확인되었습니다."));

		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/modify")
	public String modifyMember() {
		return "member/modify";
	}
	
	@RequestMapping("/usr/member/doModify")
	public String doModifyMember(@RequestParam Map<String, Object> param, Model model, HttpSession session) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");

		String loginPw = (String)param.get("loginPw");
		
		// 암호화된 공란을 다시 ""로 변경
		String sha = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
		if (loginPw.equals(sha)) {
			loginPw = "";
			param.put("loginPw", loginPw);
		}
		
		String nickname = (String)param.get("nickname");
		int memberId = (int) session.getAttribute("loggedInMemberId");
		param.put("memberId", memberId);
		
		if (nickname.length() > 0) {
			ResultData checkNicknameJoinableResultData = memberService.checkNicknameAbleToUse(nickname);

			if (checkNicknameJoinableResultData.isFail()) {
				model.addAttribute("historyBack", true);
				model.addAttribute("alertMsg", checkNicknameJoinableResultData.getMsg());
				return "common/redirect";
			}
		}
		
		int id = -1;
		id = memberService.modifyMember(param);
		
		if (id == -1) {
			model.addAttribute("alertMsg", String.format("정보수정에 실패하였습니다."));
			return "common/redirect";
		}

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("alertMsg", "정보수정에 성공하였습니다.");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/findId")
	public String findId() {
		return "member/findId";
	}
	
	@RequestMapping("/usr/member/doFindId")
	public String doFindId(@RequestParam Map<String, Object> param, Model model) {
		String name = (String)param.get("name");
		String email = (String)param.get("email");
		
		Member member = memberService.getMemberByNameAndEmail(name, email);
		
		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "입력하신 정보가 올바르지 않거나, 존재하지 않는 회원입니다.");
			return "common/redirect";
		}
		
		memberService.sendFindId(member);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "입력하신 이메일 주소로 회원님의 ID가 발송되었습니다.");

		return "common/redirect";
	}
	
	@RequestMapping("/usr/member/findPw")
	public String findPw() {
		return "member/findPw";
	}
	
	@RequestMapping("/usr/member/doFindPw")
	public String doFindPw(@RequestParam Map<String, Object> param, Model model) {
		String loginId = (String)param.get("loginId");
		String name = (String)param.get("name");
		String email = (String)param.get("email");
		
		/* 입력한 내용의 회원이 있는지 확인 */
		Member member = memberService.getMemberByLoginIdAndNameAndEmail(loginId, name, email);
		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "입력하신 정보가 올바르지 않거나, 존재하지 않는 회원입니다.");
			return "common/redirect";
		}
		
		/* 임시비밀번호 생성, 임시비밀번호 암호화, attr 이름 생성 */
		String tempPw = Util.getTempPassword(10);
		String tempPwSHA = Util.sha256(tempPw);
		String attrName = "member__"+ member.getId() + "__extra__tempPw";
		
		/* 현재 비밀번호를 찾는 유저의 임시비밀번호 발급 기록이 있는지 확인. 
		 * 기록이 있으면 업데이트로 밸류값만 변경, 기록이 없으면 새로 생성*/
		Attr attr = attrService.get(attrName);
		if (attr == null) {
			attrService.setValue(attrName, tempPwSHA);
		} else {
			attrService.updateValue(attrName, tempPwSHA);
		}
		
		/* 이 유저의 비밀번호를 임시비밀번호로 변경, 이메일로 임시비밀번호 발송 */
		memberService.changePwToTempPw(member, tempPwSHA);
		memberService.sendFindPw(member, tempPw);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", "입력하신 이메일 주소로 회원님의 임시비밀번호가 발송되었습니다.");

		return "common/redirect";
	}
}
