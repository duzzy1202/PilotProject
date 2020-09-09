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
				<th>닉네임</th>
				<td>${member.nickname}</td>
			</tr>
			<tr>
				<th>활동 정지 기록</th>
				<c:if test="${member.redLine == 0}">
					<td>기록 없음</td>
				</c:if>
				<c:if test="${member.redLine > 0}">
					<td>
						전과 ${member.redLine}범<br>
						<c:forEach var="pnsh" items="${punishments}" >
							${pnsh.count}. ${pnsh.reason} / ${pnsh.regDate}<br>
						</c:forEach>
					</td>
				</c:if>
			</tr>
		</tbody>
	</table>
	<div class="articleList">
		<c:forEach var="article" items="${articles}">
			<div>${article.id} / ${article.title} / ${article.regDate} / ${article.extra.boardName}</div>
		</c:forEach>
	</div>
	
</div>

<%@ include file="../part/foot.jspf"%>