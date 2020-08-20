package com.ljh.footballaround.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ljh.footballaround.dto.Club;

@Mapper
public interface ClubdataDao {

	List<Club> getClubdataByleagueId(int leagueId);

}
