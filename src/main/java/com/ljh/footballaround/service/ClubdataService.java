package com.ljh.footballaround.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ljh.footballaround.dao.ClubdataDao;
import com.ljh.footballaround.dto.Club;

@Service
public class ClubdataService {
	@Autowired
	private ClubdataDao clubdataDao ;

	public List<Club> getClubdataByleagueId(int leagueId) {
		return clubdataDao.getClubdataByleagueId(leagueId);
	}

	public Club getClubdataByClubCode(String boardCode) {
		return clubdataDao.getClubdataByClubCode(boardCode);
	}

	public void addClubData(Map<String, Object> param) {
		clubdataDao.addClubData(param);
		
	}

	public List<Club> getAllClubs() {
		return clubdataDao.getAllClubs();
	}
	
	
}
