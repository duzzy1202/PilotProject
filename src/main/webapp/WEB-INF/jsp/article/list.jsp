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
	<c:if test="${board.code.equals('kl1') || board.code.equals('kl2') || board.code.equals('kl3') || board.code.equals('kl4') || board.code.equals('wkl') }">
		<div class="leaderBoard">
			<table>
				<thead>
					<tr>
						<th>순위</th>
						<th>구단</th>
						<th>경기수</th>
						<th>승점</th>
						<th>승</th>
						<th>무</th>
						<th>패</th>
						<th>득점</th>
						<th>실점</th>
						<th>득실차</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="club" items="${clubs}">
						<tr>
							<td>${club.ranking}</td>
							<td><a href="/usr/article/${club.clubCode}-clubHouse">${club.name}</a></td>
							<td>${club.play}</td>
							<td>${club.points}</td>
							<td>${club.win}</td>
							<td>${club.draw}</td>
							<td>${club.defeat}</td>
							<td>${club.goal}</td>
							<td>${club.goalAgainst}</td>
							<td>${club.goal - club.goalAgainst}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:if>
	
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
<<c:if test="${isLoggedIn == true }">
<div class="list-btn-box con">
	<a class="list-btn" href="./${board.code}-write">글쓰기</a>
</div>
</c:if>

<%@ include file="../part/foot.jspf"%>