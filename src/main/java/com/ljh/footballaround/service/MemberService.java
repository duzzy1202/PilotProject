package com.ljh.footballaround.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ljh.footballaround.dao.MemberDao;
import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.dto.ResultData;
import com.ljh.footballaround.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public int join(Map<String, Object> param) {
		memberDao.join(param);

		//sendJoinCompleteMail((String) param.get("email"));

		return Util.getAsInt(param.get("id"));
	}
	
	/* 가입 완료 메일
	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.", siteName);

		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>로 이동</p>", siteMainUri, siteName));
	}
	*/
	
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

}
