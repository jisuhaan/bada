<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/member_search.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	
<div class="search_form">
<form action="member_search" method="post" name="searchform">
	<div class="search_logo">
	회원 검색
	</div>
	<br>
	<div class="search_contents">
	<div class="search_select">
	<span class="search_title">카테고리&nbsp;</span>
	<select name="search_keyword">
		<option value="user_number">회원 번호</option>
		<option value="id">회원 아이디</option>
		<option value="name">회원 닉네임</option>
	</select>
	</div>
	<input type="text" name="search_value">
	
	<div class="search_select">
	<span class="search_title">회원성별&nbsp;</span>
	<select name="gender">
		<option value="">선택 안 함</option>
		<option value="male">남성</option>
		<option value="female">여성</option>
		<option value="other">밝히고 싶지 않음(기타)</option>
	</select>
	&nbsp;		
	<span class="search_title">회원연령&nbsp;</span>
	<select name="age">
		<option value="0">선택 안 함</option>
		<option value="10">10대 이하</option>
		<option value="20">20대</option>
		<option value="30">30대</option>
		<option value="40">40대</option>
		<option value="50">50대</option>
		<option value="60">60대 이상</option>
	</select>
	</div>
	<br>
	<div class="buttons">
	<button class="btn_2" onclick="document.forms['searchform'].submit();">
	<span id="btn_text">검색하기</span>
	</button>
	</div>
	</div>
	
</form>
</div>
</body>



</html>