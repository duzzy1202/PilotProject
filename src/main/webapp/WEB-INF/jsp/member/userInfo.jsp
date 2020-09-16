<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보" />

<%@ include file="../part/head.jspf"%>

<!-- 회원정보 CSS -->
<link rel="stylesheet" href="/resource/css/myinfo.css" />
<div class="myinfo con">
	<div class="info-table">
		<h2>회원정보</h2>
		<div class="member-info-box">
			<div class="member-info">
				<div class="subject">닉네임</div>
				<div class="subject-body">${member.nickname}</div>
			</div>
			<div class="member-info">
				<div class="subject">활동 평점</div>
				<div class="subject-body">${member.rating}</div>
			</div>
			<div class="member-info">
				<div class="subject">활동 정지 기록</div>
				<c:if test="${member.redLine == 0}">
					<div class="subject-body">기록 없음</div>
				</c:if>
				<c:if test="${member.redLine > 0}">
					<div class="subject-body">
						전과 ${member.redLine}범<br>
						<c:forEach var="pnsh" items="${punishments}" >
							${pnsh.count}. ${pnsh.reason} / ${pnsh.regDate}<br>
						</c:forEach>
					</div>
				</c:if>
			</div>
			<div class="member-info">
				<div class="subject">평점주기</div>
				<form class="subject-rating" action="/usr/member/rateUser">
					<c:forEach var="i" begin="1" end="5">
						<input type="radio" id="rating_${i}" name="rating" value="${i}">
						<label for="rating_${i}">${i}.0</label>
					</c:forEach>
					<br>
					<c:forEach var="i" begin="6" end="10">
						<input type="radio" id="rating_${i}" name="rating" value="${i}">
						<label for="rating_${i}">${i}.0</label>
					</c:forEach>
					<input type="hidden" name="ratedMemberId" value="${member.id}">
					<input type="submit" value="평가">
				</form>
			</div>
		</div>
	</div>
	<div class="articleList">
		<h2>작성한 글 목록</h2>
		<div class="articleList-box">
			<c:forEach var="article" items="${articles}">
				<div class="article">
					<div>${article.id}</div>
					<div><a href="/usr/article/${article.extra.boardCode}-detail?id=${article.id}">${article.title}</a></div>
					<div>${article.extra.boardName} 게시판</div>
					<div>${article.regDate}</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

<%@ include file="../part/foot.jspf"%>