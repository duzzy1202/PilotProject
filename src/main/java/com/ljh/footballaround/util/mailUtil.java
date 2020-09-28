package com.ljh.footballaround.util;

import org.springframework.beans.factory.annotation.Value;

public class mailUtil {
	public static String joinCompleteMailBody(String siteMainUri, String siteName) {
		StringBuilder mailBodySb = new StringBuilder();
		
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append("<div>가입해 주셔서 감사합니다.</div>");
		mailBodySb.append("<div>사이트 이용 수칙은 다음과 같습니다.</div>");
		mailBodySb.append("<ul>");
		mailBodySb.append("<li>1) 불법적인 행위는 엄격히 금합니다. </li>");
		mailBodySb.append("<li>2) 타인에게 불쾌감을 줄 수 있는 게시물 또는 댓글 작성을 금합니다.</li>");
		mailBodySb.append("<li>3) 당사자가 수치심을 느낄 수 있는 성희롱 격의 내용의 게시물 또는 댓글 작성을 금합니다.</li>");
		mailBodySb.append("<li>4) 불법 도박, 불법 성인사이트 등의 광고 글은 삭제 조치 및 영구적 활동정지 조치가 될 수 있습니다.</li>");
		mailBodySb.append("</ul>");
		mailBodySb.append("<div>이상입니다. 감사합니다.</div>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a>메인으로 이동</p>", siteMainUri, siteName));
		
		
		return mailBodySb.toString();
	}

	public static String findIdMailBody(String siteMainUri, String siteName, String name, String loginId) {
		StringBuilder mailBodySb = new StringBuilder();
		
		mailBodySb.append("<div>요청하신 [ " + name + " ]님의 아이디입니다.</div>");
		mailBodySb.append("<div>[ " + loginId + " ]</div>");
		mailBodySb.append("<div>감사합니다.</div>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a> 메인으로 이동</p>", siteMainUri, siteName));
		
		return mailBodySb.toString();
	}

	public static String findPwMailBody(String siteMainUri, String siteName, String name, String tempPw) {
		StringBuilder mailBodySb = new StringBuilder();
		
		mailBodySb.append("<div>요청하신 [ " + name + " ]님의 임시비밀번호 입니다.</div>");
		mailBodySb.append("<div>[ " + tempPw + " ]</div>");
		mailBodySb.append("<div>위의 임시비밀번호로 로그인 하신 후, [회원정보] - [정보변경]에서 비밀번호를 변경해주시길 바랍니다.</div>");
		mailBodySb.append(String.format("<p><a href=\"%s\" target=\"_blank\">%s</a> 메인으로 이동</p>", siteMainUri, siteName));
		
		return mailBodySb.toString();
	}
}
