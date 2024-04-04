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

<div class="sea_result_main">

<div class="sea_result_left">
	<div class="sea_result_left_top">
	<div class="info_box">
	<span id="beach_name">${bdt.beach_name}</span>
	<br><br><hr><br><br>
		
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
		
		<div class="info_text">
		<h3>바다 소개</h3>
		<br><hr><br>
		${bdt.infomation}
		</div>
	
	</div>
	</div>
	
	<div class="sea_result_left_bottom">
	<div class="info_box inbottom">
		<div id="map" style="width:280px;height:280px;"></div>
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
			
			var iwContent = '<div class="inmaptext">${bdt.beach_name}<br><br><a href="https://map.kakao.com/link/map/${bdt.beach_name},${bldt.latitude},${bldt.longitude}" style="color:blue" target="_blank">자세히보기</a> <a href="https://map.kakao.com/link/to/${bdt.beach_name},${bldt.latitude},${bldt.longitude}" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwPosition = new kakao.maps.LatLng(latitude, longitude); //인포윈도우 표시 위치입니다
			
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
			  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 
			</script>
			
			<div class="info_text">
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
<div><a href="sea_weather_detail?beachName=${bdt.beach_name}">날씨 자세히 보기</a></div>
<div id="weather-info">
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
<script type="text/javascript">
//Date 함수
var currentDate = new Date();
// 날짜 변수
var year = currentDate.getFullYear();
var month = (currentDate.getMonth() + 1).toString().padStart(2, '0'); // 문자열의 최종 길이를 2로 설정. 문자열의 길이가 그보다 짧으면 앞에 0을 붙이기
var day = currentDate.getDate().toString().padStart(2, '0');
var dateString = year+ month + day;

var yesterday = year + month + (currentDate.getDate() - 1).toString().padStart(2, '0');

// 시간 변수 -> 얘네는 기본으로 2자리로 설정
var hours = currentDate.getHours();
var minutes = currentDate.getMinutes().toString().padStart(2, '0');

// 초단기 예보 basetime에 맞게 설정
function setToThirtyMinutes(){
	if (minutes > 30){
		return hours.toString().padStart(2, '0') + '30';
	}
	else{
		return (hours - 1).toString().padStart(2, '0') + '30';
	}
}

// 초단기 예보 fcsttime에 맞게 설정
function setToTopOfHour(){
	if (minutes > 30){
		return (hours + 1).toString().padStart(2, '0') + '00';
	}else{
		return hours.toString().padStart(2, '0') + '00'
	}
}

document.addEventListener("DOMContentLoaded", function() {
	console.log(latitude);
	fetchWeather(beach_code);
});

function fetchWeather(beach_code) {
    return getUltraSrtFcstBeach(beach_code)
        .then(ultraSrtFcstBeachData => {
            console.log("Ultra Srt Fcst Beach Data:", ultraSrtFcstBeachData);
            return getVilageFcstBeach(beach_code);
        })
        .then(vilageFcstBeachData => {
            console.log("Vilage Fcst Beach Data:", vilageFcstBeachData);
            // 다음 처리를 계속할 수 있습니다.
            return vilageFcstBeachData;
        });
};

function getUltraSrtFcstBeach(beach_code) {
	// API 호출
    var url = 'http://apis.data.go.kr/1360000/BeachInfoservice/getUltraSrtFcstBeach'; /*URL*/
    var serviceKey = 'QWzzzAb%2FUIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J%2BlicoY1Dffo51%2Fi5HTDfU00ZpDy2E4%2FASt2FgLknaA%3D%3D'; /*Service Key*/
    var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + serviceKey;
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('54');
    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
    queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON');
    queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent(dateString);
    queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent(setToThirtyMinutes());
    queryParams += '&' + encodeURIComponent('beach_num') + '=' + beach_code;
  	
    console.log('초단기예보 링크 : ' + url + queryParams);
    return fetch(url + queryParams)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
       return groupByLatestFcstTime(data.response.body.items.item);
    })
    .catch(error => {
        console.error('Fetch Error', error);
        throw error; // 에러를 상위로 전파
    });
}

function getVilageFcstBeach(beach_code) {
    // API 호출
    var url = 'http://apis.data.go.kr/1360000/BeachInfoservice/getVilageFcstBeach'; /*URL*/
    var serviceKey = 'QWzzzAb%2FUIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J%2BlicoY1Dffo51%2Fi5HTDfU00ZpDy2E4%2FASt2FgLknaA%3D%3D'; /*Service Key*/
    var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + serviceKey;
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('290');
    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
    queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON');
    queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent(yesterday);
    queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent('2300');
    queryParams += '&' + encodeURIComponent('beach_num') + '=' + beach_code;
    console.log('단기예보 링크 : ' + url + queryParams);

    return fetch(url + queryParams)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
       var originalData = data.response.body.items.item;
       var extractedItems = originalData.filter(item => item.category === 'TMN' || item.category === 'TMX'); // 최저기온과 최고기온만 분리
       
       // 변경된 JSON 데이터 출력
       console.log(extractedItems);
       
       return getTMNnTMX(extractedItems); 
    })
    .catch(error => {
        console.error('Fetch Error', error);
        throw error; // 에러를 상위로 전파
    });
}

function getLCRiseSetInfo(latitude, longitude) {
	// API 호출
    var url = 'http://apis.data.go.kr/B090041/openapi/service/RiseSetInfoService/getLCRiseSetInfo'; /*URL*/
    var serviceKey = 'QWzzzAb%2FUIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J%2BlicoY1Dffo51%2Fi5HTDfU00ZpDy2E4%2FASt2FgLknaA%3D%3D'; /*Service Key*/
    var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + serviceKey;
    queryParams += '&' + encodeURIComponent('longitude') + '=' + encodeURIComponent(longitude);
    queryParams += '&' + encodeURIComponent('latitude') + '=' + encodeURIComponent(latitude);
    queryParams += '&' + encodeURIComponent('locdate') + '=' + encodeURIComponent(dateString);
    queryParams += '&' + encodeURIComponent('dnYn') + '=' + encodeURIComponent('y');
    console.log('단기예보 링크 : ' + url + queryParams);

    return fetch(url + queryParams)
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
       var originalData = data.response.body.items.item;
       var extractedItems = originalData.filter(item => item.category === 'TMN' || item.category === 'TMX'); // 최저기온과 최고기온만 분리
       
       // 변경된 JSON 데이터 출력
       console.log(extractedItems);
       
       return getTMNnTMX(extractedItems); 
    })
    .catch(error => {
        console.error('Fetch Error', error);
        throw error; // 에러를 상위로 전파
    });
}

//가장 최근의 fcstTime 기준으로 데이터를 그룹화하는 함수
function groupByLatestFcstTime(data) {
	var dataObject = {};
	dataObject["fcstDate"] = data[0].fcstDate;
	dataObject["fcstTime"] = data[0].fcstTime;
	
	data.forEach(item =>{
		if(data[0].fcstTime === item.fcstTime){
			dataObject[item.category] = item.fcstValue;
		}
	});
	
	console.log('배열 처리 이후');
    console.log(JSON.stringify(dataObject)); // 처리된 결과를 JSON 형태로 출력합니다.
	return JSON.stringify(dataObject);
}

//가장 최근의 fcstTime 기준으로 데이터를 그룹화하는 함수
function getTMNnTMX(data) {
	var dataObject = {};
	dataObject["fcstDate"] = data[0].fcstDate;
	
	data.forEach(item =>{
		dataObject[item.category] = item.fcstValue;
	});
	
	console.log('배열 처리 이후');
    console.log(dataObject); // 처리된 결과를 JSON 형태로 출력합니다.
	return JSON.stringify(dataObject);
}

</script>

</body>
</html>