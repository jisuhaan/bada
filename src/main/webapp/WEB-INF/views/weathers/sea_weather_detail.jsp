<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/sea_result.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/slide.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    var beach_code = ${beach_code};
</script>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        // 월 입력 요소
        var monthInput = document.getElementById("beachMonth");
        // 일 입력 요소
        var dayInput = document.getElementById("beachDay");
        // 현재 연도 가져오기
        var currentYear = new Date().getFullYear();

        // 월이 변경될 때 이벤트 처리
        monthInput.addEventListener("change", function() {
            // 선택한 월 가져오기
            var selectedMonth = parseInt(monthInput.value);
            // 선택한 월에 따라 해당 월의 일수 계산
            var daysInMonth = new Date(currentYear, selectedMonth, 0).getDate();
            // 일의 최대값을 월에 따라 변경
            dayInput.max = daysInMonth;
        });
     	
        // 달 입력 필드의 값이 변경될 때 이벤트 처리
        dayInput.addEventListener("input", function() {
            // 입력된 값이 min/max 범위를 벗어나면 수정
            if (parseInt(dayInput.value) < parseInt(dayInput.min)) {
                dayInput.value = dayInput.min;
            } else if (parseInt(dayInput.value) > parseInt(dayInput.max)) {
                dayInput.value = dayInput.max;
            }
        });
        
     	// 일자 입력 필드의 값이 변경되는 이벤트 발생 시 처리
        monthInput.addEventListener("input", function() {
            // 사용자가 입력한 값이 최대값을 초과하는지 확인
            if (parseInt(monthInput.value) > parseInt(monthInput.max)) {
                // 최대값으로 변경
                monthInput.value = monthInput.max;
            }
        });
    });
</script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#searchBtn").click(function() {
            // 월 입력 요소
            var monthInput = parseInt($("#beachMonth").val());
            // 일 입력 요소
            var dayInput = parseInt($("#beachDay").val());
            // 현재 연도 가져오기
            var currentYear = new Date().getFullYear();
            
            if (isNaN(monthInput) || monthInput < 1 || monthInput > 12) {
            	alert("현재 입력한 값: "+monthInput)
                alert("월을 올바르게 입력해주세요 (1에서 12 사이).");
                return;
            }
            
            var maxDay = parseInt($("#beachDay").attr("max"));
            
            if (isNaN(dayInput) || dayInput < 1 || dayInput > maxDay) {
                alert("일을 올바르게 입력해주세요 (1에서 " + maxDay + " 사이).");
                return;
            }
            
            getWthrDataList(monthInput, dayInput, currentYear, beach_code);
            alert("검색 버튼이 클릭되었습니다.");
        });
    });
</script>
<title>Insert title here</title>

<style type="text/css">
	.hidden {
	    display: none;
	}
</style>

</head>
<body>
<h2> ${bldt.beach} : 오늘의 날씨 정보</h2>
<div id="weather-info"></div>
<div>
<h1>Weather Forecast</h1>

<c:set var="timeLoop" value="0"/>
<c:forEach var="dateEntry" items="${groupedData}" varStatus="loop">
<c:if test="${loop.index lt 3}">
    <!-- 출력 내용 -->
    <h2>${dateEntry.key}</h2>
    <table border="1">
        <tr>
            <th>시간</th>
            <th>날씨</th>
            <th>강수확률</th>
            <th>강수량</th>
            <th>기온</th>
            <th>습도</th>
            <th>풍속</th>
            <th>파고</th>
        </tr>
        <c:forEach var="timeEntry" items="${dateEntry.value}">
        <!-- 숨김으로 가져올 항목들 -->
            <div class="hidden" id="sky_${timeLoop}">${timeEntry.value.sky}</div>
		    <div class="hidden" id="pty_${timeLoop}">${timeEntry.value.pty}</div>
		    <div class="hidden" id="fcstDate_${timeLoop}">${timeEntry.value.fcstDate}</div>
		    <div class="hidden" id="fcstTime_${timeLoop}">${timeEntry.value.fcstTime}</div>
        	<tr>
                <td>${timeEntry.value.fcstTime}</td>
                <td id = "weatherIcon_${timeLoop}"></td>
                <td>${timeEntry.value.pop}</td>
                <td>${timeEntry.value.rn1}</td>
                <td>${timeEntry.value.tmp}</td>
                <td>${timeEntry.value.reh}</td>
                <td>${timeEntry.value.wsd}</td>
                <td>${timeEntry.value.wav}</td>
            </tr>
            <c:set var="timeLoop" value="${timeLoop + 1}"/> <!-- timeLoop 업데이트 -->
        </c:forEach>
    </table>
    <br><br>
</c:if>
</c:forEach>

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

<br><br>
    <h1>다른 날의 바다 날씨는?</h1>
    <div>
        <input type="number" id="beachMonth" name="beachMonth" min="1" max="12">월 
        <input type="number" id="beachDay" name="beachDay" min="1" max="31">일
        <button id="searchBtn">검색</button>
    </div>
    <div id="weather-info-list" style="margin-top: 20px;"></div>
    
    <script type="text/javascript">
    function getWthrDataList(monthInput, dayInput, currentYear, beach_code) {
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
            return response.json(); // 서버로부터 JSON 형식의 응답을 받음
        })
        .then(data => {
            console.log(data); // 서버로부터 받은 응답 출력
            displayWeatherDataList(data);
        })
        .catch(error => {
            console.error('Error:', error);
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
            weatherInfoElement.innerHTML = '<h4>날짜: ' + weather.tm + '</h4>' +
                                           '<p>평균 기온: ' + weather.avgTa + '</p>' +
                                           '<p>최저 기온: ' + weather.minTa + '</p>' +
                                           '<p>최고 기온: ' + weather.maxTa + '</p>' +
                                           '<p>평균 풍속: ' + weather.avgWs + '</p>' +
                                           '<p>평균 상대습도: ' + weather.avgRhm + '</p>' +
                                           '<p>평균 전운량: ' + weather.avgTca + '</p>';
            
           // ptySet이 null이 아닐 때 해당 리스트 항목도 추가
           if (weather.ptySet != null) {
               weatherInfoElement.innerHTML += '<p>ptySet: ' + weather.ptySet + '</p>';
           }
           weatherInfoElement.innerHTML += '<br>';
            // 생성한 요소를 화면에 추가
            weatherInfoDiv.appendChild(weatherInfoElement);
        });
    }

</script>

</body>
</html>