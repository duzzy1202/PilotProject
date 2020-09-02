package com.ljh.footballaround.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class Report {
	private int id;
	private String regDate;
	private String updateDate;
	private String processDate;
	private String reportedType;
	private int reportedId;
	private int reportedCount;
	private String reportedReason;
	private int isProcessed;
	private int processedMemberId;
}

