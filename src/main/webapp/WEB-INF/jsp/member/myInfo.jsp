<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보" />

<%@ include file="../part/head.jspf"%>

<!-- 회원정보 CSS -->
<link rel="stylesheet" href="/resource/css/myinfo.css" />

<div class="myinfo con">
	<div class="info-table">
		<h2>내 정보</h2>
		<div class="member-info-box">
			<div class="member-info">
				<div class="subject">아이디</div>
				<div class="subject-body">${loggedInMember.loginId}</div>
			</div>
			<div class="member-info">
				<div class="subject">닉네임</div>
				<div class="subject-body">${loggedInMember.nickname}</div>
			</div>
			<div class="member-info">
				<div class="subject">성함</div>
				<div class="subject-body">${loggedInMember.name}</div>
			</div>
			<div class="member-info">
				<div class="subject">활동 평점</div>
				<div class="subject-body">${loggedInMember.rating}</div>
			</div>
			<div class="member-info">
				<div class="subject">활동 정지 기록</div>
				<c:if test="${loggedInMember.redLine == 0}">
					<div class="subject-body">기록 없음</div>
				</c:if>
				<c:if test="${loggedInMember.redLine > 0}">
					<div class="subject-body">
						전과 ${loggedInMember.redLine}범<br>
						<c:forEach var="pnsh" items="${punishments}" >
							${pnsh.count}. ${pnsh.reason} / ${pnsh.regDate}<br>
						</c:forEach>
					</div>
				</c:if>
			</div>
			<div class="member-info">
				<div class="subject">이메일</div>
				<div class="subject-body">${loggedInMember.email}</div>
			</div>
			<div class="member-info">
				<div class="subject">이메일 인증여부</div>
				<div class="subject-body"><c:choose>
						<c:when test="${loggedInMember.level == 1 }">
						미인증 <a href="#" style="color: grey;">메일 인증하기</a>
					</c:when>
						<c:when test="${loggedInMember.level == 2 }">
						인증
					</c:when>
						<c:when test="${loggedInMember.level == 3 }">
						관리자
						<button type="button" onclick="location.href='/adm/admin/adminPage'">관리자 페이지</button>
					</c:when>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<div class="btns flex flex-jc-c">
		<button class="btn btn-margin" type="button" onclick="location.href='/usr/member/checkPw'">정보수정</button>
	</div>
</div>

<%@ include file="../part/foot.jspf"%>