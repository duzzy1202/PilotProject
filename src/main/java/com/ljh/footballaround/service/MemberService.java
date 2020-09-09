package com.ljh.footballaround.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ljh.footballaround.dao.MemberDao;
import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.dto.Punishment;
import com.ljh.footballaround.dto.ResultData;
import com.ljh.footballaround.util.Util;
import com.ljh.footballaround.util.mailUtil;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private MailService mailService;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;


	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public int join(Map<String, Object> param) {
		memberDao.join(param);

		sendJoinCompleteMail((String) param.get("email"));

		return Util.getAsInt(param.get("id"));
	}
	
	/* 가입 완료 메일 */
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);
		String mailBody = mailUtil.joinCompleteMailBody(siteMainUri, siteName);
		
		mailService.send(email, mailTitle, mailBody);
	}
	

	public ResultData checkLoginIdJoinable(String loginId) {
		int count = memberDao.getLoginIdDupCount(loginId);

		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public int modifyMember(Map<String, Object> param) {
		return memberDao.modifyMember(param);
	}

	public ResultData checkNicknameAbleToUse(String nickname) {
		int count = memberDao.getNicknameDupCount(nickname);

		if (count == 0) {
			return new ResultData("S-1", "사용가능한 닉네임입니다.", "nickname", nickname);
		}

		return new ResultData("F-1", "이미 사용중인 닉네임입니다.", "nickname", nickname);
	}

	public ResultData checkEmailAbleToUse(String email) {
		int count = memberDao.getEmailDupCount(email);

		if (count == 0) {
			return new ResultData("S-1", "사용가능한 닉네임입니다.", "email", email);
		}

		return new ResultData("F-1", "이미 사용중인 닉네임입니다.", "email", email);
	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberDao.getMemberByNameAndEmail(name, email);
	}

	public void sendFindId(Member member) {
		String name = member.getName();
		String email = member.getEmail();
		String loginId = member.getLoginId();
		
		String mailTitle = String.format("[%s] 커뮤니티 회원님의 아이디 입니다.", siteName);
		String mailBody = mailUtil.findIdMailBody(siteMainUri, siteName, name, loginId);
		
		mailService.send(email, mailTitle, mailBody);
	}

	public Member getMemberByLoginIdAndNameAndEmail(String loginId, String name, String email) {
		return memberDao.getMemberByLoginIdAndNameAndEmail(loginId, name, email);
	}

	public void sendFindPw(Member member, String tempPw) {
		String name = member.getName();
		String email = member.getEmail();
		
		String mailTitle = String.format("[%s] 커뮤니티 회원님의 임시비밀번호 입니다.", siteName);
		String mailBody = mailUtil.findPwMailBody(siteMainUri, siteName, name, tempPw);
		
		mailService.send(email, mailTitle, mailBody);
	}

	public void changePwToTempPw(Member member, String tempPwSHA) {
		Map<String, Object> param = new HashMap<>();
		param.put("loginPw", tempPwSHA);
		param.put("nickname", "");
		param.put("memberId", member.getId());
		memberDao.modifyMember(param);
	}

	public void updateRedLine(int memberId, int writersRedLine) {
		memberDao.updateRedLine(memberId, writersRedLine);
	}
	
	public List<Punishment> getPunishment(int memberId) {
		return memberDao.getPunishment(memberId);
	}

	public void insertPunishment(int memberId, String reason, int punishmentCount) {
		memberDao.insertPunishment(memberId, reason, punishmentCount);
	}

}
