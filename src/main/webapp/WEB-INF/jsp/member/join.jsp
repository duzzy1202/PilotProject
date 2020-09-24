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

		if (form.loginPwConfirm.value.length == 0) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인을 입력해주세요.');

			return;
		}

		if (form.loginPw.value != form.loginPwConfirm.value) {
			form.loginPwConfirm.focus();
			alert('로그인 비밀번호 확인이 일치하지 않습니다.');

			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			form.name.focus();
			alert('이름을 입력해주세요.');

			return;
		}

		form.nickname.value = form.nickname.value.trim();

		if (form.nickname.value.length == 0) {
			form.nickname.focus();
			alert('활동명을 입력해주세요.');

			return;
		}

		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			form.email.focus();
			alert('이메일을 입력해주세요.');

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
	<span>회원가입</span>
	<form method="POST" class="join-table-box" action="doJoin"
		onsubmit="MemberJoinForm__submit(this); return false;">
		<input type="hidden" name="redirectUri" value="/usr/home/main">
		<input type="hidden" name="loginPwReal">

		<div class="subject">
			<div>아이디</div>
			<input type="text" placeholder="로그인 아이디 입력해주세요." name="loginId"
				maxlength="30" autocomplete="off" />
		</div>
		<div class="subject">
			<div>비밀번호</div>
			<input type="password" placeholder="로그인 비밀번호를 입력해주세요." name="loginPw"
				maxlength="30" />
		</div>
		<div class="subject">
			<div>비밀번호 확인</div>
			<input type="password" placeholder="로그인 비밀번호 확인을 입력해주세요."
				name="loginPwConfirm" maxlength="30" />
		</div>
		<div class="subject">
			<div>닉네임</div>
			<input type="text" placeholder="활동명 입력해주세요." name="nickname"
				maxlength="20" autocomplete="off" />
		</div>
		<div class="subject">
			<div>이메일</div>
			<input type="email" placeholder="이메일 입력해주세요." name="email"
				maxlength="50" autocomplete="off" /> 
		</div>
		<span>* 현재 이메일 변경이 불가하므로
				정확히 입력하지 않으면 이메일 인증이 불가할 수 있으니, 정확히 입력해주시길 바랍니다.</span>
		<div class="button-box">
			<button class="button" type="submit">가입</button>
		</div>
	</form>
	<div class="empty-space"></div>
</div>

<%@ include file="../part/foot.jspf"%>