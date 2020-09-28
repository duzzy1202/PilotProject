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

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public int join(Map<String, Object> param) {
		memberDao.join(param);

		sendJoinCompleteMail((String) param.get("email"));

		return Util.getAsInt(param.get("id"));
	}
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", "Football Around");
		String mailBody = mailUtil.joinCompleteMailBody("localhost:8085/usr/home/main", "Football Around");
		
		mailService.send(email, mailTitle, mailBody);
	}
	public ResultData checkLoginIdJoinable(String loginId) {
		int count = memberDao.getLoginIdDupCount(loginId);
		if (count == 0) {
			return new ResultData("S-1", "가입가능한 로그인 아이디 입니다.", "loginId", loginId);
		}

		return new ResultData("F-1", "이미 사용중인 로그인 아이디 입니다.", "loginId", loginId);
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
			return new ResultData("S-1", "사용가능한 이메일입니다.", "email", email);
		}

		return new ResultData("F-1", "이미 사용중인 이메일입니다.", "email", email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public int modifyMember(Map<String, Object> param) {
		return memberDao.modifyMember(param);
	}

	public Member getMemberByEmail( String email) {
		return memberDao.getMemberByEmail(email);
	}

	public void sendFindId(Member member) {
		String nickname = member.getNickname();
		String email = member.getEmail();
		String loginId = member.getLoginId();
		
		String mailTitle = String.format("[%s] 커뮤니티 회원님의 아이디 입니다.", "Football Around");
		String mailBody = mailUtil.findIdMailBody("localhost:8085/usr/home/main", "Football Around", nickname, loginId);
		
		mailService.send(email, mailTitle, mailBody);
	}

	public Member getMemberByLoginIdAndEmail(String loginId, String email) {
		return memberDao.getMemberByLoginIdAndEmail(loginId, email);
	}

	public void sendFindPw(Member member, String tempPw) {
		String nickname = member.getNickname();
		String email = member.getEmail();
		
		String mailTitle = String.format("[%s] 커뮤니티 회원님의 임시비밀번호 입니다.", "Football Around");
		String mailBody = mailUtil.findPwMailBody("localhost:8085/usr/home/main", "Football Around", nickname, tempPw);
		
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

	public void updateRating(int memberId, double averageRating) {
		memberDao.updateRating(memberId, averageRating);
	}

	public List<Member> getMemberByKeywordId(int id) {
		return memberDao.getMemberByKeywordId(id);
	}

	public List<Member> getMemberByKeywordLoginId(String loginId) {
		return memberDao.getMemberByKeywordLoginId(loginId);
	}

	public List<Member> getMemberByKeywordNickname(String nickname) {
		return memberDao.getMemberByKeywordNickname(nickname);
	}

	public void signoutMemberById(int memberId) {
		memberDao.signoutMemberById(memberId);
	}

}
