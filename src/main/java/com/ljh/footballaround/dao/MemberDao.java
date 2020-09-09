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

	Member getMemberByLoginId(@Param("loginId") String loginId);

	int modifyMember(Map<String, Object> param);

	int getNicknameDupCount(String nickname);

	int getEmailDupCount(String email);

	Member getMemberByNameAndEmail(String name, String email);

	Member getMemberByLoginIdAndNameAndEmail(String loginId, String name, String email);

	void updateRedLine(int memberId, int writersRedLine);
	
	List<Punishment> getPunishment(int memberId);

	void insertPunishment(int memberId, String reason, int punishmentCount);
}
