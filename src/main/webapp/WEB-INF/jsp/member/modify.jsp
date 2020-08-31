<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="정보수정" />

<%@ include file="../part/head.jspf"%>

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
<form method="POST" class="table-box con form1 margin-top-20" action="doModify"
	onsubmit="MemberJoinForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/usr/member/myInfo">
	<input type="hidden" name="loginPwReal" >

	<table>
		<colgroup>
			<col width="100">
		</colgroup>
		<tbody>
			<tr>
				<th>아이디</th>
				<td>${loggedInMember.loginId }</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<div class="form-control-box">
						<input type="password" placeholder="로그인 비밀번호를 입력해주세요."
							name="loginPw" maxlength="30" />
						<span>* 비밀번호 변경을 원하지 않는경우, 공란으로 두시면 됩니다.</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<div class="form-control-box">
						<input type="password" placeholder="로그인 비밀번호 확인을 입력해주세요."
							name="loginPwConfirm" maxlength="30" />
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${loggedInMember.name }</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="${loggedInMember.nickname }" name="nickname"
							maxlength="20" autocomplete="off"/>
						<span>* 닉네임 변경을 원하지 않는경우, 공란으로 두시면 됩니다.</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${loggedInMember.email }</td>
			</tr>
		</tbody>
	</table>
	<div class="btns flex flex-jc-c">
		<button class="btn btn-margin" type="submit">수정완료</button>
	</div>
</form>

<%@ include file="../part/foot.jspf"%>