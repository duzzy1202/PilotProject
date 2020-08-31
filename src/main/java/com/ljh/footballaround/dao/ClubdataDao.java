package com.ljh.footballaround.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ljh.footballaround.dto.Club;

@Mapper
public interface ClubdataDao {

	List<Club> getClubdataByleagueId(int leagueId);

	void updateLeagueDataByLeagueIdAndClubName(Map<String, Object> param);

	Club getClubdataByClubCode(String boardCode);

	void addClubData(Map<String, Object> param);

	List<Club> getAllClubs();

}
