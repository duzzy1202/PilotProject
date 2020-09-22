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
		</div>
		<div class="memberList" >
		
		</div>
	</div>
</div>

<script>

	var MemberList__$box = $('.search-member-list-box > .memberList');
	var MemberList__$InsideBox = $('.search-member-list-box > .memberList > .memberInfo');
	//var MemberList__$tbody = ReplyList__$box.find('.memberList');

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
		html += '<div class="member" style="display: flex; justify-content: space-between;">';
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
		html += '</div>';
		
		/*
		html += '<div class="reply-writer">[ ' + reply.extra.writer + ' ]</div>';
		html += '<div class="reply-regdate">( ' + reply.regDate + ' )</div>';
		html += '</div>';
		html += '<div class="reply-body-box">';
		html += '<div class="reply-body">' + reply.forPrintBody + '</div>';
		html += '</div>';
		html += '</div>';
		*/
    

    	var $tr = $(html);
    	$tr.data('data-originBody', member.body);
    	MemberList__$box.prepend($tr);
	}

</script>