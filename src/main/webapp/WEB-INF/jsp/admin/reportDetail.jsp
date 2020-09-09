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
								<video controls src="/usr/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}"></video>
							</div>
						</c:if>
						<c:if test="${file.fileExtTypeCode == 'img'}">
							<div class="img-box img-box-auto">
								<img src="/usr/file/img?id=${file.id}&updateDate=${file.updateDate}" alt="" />
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
		<c:if test="${report.isProcessed == 0}">
		<div class="process-report-box" style="padding: 20px;">
			<h2>처리하기</h2>
			<form class="process-report flex flex-jc-sa" action="/adm/admin/processReport">
				<input type="hidden" name="memberId" value="${member.id}">
				<input type="hidden" name="articleId" value="${article.id}">
				<input type="hidden" name="reportedType" value="Article">
				<span>게시글 처리</span>
				<select name="processArticle">
					<option value="none">처리하지 않음</option>
					<option value="delete">삭제 처리</option>
				</select>
				<span>작성 회원 처리</span>
				<select name="processMember">
					<option value="none">처리하지 않음</option>
					<option value="1day">활동정지 1일</option>
					<option value="3days">활동정지 3일</option>
					<option value="7days">활동정지 7일</option>
					<option value="14days">활동정지 14일</option>
					<option value="30days">활동정지 30일</option>
					<option value="90days">활동정지 90일</option>
					<option value="365days">활동정지 365일</option>
					<option value="forever">영구 활동정지</option>
				</select>
				<span>징계 사유 선택</span> 
				<select name="selectReason" id="selectReason">
					<option value="none">처리하지 않음</option>
					<option value="타인에게 심각한 욕설 및 비난을 함">타인에게 심각한 욕설 및 비난을 함</option>
					<option value="불법적인 행위 포착">불법적인 행위 포착</option>
					<option value="음란물 게시">음란물 게시</option>
					<option value="정치적 성향을 과도하게 피력함">정치적 성향을 과도하게 피력함</option>
					<option value="불법 성인사이트 및 도박사이트 홍보">불법 성인사이트 및 도박사이트 홍보</option>
					<option value="특정 사상을 타인에게 과도하게 전파함">특정 사상을 타인에게 과도하게 전파함</option>
					<option value="기타" >기타</option>
				</select>
				<input type="text" id="selectETC" name="reasonETC" placeholder="징계 사유 직접입력"/> 
				<input type="submit" value="처리하기">
			</form>
		</div>
		</c:if>
		<c:if test="${report.isProcessed == 1}">
			<div>이미 처리된 신고</div>
		</c:if>
	</div>
</div>

<%@ include file="../part/foot.jspf"%>

<script>

$(function(){
      //직접입력 인풋박스 기존에는 숨어있다가
$("#selectETC").hide();
$("#selectReason").change(function() {
                //직접입력을 누를 때 나타남
		if($("#selectReason").val() == "기타") {
			$("#selectETC").show();
		}  else {
			$("#selectETC").hide();
		}
	}) 
});
</script>