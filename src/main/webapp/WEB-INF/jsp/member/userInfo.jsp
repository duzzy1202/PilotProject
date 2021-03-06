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
				<div class="subject-body">${member.nickname}
					<c:if test="${member.delStatus == 1}">
						(탈퇴한 회원)
					</c:if>
				</div>
			</div>
			<div class="member-info">
				<div class="subject">활동 평점</div>
				<div class="subject-body">${member.rating} 점</div>
			</div>
			<div class="member-info">
				<div class="subject">활동 정지 기록</div>
				<c:if test="${member.redLine == 0}">
					<div class="subject-body">기록 없음</div>
				</c:if>
				<c:if test="${member.redLine > 0}">
					<div class="subject-body">
						 ${member.redLine} 회<br>
						<c:forEach var="pnsh" items="${punishments}" >
							${pnsh.count}. / ${pnsh.reason} / ${pnsh.regDate}<br>
						</c:forEach>
					</div>
				</c:if>
			</div>
			<div class="member-info">
				<div class="subject">평점주기</div>
				<c:if test="${ratedPoint == null}">
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
				</c:if>
				<c:if test="${ratedPoint != null}">
					<div class="subject-body"> 이미 평가를 한 회원입니다.(${ratedPoint}점)</div>
				</c:if>
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