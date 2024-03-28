<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/forecast.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
<div class="seamain">
<div class="seamainleft">
	<div class="seamainmaps">
	<span id="maptext">가고싶은 지역을 선택해보세요!</span>
	<object type="image/svg+xml" data="./resources/svg/southKoreamap.svg" width="650px" height="800px" id="selectmap"></object>
		<div class="map">
			<ul class="map-step1"><!--링크 클릭 시 해당지역 추가-->
				<li class="kyungin">
					<a class="" href="javascript:void(0);">
					<img src="./resources/image/경인-01.png" width="100px">
					</a>
				</li>
				<li class="gangwon">
					<a class="" href="javascript:void(0);">
					<img src="./resources/image/강원-01.png" width="100px">
					</a>
				</li>
				<li class="chungnam">
					<a class="" href="javascript:void(0);">
					<img src="./resources/image/충남-01.png" width="100px">
					</a>
				</li>
				<li class="jeonbuk">
					<a class="" href="javascript:void(0);">
					<img src="./resources/image/전북-01.png" width="100px">
					</a>
				</li>
				<li class="jeonnam">
					<a class="" href="javascript:void(0);">
					<img src="./resources/image/전남-01.png" width="100px">
					</a>
				</li>
				<li class="kyungbuk">
					<a class="" href="javascript:void(0);">
					<img src="./resources/image/경북-01.png" width="100px">
					</a>
				</li>
				<li class="kyungnam">
					<a class="" href="javascript:void(0);">
					<img src="./resources/image/경남-01.png" width="100px">
					</a>
				</li>
				
				<li class="buul">
					<a class="" href="javascript:void(0);">
					<img src="./resources/image/부울-01.png" width="100px">
					</a>
				</li>
				<li class="jeju">
					<a class="" href="javascript:void(0);">
					<img src="./resources/image/제주-01.png" width="100px">
					</a>
				</li>
			</ul>
			</div>
		</div>	
	
</div>
<div class="seamainright">
<div class="searighttop"></div>
<div class="searightbottom"></div>
</div>
</div>
</body>
</html>