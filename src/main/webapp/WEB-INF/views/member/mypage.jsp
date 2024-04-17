<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet" type="text/css">
<title>바라던 바다 :: 마이페이지</title>

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
  <div class="profile-info">
      <div class="profile-image">
      <img src="./resources/image/profile.png">
    </div>
    <div class="profile-name-email">
      <p><strong>${info.name} 님</strong></p>
      <p>${info.email}</p>
    </div>
  </div>
  <div class="profile-action">
    <button type="button" onclick="location.href='info_modify?id=${info.id}'">나의정보수정</button>
    <button type="button" onclick="confirm_quit()">회원탈퇴</button>
  </div>
   <div class="additional-actions">
        <div class="action-item">
            <button type="button" class="action-button" onclick="location.href='#'">나의 BBTI</button>
        </div>
        <div class="action-item">
            <button type="button" class="action-button" onclick="location.href='my_favorite'">북마크 바다</button>
        </div>
        <div class="action-item">
            <button type="button" class="action-button" onclick="location.href='my_review'">나의 리뷰</button>
        </div>
        <div class="action-item">
            <button type="button" class="action-button" onclick="location.href='my_require'">나의 문의</button>
        </div>
    </div>
</div>

</body>
</html>