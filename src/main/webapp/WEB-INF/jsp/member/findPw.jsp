<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>

<!-- 로그인, 가입 CSS -->
<link rel="stylesheet" href="/resource/css/loginAndJoin.css" />

<script>
	var MemberJoinForm__submitDone = false;
	function MemberJoinForm__submit(form) {
		if (MemberJoinForm__submitDone) {
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

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

			return;
		}

		form.submit();
		MemberJoinForm__submitDone = true;
	}
</script>

<div class="join-box con">
	<div class="empty-space"></div>
	<span>비밀번호 찾기</span>
	<form method="POST" class="join-table-box" action="doFindPw"
	onsubmit="MemberJoinForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="/usr/member/login">

		<div class="subject">
			<div>아이디</div>
			<input type="text" placeholder="로그인 아이디 입력해주세요." name="loginId"
				maxlength="30" autocomplete="off"/>
		</div>
		
		<div class="subject">
			<div>가입시 등록한 이메일</div>
			<input type="email" placeholder="이메일 입력해주세요." name="email"
				maxlength="50" autocomplete="off"/>
		</div>
		
		<div class="login-button-box">
			<button class="button" type="submit" style="width: 100px;">비밀번호 찾기</button>
		</div>
	</form>
	<div class="empty-space"></div>
</div>

<%@ include file="../part/foot.jspf"%>

