<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 찾기</title>
<link href="${pageContext.request.contextPath}/resources/css/find_id.css" rel="stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$("#search_id").click(function(){
	
	var name = $("#name").val();
	var email = $("#email").val();
	
	$.ajax({
		
		type:"POST",
		url:"look_id",
		async:true,
		dataType:"json",
		data:{"name":name,"email":email},
		success:function(result){
			
			 if(result.error){
                 alert(result.error);
             } else {
                 alert("이름 : " + result.name + "\n아이디 : " + result.id);
             }
			
		},error: function(xhr, status, error){
			console.log(xhr.responseText);
			alert("데이터 전송 과정에서 에러가 발생했습니다.");
		}
		
	});
		
		
	});
	
	
	
});


</script>
</head>
<body>

<div class="main-container">
    <h2>아이디 찾기</h2>
    <input type="text" id="name" placeholder="이름">
    <input type="email" id="email" placeholder="이메일">
    <button id="search_id">아이디 찾기</button>
    <div class="link_text">
        <a id="join" onclick="location.href='member_join'">회원가입하기</a>
        <a id="login" onclick="location.href='login'">로그인하기</a>
    </div>
</div>




</body>
</html>