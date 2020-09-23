<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보" />

<%@ include file="../part/head.jspf"%>
<link rel="stylesheet" href="/resource/css/admin.css" />

<div class="search-member con">
	<h1 class="block ta-c">회원 찾기 및 빠른 관리</h1>
	<div class="search-member-box">
		<form action="" class="margin-auto" style="width: 400px; display: flex; justify-content: space-around;"
		onsubmit="MemberList__loadMore(this); return false;">
			<select name="selectItemForSearch">
				<option value="id">회원 고유번호</option>
				<option value="loginId">로그인 아이디</option>
				<option value="nickname">닉네임</option>
			</select> 
			<input type="text" name="keyword" placeholder="검색 정보 입력..">
			<input type="submit" value="검색">
		</form>
	</div>
	<div class="search-member-list-box">
		<div class="memberListHead" style="display: flex; justify-content: space-between; font-weight: bold;">
			<div>고유번호</div>
			<div>로그인 아이디</div>
			<div>닉네임</div>
			<div>이메일</div>
			<div>징계 기록</div>
			<div>권한 레벨</div>
			<div>비고</div>
		</div>
		<div class="memberList" >
		
		</div>
	</div>
</div>

<script>

	var MemberList__$box = $('.search-member-list-box > .memberList');
	var MemberList__$InsideBox = $('.search-member-list-box > .memberList > .memberInfo');

	var MemberList__lastLodedId = 0;

	function MemberList__loadMore(form) {

		MemberList__$box.empty();
		
		$.get('/adm/member/getMembersAjax', {
			selectItemForSearch : form.selectItemForSearch.value,
			keyword : form.keyword.value,
			from : MemberList__lastLodedId + 1
		}, MemberList__loadMoreCallback, 'json');
	}

	function MemberList__loadMoreCallback(data) {
		if (data.body.members && data.body.members.length > 0) {
			MemberList__lastLodedId = data.body.members[data.body.members.length - 1].id;
			MemberList__drawMembers(data.body.members);
		}

	}

	function MemberList__drawMembers(members) {
		for (var i = 0; i < members.length; i++) {
			var member = members[i];
			MemberList__drawMember(member);
		}
	}

	function MemberList__drawMember(member) {
		var html = '';
		html += '<div class="member">';

		html += '<div class="member-info" style="display: flex; justify-content: space-between;">';
		
		html += '<div>';
		html += member.id + '';
		html += '</div>';
		html += '<div>';
		html += member.loginId + '';
		html += '</div>';
		html += '<div>';
		html += member.nickname + '';
		html += '</div>';
		html += '<div>';
		html += member.email + '';
		html += '</div>';
		html += '<div>';
		html += member.redLine + '';
		html += '</div>';
		html += '<div>';
		html += member.level + '';
		html += '</div>';
		html += '<div style="display: flex; justify-content: space-around;">';
		html += '<a href="/usr/member/userInfo?id=' + member.id + '">유저정보</a>';
		html += '<a href="#" onclick="javascript:changeDisplayBlock('+ member.id +'); return false;">▼</a>';
		html += '</div>';
		
		html += '</div>';

		html += '<div class="member-management" id="memberManagement-' + member.id + '" style="display: none;">';

		html += '<form class="process-report flex flex-jc-sa" action="/adm/admin/memberManagement">';
		html += '<input type="hidden" name="memberId" value="${member.id}">';
		html += '<span>회원 처리</span>';
		html += '<select name="processMember">';
		html += '<option value="none">조치하지 않음</option>';
		html += '<option value="1day">활동정지 1일</option>';
		html += '<option value="3days">활동정지 3일</option>';
		html += '<option value="7days">활동정지 7일</option>';
		html += '<option value="14days">활동정지 14일</option>';
		html += '<option value="30days">활동정지 30일</option>';
		html += '<option value="90days">활동정지 90일</option>';
		html += '<option value="365days">활동정지 365일</option>';
		html += '<option value="forever">영구 활동정지</option>';
		html += '</select>';
		html += '<span>징계 사유 선택</span> ';
		html += '<select name="selectReason" id="selectReason-' + member.id + '">';
		html += '<option value="none">처리하지 않음</option>';
		html += '<option value="타인에게 심각한 욕설 및 비난을 함">타인에게 심각한 욕설 및 비난을 함</option>';
		html += '<option value="불법적인 행위 포착">불법적인 행위 포착</option>';
		html += '<option value="음란물 게시">음란물 게시</option>';
		html += '<option value="정치적 성향을 과도하게 피력함">정치적 성향을 과도하게 피력함</option>';
		html += '<option value="불법 성인사이트 및 도박사이트 홍보">불법 성인사이트 및 도박사이트 홍보</option>';
		html += '<option value="특정 사상을 과도하게 전파함">특정 사상을 타인에게 과도하게 전파함</option>';
		html += '<option value="아무 의미없는 뻘글">아무 의미없는 뻘글</option>';
		html += '<option value="etc" >기타</option>';
		html += '</select>';
		html += '<input type="text" id="selectETC-' + member.id + '" name="reasonETC" placeholder="징계 사유 직접입력"/> ';
		html += '<input type="submit" value="처리하기">';
		html += '</form>';
		html += '<a href="#" onclick="javascript:changeDisplayNone('+ member.id +'); return false;">닫기</a>';
		
		html += '</div>';

		html += '</div>';
    
		html += '<script>';
		html += '$(function(){ $("#selectETC-' + member.id + '").hide();';
		html += '$("#selectReason-' + member.id + '").change(function() {';
		html += 'if($("#selectReason-' + member.id + '").val() == "etc") { $("#selectETC-' + member.id + '").show();}';
		html += 'else { $("#selectETC-' + member.id + '").hide();} }) });';
		html += '</scrip' + 't>';

		html += '<script>';
		html += 'function changeDisplayBlock(id) {';
		html += 'var memberManagement = document.getElementById(\'memberManagement-\' + id);';
		html += 'memberManagement.style.display = \'block\';}';
		html += 'function changeDisplayNone(id) {';
		html += 'var memberManagement = document.getElementById(\'memberManagement-\' + id);';
		html += 'memberManagement.style.display = \'none\';}';
		html += '</scrip' + 't>';
		
    	var $tr = $(html);
    	$tr.data('data-originBody', member.body);
    	MemberList__$box.prepend($tr);
	}

</script>



