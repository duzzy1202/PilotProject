package com.ljh.footballaround.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private boolean delStatus;
	private String delDate;
	private String loginId;
	private String loginPw;
	private String nickname;
	private String email;
	private int level;
	private int redLine;
	private double rating;
}
