package com.ljh.footballaround.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ljh.footballaround.dto.Attr;
import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.dto.Reply;
import com.ljh.footballaround.dto.Report;
import com.ljh.footballaround.dto.ResultData;
import com.ljh.footballaround.service.AdminService;
import com.ljh.footballaround.service.AttrService;
import com.ljh.footballaround.service.ReplyService;
import com.ljh.footballaround.util.Util;

@Controller
public class ReplyController {
	@Autowired
	private ReplyService replyService;	
	@Autowired
	private AttrService attrService;	
	@Autowired
	private AdminService adminService;
	
	@RequestMapping("/usr/reply/getForPrintReplies")
	@ResponseBody
	public ResultData getForPrintReplies(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Member loggedInMember = (Member) req.getAttribute("loggedInMember");
		Map<String, Object> rsDataBody = new HashMap<>();

		param.put("relTypeCode", "article");
		Util.changeMapKey(param, "articleId", "relId");

		param.put("actor", loggedInMember);
		List<Reply> replies = replyService.getForPrintReplies(param);
		rsDataBody.put("replies", replies);

		return new ResultData("S-1", String.format("%d개의 댓글을 불러왔습니다.", replies.size()), rsDataBody);
	}
	
	@RequestMapping("/usr/reply/getReply")
	@ResponseBody
	public ResultData getReply(int id, HttpServletRequest req) {
	
		Reply reply = replyService.getForPrintReplyById(id);

		return new ResultData("S-1", String.format("1개의 댓글을 불러왔습니다."), reply);
	}

	@RequestMapping("/usr/reply/doWriteReplyAjax")
	@ResponseBody
	public ResultData doWriteReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		Map<String, Object> rsDataBody = new HashMap<>();

		param.put("memberId", request.getAttribute("loggedInMemberId"));

		int newReplyId = replyService.writeReply(param);
		rsDataBody.put("replyId", newReplyId);

		return new ResultData("S-1", String.format("댓글을 등록하였습니다."), rsDataBody);
	}

	@RequestMapping("/usr/reply/doDeleteReplyAjax")
	@ResponseBody
	public ResultData doDeleteReplyAjax(int id, HttpServletRequest req) {
		Member loggedInMember = (Member) req.getAttribute("loggedInMember");
		Reply reply = replyService.getForPrintReplyById(id);

		if (replyService.actorCanDelete(loggedInMember, reply) == false) {
			return new ResultData("F-1", String.format("%d번 댓글을 삭제할 권한이 없습니다.", id));
		}

		replyService.deleteReply(id);

		return new ResultData("S-1", String.format("댓글을 삭제하였습니다.", id));
	}

	@RequestMapping("/usr/reply/doModifyReplyAjax")
	@ResponseBody
	public ResultData doModifyReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest req, int id) {
		Member loggedInMember = (Member) req.getAttribute("loggedInMember");
		Reply reply = replyService.getForPrintReplyById(id);

		if (replyService.actorCanModify(loggedInMember, reply) == false) {
			return new ResultData("F-1", String.format("%d번 댓글을 수정할 권한이 없습니다.", id));
		}

		Map<String, Object> modfiyReplyParam = Util.getNewMapOf(param, "id", "body");
		ResultData rd = replyService.modfiyReply(modfiyReplyParam);

		return rd;
	}
	
	@RequestMapping("/usr/reply/doSendReplyReport")
	public String doSendReplyReport(@RequestParam Map<String, Object> param, HttpServletRequest req, int id, Model model) {
		
		int memberId = (int)req.getAttribute("loggedInMemberId");
		Attr isMemberReportedThisReply = attrService.getAttr("member__" + memberId + "__extra__reportedReplyId__" + id);
		
		if (isMemberReportedThisReply != null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "이미 신고한 댓글입니다.");
			return "common/redirect";
		}
		
		Report report = adminService.getReportByReportedIdAndReportedType(id, "Reply");
		if (report != null) {
			int newReportedCount = report.getReportedCount() + 1;
			adminService.updateReportedCount(report.getId(), newReportedCount);
			
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "신고 되었습니다.");
			
			return "common/redirect";
		}
		
		adminService.newReport(param);
		
		int b = attrService.setValue("member__" + memberId + "__extra__reportedReplyId", id+"");
		
		model.addAttribute("historyBack", true);
		model.addAttribute("alertMsg", "신고 되었습니다.");
		
		return "common/redirect";
	}
}
