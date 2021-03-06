package com.ljh.footballaround.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.ljh.footballaround.dto.Article;
import com.ljh.footballaround.dto.Member;
import com.ljh.footballaround.service.ArticleService;
import com.ljh.footballaround.service.MemberService;
import com.ljh.footballaround.util.Util;

@Component("beforeActionInterceptor") // 컴포넌트 이름 설정
public class BeforeActionInterceptor implements HandlerInterceptor {
	@Autowired
	@Value("${spring.profiles.active}")
	private String activeProfile;
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private ArticleService articleService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 기타 유용한 정보를 request에 담는다.
		Map<String, Object> param = Util.getParamMap(request);
		String paramJson = Util.toJsonStr(param);

		String requestUri = request.getRequestURI();
		String queryString = request.getQueryString();

		if (queryString != null && queryString.length() > 0) {
			requestUri += "?" + queryString;
		}

		String encodedRequestUri = Util.getUriEncoded(requestUri);

		request.setAttribute("requestUri", requestUri);
		request.setAttribute("encodedRequestUri", encodedRequestUri);

		String afterLoginUri = requestUri;

		// 현재 페이지가 이미 로그인 페이지라면, 이 상태에서 로그인 버튼을 눌렀을 때 기존 param의 redirectUri가 계속 유지되도록
		// 한다.
		if (requestUri.contains("/usr/member/login")) {
			afterLoginUri = Util.getString(request, "redirectUri", "");
		}

		String encodedAfterLoginUri = Util.getUriEncoded(afterLoginUri);

		request.setAttribute("afterLoginUri", afterLoginUri);
		request.setAttribute("encodedAfterLoginUri", encodedAfterLoginUri);
		request.setAttribute("param", param);
		request.setAttribute("paramJson", paramJson);

		// 해당 요청이 ajax 요청인지 아닌지 체크
		boolean isAjax = requestUri.endsWith("Ajax");

		if (isAjax == false) {
			if (param.containsKey("ajax") && param.get("ajax").equals("Y")) {
				isAjax = true;
			}
		}

		if (isAjax == false) {
			if (requestUri.contains("/get")) {
				isAjax = true;
			}
		}

		request.setAttribute("isAjax", isAjax);

		// 설정 파일에 있는 정보를 request에 담는다.
		HttpSession session = request.getSession();

		// 로그인 여부에 관련된 정보를 request에 담는다.
		boolean isLoggedIn = false;
		int loggedInMemberId = 0;
		Member loggedInMember = null;

		if (session.getAttribute("loggedInMemberId") != null) {
			loggedInMemberId = (int) session.getAttribute("loggedInMemberId");
			isLoggedIn = true;
			loggedInMember = memberService.getMemberById(loggedInMemberId);
		}

		request.setAttribute("loggedInMemberId", loggedInMemberId);
		request.setAttribute("isLoggedIn", isLoggedIn);
		request.setAttribute("loggedInMember", loggedInMember);
		
		// 상단 공지사항을 불러오기 위함
		
		Article notice = articleService.getLastestNotice();
		
		if (notice != null) {
			request.setAttribute("lastestNotice", notice);
		}

		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
