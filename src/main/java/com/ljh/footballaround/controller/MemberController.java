package com.ljh.footballaround.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.dto.ResultData;
import com.ljh.footballaround.service.MemberService;
import com.ljh.footballaround.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;

	@RequestMapping("/member/join")
	public String showWrite() {
		return "member/join";
	}

	@RequestMapping("/member/doJoin")
	public String doWrite(@RequestParam Map<String, Object> param, Model model) {
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		ResultData checkLoginIdJoinableResultData = memberService.checkLoginIdJoinable(Util.getAsStr(param.get("loginId")));
		ResultData checkNicknameJoinableResultData = memberService.checkNicknameAbleToUse(Util.getAsStr(param.get("nickname")));

		if (checkNicknameJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkNicknameJoinableResultData.getMsg());
			return "common/redirect";
		}

		if (checkLoginIdJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkLoginIdJoinableResultData.getMsg());
			return "common/redirect";
		}

		int newMemberId = memberService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	@RequestMapping("/member/login")
	public String showLogin() {
		return "member/login";
	}

	@RequestMapping("/member/doLogin")
	public String doLogin(String loginId, String loginPwReal, String redirectUri, Model model, HttpSession session) {
		String loginPw = loginPwReal;
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 회원입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		session.setAttribute("loggedInMemberId", member.getId());

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("%s님 반갑습니다.", member.getNickname()));

		return "common/redirect";
	}

	@RequestMapping("/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUri) {
		session.removeAttribute("loggedInMemberId");

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		return "common/redirect";
	}
	
	@RequestMapping("/member/myInfo")
	public String showMyInfo() {
		return "member/myInfo";
	}
	
	@RequestMapping("/member/checkPw")
	public String checkPw() {
		return "member/checkPw";
	}
	
	@RequestMapping("/member/doCheckPw")
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
			redirectUri = "/home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("비밀번호가 확인되었습니다."));

		return "common/redirect";
	}
	
	@RequestMapping("/member/modify")
	public String modifyMember() {
		return "member/modify";
	}
	
	@RequestMapping("/member/doModify")
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
}
