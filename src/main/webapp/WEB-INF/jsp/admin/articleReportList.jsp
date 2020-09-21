<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../part/head.jspf"%>

<!-- 리스트 CSS -->
<link rel="stylesheet" href="/resource/css/admin.css" />

<!-- PC용 -->
<div class="list-box con">
	<h1>미처리 신고 게시판</h1>

	<div class="article-list">
		<div class="thead">
			<div>
				<div>글번호</div>
				<div>제목</div>
				<div>신고 당한 수</div>
				<div>작성일</div>
			</div>
		</div>
		<div class="tbody">
			<c:forEach var="article" items="${articles}" varStatus="status">
				<div>
					<div>${article.id}</div>
					<div><a href="/adm/admin/reportDetail?id=${article.id}">${article.title}</a></div>
					<div>${reportedArticles[status.index].reportedCount}</div>
					<div>${article.regDate}</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<h2><a href="adminPage">돌아가기</a></h2>

</div>

<%@ include file="../part/foot.jspf"%>