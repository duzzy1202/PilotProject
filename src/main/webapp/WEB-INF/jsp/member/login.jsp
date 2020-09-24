<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="로그인" />

<%@ include file="../part/head.jspf"%>

<!-- 로그인, 가입 CSS -->
<link rel="stylesheet" href="/resource/css/loginAndJoin.css" />


<script>
	var MemberLoginForm__submitDone = false;
	function MemberLoginForm__submit(form) {
		if (MemberLoginForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.loginId.value = form.loginId.value.trim();
		form.loginId.value = form.loginId.value.replaceAll('-', '');
		form.loginId.value = form.loginId.value.replaceAll('_', '');
		form.loginId.value = form.loginId.value.replaceAll(' ', '');

		if (form.loginId.value.length == 0) {
			form.loginId.focus();
			alert('로그인 아이디를 입력해주세요.');

			return;
		}

		if (form.loginId.value.length < 4) {
			form.loginId.focus();
			alert('로그인 아이디 4자 이상 입력해주세요.');

			return;
		}

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length == 0) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 입력해주세요.');

			return;
		}

		if (form.loginPw.value.length < 5) {
			form.loginPw.focus();
			alert('로그인 비밀번호를 5자 이상 입력해주세요.');

			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';

		form.submit();
		MemberLoginForm__submitDone = true;
	}
</script>
<div class="join-box con">
	<div class="empty-space"></div>
	<span>로그인</span>
	<form method="POST" class="join-table-box" action="doLogin"
	onsubmit="MemberLoginForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="/usr/home/main">
		<input type="hidden" name="loginPwReal">

		<div class="subject">
			<div>아이디</div>
			<input type="text" placeholder="로그인 아이디 입력해주세요." name="loginId"
				maxlength="30" autofocus="autofocus" autocomplete="off"/>
		</div>
		<div class="subject">
			<div>비밀번호</div>
			<input type="password" placeholder="로그인 비밀번호를 입력해주세요."
				name="loginPw" maxlength="30" autocomplete="off"/>
		</div>
		
		<div class="login-button-box">
			<button class="button" type="submit">로그인</button>
			<button class="button" type="button" onclick="location.href='/usr/member/findId'">아이디 찾기</button>
			<button class="button" type="button" onclick="location.href='/usr/member/findPw'">비밀번호 찾기</button>
		</div>
	</form>
	<div class="empty-space"></div>
</div>

<%@ include file="../part/foot.jspf"%>

