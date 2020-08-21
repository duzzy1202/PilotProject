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
		
		System.out.println("HI");
		
		for (Map<String, Object> teamData : leagueData) {
			if ( teamData.size()  > 0 ) {
				System.out.println(teamData);
				teamData.put("leagueId", 1);
				clubdataDao.updateLeagueDataByLeagueIdAndClubName(teamData);				
			}
		}

		return "{\"1\":\"1\"}";
	}
	
	public String crawlingKL3() throws IOException {

		String url = "https://www.joinkfa.com/";

		Document doc = Jsoup.connect(url).get();

		Elements element = doc.select("div.nexainnercontainer");

		StringBuilder sb = new StringBuilder();
		for (Element el : element.select("div")) {
			sb.append(el.text() + ":");
		}
		
		System.out.println("체크체크 = " + sb.toString());
		/*
		String sbdata = sb.toString();
		String[] data = sbdata.split(":");
		
		List<Map<String, Object>> leagueData = organizeData(1, data);
		
		System.out.println("HI");
		
		for (Map<String, Object> teamData : leagueData) {
			if ( teamData.size()  > 0 ) {
				System.out.println(teamData);
				teamData.put("leagueId", 1);
				clubdataDao.updateLeagueDataByLeagueIdAndClubName(teamData);				
			}
		}
		*/
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
		case 3:
			repeatTimes = 16;
			break;
		case 4:
			repeatTimes = 13;
			break;
		case 5:
			repeatTimes = 8;
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
