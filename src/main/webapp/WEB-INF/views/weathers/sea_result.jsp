<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/sea_result.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/slide.css" rel="stylesheet" type="text/css">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>

<div class="result_container">

<div class="sea_result_left">
	<div class="sea_result_left_top">
	<div class="info_box">
	<br>
	<span id="beach_name">${bdt.beach_name}</span>
	<br>
	<div class="info_detail">	
		<div class="info_slider" width="300px" height="300px">
			<div class="slide slide_wrap">
			  <div class="slide_item item1">
			  <img src="./resources/image/${bdt.picture1}"></div>
			  <div class="slide_item item2">
			  <img src="./resources/image/${bdt.picture2}"></div>
			  <div class="slide_item item3">
			  <img src="./resources/image/${bdt.picture3}"></div>
			  <div class="slide_prev_button slide_button">＜</div>
			  <div class="slide_next_button slide_button">＞</div>
			  <ul class="slide_pagination"></ul>
			</div>
		</div>
	</div>	
		<div class="info_text">
		<br><hr><br>
		${bdt.infomation}
		</div>
	
	</div>
	</div>
	
	<div class="sea_result_left_bottom">
	<div class="info_box in_bottom">
		<div id="map"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=513793c3569011c75762309c9b3a2138"></script>
			<script>
			
		    var latitude = "${bldt.latitude}";
		    var longitude = "${bldt.longitude}";
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
			        level: 4 // 지도의 확대 레벨
			    };
			
			var map = new kakao.maps.Map(mapContainer, mapOption);
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			var iwContent = '<div class="in_map_text">${bdt.beach_name}<br><br><a href="https://map.kakao.com/link/map/${bdt.beach_name},${bldt.latitude},${bldt.longitude}" style="color:blue" target="_blank">자세히보기</a> <a href="https://map.kakao.com/link/to/${bdt.beach_name},${bldt.latitude},${bldt.longitude}" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwPosition = new kakao.maps.LatLng(latitude, longitude); //인포윈도우 표시 위치입니다
			
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
			  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 
			</script>
			
			<div class="info_text2">
				<h3>바다 안내</h3>
				<br><hr><br>
				주소 : ${bdt.address}<br>
				편의시설 : ${bdt.accomodation}<br>
				특징 : ${bdt.special}<br><br>
				<h4>많이 달린 해시태그</h4><br>
			</div>
		</div>
	</div>
</div>

<div class="sea_result_right">

<div class="weatherbox">
<span id="beach_name">날씨 정보 요약</span>
<br><br><hr><br><br>
<div id="today_weather">
<span id="weather_title">${bdt.beach_name} 의 오늘의 날씨</span>
<br><br><hr><br><br>
어쩌고저쩌고...
</div>
<div><a href="sea_weather_detail?beachName=${bdt.beach_name}">날씨 자세히 보기</a></div>
<div id="weather_info">
<script type="text/javascript">
	var beachName = "${bdt.beach_name}";
	var beach_code = "${bdt.beach_code}";
	var nx = "${bldt.grid_x}";
	var ny = "${bldt.grid_y}";
</script>
</div>
</div>

</div>

</div>

<script src="./resources/js/slide.js"></script>

</body>
</html>