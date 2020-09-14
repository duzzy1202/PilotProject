<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="메인" />
<%@ include file="../part/head.jspf"%>
<div class="con">
	<h1> 0.1 Ver aaaa</h1>
	<h2> 구현된 기능들 </h2>
	<ul>
		<li> ○ 게시판 관련 </li>
		<li>  - 국내축구, 해외축구, 기타, 공지사항 게시판 이용 가능</li>
		<li>  - 국내축구 게시판은 K리그 1, K리그 2, K3 리그, K4 리그, WK리그 게시판 이용 가능</li>
		<li>  - K리그 1 클럽팀들 클럽하우스 게시판 이용 가능</li>
		<li>  - K리그 1 클럽팀 클럽하우스 중 울산, 수원 게시판만 이미지 작업 완료</li>
		<br>
		<li> ○ 회원기능 관련 </li>
		<li>  - 회원가입, 로그인, 로그아웃 기능 구현 </li>
		<li>  - 아이디 찾기, 비밀번호 찾기 기능 구현 </li>
		<li>  - 회원정보에서 비밀번호 및 닉네임 변경기능 구현 </li>
		<li>  - 이메일 인증은 아직 미구현 </li>
		<br>
		<li> ○ 데이터베이스 관련 </li>
		<li>  - K리그 1, K리그 2, K3 리그, K4 리그, WK리그 모든 팀들 데이터 등록 </li>
		<li>  - 관리자 계정으로 K리그 1, K리그 2 의 리그 데이터를 가져와 업데이트 할수있음 </li>
		<li>  - K3, K4, WK 리그는 직접 수기로 업데이트 해야함 </li>
		<li>  - 수기로 데이터를 등록할수 있는 관리자 화면 구현 </li>
		<br>
		<li> ○ 게시판 관리 관련 </li>
		<li>  - 게시물 상세보기에 신고 추가 </li>
		<li>  - 관리자 페이지에 신고된 게시물 관리 게시판 추가 (미처리, 처리) </li>
		<li>  - 댓글 신고 게시판 추가중 </li>
		<li>  -  </li>
		
	</ul>
	<img src="/resource/img/jotduya.jpg" width="1200px" height="690px">
</div>

<%@ include file="../part/foot.jspf"%>