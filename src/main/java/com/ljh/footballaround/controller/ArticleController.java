package com.ljh.footballaround.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ljh.footballaround.dto.Article;
import com.ljh.footballaround.dto.Attr;
import com.ljh.footballaround.dto.Board;
import com.ljh.footballaround.dto.Club;
import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.dto.Reply;
import com.ljh.footballaround.dto.Report;
import com.ljh.footballaround.dto.ResultData;
import com.ljh.footballaround.service.AdminService;
import com.ljh.footballaround.service.ArticleService;
import com.ljh.footballaround.service.AttrService;
import com.ljh.footballaround.service.ClubdataService;
import com.ljh.footballaround.service.MemberService;
import com.ljh.footballaround.service.ReplyService;
import com.ljh.footballaround.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ClubdataService clubdataService;
	@Autowired
	private AttrService attrService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ReplyService replyService;

	@RequestMapping("/usr/article/{boardCode}-list")
	public String showList(Model model, @PathVariable("boardCode") String boardCode) {
		Board board = articleService.getBoardByCode(boardCode);
		int boardId = board.getId();
		int leagueId = board.getLeagueId();
		model.addAttribute("board", board);
		
		/* 게시판 코드와 연결되는 리그의 클럽들 데이터를 가져옴 */
		if (boardCode.equals("kl1")) {
			List<Club> clubs = clubdataService.getClubdataByleagueId(leagueId);
			model.addAttribute("clubs", clubs);
		}
		else if (boardCode.equals("kl2")) {
			List<Club> clubs = clubdataService.getClubdataByleagueId(leagueId);
			model.addAttribute("clubs", clubs);
		}
		else if (boardCode.equals("kl3")) {
			List<Club> clubs = clubdataService.getClubdataByleagueId(leagueId);
			model.addAttribute("clubs", clubs);
		}
		else if (boardCode.equals("kl4")) {
			List<Club> clubs = clubdataService.getClubdataByleagueId(leagueId);
			model.addAttribute("clubs", clubs);
		}
		else if (boardCode.equals("wkl")) {
			List<Club> clubs = clubdataService.getClubdataByleagueId(leagueId);
			model.addAttribute("clubs", clubs);
		}
		/* 게시판 번호와 맞는 게시물들의 리스트를 가져옴 */
		List<Article> articles = articleService.getForPrintArticles(boardId);
		
		model.addAttribute("articles", articles);

		return "article/list";
	}
	
	@RequestMapping("/usr/article/{boardCode}-clubHouse")
	public String showClubHouse(Model model, @PathVariable("boardCode") String boardCode) {
		Board board = articleService.getBoardByCode(boardCode);
		int boardId = board.getId();
		model.addAttribute("board", board);
		
		/* 게시판 코드와 연결되는 클럽의 데이터를 가져옴 */
		
		Club club = clubdataService.getClubdataByClubCode(boardCode);
		Board clubLeague = articleService.getBoardByLeagueId(club.getLeagueId());
		
		model.addAttribute("club", club);
		model.addAttribute("clubLeague", clubLeague);
		
		/* 게시판 번호와 맞는 게시물들의 리스트를 가져옴 */
		List<Article> articles = articleService.getForPrintArticles(boardId);
		
		model.addAttribute("articles", articles);

		return "article/clubHouse";
	}

	@RequestMapping("/usr/article/{boardCode}-detail")
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

		int hits = article.getHit() + 1;

		articleService.updateHitOfArticle(id, hits);
		article = articleService.getForPrintArticleById(loggedInMember, id);
		
		Member articleWriter = memberService.getMemberById(article.getMemberId());
		
		model.addAttribute("article", article);
		model.addAttribute("writer", articleWriter);
		
		return "article/detail";
	}
	
	@RequestMapping("/usr/article/detail")
	public String showDetailWithoutBoardCode(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req, String listUrl) {
		
		Member loggedInMember = (Member)req.getAttribute("loggedInMember");
		int id = Integer.parseInt((String) param.get("id"));
		Article article = articleService.getForPrintArticleById(loggedInMember, id);
		Board board = articleService.getBoardById(article.getBoardId());
		String boardCode = board.getCode();
		
		return showDetail(model, param, req, boardCode, listUrl);
	}
	
	@RequestMapping("/usr/article/{boardCode}-write")
	public String showWrite(@PathVariable("boardCode") String boardCode, Model model, HttpSession session, String listUrl) {
		
		int currentMemeberId = (int) session.getAttribute("loggedInMemberId");
		Member member = memberService.getMemberById(currentMemeberId);
		
		if (boardCode.equals("notice")) {
			if (member.getLevel() != 3) {
				model.addAttribute("historyBack", true);
				model.addAttribute("alertMsg", "공지사항은 관리자만 작성 가능합니다.");
				return "common/redirect";
			}
		}
		
		if ( listUrl == null ) {
			listUrl = "./" + boardCode + "-list";
		}
		model.addAttribute("listUrl", listUrl);
		Board board = articleService.getBoardByCode(boardCode);
		model.addAttribute("board", board);
		
		return "article/write";
	}
	
	@RequestMapping("/usr/article/{boardCode}-doWrite")
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
	
	@RequestMapping("/usr/article/{boardCode}-modify")
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
	
	@RequestMapping("/usr/article/{boardCode}-doModify")
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
	
	@RequestMapping("/usr/article/{boardCode}-doDelete")
	public String doDelete(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req, @PathVariable("boardCode") String boardCode) {
		
		int id = Integer.parseInt((String) param.get("id"));
		Article article = articleService.getArticleById(id);
		Member loggedInMember = (Member)req.getAttribute("loggedInMember");
		
		if (article.getMemberId() != loggedInMember.getId()) {
			model.addAttribute("alertMsg", "권한이 없습니다.");
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		articleService.deleteArticleById(id);

		model.addAttribute("alertMsg", "삭제되었습니다.");
		model.addAttribute("redirectUri", "/usr/article/" + boardCode + "-list");

		return "common/redirect";
	}
	
	@RequestMapping("/usr/article/doSendArticleReport")
	public String doSendArticleReport(@RequestParam Map<String, Object> param, HttpServletRequest req, int id, Model model) {
		
		int memberId = (int)req.getAttribute("loggedInMemberId");
		Attr isMemberReportedThisArticle = attrService.getAttr("member__" + memberId + "__extra__reportedArticleId__" + id);
		
		if (isMemberReportedThisArticle != null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "이미 신고한 게시물입니다.");
			return "common/redirect";
		}
		
		Report report = adminService.getReportByReportedIdAndReportedType(id, "Article");
		if (report != null) {
			int newReportedCount = report.getReportedCount() + 1;
			adminService.updateReportedCount(report.getId(), newReportedCount);
			
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "신고 되었습니다.");
			
			return "common/redirect";
		}
		
		adminService.newReport(param);
		
		int b = attrService.setValue("member__" + memberId + "__extra__reportedArticleId", id+"");
		
		model.addAttribute("historyBack", true);
		model.addAttribute("alertMsg", "신고 되었습니다.");
		
		return "common/redirect";
	}

	@RequestMapping("/usr/article/doLike")
	public String doLike(Model model, int id, String redirectUrl, HttpServletRequest request) {

		int loggedInMemberId = (int) request.getAttribute("loggedInMemberId");

		Map<String, Object> articleLikeAvailableRs = articleService.getArticleLikeAvailable(id, loggedInMemberId);

		if (((String) articleLikeAvailableRs.get("resultCode")).startsWith("F-")) {
			model.addAttribute("alertMsg", articleLikeAvailableRs.get("msg"));
			model.addAttribute("historyBack", true);

			return "common/redirect";
		}

		Map<String, Object> rs = articleService.likeArticle(id, loggedInMemberId);

		String msg = (String) rs.get("msg");

		model.addAttribute("alertMsg", msg);
		model.addAttribute("redirectUri", redirectUrl);

		return "common/redirect";
	}
	
	@RequestMapping("/usr/article/doDislike")
	public String doDislike(Model model, int id, String redirectUrl, HttpServletRequest request) {

		int loggedInMemberId = (int) request.getAttribute("loggedInMemberId");

		Map<String, Object> articleLikeAvailableRs = articleService.getArticleLikeAvailable(id, loggedInMemberId);

		if (((String) articleLikeAvailableRs.get("resultCode")).startsWith("F-")) {
			model.addAttribute("alertMsg", articleLikeAvailableRs.get("msg"));
			model.addAttribute("historyBack", true);

			return "common/redirect";
		}

		Map<String, Object> rs = articleService.dislikeArticle(id, loggedInMemberId);

		String msg = (String) rs.get("msg");

		model.addAttribute("alertMsg", msg);
		model.addAttribute("redirectUri", redirectUrl);

		return "common/redirect";
	}
	
	@RequestMapping("/usr/article/totalSearch")
	public String totalSearch(@RequestParam Map<String, Object> param, Model model) {
		
		String keyword = (String)param.get("searchKeyword");
		
		System.out.println("sdfadsfa : " + keyword);
		
		List<Article> searchTitleResultArticles = articleService.getArticlesByTitleKeyword(keyword);
		List<Article> searchBodyResultArticles = articleService.getArticlesMyBodyKeyword(keyword);
		List<Reply> searchResultReplies = replyService.getReplysByKeyword(keyword);
		
		if (searchTitleResultArticles.size() > 0) {
			model.addAttribute("searchTitleResultArticles", searchTitleResultArticles);
		}
		if (searchBodyResultArticles.size() > 0) {
			model.addAttribute("searchBodyResultArticles", searchBodyResultArticles);
		}
		if (searchResultReplies.size() > 0) {
			model.addAttribute("searchResultReplies", searchResultReplies);
		}
		
		model.addAttribute("keyword", keyword);
		
		return "article/totalSearch";
	}
}
