<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원정보" />

<%@ include file="../part/head.jspf"%>
<link rel="stylesheet" href="/resource/css/myinfo.css" />

<div class="dataCenter con">
	<form class="dataCenter-box" action="/home/addData" method="GET">
		<div class="block">
			<div class="flex">
				<span>팀명</span>
				<input type="text" name="name" placeholder="name" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>팀풀네임</span>
				<input type="text" name="fullname" placeholder="fullname" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>팀 코드</span>
				<input type="text" name="clubCode" placeholder="clubCode" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>연고지</span>
				<input type="text" name="location" placeholder="location" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>창단년도</span>
				<input type="text" name="since" placeholder="since" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>감독</span>
				<input type="text" name="coach" placeholder="coach" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>홈구장</span>
				<input type="text" name="homeGround" placeholder="homeGround" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>소속리그ID (k리그1 부터 아래로 1, 2, 3, 4, 5)</span>
				<input type="text" name="leagueId" placeholder="leagueId" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>순위</span>
				<input type="text" name="ranking" placeholder="ranking" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>경기수</span>
				<input type="text" name="play" placeholder="play" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>승점</span>
				<input type="text" name="points" placeholder="points" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>승</span>
				<input type="text" name="win" placeholder="win" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>무</span>
				<input type="text" name="draw" placeholder="draw" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>패</span>
				<input type="text" name="defeat" placeholder="defeat" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>득점</span>
				<input type="text" name="goal" placeholder="goal" autocomplete="off">
			</div>
		</div>
		<div class="block">
			<div class="flex">
				<span>실점</span>
				<input type="text" name="goalAgainst" placeholder="goalAgainst" autocomplete="off">
			</div>
		</div>
		<input type="submit" value="작성완료">
	</form>
</div>