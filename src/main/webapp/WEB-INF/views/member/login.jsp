<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">


$(document).ready(function(){
	
	var errstack = 0;
	
	$("#login").click(function(){
		
		var id = $("#id").val();
		var pw = $("#pw").val();
		
		
		$.ajax({
			
			type:"post",
			url:"login_save",
			async:true,
			dataType:"text",
			data:{"id":id,"pw":pw},
			success:function(result){
				
				if(result=="no"){
					
					errstack ++;
					
					if(errstack>=5){
						alert("로그인 5회 오류! 회원가입/회원정보 찾기 창으로 이동합니다!")
						window.location="sign" // 회원가입창으로 이동 or (회원정보 찾기)
					}
					else{
						alert("일치하는 회원정보가 존재하지 않습니다!")
						window.location="login"
					}
					
				}
				else{
					alert(id+"님, 로그인 되었습니다!")
					window.location.replace("./")
				}	
			},
			
			error: function(){
				alert("데이터 전송 과정에 에러가 발생했습니다!")
			}
			
		});
	});
	
});


</script>
<title>바라던 바다 :: 로그인</title>
</head>
<body>

<div class="main">
        <h1 class="logo">bada_login</h1>
        <div class="container">
            <input type="text" name="id" placeholder="ID" id="id" class="account">
            <input type="password" name="pw" placeholder="Password" id="pw" class="account">
            	<button id="login" class="account">로그인</button>
            	<button id="login_search" class="account">회원정보찾기</button>
            	<button id="sign" class="account">회원가입</button>

        </div>
    </div>   


</body>
</html>