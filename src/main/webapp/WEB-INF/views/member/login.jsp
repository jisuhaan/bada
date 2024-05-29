<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    var banTime = localStorage.getItem("banTime");

    // 밴 시간 확인
    if (banTime && new Date().getTime() < parseInt(banTime)) {
        alert("로그인 5회 연속 오류로 로그인이 1분간 금지되었습니다.");
        
        return;
    } else if (banTime && new Date().getTime() >= parseInt(banTime)) {
        localStorage.removeItem("banTime");
        localStorage.setItem("errstack", "0");
        return;
    }

    if (localStorage.getItem("remember") === "true") {
        $("#remember").prop('checked', true);
        $("#id").val(localStorage.getItem("savedId"));
    } else {
        $("#remember").prop('checked', false);
        $("#id").val('');
    }
    
    // 엔터 키 이벤트 추가
    $(".login_container").keypress(function(event) {
        if (event.which == 13) { // 13은 엔터 키의 키코드
            $("#login_button").click();
        }
    });

    $("#login_button").click(function(){
        var id = $("#id").val();
        var pw = $("#pw").val();
        var bbti = $("#bbti").val();

        if(id=="" || pw=="") {
            alert(id=="" ? "아이디를 입력해주세요!" : "비밀번호를 입력해주세요!");
            return;
        }

        var loginAttempts = parseInt(localStorage.getItem(id) || "0");

        if (loginAttempts === 5) {
            var banUntil = parseInt(localStorage.getItem("banTime"));
            if (new Date().getTime() < banUntil) {
                alert("로그인 연속 5회 오류! 1분 동안 로그인이 금지됩니다.");
                $("#pw").val('');
                if (!$("#remember").is(":checked")) {
                    $("#id").val('');
                }
                return;
            } else {
                localStorage.setItem(id, "0");
                localStorage.removeItem("banTime");
                loginAttempts = 0;
            }
        }
        
        $.ajax({
            type: "post",
            url: "login_save",
            async: true,
            dataType: "text",
            data: {"id": id, "pw": pw, "bbti": bbti},
            success: function(result) {
                if (result == "no") {
                    loginAttempts++;
                    localStorage.setItem(id, loginAttempts);
                    if (loginAttempts === 5) {
                        var banUntil = new Date().getTime() + 1 * 60000;
                        localStorage.setItem("banTime", banUntil.toString());
                        alert("로그인 5회 오류! 해당 아이디로 1분 동안 로그인이 금지됩니다.");
                        $("#pw").val('');
                        if (!$("#remember").is(":checked")) {
                            $("#id").val('');
                        }
                        return;
                    } else if (loginAttempts === 3) {
                        var userChoice = confirm("로그인 3회 오류! 회원정보를 찾으시겠습니까?");
                        if (userChoice) {
                            window.location = "info_search";
                        }
                    } else {
                        alert("로그인 실패!");
                    }
                    
                    $("#pw").val('');
                    
                    if (!$("#remember").is(":checked")) {
                        $("#id").val('');
                    }
                    
                } else {
                    alert(id + "님, 로그인 되었습니다!");
                    localStorage.setItem(id, "0");
                    window.location.replace("./");
                }
            },
            error: function() {
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

    $("#sign_button").click(function(){
        var bbti = $("#bbti").val();
        if(bbti.trim()===""||bbti==null){
            window.location.href="member_join";
        } else {
            window.location.href="join_with?bbti="+bbti;
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
        <input type="hidden" name="bbti" id="bbti" value="${bbti}">
        <div class="remember_id" style="margin-bottom: 20px;">
            <input type="checkbox" id="remember" name="remember">
            <label for="remember">아이디 저장하기</label>
        </div>
        <button id="login_button" class="button_field" >로그인</button>
        <button id="sign_button" class="button_field">회원가입</button>
        <div class="div_line"></div>
        <div class="search_info">
            <a class="forgot" onclick="location.href='info_search'">아이디 / 비밀번호를 잊으셨나요?</a>
        </div>
    </div>
</div>
</div>
</body>
</html>
