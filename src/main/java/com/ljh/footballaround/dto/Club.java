package com.ljh.footballaround.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class Club {
	private int id;
	private String regDate;
	private String updateDate;
	private boolean delStatus;
	private String delDate;
	private String name;
	private int leagueId;
	private int ranking;
	private int play;
	private int points;
	private int win;
	private int draw;
	private int defeat;
	private int goal;
	private int goalAgainst;

}
