<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보" />

<%@ include file="../part/head.jspf"%>
<link rel="stylesheet" href="/resource/css/admin.css" />

<div class="adminPage con">
	<h1>관리자 페이지</h1>
	<h2>데이터 관리 센터</h2>
	<div class="dataCenterBox flex flex-jc-sa" style="padding: 15px; border: 2px solid green;">
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/newData'" >새 데이터 추가</button>
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/updateData'" >데이터 업데이트</button>
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/crwalData'" >크롤링 데이터 (K리그 1,2)</button>
	</div>
	<h2>신고 관리 센터</h2>
	<div class="articleCenterBox flex flex-jc-sa" style="padding: 15px; border: 2px solid red;">
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/articleReportList'" >미처리 신고 게시판</button>
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/processedArticleReportList'" >처리된 신고 게시판</button>
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/replyReportList'" >미처리 신고 댓글 게시판</button>
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/processedReplyReportList'" >처리된 신고 댓글 게시판</button>
	</div>
	<h2>회원 관리 센터</h2>
	<div class="articleCenterBox flex flex-jc-sa" style="padding: 15px; border: 2px solid blue;">
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/searchMember'" >회원 찾기 및 빠른 관리</button>
		<button type="button" style="padding: 15px;" onclick="location.href='#'" >미사용 버튼</button>
		<button type="button" style="padding: 15px;" onclick="location.href='#'" >미사용 버튼</button>
		<button type="button" style="padding: 15px;" onclick="location.href='#'" >미사용 버튼</button>
	</div>
	<h2>신고 관리 센터</h2>
	<div class="articleCenterBox flex flex-jc-sa" style="padding: 15px; border: 2px solid black;">
		<button type="button" style="padding: 15px;" onclick="location.href='#'" >게시물 찾기 및 빠른 관리</button>
		<button type="button" style="padding: 15px;" onclick="location.href='#'" >미사용 버튼</button>
		<button type="button" style="padding: 15px;" onclick="location.href='#'" >미사용 버튼</button>
		<button type="button" style="padding: 15px;" onclick="location.href='#'" >미사용 버튼</button>
	</div>
</div>
