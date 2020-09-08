package com.ljh.footballaround.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ljh.footballaround.dto.Punishment;
import com.ljh.footballaround.dto.Report;

@Mapper
public interface AdminDao {
	
	void newReport(Map<String, Object> param);

	void updateReportedCount(int id, int newReportedCount);

	List<Report> getReportedListByReportedType(String reportedType);

	void processReport(int reportedId, String reportedType, int adminMemberId);

	List<Report> getProcessedReportListByReportedType(String reportedType);

	Report getReportByReportedIdAndReportedType(int reportedId, String reportedType);

	List<Punishment> getPunishment(int memberId);

}
