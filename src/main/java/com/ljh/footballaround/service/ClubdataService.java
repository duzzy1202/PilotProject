package com.ljh.footballaround.service;

import java.util.List;

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
}
