package com.ljh.footballaround.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ljh.footballaround.dao.ClubdataDao;

@Service
public class CrawlingService {
	@Autowired
	private ClubdataDao clubdataDao; 

	// @RequestMapping(value = "crwaling.do")

	public String crawlingKL1() throws IOException {

		String url = "http://www.kleague.com/rank";

		Document doc = Jsoup.connect(url).get();

		Elements element = doc.select("table.table.league1");

		StringBuilder sb = new StringBuilder();
		for (Element el : element.select("td")) {
			sb.append(el.text() + ",");
		}

		String sbdata = sb.toString();
		String[] data = sbdata.split(",");
		
		List<Map<String, Object>> leagueData = organizeData(1, data);

		for (Map<String, Object> teamData : leagueData) {
			if ( teamData.size()  > 0 ) {
				System.out.println(teamData);
				teamData.put("leagueId", 1);
				clubdataDao.updateLeagueDataByLeagueIdAndClubName(teamData);				
			}
		}

		return "{\"1\":\"1\"}";
	}
	
	public String crawlingKL2() throws IOException {

		String url = "http://www.kleague.com/rank/get_rank_html?select_league=2&select_year=2020&"
				+ "select_competition=7ZWY64KY7JuQ7YGQIEvrpqzqt7gyIDIwMjA%3D&select_r_detail=&return_type=html";

		Document doc = Jsoup.connect(url).get();

		Elements element = doc.select("body");

		String sbdata = element.select("body").text();
		String[] data = sbdata.split(" ");
		
		List<Map<String, Object>> leagueData = organizeData(2, data);

		for (Map<String, Object> teamData : leagueData) {
			if ( teamData.size()  > 0 ) {
				System.out.println(teamData);
				teamData.put("leagueId", 2);
				clubdataDao.updateLeagueDataByLeagueIdAndClubName(teamData);				
			}
		}
		
		return "{\"1\":\"1\"}";
	}

	public List<Map<String, Object>> organizeData(int leagueId, String[] data) {
		int repeatTimes = 0;

		switch (leagueId) {
		case 1:
			repeatTimes = 12;
			break;
		case 2:
			repeatTimes = 10;
			break;
		}

		List<Map<String, Object>> leagueData = new ArrayList<>();

		for (int i = 0; i < repeatTimes * 10; i = i + 10) {
			Map<String, Object> teamData = new HashMap<>();
			teamData.put("ranking", data[i]);
			teamData.put("name", data[i+1]);
			teamData.put("play", data[i+2]);
			teamData.put("points", data[i+3]);
			teamData.put("win", data[i+4]);
			teamData.put("draw", data[i+5]);
			teamData.put("defeat", data[i+6]);
			teamData.put("goal", data[i+7]);
			teamData.put("goalAgainst", data[i+8]);
			
			leagueData.add(teamData);
		}
		
		return leagueData;
	}



}
