<%@ page import="com.ljh.footballaround.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 상세내용" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>

<!-- 리스트 CSS -->
<link rel="stylesheet" href="/resource/css/detail.css" />

<div class="article-detail con">
	<div class="article-detail-thead"></div>
	<div class="detail-boardname">
		<span>${board.name} 게시판</span>
	</div>
	<div class="detail-table">
		<div class="detail-box-title">
			<div class="detail-title">${article.forPrintTitle}</div>
		</div>
		<div class="detail-box-etc">
			<div class="detail-writer">${article.extra.writer}</div>
			<div class="detail-regDate">${article.regDate}</div>
		</div>
		<div class="detail-body">
			<script type="text/x-template">${article.body}</script>
            <div class="toast-editor toast-editor-viewer"></div>
		</div>
		<c:forEach var="i" begin="1" end="3" step="1">
			<c:set var="fileNo" value="${String.valueOf(i)}" />
			<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
			<c:if test="${file != null}">
				<div>
					<span>첨부파일 ${fileNo}</span>
					<span>
						<c:if test="${file.fileExtTypeCode == 'video'}">
							<div class="video-box">
								<video controls src="/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}"></video>
							</div>
						</c:if>
						<c:if test="${file.fileExtTypeCode == 'img'}">
							<div class="img-box img-box-auto">
								<img src="/file/img?id=${file.id}&updateDate=${file.updateDate}" alt="" />
							</div>
						</c:if>
					</span>
				</div>
			</c:if>
		</c:forEach>
		<div class="writer-info flex flex-jc-sa" style="text-align: center;">
			<div style="margin: 10px;">
				<div>번호</div>
				<div>${member.id}</div>
			</div>
			<div style="margin: 10px;">
				<div>닉네임</div>
				<div>${member.nickname}</div>
			</div>
			<div style="margin: 10px;">
				<div>이름</div>
				<div>${member.name}</div>
			</div>
			<div style="margin: 10px;">
				<div>아이디</div>
				<div>${member.loginId}</div>
			</div>
			<div style="margin: 10px;">
				<div>가입날짜</div>
				<div>${member.regDate }</div>
			</div>
			<div style="margin: 10px;">
				<div>전과</div>
				<div>${member.redLine }</div>
			</div>
			<div style="margin: 10px;">
				<div>이메일</div>
				<div>${member.email}</div>
			</div>
			<div style="margin: 10px;">
				<div>레벨</div>
				<div>${member.level}</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../part/foot.jspf"%>