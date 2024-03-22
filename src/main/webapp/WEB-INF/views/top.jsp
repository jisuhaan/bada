<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/097b31c9b8.js" crossorigin="anonymous"></script>
</head>
<body>
<nav class="navbar">
	<div class="navbar__logo">
		<a href="./">바라는 바다!</a>
	</div>
	<ul class="navbar__menu">
		<li class="navbar__menud"><a href="#">회원관리</a>
			<div class="navbar__dropdown">
			<ul>
				<li class="navbar__dropdownli"><a href="member_join">회원등록</a></li>
				<li class="navbar__dropdownli"><a href="member_out">회원출력</a></li>
			</ul>
			</div>
		</li>
			<li class="navbar__menud"><a href="#">바다정보</a>
			<div class="navbar__dropdown">
			<ul>
				<li class="navbar__dropdownli"><a href="#">바다정보</a></li>
				<li class="navbar__dropdownli"><a href="#">후기정보</a></li>
			</ul>
			</div>
		</li>
	</ul>
	<ul class="navbar__icons">

<c:choose>
	<c:when test="${loginstate==true}">
		<li class="navbar__menud" id="myinfo">
		<a href="mypage">${loginid} 님의<br>마이페이지</a>
		</li>
		<li class="navbar__menud">
		<a href="logout">로그아웃</a>
		</li>
	</c:when>
	<c:otherwise>
		<li class="navbar__menud">
		<a href="member_input">가입하기</a>
		</li>
		<li class="navbar__menud">
		<a href="login">로그인</a>
		</li>
	</c:otherwise>
</c:choose>
	</ul>
</nav>
</body>
</html>