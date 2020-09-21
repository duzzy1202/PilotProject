<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../part/head.jspf"%>

<!-- 리스트 CSS -->
<link rel="stylesheet" href="/resource/css/articleList.css" />

<!-- PC용 -->
<div class="list-box con">
	<h1> 검색한 키워드 " ${keyword} "</h1>

	<h2> 게시물을 제목으로 검색한 결과</h2>
		<c:forEach var="article" items="${searchTitleResultArticles}">
			<div> <a href="/usr/article/detail?id=${article.id}">${article.title}</a> / ${article.extra.writer} / ${article.regDate}</div>
		</c:forEach>
	<br>	
	<h2> 게시물을 내용으로 검색한 결과</h2>
		<c:forEach var="article" items="${searchBodyResultArticles}">
			<div> <a href="/usr/article/detail?id=${article.id}">${article.title}</a> / ${article.extra.writer} / ${article.regDate}</div>
		</c:forEach>
	
	<br>
	<h2> 댓글을 검색한 결과</h2>
		<c:forEach var="reply" items="${searchResultReplies}">
			<div> <a href="/usr/article/detail?id=${reply.relId}">${reply.body}</a> / ${reply.extra.writer} / ${reply.regDate}</div>
		</c:forEach>
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
<c:if test="${isLoggedIn == true }">
<div class="list-btn-box con">
	<a class="list-btn" href="./${board.code}-write">글쓰기</a>
</div>
</c:if>

<%@ include file="../part/foot.jspf"%>