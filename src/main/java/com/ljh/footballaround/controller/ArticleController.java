package com.ljh.footballaround.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ljh.footballaround.dto.Article;
import com.ljh.footballaround.dto.Board;
import com.ljh.footballaround.dto.Club;
import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.dto.ResultData;
import com.ljh.footballaround.service.ArticleService;
import com.ljh.footballaround.service.ClubdataService;
import com.ljh.footballaround.service.CrawlingService;
import com.ljh.footballaround.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ClubdataService clubdataService;
	@Autowired
	private CrawlingService crawlingService;

	@RequestMapping("/article/{boardCode}-list")
	public String showList(Model model, @PathVariable("boardCode") String boardCode) throws IOException {
		Board board = articleService.getBoardByCode(boardCode);
		int boardId = board.getId();
		int leagueId = board.getLeagueId();
		model.addAttribute("board", board);
		
		if (boardCode.equals("kl1")) {
			crawlingService.crawlingKL1();
		}
		if (boardCode.equals("kl3")) {
			crawlingService.crawlingKL3();
		}
		
		
		
		List<Article> articles = articleService.getForPrintArticles(boardId);
		
		List<Club> clubs = clubdataService.getClubdataByleagueId(leagueId);
		
		model.addAttribute("articles", articles);
		model.addAttribute("clubs", clubs);

		return "article/list";
	}

	@RequestMapping("/article/{boardCode}-detail")
	public String showDetail(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, String listUrl) {
		if ( listUrl == null ) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);
		
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		int id = Integer.parseInt((String) param.get("id"));
		
		Member loggedInMember = (Member)req.getAttribute("loggedInMember");

		Article article = articleService.getForPrintArticleById(loggedInMember, id);

		model.addAttribute("article", article);

		return "article/detail";
	}
	
	@RequestMapping("/article/{boardCode}-modify")
	public String showModify(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, String listUrl) {
		model.addAttribute("listUrl", listUrl);
		
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		int id = Integer.parseInt((String) param.get("id"));
		
		Member loggedInMember = (Member)req.getAttribute("loggedInMember");
		Article article = articleService.getForPrintArticleById(loggedInMember, id);

		model.addAttribute("article", article);

		return "article/modify";
	}

	@RequestMapping("/article/{boardCode}-write")
	public String showWrite(@PathVariable("boardCode") String boardCode, Model model, String listUrl) {
		if ( listUrl == null ) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		return "article/write";
	}
	
	@RequestMapping("/article/{boardCode}-doModify")
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req, int id, @PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr", "articleId", "id");
		Member loggedInMember = (Member)req.getAttribute("loggedInMember");
		
		ResultData checkActorCanModifyResultData = articleService.checkActorCanModify(loggedInMember, id);
		
		if (checkActorCanModifyResultData.isFail() ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("msg", checkActorCanModifyResultData.getMsg());
			
			return "common/redirect";
		}
		
		articleService.modify(newParam);
		
		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}

	@RequestMapping("/article/{boardCode}-doWrite")
	public String doWrite(@RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode, Model model) {
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		Map<String, Object> newParam = Util.getNewMapOf(param, "title", "body", "fileIdsStr");
		int loggedInMemberId = (int)req.getAttribute("loggedInMemberId");
		newParam.put("boardId", board.getId());
		newParam.put("memberId", loggedInMemberId);
		int newArticleId = articleService.write(newParam);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArticleId + "");

		return "redirect:" + redirectUri;
	}
}
