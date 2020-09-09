package com.ljh.footballaround.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ljh.footballaround.dto.Article;
import com.ljh.footballaround.dto.Club;
import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.dto.Punishment;
import com.ljh.footballaround.dto.Reply;
import com.ljh.footballaround.dto.Report;
import com.ljh.footballaround.service.AdminService;
import com.ljh.footballaround.service.ArticleService;
import com.ljh.footballaround.service.AttrService;
import com.ljh.footballaround.service.ClubdataService;
import com.ljh.footballaround.service.CrawlingService;
import com.ljh.footballaround.service.MemberService;
import com.ljh.footballaround.service.ReplyService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdminController {
	@Autowired
	private CrawlingService crawlingService;
	@Autowired
	private ClubdataService clubdataService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private AttrService attrService;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private ReplyService replyService;
	
	
	
	@RequestMapping("/adm/admin/crwalData")
	public String updateClubData(Model model, HttpServletRequest req) throws IOException {
		
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		crawlingService.crawlingKL1();
		crawlingService.crawlingKL2();
		
		model.addAttribute("redirectUri", "/usr/home/main");
		model.addAttribute("alertMsg", "업데이트가 완료되었습니다.");
		return "common/redirect";
		
	}
	
	@RequestMapping("/adm/admin/adminPage")
	public String dataCenter(Model model, HttpServletRequest req) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		return "/admin/adminPage";
	}
	
	@RequestMapping("/adm/admin/addData")
	public String AddClubData(Model model, @RequestParam Map<String, Object> param) {
		clubdataService.addClubData(param);
		
		model.addAttribute("redirectUri", "/adm/admin/dataCenter");
		model.addAttribute("alertMsg", "데이터 추가가 완료되었습니다.");
		return "common/redirect";
	}
	
	@RequestMapping("/adm/admin/newData")
	public String newData(Model model, HttpServletRequest req) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		return "/admin/newData";
	}
	
	@RequestMapping("/adm/admin/updateData")
	public String updateData(Model model, HttpServletRequest req) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		List<Club> clubs = clubdataService.getAllClubs();
		model.addAttribute("clubs", clubs);
		
		return "/admin/updateData";
	}
	
	@RequestMapping("/adm/admin/doUpdateData")
	public String doUpdateData(Model model, @RequestParam Map<String, Object> param) {
		clubdataService.updateClubdata(param);
		
		model.addAttribute("redirectUri", "/adm/admin/adminPage");
		model.addAttribute("alertMsg", "데이터 수정이 완료되었습니다.");
		return "common/redirect";
	}
	
	@RequestMapping("/adm/admin/articleReportList")
	public String articleReportList(Model model, HttpServletRequest req) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		List<Report> reportedArticles = adminService.getReportedListByReportedType("Article");
		List<Article> articles = new ArrayList<>();
		for (Report data : reportedArticles) {
			Article article = articleService.getArticleById(data.getReportedId());
			articles.add(article);
		}
		
		model.addAttribute("reportedArticles", reportedArticles);
		model.addAttribute("articles", articles);
		
		return "/admin/articleReportList";
	}
	
	@RequestMapping("/adm/admin/processedArticleReportList")
	public String processedArticleReportList(Model model, HttpServletRequest req) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		List<Report> reportedArticles = adminService.getProcessedReportListByReportedType("Article");
		List<Article> articles = new ArrayList<>();
		for (Report data : reportedArticles) {
			Article article = articleService.getArticleById(data.getReportedId());
			articles.add(article);
		}
		
		model.addAttribute("reportedArticles", reportedArticles);
		model.addAttribute("articles", articles);
		
		return "/admin/processedArticleReportList";
	}
	
	@RequestMapping("/adm/admin/reportDetail")
	public String reportDetail(Model model, HttpServletRequest req, int id) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		Article article = articleService.getArticleById(id);
		Member writer = memberService.getMemberById(article.getMemberId());
		Report report = adminService.getReportByReportedIdAndReportedType(article.getId(), "Article");
		
		model.addAttribute("article", article);
		model.addAttribute("member", writer);
		model.addAttribute("report", report);
		
		return "/admin/reportDetail";
	}
	
	@RequestMapping("/adm/admin/reportReplyDetail")
	public String reportReplyDetail(Model model, HttpServletRequest req, int id) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		Reply reply = replyService.getReplyById(id);
		Member writer = memberService.getMemberById(reply.getMemberId());
		Report report = adminService.getReportByReportedIdAndReportedType(reply.getId(), "Reply");
		
		System.out.println("댓글 엑스트라 : " + reply.getExtra());
		
		model.addAttribute("reply", reply);
		model.addAttribute("member", writer);
		model.addAttribute("report", report);
		
		return "/admin/reportReplyDetail";
	}
	
	@RequestMapping("/adm/admin/processReport")
	public String processReport(Model model, HttpServletRequest req, @RequestParam Map<String, Object> param) throws ParseException {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		int reportedId = 0;
		int memberId = Integer.parseInt((String)param.get("memberId"));
		String articleProcess = (String)param.get("processArticle");
		String processMember = (String)param.get("processMember");
		String reportedType = (String)param.get("reportedType");
		String reason = (String)param.get("selectReason");
		
		if (reportedType.equals("Article")) {
			reportedId = Integer.parseInt((String)param.get("articleId"));
		}
		if (reportedType.equals("Reply")) {
			reportedId = Integer.parseInt((String)param.get("replyId"));
		}
		
		if (articleProcess.equals("delete")) {
			if (reportedType.equals("Article")) {
				articleService.deleteArticleById(reportedId);
			}
			else if (reportedType.equals("Reply")) {
				replyService.deleteReply(reportedId);
			}
		}
		
		if (!processMember.equals("none")) {
			adminService.setMemberAccountSuspensionDate(param);
			Member writer = memberService.getMemberById(memberId);
			int writersRedLine = writer.getRedLine() + 1;
			memberService.updateRedLine(memberId, writersRedLine);
		}
		
		if (!reason.equals("none")) {
			List<Punishment> punishments = memberService.getPunishment(memberId);
			if (punishments == null) {
				int punishmentCount = 1;
				memberService.insertPunishment(memberId, reason, punishmentCount);
			} else if(punishments != null) {
				int lastCount =  punishments.size();
				int punishmentCount = lastCount + 1;
				memberService.insertPunishment(memberId, reason, punishmentCount);
			}
		}
		
		int adminMemberId = (int)req.getAttribute("loggedInMemberId");
		adminService.processReport(reportedId, reportedType, adminMemberId);
		
		model.addAttribute("redirectUri", "/adm/admin/adminPage");
		model.addAttribute("alertMsg", "처리가 완료되었습니다.");
		
		return "common/redirect";
	}
	
	@RequestMapping("/adm/admin/replyReportList")
	public String replyReportList(Model model, HttpServletRequest req) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		List<Report> reportedReplys = adminService.getReportedListByReportedType("Reply");
		List<Reply> replys = new ArrayList<>();
		for (Report data : reportedReplys) {
			Reply reply = replyService.getReplyById(data.getReportedId());
			replys.add(reply);
		}
		
		model.addAttribute("reportedReplys", reportedReplys);
		model.addAttribute("replys", replys);
		
		return "/admin/replyReportList";
	}
	
	@RequestMapping("/adm/admin/processedReplyReportList")
	public String processedReplyReportList(Model model, HttpServletRequest req) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		List<Report> reportedReplys = adminService.getProcessedReportListByReportedType("Reply");
		List<Reply> replys = new ArrayList<>();
		for (Report data : reportedReplys) {
			Reply reply = replyService.getReplyById(data.getReportedId());
			replys.add(reply);
		}
		
		model.addAttribute("reportedReplys", reportedReplys);
		model.addAttribute("replys", replys);
		
		return "/admin/processedReplyReportList";
	}
}
