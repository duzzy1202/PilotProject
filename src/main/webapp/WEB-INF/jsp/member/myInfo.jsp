<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보" />

<%@ include file="../part/head.jspf"%>

<!-- 회원정보 CSS -->
<link rel="stylesheet" href="/resource/css/myinfo.css" />

<div class="myinfo con">
	<table>
		<h2>회원정보</h2>
		<tbody class="member-info-box">
			<tr>
				<th>아이디</th>
				<td>${loggedInMember.loginId}</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>${loggedInMember.nickname}</td>
			</tr>
			<tr>
				<th>성함</th>
				<td>${loggedInMember.name}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${loggedInMember.email}</td>
			</tr>
			<tr>
				<th>이메일 인증여부</th>
				<td><c:choose>
						<c:when test="${loggedInMember.level == 1 }">
						미인증 <a href="#" style="color: grey;">메일 인증하기</a>
					</c:when>
						<c:when test="${loggedInMember.level == 2 }">
						인증
					</c:when>
						<c:when test="${loggedInMember.level == 3 }">
						관리자
						<button class="update-clubdata-btn" type="button" onclick="location.href='/home/updateClubData'">
							데이터 업데이트
						</button>
						<button type="button" onclick="location.href='/home/dataCenter'">데이터 센터</button>
					</c:when>
					</c:choose>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="btns flex flex-jc-c">
		<button class="btn btn-margin" type="button" onclick="location.href='/member/checkPw'">정보수정</button>
	</div>
</div>

<%@ include file="../part/foot.jspf"%>