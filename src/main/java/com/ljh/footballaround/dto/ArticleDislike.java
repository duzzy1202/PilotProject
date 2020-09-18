package com.ljh.footballaround.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class ArticleDislike {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private String code;
	private int leagueId;
	private Map<String, Object> extra;
}
