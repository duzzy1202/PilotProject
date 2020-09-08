package com.ljh.footballaround.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class Punishment {
	private int id;
	private String regDate;
	private int memberId;
	private String reason;
	private int count;
}
