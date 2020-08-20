<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />
<%@ include file="../part/head.jspf"%>

<script>
	var MemberJoinForm__submitDone = false;
	function MemberJoinForm__submit(form) {
		if (MemberJoinForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			form.name.focus();
			alert('이름을 입력해주세요.');

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
<form method="POST" class="table-box con form1" action="doFindId"
	onsubmit="MemberJoinForm__submit(this); return false;">
	<input type="hidden" name="redirectUri" value="/member/login">

	<table>
		<colgroup>
			<col width="100">
		</colgroup>
		<tbody>
			<tr>
				<th>이름</th>
				<td>
					<div class="form-control-box">
						<input type="text" placeholder="이름을 입력해주세요." name="name"
							maxlength="20" autocomplete="off"/>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div class="form-control-box">
						<input type="email" placeholder="이메일 입력해주세요." name="email"
							maxlength="50" autocomplete="off"/>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="btns flex flex-jc-c">
		<button class="btn btn-margin" type="submit">아이디 찾기</button>
	</div>
</form>

<%@ include file="../part/foot.jspf"%>