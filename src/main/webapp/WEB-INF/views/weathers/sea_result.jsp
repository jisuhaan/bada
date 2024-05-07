<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/sea_result.css" rel="stylesheet" type="text/css">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script src="./resources/js/sea_weatherEmoticon.js"></script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    var fcstDate = ${bldt.ultraSrtFcstBeach_dto.fcstDate};
    var fcstTime = ${bldt.ultraSrtFcstBeach_dto.fcstTime};
    console.log(fcstTime);
    var hour = parseInt(fcstTime.toString().slice(0, -2));  // 00 삭제하여 시간 부분만 남기기
    var month = parseInt(fcstDate.toString().substring(4, 6));
    var sky = parseInt(${bldt.ultraSrtFcstBeach_dto.sky});
    var pty = parseInt(${bldt.ultraSrtFcstBeach_dto.pty});
    console.log(weatherEmoticon(sky, pty, hour, month));
    document.getElementById("weatherIcon").innerHTML = weatherEmoticon(sky, pty, hour, month, 50, 50);
  
    const elements = document.querySelectorAll('.todays');
    elements.forEach((element, index) => {
        setTimeout(() => {
            element.classList.remove('hidden');
            element.style.opacity = '1'; // 투명도를 1로 설정하여 페이드 인 효과 적용
        }, index * 500); // 각 요소가 0.5초 간격으로 나타나도록 설정
    });

 });
 
</script>
</head>
<body>

<%
HttpSession hs = request.getSession();
if(hs.getAttribute("loginstate")==null){
	hs.setAttribute("loginstate", false);
}
%>

<div class="result_container">

   <div class="sea_result_left">
      <div class="sea_result_left_top">
      <div class="info_box">
      <br>
      <span id="beach_name">${bdt.beach_name}</span>
      <br>
      <div class="info_detail">   
         <div class="info_slider">
              <div><img src="./resources/image/${bdt.picture1}"></div>
              <div><img src="./resources/image/${bdt.picture2}"></div>
              <div><img src="./resources/image/${bdt.picture3}"></div>
         </div>
         <script type="text/javascript">
            $(document).ready(function(){
   
                $('.info_slider').slick({
                  slide: 'div',
                  dots: false,
                  arrows: false,      
                  infinite: true,
                  adaptiveWidth: true,
                  adaptiveHeight: true,
                   autoplay:true,
                   autoplaySpeed: 2000,
                  speed: 500,
                  fade: true,
                  draggable: true,
                  cssEase: 'linear'
                });
                
            });   
         </script>
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
             
             console.log("카카오맵에 들어갈 위도 : "+latitude+", 경도 : "+longitude);
            
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
               <b>주소</b> : ${bdt.address}<br>
               <b>편의시설</b> : ${bdt.accomodation}<br>
               <b>주변특징</b> : ${bdt.special}<br><br>
               <h4>많이 달린 해시태그</h4><br>
               <div class="hashtag_best">
               <c:forEach items="${hashtags}" var="hashtag">
                  <div id="hash">${hashtag}</div>
               </c:forEach>
               
               </div>
            </div>
         </div>
      </div>
   </div>
   
   <div class="sea_result_right">
   
      <div class="weatherbox">
      <div id="beach_name">날씨 정보 요약</div>
      
      <div class="today_container">
         <div id="clock_by_hour"></div>
         <div class="name_beach">${bdt.beach_name}의</div>
         <div class="todays now1 hidden">
            <div class="weather nowing">
               <span id="today_text">현재 날씨는</span><br>
               <div id="weatherIcon"></div>
            </div>
            <div class="weather tempt">
               <span id="today_text">현재 기온은</span><br>
               <div class="temperature_text"><span id="nowTemperature">${bldt.ultraSrtFcstBeach_dto.t1h}</span>&nbsp;<img src="./resources/image/forecast_celsius.gif" width="50px"></div>
            </div>
        	 <c:if test="${bldt.ultraSrtFcstBeach_dto.rn1 ne '강수없음'}">
            <div class="weather nowing">
               <span id="today_text">시간당 강수</span><br>
               <div class="etc_text"><img src="./resources/image/forecast_umbrella.gif" width="50px">&nbsp;
	               <c:choose>
	               <c:when test="${fn:length(bldt.ultraSrtFcstBeach_dto.rn1)<4}">
	               		<span id="hour_rain">${bldt.ultraSrtFcstBeach_dto.rn1}</span>
	               </c:when>
	               <c:otherwise>
	               		<span id="hour_rain2">${bldt.ultraSrtFcstBeach_dto.rn1}</span>
	               </c:otherwise>
	               </c:choose>
               </div>
            </div>
        	</c:if>
         </div>
         <div class="todays now2 hidden">
            <div class="weather tempt">
               <span id="today_text">최고 기온은</span><br>
               <div class="temperature_text"><img src="./resources/image/forecast_hot.gif" width="50px">&nbsp;<span id="highTemperature">${bldt.bada_tmx_n_dto.tmx}</span></div>
            </div>
            <div class="weather tempt">
               <span id="today_text">최저 기온은</span><br>
               <div class="temperature_text"><img src="./resources/image/forecast_cold.gif" width="50px">&nbsp;<span id="lowTemperature">${bldt.bada_tmx_n_dto.tmn}</span></div>
            </div>
            <div class="weather tempt">
               <span id="today_text">바다 수온은</span><br>
               <div class="temperature_text"><img src="./resources/image/forecast_wave.gif" width="50px">&nbsp;<span id="lowTemperature">
               <c:choose>
                  <c:when test="${bldt.bada_tw_dto.water_temp eq '-°C'}">정보 없음</c:when>
                  <c:when test="${bldt.bada_tw_dto.water_temp ne '-°C'}">${bldt.bada_tw_dto.water_temp}</c:when>
               </c:choose>
               </span></div>
            </div>
         </div>
         <div class="todays now3 hidden">
            <div class="weather nowing">
               <span id="today_text">일출 시각은</span><br>
               <div class="sun_text"><img src="./resources/image/forecast_sunrise.gif" width="50px">&nbsp;<span id="sunrise"></span></div>
            </div>
            <div class="weather tempt">
               <span id="today_text">일몰 시각은</span><br>
               <div class="sun_text"><img src="./resources/image/forecast_sunset.gif" width="50px">&nbsp;<span id="sunset"></span></div>
            </div>
         </div>
      <div class="todays now4 hidden">
         <c:if test="${warningString ne '없음'}">
            <div class="weather nowing cast">
               <span id="today_text">발표된 특보</span><br>
               <div class="etc_text"><img src="./resources/image/forecast_radio.gif" width="50px">&nbsp;<span id="warning">${warningString}</span></div>
            </div>
         </c:if>
         <c:if test="${not empty WthrWrnMsg}">
            <div class="weather holding cast">
               <span id="today_text">유지중 특보</span><br>
               <div class="etc_text"><img src="./resources/image/forecast_radio.gif" width="50px">&nbsp;
               <div class="warninglist">
                   <c:forEach items="${WthrWrnMsg}" var="wrn">
                       <div id="warning">${wrn}</div>
                     </c:forEach>
               </div>
               </div>
            </div>
         </c:if>
      </div>
      
      <script type="text/javascript">
        function formatTime(rawTime) {
            // 입력된 문자열에서 시와 분을 추출
            let hour = rawTime.substring(0, 2);
            let minute = rawTime.substring(2);
      
            // 시와 분을 ":"로 연결하여 반환
            return hour + ":" + minute;
         }
      
      // 예시: "1854"를 "18:54"로 변환하여 반환
      
           let formattedSunriseTime = formatTime("${bldt.lc_rise_set_info_dto.sunrise}");
           let formattedSunsetTime = formatTime("${bldt.lc_rise_set_info_dto.sunset}");
           document.getElementById("sunrise").innerText = formattedSunriseTime;
           document.getElementById("sunset").innerText = formattedSunsetTime;
      </script>
        
      </div>
      
      <br><br>
      <div class="sea_detail" onclick="window.location.href='sea_weather_detail?beach_code=${bdt.beach_code}'">
         <img alt="" src="./resources/image/forecast_detail.png" width="40px">
         <span id="detail_text">자세히 보기 →</span>
      </div>
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

<script src="./resources/js/clockmain.js"></script>

</body>
</html>