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
  <button type="button" onclick="location.href='#'">회원탈퇴</button>
  </div>
</div>

</body>
</html>