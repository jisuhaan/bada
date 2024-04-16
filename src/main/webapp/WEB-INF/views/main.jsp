<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/097b31c9b8.js" crossorigin="anonymous"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
HttpSession hs = request.getSession();
if(hs.getAttribute("loginstate")==null){
	hs.setAttribute("loginstate", false);
}
%>
<div class="container">
	<div class="main_logo">
		<img src ="./resources/image/로고 9-1.png" width="300px">
	</div>
	<div class="main_search">
		떠나자, &nbsp;
		<input type="text" name="area" id="area" placeholder="지역명을 입력하세요! ex)강원, 강릉">&nbsp;
		<a href="#" onclick="search_area();"><i class="fa-solid fa-magnifying-glass fa-beat fa-xl" style="color: #1B70A6;"></i></a>&nbsp;
		바다로! 
	</div>
	
	<div class="main_container">
		<div class="main_left">바다추천 영역</div>
		<div class="main_right">
			<div class="main_right_top">
			배너 영역
			<a href="#" onclick="window.open('member_try_bbti?id=${loginid}','BBTI 테스트','width=610,height=810,resizable=no,scrollbars=no,menubar=no')">BBTI 테스트</a>
			
			</div>
			<div class="main_right_bottom">
			<jsp:include page="main_recommend_view.jsp" />
			</div>
		</div>
	</div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">


function search_area() {
	
	let area = $("#area").val();
	
	if(area=="" || area.length==1){
		alert("검색어는 두 글자 이상 입력해주세요!");
	}
	else {
		$.ajax({
			url: "main_search",
			type: "GET",
			async: true,
			data: {"area":area},
			dataType:"text",
			success: function(response) {
				
				if(response==''){
					
				}
		
			},
			error:function(xhr, status, error) {
	            console.error(xhr.responseText); 
				alert('데이터 전송과정에서 문제가 발생했습니다!');
			}
		});
	}
}
	
</script>

</body>
</html>