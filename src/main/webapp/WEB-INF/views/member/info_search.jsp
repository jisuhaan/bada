<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
  .photo_idpw {
	  display: flex;
	  flex-direction: row; /* 수평 나열 */
	  align-items: center; /* 수직 중앙 정렬 */
	  justify-content: center; /* 수평 중앙 정렬 */
	  flex-wrap: wrap; /* 필요에 따라 요소들을 다음 줄로 넘김 */
	  padding-top: 60px; /* 상단에서 떨어지는 거리 */
	  height: calc(100vh - 100px); /* 상단 패딩을 제외한 높이 */
  }
  .photo_idpw img {
    margin: 0 40px; /* 이미지 사이의 좌우 간격 조절 */
  	max-width: 50%; /* 반응형 디자인을 위해 이미지 최대 너비를 50%로 설정 */
 	height: auto; /* 이미지의 원래 비율을 유지 */
  }

</style>

<meta charset="UTF-8">
<title>유저 로그인 정보 찾기</title>
<body>


<div class="photo_idpw">
<img src="./resources/image/idid.png" width="500px" onclick="location.href='find_id'">
<img src="./resources/image/pwpw.png" width="500px" onclick="location.href='find_pw'">
</div>

</body>
</html>