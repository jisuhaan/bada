<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/097b31c9b8.js" crossorigin="anonymous"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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

<div class="mainsearch">
<span id="searchtext">떠나자, </span>
<input type="text" name="area" id="area" placeholder="지역명을 입력하세요! ex)강원" class="searchbar">&nbsp;
<a href="#"><i class="fa-solid fa-magnifying-glass fa-beat fa-xl" style="color: #1B70A6;"></i></a>&nbsp;
<span id="searchtext"> 바다로!</span>
</div>

<div class="mains">
<div class="mainleft"></div>
<div class="mainright">
<div class="righttop">지역별 추천글(베스트) 영역</div>
<div class="rightbottom">날씨, 나도한마디</div>
</div>
</div>
</body>
</html>