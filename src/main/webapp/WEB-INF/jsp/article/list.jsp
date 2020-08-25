<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../part/head.jspf"%>

<!-- 리스트 CSS -->
<link rel="stylesheet" href="/resource/css/articleList.css" />

<!-- PC용 -->
<div class="table-box con visible-on-md-up">
	<h1>${board.name}게시판</h1>
	<c:if test="${board.leagueId == 1 || board.leagueId == 2 || board.leagueId == 5 }">
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
							<td>${club.name}</td>
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
	<table>
		<colgroup>
			<col width="100" />
			<col width="200" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>제목</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
				<tr>
					<td>${article.id}</td>
					<td>${article.regDate}</td>
					<td><a href="${article.getDetailLink(board.code)}">${article.forPrintTitle}</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
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

<div class="btn-box con margin-top-20">
	<a class="btn btn-primary" href="./${board.code}-write">글쓰기</a>
</div>

<%@ include file="../part/foot.jspf"%>