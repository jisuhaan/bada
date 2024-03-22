<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form id="findForm" action="find_check_id" method="post">
	<div class="form-group">
    	<input type="text" name="name" id="name" placeholder="이름">
    </div>
    <div class="form-group">
    	<input type="email" name="email" id="email" placeholder="이메일">
    </div>
    <button type="submit" id="id-find" onclick="#">아이디 찾기</button>
</form>




</body>
</html>