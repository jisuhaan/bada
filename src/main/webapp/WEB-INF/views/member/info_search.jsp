<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보 찾기</title>
<link href="${pageContext.request.contextPath}/resources/css/info_search.css" rel="stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $(".tab").click(function(){
        $(".tab").removeClass("active");
        $(this).addClass("active");
        $(".tab-content").hide();
        var activeTab = $(this).attr("id");
        $("#" + activeTab + "-content").show();
    });

    $("#tab-id").click();

    $("#search_id").click(function(){
        var name = $("#name").val();
        var email = $("#email").val();
        
        if (!name || !email) {
            alert("모든 정보를 입력해주세요!");
            return;
        }
        
        $.ajax({
            type: "POST",
            url: "look_id",
            async: true,
            dataType: "json",
            data: {"name": name, "email": email},
            success: function(result){
                if(result.error){
                    alert(result.error);
                } else {
                    alert("이름 : " + result.name + "\n아이디 : " + result.id);
                }
            },
            error: function(xhr, status, error){
                console.log(xhr.responseText);
                alert("데이터 전송 과정에서 에러가 발생했습니다.");
            }
        });
    });

    $("#search_pw").click(function(){
        var id = $("#password_id").val();
        var email = $("#password_email").val();
        
        if (!id || !email) {
            alert("모든 정보를 입력해주세요!");
            return;
        }
        
        $.ajax({
            type: "POST",
            url: "look_pw",
            async: true,
            dataType: "json",
            data: {"id": id, "email": email},
            success: function(result){
                if(result.error){
                    alert(result.error);
                } else {
                    alert(result.name + " 님의 비밀번호 찾기 결과입니다." + "\n비밀번호 : " + result.pw);
                }
            },
            error: function(){
                alert("데이터 전송 과정에서 에러가 발생했습니다.");
            }
        });
    });
});
</script>
</head>
<body>

<div class="logo"><img src="${pageContext.request.contextPath}/resources/image/logo8-1.png" width="300px"></div>

<div class="tab-container">
    <div id="tab-id" class="tab active">아이디 찾기</div>
    <div id="tab-pw" class="tab">비밀번호 찾기</div>
</div>

<div id="tab-id-content" class="tab-content">
    <div class="main-container">
        <h2>아이디 찾기</h2>
        <div class="input-group">
            <input type="text" id="name" placeholder="닉네임">
            <input type="email" id="email" placeholder="이메일">
        </div>
        <div class="button-group">
            <button id="search_id">아이디 찾기</button>
            <button id="login" onclick="location.href='login'">로그인 하기</button>
            <button id="join" onclick="location.href='member_join'">회원가입 하기</button>
        </div>
    </div>
</div>

<div id="tab-pw-content" class="tab-content" style="display:none;">
    <div class="main-container">
        <h2>비밀번호 찾기</h2>
        <div class="input-group">
            <input type="text" id="password_id" placeholder="아이디">
            <input type="email" id="password_email" placeholder="이메일">
        </div>
        <div class="button-group">
            <button id="search_pw">비밀번호 찾기</button>
            <button id="login" onclick="location.href='login'">로그인 하기</button>
        </div>
    </div>
</div>

</body>
</html>
