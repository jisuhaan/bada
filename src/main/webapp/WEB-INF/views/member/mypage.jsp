<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>바라던 바다 :: 마이페이지</title>
<style type="text/css">

  .profile-card {
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    width: 300px;
    margin: 20px;
    text-align: center;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    margin-right: 20px;
    position: absolute;
    top:50%;
    left:50%;
    margin-top: 150px;
    
  }

  .profile-image img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
  }

  .profile-info {
    margin-top: 20px;
  }

  .profile-action {
    margin-top: 20px;
  }

  .profile-action button {
    padding: 10px 20px;
    background-color: blue;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-bottom: 10px;
  }
</style>

<script type="text/javascript">
function confirm_quit() {
    var user_check = confirm("정말 탈퇴하시겠습니까?");
    
    if (user_check) {
        var password = prompt("비밀번호를 입력해주세요.");
        
        if (password !== null && password !== "") {

            $.ajax({
                type: "POST",
                url: "checkPassword", // 서버의 비밀번호 검증 및 회원 탈퇴 처리 경로
                data: { password: password },
                success: function(result) {
                    if (result === "yes") {
                        alert("회원 탈퇴가 완료되었습니다.");
                        window.location.href = 'quit'; // 로그아웃 및 로그인 페이지로 이동
                    } else {
                        alert("비밀번호가 일치하지 않습니다.");
                    }
                },
                error: function() {
                    alert("오류가 발생했습니다. 다시 시도해주세요.");
                }
            });
        } else {
            alert("비밀번호 입력이 취소되었습니다.");
        }
    }
}


</script>
</head>
<body>

<div class="profile-card">
  <div class="profile-image">
    <img src="./resources/image/profile.png">
  </div>
  <div class="profile-info">
    <p><strong>${info.name}</strong></p>
    <p>${info.email}</p>
  </div>
  <div class="profile-action">
  <button type="button" onclick="location.href='info_modify?id=${info.id}'">나의정보수정</button>
  <button type="button" onclick="location.href='#'">북마크바다</button>
  <button type="button" onclick="location.href='#'">나의게시글</button>
  <button type="button" onclick="confirm_quit()">회원탈퇴</button>
  </div>
</div>

</body>
</html>