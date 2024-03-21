<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
어디로 가볼까요?<br>
<input type="text" name="area" id="area" placeholder="지역명을 입력하세요! ex)강원">
</div>

<div class="mains">
<div class="mainleft">
<div class="mainmaps">
<object type="image/svg+xml" data="./resources/svg/southKoreamap.svg" width="620px" height="800px">
</object>
</div>
</div>
<div class="mainright">
<div class="righttop"></div>
<div class="rightbottom"></div>
</div>
</div>
</body>
</html>