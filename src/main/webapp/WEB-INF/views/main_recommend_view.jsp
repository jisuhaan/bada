<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/main_recommend_view.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
   $(document).ready(function(){
       // 페이지 로드될 때 실행될 코드
       $.ajax({
           url: "recommend_view", // 컨트롤러의 엔드포인트 URL
           type: "GET", // GET 요청
           success: function(response) { // 성공적으로 응답을 받았을 때 실행될 함수
               // 응답을 받아와서 페이지에 표시하는 코드
               console.log("추천페이지 결과 가져오기 성공"); // 응답을 콘솔에 출력 (개발자 도구에서 확인 가능)
           },
           error: function(xhr, status, error) { // 요청이 실패했을 때 실행될 함수
               console.error(xhr.responseText); // 오류 메시지를 콘솔에 출력
           }
       });
   });
</script>

</head>
<body>

<div class="view_container">

	<div class="review_box">
		<div class="review_title"><h3>추천리뷰</h3></div>
		<div class="card-slide">
		
			<div class='slide-track'>
			<c:forEach items="${list}" var="r">
				<div class='slide'>
				  <div class="train-card">
				  	<div class="card-body">
				  		<div class="body-thumbnail"><img src="${pageContext.request.contextPath}/resources/image_user/${r.thumbnail}"></div>
				  	</div>
				  </div>
				</div>
			</c:forEach>
			</div>	
			<!-- 한번 더 반복하기 -->
			<div class='slide-track'>
			<c:forEach items="${list}" var="r">
				<div class='slide'>
				  <div class="train-card">
				  	<div class="card-body">
				  		<div class="body-thumbnail"><img src="${pageContext.request.contextPath}/resources/image_user/${r.thumbnail}"></div>
				  	</div>
				  </div>
				</div>
			</c:forEach>
			</div>					
	
	</div>
	
	</div>
</div>

</body>
</html>