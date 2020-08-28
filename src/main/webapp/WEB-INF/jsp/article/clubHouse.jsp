<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../part/head.jspf"%>

<!-- 리스트 CSS -->
<link rel="stylesheet" href="/resource/css/articleList.css" />

<!-- PC용 -->
<div class="list-box con">
	<h1>[${board.name}] 게시판</h1>
	<div class="clubData-chart">
		<div class="clubData-chart-left">
			<div class="leagueName cl">
				<img src="/resource/img/logo_${club.leagueId}.png"> 
				<span><a href="/article/${clubLeague.code}-list">대한민국 ${clubLeague.name}</a></span>
			</div>
			<div class="club-logo cl">
				<img src="/resource/img/emblem/logo_${club.clubCode}.png">
			</div>
			<div class="club-fullname cl">
				<span>${club.fullname}</span>
			</div>
			<div class="mascot cl">
				<div class="cl">마스코트</div>
				<img src="/resource/img/mascot/mascot_${club.clubCode}.png">
			</div>
		</div>
		<div class="clubData-chart-right">
			<div>
				<div>
					<span class="item">연고지</span>
					<span>${club.location}</span>
				</div>
				<div>
					<span class="item">창단년</span>
					<span>${club.since }</span>
				</div>
			</div>
			<div>
				<div>
					<span class="item">홈 구장</span>
					<span>${club.homeGround }</span>
				</div>
				<div>
					<span class="item">감독</span>
					<span>${club.coach }</span>
				</div>
			</div>
			<div>
				<div>
					<span class="item">현재 순위</span>
					<span>${club.ranking}</span>
				</div>
				<div>
					<span class="item">승점</span>
					<span>${club.points}</span>
				</div>
			</div>
			<div>
				<div>
					<span class="item">홈 유니폼</span>
					<img src="/resource/img/uniform/uniform_home_${club.clubCode}.png">
				</div>
				<div>
					<span class="item">원정 유니폼</span>
					<img src="/resource/img/uniform/uniform_away_${club.clubCode}.png">
				</div>
			</div>
		</div>
	</div>

	<div class="article-list">
		<table>
			<colgroup>
				<col width="100" />
				<col width="200" />
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${articles}" var="article">
					<tr>
						<td>${article.id}</td>
						<td><a href="${article.getDetailLink(board.code)}">${article.forPrintTitle}</a></td>
						<td>${article.extra.writer}</td>
						<td>${article.regDate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<!-- 모바일 용 -->
<!-- 
<div class="table-box con visible-on-sm-down">
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<tr>
					<td>${article.id}</td>
					<td>
						<a href="${article.getDetailLink(board.code)}">${article.forPrintTitle}</a>
						<br />
						날짜 : ${article.regDate}
						<br />
						작성 : ${article.extra.writer}
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
 -->
<
<c:if test="${isLoggedIn == true }">
	<div class="list-btn-box con">
		<a class="list-btn" href="./${board.code}-write">글쓰기</a>
	</div>
</c:if>

<%@ include file="../part/foot.jspf"%>