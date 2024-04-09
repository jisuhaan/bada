<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
    
    var errstack = parseInt(localStorage.getItem("errstack") || "0");
    var banTime = localStorage.getItem("banTime");
    
    if(banTime && new Date().getTime() < parseInt(banTime)) {
        alert("로그인 10회 오류! 로그인이 10분간 금지되었습니다.");
        return; 
    }
    
    if(localStorage.getItem("remember") === "true") {
        $("#remember").prop('checked', true);
        $("#id").val(localStorage.getItem("savedId"));
    } else {
        $("#remember").prop('checked', false);
        $("#id").val('');
    }
    
    
    $("#login_button").click(function(){
        
        var id = $("#id").val();
        var pw = $("#pw").val();
        
        
        if(id=="" || pw=="") {
            alert(id=="" ? "아이디를 입력해주세요!" : "비밀번호를 입력해주세요!");
            return;
        }
        
        $.ajax({
            
            type:"post",
            url:"login_save",
            async:true,
            dataType:"text",
            data:{"id":id,"pw":pw},
            success:function(result){
                
                if(result=="no"){
                    
                    errstack++;
                    localStorage.setItem("errstack", errstack.toString());
                    
                    if(errstack>=3){
                        var userChoice = confirm("로그인 3회 오류! 회원정보를 찾으시겠습니까?");
                        if(userChoice) {
                            window.location = "info_search";
                        } else {
                            window.location = "login";
                        }
                    } else if(errstack === 5){
                        var banUntil = new Date().getTime() + 1*60000; // 1분 추가
                        localStorage.setItem("banTime", banUntil.toString());
                        alert("5회 이상 로그인 실패, 1분 동안 로그인이 금지됩니다.");
                    }
                    
                    else {
                        alert("일치하는 회원정보가 존재하지 않습니다!");
                    }
                } else {
                    alert(id+"님, 로그인 되었습니다!");
                    localStorage.setItem("errstack", "0");
                    window.location.replace("./");
                }
            },
            error: function(){
                alert("데이터 전송 과정에 에러가 발생했습니다!");
            }
            
        });
        
        
        if($("#remember").is(":checked")){
            localStorage.setItem("savedId", id);
            localStorage.setItem("remember", "true");
        } else {
            localStorage.removeItem("savedId");
            localStorage.setItem("remember", "false");
        }
        
        
    });

});

</script>
<title>바라던 바다 :: 로그인</title>
</head>
<body>
<div class="login_video">
<video class="bg-video__content" autoplay muted loop>
	<source src = "./resources/image/sea_movie.mp4" type = "video/mp4">
	<strong>Your browser does not support the video tag.</strong>
</video>
</div>
<div class="bodybox">

<div class="login_main">
	<div class="login_logo1"><img src="./resources/image/로고 9-2.png" width="70px"></div>
	<h1 class="login_logo2">로그인 해볼까요?</h1>
	<div class="login_container">
		<input type="text" name="id" placeholder="ID" id="id" class="input_field">
		<input type="password" name="pw" placeholder="Password" id="pw" class="input_field">
		<div class="remember_id" style="margin-bottom: 20px;">
			<input type="checkbox" id="remember" name="remember">
			<label for="remember">아이디 저장하기</label>
		</div>
	           
		<button id="login_button" class="button_field" >로그인</button>
		<button id="sign_button" class="button_field" onclick="location.href='member_join'">회원가입</button>
	
	<div class="div_line"></div>
	<div class="search_info">
		<a class="forgot" onclick="location.href='info_search'">아이디 / 비밀번호를 잊으셨나요?</a>
	</div>
	</div>

</div>

</div>


</body>
</html>
