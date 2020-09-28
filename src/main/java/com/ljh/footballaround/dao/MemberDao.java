package com.ljh.footballaround.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.dto.Punishment;

@Mapper
public interface MemberDao {

	Member getMemberById(@Param("id") int id);

	void join(Map<String, Object> param);

	int getLoginIdDupCount(@Param("loginId") String loginId);

	int getNicknameDupCount(String nickname);

	int getEmailDupCount(String email);
	
	Member getMemberByLoginId(@Param("loginId") String loginId);

	int modifyMember(Map<String, Object> param);
	
	List<Punishment> getPunishment(int memberId);

	Member getMemberByEmail(String email);

	Member getMemberByLoginIdAndEmail(String loginId, String email);

	void updateRedLine(int memberId, int writersRedLine);

	void insertPunishment(int memberId, String reason, int punishmentCount);

	void updateRating(int memberId, double averageRating);

	List<Member> getMemberByKeywordId(int id);

	List<Member> getMemberByKeywordLoginId(String loginId);

	List<Member> getMemberByKeywordNickname(String nickname);

	void signoutMemberById(int memberId);
}
