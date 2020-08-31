<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보" />

<%@ include file="../part/head.jspf"%>

<div class="adminPage con">
	<div class="buttonbox" style="padding: 15px;">
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/newData'" >새 데이터 추가</button>
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/updateData'" >데이터 업데이트</button>
		<button type="button" style="padding: 15px;" onclick="location.href='/adm/admin/crwalData'" >크롤링 데이터 (K리그 1,2)</button>
	</div>
</div>
