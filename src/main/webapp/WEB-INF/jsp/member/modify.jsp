<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="정보수정" />

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

		form.loginPw.value = form.loginPw.value.trim();

		if (form.loginPw.value.length < 5 && form.loginPw.value.length > 0) {
			form.loginPw.focus();
			alert('비밀번호를 5자 이상 입력해주세요.');

			return;
		}

		if (form.loginPwConfirm.value.length == 0 && form.loginPw.value.length > 0) {
			form.loginPwConfirm.focus();
			alert('비밀번호 확인을 입력해주세요.');

			return;
		}

		if (form.loginPwConfirm.value.length > 0 && form.loginPw.value.length == 0) {
			form.loginPwConfirm.focus();
			alert('비밀번호를 입력하지 않았습니다.');

			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			form.loginPwConfirm.focus();
			alert('비밀번호 확인이 일치하지 않습니다.');

			return;
		}


		form.nickname.value = form.nickname.value.trim();

		if (form.nickname.value.length == 0 && form.loginPw.value.length == 0) {
			form.loginPw.focus();
			alert('아무정보도 입력하지 않았습니다.');

			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';

		form.submit();
		MemberJoinForm__submitDone = true;
	}
</script>

<div class="join-box con">
	<div class="empty-space"></div>
	<span>비밀번호 확인</span>
	<form method="POST" class="join-table-box" action="doCheckPw"
	onsubmit="MemberLoginForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="/usr/member/modify">
		<input type="hidden" name="loginPwReal">

		<div class="subject">
			<div>아이디</div>
			<div style="width: 80%;">${loggedInMember.loginId}</div>
		</div>
		
		<div class="subject">
			<div>비밀번호</div>
			<input type="password" placeholder="로그인 비밀번호를 입력해주세요."
				name="loginPw" maxlength="30" />
		</div>
		
		<div class="subject">
			<div>비밀번호 확인</div>
			<input type="password" placeholder="로그인 비밀번호 확인을 입력해주세요."
				name="loginPwConfirm" maxlength="30" />
		</div>
		
		<div class="subject">
			<div>닉네임</div>
			<input type="text" placeholder=" 현재 닉네임 : ${loggedInMember.nickname}" name="nickname"
				maxlength="20" autocomplete="off"/>
		</div>
		
		<div class="subject">
			<div>이메일</div>
			<div style="width: 80%;">${loggedInMember.email}</div>
		</div>
		
		<span>* 변경을 원하지 않는 항목은 공란으로 두시면 됩니다.</span>
		
		<div class="login-button-box">
			<button class="button" type="submit">확인</button>
		</div>
	</form>
	<div class="empty-space"></div>
</div>

<%@ include file="../part/foot.jspf"%>

