<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/sea_detail.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">

<!-- ECharts library -->
<script src="https://cdn.jsdelivr.net/npm/echarts@5.2.1/dist/echarts.min.js"></script>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script src="./resources/js/loading.js"></script>
<script src="./resources/js/beachForecastDate.js"></script>

<script>
    var beach_code = ${beach_code};
</script>

<script type="text/javascript">
   function changeColor(selected){
      
      var categories = document.querySelectorAll('.fcsbtn');
      
       categories.forEach(function(category) {
           // 모든 카테고리 박스의 배경색을 투명으로 설정
           category.style.backgroundColor = 'transparent';
       });
       // 선택된 카테고리의 배경색을 노란색으로 설정
       selected.style.backgroundColor = '#CDE4F2';
       
   }
</script>
<title>Insert title here</title>

</head>
<body>

<div class="container">

<div id="main_title">${choicebeach.beach} : 날씨 정보</div>

<div class="forecast_container">

   <div id="titles"><단기예보></div>
   
   <div class="contents forecasts">
      <c:if test="${empty groupedData}">
          현재 API 오류로 단기 예보를 띄울 수 없습니다. 새로고침을 시도하시거나, 일정 시간이 지난 후 다시 페이지에 방문해주세요.
      </c:if>
      
      <c:if test="${not empty groupedData}">
      <div class="forecast_btn">
         <div class="fcsbtn fcstoday" onclick="changeColor(this)">오늘</div>
         <div class="fcsbtn fcsnextday" onclick="changeColor(this)">내일</div>
         <div class="fcsbtn fcsdayafttommorrow" onclick="changeColor(this)">모레</div>
      </div>
      <div class="forecast_div">
         <ul id="table_label">
            <li>시간</li>
            <li id="weather_label">날씨</li>
            <li> </li>
            <li>강수확률</li>
            <li>강수량</li>
            <li>기온</li>
            <li>습도</li>
            <li>바람</li>
            <li>파고</li>
         </ul>
         <c:set var="timeLoop" value="0"/>
         <c:forEach var="dateEntry" items="${groupedData}" varStatus="loop">
         <c:if test="${loop.index lt 3}">
         <div class="forecast_box box${loop.index} hidden">
            <c:forEach var="timeEntry" items="${dateEntry.value}">
               <!-- 숨김으로 가져올 항목들 -->
               <div class="hidden" id="sky_${timeLoop}">${timeEntry.value.sky}</div>
               <div class="hidden" id="pty_${timeLoop}">${timeEntry.value.pty}</div>
               <div class="hidden" id="fcstDate_${timeLoop}">${timeEntry.value.fcstDate}</div>
               <div class="hidden" id="fcstTime_${timeLoop}">${timeEntry.value.fcstTime}</div>
               <ul>
                  <li>${timeEntry.value.fcstTime}</li>
                  <li id = "weatherIcon_${timeLoop}"></li>
                  <li>${timeEntry.value.pop}%</li>
                  <c:choose>
                     <c:when test="${timeEntry.value.rn1 eq '강수없음' || timeEntry.value.rn1 eq '1mm 미만'}">
                     <li id="li_smallsize">${timeEntry.value.rn1}</li>
                     </c:when>
                     <c:otherwise>
                     <li>${timeEntry.value.rn1}</li>
                     </c:otherwise>
                  </c:choose>
                  <li>${timeEntry.value.tmp}도</li>
                  <li>${timeEntry.value.reh}%</li>
                  <li>${timeEntry.value.wsd}m/s</li>
                  <li>${timeEntry.value.wav}m</li>
               </ul>   
            <c:set var="timeLoop" value="${timeLoop + 1}"/> <!-- timeLoop 업데이트 -->
            </c:forEach>
         </div>
         </c:if>
         </c:forEach>
      </div>
      </c:if>
      
   </div>
   <!-- 오늘/내일/모레 선택 버튼 script -->
   <script>
   
      // 각 버튼을 클릭하면 해당하는 예보만 보이도록 설정하는 함수
      function toggleForecast(boxId) {
          // 모든 예보 박스 숨기기
          var allBoxes = document.querySelectorAll('.forecast_box');
          allBoxes.forEach(function(box) {
              box.classList.add('hidden');
          });
   
          // 선택한 예보 박스 보이기
          var selectedBox = document.querySelector('.box' + boxId);
          selectedBox.classList.remove('hidden');
      }
   
      // 오늘 버튼을 클릭하면 today 예보 박스만 보이기
      document.querySelector('.fcstoday').addEventListener('click', function() {
          toggleForecast(0);
      });
   
      // 내일 버튼을 클릭하면 nextday 예보 박스만 보이기
      document.querySelector('.fcsnextday').addEventListener('click', function() {
          toggleForecast(1);
      });
   
      // 모레 버튼을 클릭하면 dayafttommorrow 예보 박스만 보이기
      document.querySelector('.fcsdayafttommorrow').addEventListener('click', function() {
          toggleForecast(2);
      });

   </script>
   
   <!-- 날씨에 맞는 이모티콘 불러오기 -->
   <script src="./resources/js/sea_weatherEmoticon.js"></script>
   <script>
      document.addEventListener("DOMContentLoaded", function() {
         var totalCount = ${timeLoop};
         for (var i = 0; i < totalCount; i++) {
            var fcstDate = document.getElementById("fcstDate_"+ i).innerText;
             var fcstTime = document.getElementById("fcstTime_"+ i).innerText;
             console.log(fcstDate, fcstTime);
             
             var hour = parseInt(fcstTime.toString().slice(0, -2));  // 00 삭제하여 시간 부분만 남기기
             var month = parseInt(fcstDate.toString().substring(4, 6));
             var sky = parseInt(document.getElementById("sky_"+ i).innerText);
             var pty = parseInt(document.getElementById("pty_"+ i).innerText);
             console.log(sky, pty, hour, month);
             document.getElementById("weatherIcon_"+ i).innerHTML = weatherEmoticon(sky, pty, hour, month, 40, 40);
         }  
      });
   </script>
   
</div>
<!-- 단기예보 컨테이너 끝 -->

<div class="otheryear_container">

   <div id="titles"><지난 해 같은 날에는 어땠을까?></div>
   
   <div class="contents otheryear">
   
      <c:if test="${empty dataListMap}">
          현재 API 오류로 지난 해의 날씨 정보를 띄울 수 없습니다. 새로고침을 시도하시거나, 일정 시간이 지난 후 다시 페이지에 방문해주세요.
      </c:if>
      
      <c:if test="${not empty dataListMap}">
          <c:forEach var="wthrmap" items="${dataListMap}">
         <!-- 출력 내용 -->
         <div class="table_div">
              <table class="otheryear_table">
                 <tr>
                    <th colspan="2">
                    <div class="hidden">${wthrmap.key}</div>
                    ${fn:substring(wthrmap.key,0,4)}년 오늘
                    </th>
                 </tr>
                 <tr>
                     <th>평균 기온</th>
                     <td>${wthrmap.value.avgTa}</td>
                 </tr>
                 <tr>
                     <th>최저 기온</th>
                     <td>${wthrmap.value.minTa}</td>
                 </tr>
                 <tr>
                     <th>최고 기온</th>
                     <td>${wthrmap.value.maxTa}</td>
                 </tr>
                 <tr>
                     <th>평균 풍속</th>
                     <td>${wthrmap.value.avgWs}</td>
                 </tr>
                 <tr>
                     <th>평균 습도</th>
                     <td>${wthrmap.value.avgRhm}</td>
                 </tr>
                 <tr>
                     <th>평균 전운량</th>
                     <td>${wthrmap.value.avgTca}</td>
                 </tr>
                 <tr>
                     <th>같은 시간의 파고</th>
                     <td>${wthrmap.value.wh}</td>
                 </tr>
                 <%-- ptySet이 null이 아닐 때 해당 리스트 항목도 추가 --%>
                 <c:if test="${wthrmap.value.ptySet ne null}">
                     <tr>
                         <th>강수 형태</th>
                         <td>
                         <c:forEach var="pty" items="${wthrmap.value.ptySet}" varStatus="loop">
						    <span id="ptylist">${fn:trim(pty)}<c:if test="${not loop.last}">,</c:if>
						    </span>
						</c:forEach>

                     </td>
                     </tr>
                 </c:if>
             </table>
             </div>
         </c:forEach>
      </c:if>
   </div>
</div>

   <div class="another_container">
       <div id="titles"><다른 날의 바다 날씨는?></div>
       <div>
           <input type="number" id="beachMonth" name="beachMonth" min="1" max="12"> 월 &nbsp; 
           <input type="number" id="beachDay" name="beachDay" min="1" max="31"> 일 &nbsp;
           <button id="searchBtn" class="btn2">검색</button>
       </div>
       <div id="weather-info-list"></div>
   </div>
   
   
</div>

<!-- 다른 날의 바다 날씨 script -->
<script type="text/javascript">

   function getWthrDataList(monthInput, dayInput, currentYear, beach_code) {
	   showLoadingPage();
	   
	   var requestData = {
           monthInput: monthInput.toString().padStart(2, '0'),
           dayInput: dayInput.toString().padStart(2, '0'),
           currentYear: currentYear,
           beach_code: beach_code
       };
       
       fetch('getWthrDataList_DTO', {
           method: 'post',
           headers: {
               'Content-Type': 'application/json'
           },
           body : JSON.stringify(requestData)
       }).then(response => {
           if (!response.ok) {
               throw new Error('Network response was not ok');
           }
           return response.text(); ;
       })
       .then(data => {
          try {
               // JSON 형식으로 파싱
               var jsonData = JSON.parse(data);
               console.log(jsonData); // 서버로부터 받은 JSON 데이터 출력
               displayWeatherDataList(jsonData);
           } catch (error) {
               // JSON 파싱 실패 시
              alert("종관기상관측 API 오류로 결과를 출력할 수 없습니다.");
           } finally {
               // 로딩 창 숨기기
               hideLoadingPage();
           }
       })
       .catch(error => {
           console.error('Error:', error);
           alert("종관기상관측 API 오류로 결과를 출력할 수 없습니다.");
           hideLoadingPage();
       });
   }
   
   function displayWeatherDataList(data) {
       // 화면에 날씨 정보를 표시할 요소 선택
       var weatherInfoDiv = document.getElementById("weather-info-list");
       
       // 기존에 있던 날씨 정보를 모두 삭제
       weatherInfoDiv.innerHTML = '';
   
       // 날씨 정보를 담고 있는 배열 순회
       data.forEach(function(weather) {
           // 날씨 정보를 보여줄 HTML 요소 생성
           var weatherInfoElement = document.createElement("div");
           var table = document.createElement("table");
           table.classList.add("otheryear_table");
           
           //테이블 추가
         var row = document.createElement("tr");
           var th = document.createElement("th");
           th.setAttribute("colspan", "2");
            th.textContent = weather.tm;
            row.appendChild(th);
            table.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = '<th>평균 기온</th><td>' + weather.avgTa + '</td>';
            table.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = '<th>최저 기온</th><td>' + weather.minTa + '</td>';
            table.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = '<th>최고 기온</th><td>' + weather.maxTa + '</td>';
            table.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = '<th>평균 풍속</th><td>' + weather.avgWs + '</td>';
            table.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = '<th>평균 습도</th><td>' + weather.avgRhm + '</td>';
            table.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = '<th>평균 전운량</th><td>' + weather.avgTca + '</td>';
            table.appendChild(row);

            row = document.createElement("tr");
            row.innerHTML = '<th>이 시간의 파고</th><td>' + weather.wh + '</td>';
            table.appendChild(row);

            // ptySet이 null이 아닐 때 해당 리스트 항목도 추가
            if (weather.ptySet != null) {
            	const ptyListStr = weather.ptySet.join(", ");
                row = document.createElement("tr");
                row.innerHTML = '<th>날씨 상태</th><td><span id="ptylist">' + ptyListStr + '</span></td>';
                table.appendChild(row);
            }

            // 테이블을 div에 추가
            weatherInfoElement.appendChild(table);
            // 생성한 요소를 화면에 추가
            weatherInfoDiv.appendChild(weatherInfoElement);
       });
   }

</script>

<!-- 로딩 페이지 -->
<div id="loading" style="display: none;">
    <jsp:include page="../loading.jsp"/>
</div>

</body>
</html>