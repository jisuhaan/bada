<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<style type="text/css">

*{
	margin:0;
	padding:0;
}

body {
	margin:0;
	padding:0;
	width:600px;
	height:800px;
}

.bbti_body {
	position:relative;
	display:flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	z-index:1;
}

.bbti_btn {
	position:relative;
	margin-top:50px;
	margin-bottom:50px;
	text-align: center;
	z-index:2;
}

</style>
</head>
<body>
	
<div class="bbti_body">
	<input type="hidden" name="id" id="id" value="${id}">
	<img src="./resources/image/bbti_main.png" width="600px" height="800px">
	<div class="bbti_btn bbti_yes"><img src="./resources/image/bbti_yes.png" width="300px"></div>
	<div class="bbti_btn bbti_choose"><img src="./resources/image/bbti_choose.png" width="300px"></div>
	<div class="bbti_btn bbti_no"><img src="./resources/image/bbti_no.png" width="300px"></div>
</div>
	
</body>
</html>