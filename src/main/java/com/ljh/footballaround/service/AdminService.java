package com.ljh.footballaround.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ljh.footballaround.dao.AdminDao;
import com.ljh.footballaround.dto.Attr;
import com.ljh.footballaround.dto.Punishment;
import com.ljh.footballaround.dto.Report;

@Service
public class AdminService {
	@Autowired
	private AttrService attrService;
	@Autowired
	private AdminDao adminDao;
	
	public void setMemberAccountSuspensionDate(Map<String, Object> param) throws ParseException {
		
		int memberId = Integer.parseInt((String)param.get("memberId"));
		String memberProcess = (String)param.get("processMember");
		
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
		
		Attr attr = attrService.get("member__" + memberId + "__extra__AccountSuspension");
		
		if (memberProcess.equals("1day")) {
			if (attr != null) {
				String value = attr.getValue();
				Date suspensionDate = format.parse(value);
				cal.setTime(suspensionDate);
				cal.add(Calendar.DATE, 1);
				attrService.updateValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()));
			} else {
			cal.add(Calendar.DATE, 1);
			int a = attrService.setValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()) );
			}
		}
		
		if (memberProcess.equals("3days")) {
			if (attr != null) {
				String value = attr.getValue();
				Date suspensionDate = format.parse(value);
				cal.setTime(suspensionDate);
				cal.add(Calendar.DATE, 3);
				attrService.updateValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()));
			} else {
			cal.add(Calendar.DATE, 3);
			int a = attrService.setValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()) );
			}
		}
		
		if (memberProcess.equals("7days")) {
			if (attr != null) {
				String value = attr.getValue();
				Date suspensionDate = format.parse(value);
				cal.setTime(suspensionDate);
				cal.add(Calendar.DATE, 7);
				attrService.updateValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()));
			} else {
			cal.add(Calendar.DATE, 7);
			int a = attrService.setValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()) );
			}
		}
		
		if (memberProcess.equals("14days")) {
			if (attr != null) {
				String value = attr.getValue();
				Date suspensionDate = format.parse(value);
				cal.setTime(suspensionDate);
				cal.add(Calendar.DATE, 14);
				attrService.updateValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()));
			} else {
			cal.add(Calendar.DATE, 14);
			int a = attrService.setValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()) );
			}
		}
		
		if (memberProcess.equals("30days")) {
			if (attr != null) {
				String value = attr.getValue();
				Date suspensionDate = format.parse(value);
				cal.setTime(suspensionDate);
				cal.add(Calendar.DATE, 30);
				attrService.updateValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()));
			} else {
			cal.add(Calendar.DATE, 30);
			int a = attrService.setValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()) );
			}
		}
		
		if (memberProcess.equals("90days")) {
			if (attr != null) {
				String value = attr.getValue();
				Date suspensionDate = format.parse(value);
				cal.setTime(suspensionDate);
				cal.add(Calendar.DATE, 90);
				attrService.updateValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()));
			} else {
			cal.add(Calendar.DATE, 90);
			int a = attrService.setValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()) );
			}
		}
		
		if (memberProcess.equals("365days")) {
			if (attr != null) {
				String value = attr.getValue();
				Date suspensionDate = format.parse(value);
				cal.setTime(suspensionDate);
				cal.add(Calendar.DATE, 365);
				attrService.updateValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()));
			} else {
			cal.add(Calendar.DATE, 365);
			int a = attrService.setValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()) );
			}
		}
		
		if (memberProcess.equals("forever")) {
			if (attr != null) {
				String value = attr.getValue();
				Date suspensionDate = format.parse(value);
				cal.setTime(suspensionDate);
				cal.add(Calendar.YEAR, 100);
				attrService.updateValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()));
			} else {
			cal.add(Calendar.YEAR, 100);
			int a = attrService.setValue("member__" + memberId + "__extra__AccountSuspension", format.format(cal.getTime()) );
			}
		}
		
		
	}

	public void newReport(Map<String, Object> param) {
		adminDao.newReport(param);
	}

	public void updateReportedCount(int id, int newReportedCount) {
		adminDao.updateReportedCount(id, newReportedCount);
	}

	public List<Report> getReportedListByReportedType(String reportedType) {
		return adminDao.getReportedListByReportedType(reportedType);
	}

	public void processReport(int reportedId, String reportedType, int adminMemberId) {
		adminDao.processReport(reportedId, reportedType, adminMemberId);
	}

	public List<Report> getProcessedReportListByReportedType(String reportedType) {
		return adminDao.getProcessedReportListByReportedType(reportedType);
	}

	public Report getReportByReportedIdAndReportedType(int reportedId, String reportedType) {
		return adminDao.getReportByReportedIdAndReportedType(reportedId, reportedType);
	}

	public List<Punishment> getPunishment(int memberId) {
		return adminDao.getPunishment(memberId);
	}
	
	
	
}
