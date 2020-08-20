package com.ljh.footballaround.util;

import org.springframework.beans.factory.annotation.Value;

public class mailUtil {
	public static String joinCompleteMailBody(String siteMainUri, String siteName) {
		StringBuilder mailBodySb = new StringBuilder();
		
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		mailBodySb.append("<div>가입해 주셔서 감사합니다.</div>");
		mailBodySb.append("<div>사이트 이용 수칙은 다음과 같습니다.</div>");
		mailBodySb.append("<ul>");
		mailBodySb.append("<li>첫번째 뭐뭐뭐뭐뭐</li>");
		mailBodySb.append("<li>두번째 뭐뭐뭐뭐뭐</li>");
		mailBodySb.append("<li>세번째 뭐뭐뭐뭐뭐</li>");
		mailBodySb.append("<li>네번째 뭐뭐뭐뭐뭐</li>");
		mailBodySb.append("<li>다섯번째 뭐뭐뭐뭐뭐</li>");
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
