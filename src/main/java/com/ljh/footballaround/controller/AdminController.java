package com.ljh.footballaround.controller;

import java.io.IOException;
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
import com.ljh.footballaround.dto.Attr;
import com.ljh.footballaround.dto.Club;
import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.service.ArticleService;
import com.ljh.footballaround.service.AttrService;
import com.ljh.footballaround.service.ClubdataService;
import com.ljh.footballaround.service.CrawlingService;
import com.ljh.footballaround.service.MemberService;

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
		
		model.addAttribute("redirectUri", "/adm/admin/dataCenter");
		model.addAttribute("alertMsg", "데이터 수정이 완료되었습니다.");
		return "common/redirect";
	}
	
	@RequestMapping("/adm/admin/reportList")
	public String showReportList(Model model, HttpServletRequest req) {
		Member member = memberService.getMemberById((int)req.getAttribute("loggedInMemberId"));
		if (member == null || member.getLevel() != 3) {
			model.addAttribute("redirectUri", "/usr/home/main");
			model.addAttribute("alertMsg", "접근 권한이 없습니다.");
			return "common/redirect";
		}
		
		List<Attr> reportedArticlesData = attrService.getReportedArticlesByRelTypeCode();
		List<Article> reportedArticles = new ArrayList<>();
		for (Attr data : reportedArticlesData) {
			Article article = articleService.getArticleById(data.getRelId());
			reportedArticles.add(article);
		}
		
		model.addAttribute("reportedArticlesData", reportedArticlesData);
		model.addAttribute("reportedArticles", reportedArticles);
		
		return "/admin/reportList";
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
		
		model.addAttribute("article", article);
		model.addAttribute("member", writer);
		
		return "/admin/reportDetail";
	}
	
}
