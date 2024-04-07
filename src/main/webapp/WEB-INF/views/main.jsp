<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/097b31c9b8.js" crossorigin="anonymous"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
HttpSession hs = request.getSession();
if(hs.getAttribute("loginstate")==null){
	hs.setAttribute("loginstate", false);
}
%>
<div class="container">
	<div class="main_logo">
		<img src ="./resources/image/로고 9-1.png" width="300px">
	</div>
	<div class="main_search">
		떠나자, &nbsp;
		<input type="text" name="area" id="area" placeholder="지역명을 입력하세요! ex)강원">&nbsp;
		<a href="#"><i class="fa-solid fa-magnifying-glass fa-beat fa-xl" style="color: #1B70A6;"></i></a>&nbsp;
		바다로! 
	</div>
	
	<div class="main_container">
		<div class="main_left">바다추천 영역</div>
		<div class="main_right">
			<div class="main_right_top">배너 영역</div>
			<div class="main_right_bottom">베스트 추천 영역</div>
		</div>
	</div>
</div>
</body>
</html>