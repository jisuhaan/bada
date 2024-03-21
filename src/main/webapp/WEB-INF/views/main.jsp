<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/slide.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
HttpSession hs = request.getSession();
if(hs.getAttribute("loginstate")==null){
	hs.setAttribute("loginstate", false);
}
%>

이곳은 메인화면...
    
</body>
</html>