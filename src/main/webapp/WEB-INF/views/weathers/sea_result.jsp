<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
document.addEventListener("DOMContentLoaded", function() {
	var fcstDate = ${bldt.ultraSrtFcstBeach_dto.fcstDate};
    var fcstTime = ${bldt.ultraSrtFcstBeach_dto.fcstTime};
    var hour = parseInt(fcstTime.toString().substring(0, 2));  // 시간 부분만 떼오기
    var month = parseInt(fcstDate.toString().substring(4, 6));
    var sky = parseInt(${bldt.ultraSrtFcstBeach_dto.sky});
    var pty = parseInt(${bldt.ultraSrtFcstBeach_dto.pty});
    
    console.log(weatherEmoticon(sky, pty, hour, month));
    document.getElementById("weatherIcon").innerHTML = weatherEmoticon(sky, pty, hour, 50, 50);
  });
  
function weatherEmoticon(sky, pty, hour, month, w, h) {
    let imgSrc, title;
    const width = w; // 기본 너비
    const height = h; // 기본 높이

    if (pty === 0 && 6 <= hour && hour <= 18) {
        switch (sky) {
            case 1:
            	if(3 <= month <= 5){
            		imgSrc = "./resources/image/날씨_맑음_봄.gif";
            	}else{
            		imgSrc = "./resources/image/날씨_맑음_기본.gif";
            	}
                title = "날씨 맑음";
                break;
            case 3:
                imgSrc = "./resources/image/날씨_구름_낮.gif";
                title = "구름 많음";
                break;
            case 4:
                imgSrc = "./resources/image/날씨_흐림.gif";
                title = "날씨 흐림";
                break;
            default:
                alert('날씨 값이 들어오지 않았습니다.');
                break;
        }
    } else if (pty !== 0) {
        switch (pty) {
            case 1:
                imgSrc = "./resources/image/날씨_비.gif";
                title = "날씨 비";
                break;
            case 2:
                imgSrc = "./resources/image/날씨_비와눈.png";
                title = "날씨 비와 눈";
                break;
            case 3:
                imgSrc = "./resources/image/날씨_눈.gif";
                title = "날씨 눈";
                break;
            case 4:
                imgSrc = "./resources/image/날씨_소나기.gif";
                title = "날씨 소나기";
                break;
            case 5:
                imgSrc = "./resources/image/날씨_빗방울.gif";
                title = "날씨 빗방울";
                break;
            case 6:
                imgSrc = "./resources/image/날씨_빗방울눈날림.png";
                title = "날씨 빗방울눈날림";
                break;
            case 7:
                imgSrc = "./resources/image/날씨_눈날림.png";
                title = "날씨 눈날림";
                break;
            default:
                break;
        }
    } else if (pty === 0) {
        switch (sky) {
            case 1:
                imgSrc = "./resources/image/날씨_맑음_밤.gif";
                title = "밤 날씨 맑음";
                break;
            case 3:
                imgSrc = "./resources/image/날씨_구름_밤.gif";
                title = "밤 구름 많음";
                break;
            case 4:
                imgSrc = "./resources/image/날씨_흐림.gif";
                title = "밤 흐림";
                break;
            default:
                alert('날씨 값이 들어오지 않았습니다.');
                break;
        }
    }

    console.log('타이틀: ' + title);
    return '<img src="' + imgSrc + '" alt="' + title + '"title="' + title + '" width="' + width + '" height="'+ height + '"/>'
}

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
<div id="beach_name">날씨 정보 요약</div>
<br>

<div class="today_container">
	<div class="clock_by_hour"></div>
	<div class="name_beach"></div>
	<div class="todays now">
		<div class="weather nowing">
			<span id="today_text">현재 날씨는...</span><br>
			<div id="weatherIcon"></div>
		</div>
		<div class="weather tempt">
			<span id="today_text">현재 기온은...</span><br>
			<div class="temperature_text"><span id="nowTemperature">20</span><img src="./resources/image/forecast_celsius.gif" width="100px"></div>
		</div>
	</div>
</div>

<br><br>
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