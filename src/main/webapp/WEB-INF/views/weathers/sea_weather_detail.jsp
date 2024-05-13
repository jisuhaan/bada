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
	
	<!-- ECharts library -->
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.2.1/dist/echarts.min.js"></script>
    <style>
        
        .chart-container {
		    width: 800px; /* 부모 요소 너비의 800px로 설정하여 가로 스크롤을 생성 */
		    overflow-x: auto; /* 넘치는 부분을 가로 스크롤로 표시 */
		    white-space: nowrap; /* 차트 요소들이 한 줄에 표시되도록 설정 */
		}
		
		.chart {
			padding: 0; /* 양옆 여백 없애기 */
			width: 2500px; /* 예시로 설정한 차트의 가로 길이 */
		    height: 300px; /* 예시로 설정한 차트의 세로 길이 */
		    background-color: lightgray; /* 예시로 설정한 차트의 배경색 */
		    display: inline-block; /* 차트 요소를 한 줄에 표시 */
		}

		        
    </style>
	
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
	                alert("월을 올바르게 입력해주세요 (1에서 12 사이).");
	                return;
	            }
	            
	            var maxDay = parseInt($("#beachDay").attr("max"));
	            
	            if (isNaN(dayInput) || dayInput < 1 || dayInput > maxDay) {
	                alert("일을 올바르게 입력해주세요 (1에서 " + maxDay + " 사이).");
	                return;
	            }
	            
	            getWthrDataList(monthInput, dayInput, currentYear, beach_code);
	            alert("지난 바다 날씨 검색을 시작합니다.");
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
<h2> ${choicebeach.beach} : 오늘의 날씨 정보</h2>
<br>
<div>
<h1>단기 예보</h1>

<c:if test="${empty groupedData}">
    현재 API 오류로 단기 예보를 띄울 수 없습니다. 새로고침을 시도하시거나, 일정 시간이 지난 후 다시 페이지에 방문해주세요.
</c:if>

<c:if test="${not empty groupedData}">
	<!-- 차트 컨테이너 -->
	<div class="chart-container">
	    <div id="temperature-chart" class="chart"></div>
	</div>

    
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
</c:if>

<script>
	function getTemperatureArray() {
	    var getWeatherForecastMap = ${ForecastMapJson};
	    var temperatureList = [];
	
	    var loopCount = 0;
	
	    // 바깥 루프를 제어하기 위한 카운터
	    for (var date in getWeatherForecastMap) {
	        if (loopCount >= 3) {
	            break;
	        }
	        loopCount++;
	
	        var timeMap = getWeatherForecastMap[date];
	        for (var time in timeMap) {
	            temperatureList.push(timeMap[time]["TMP"]);
	        }
	    }
	    console.log("삼봉 해수욕장의 기온 배열 : " + temperatureList);
	    console.log("삼봉 해수욕장의 기온 배열 사이즈 : " + temperatureList.length);
	    // 사이즈에서 -48+1 하면 다음날
	    // 사이즈에서 -24+1 하면 모레
	    return temperatureList;
	}
	
	function getTimeArray() {
	    var getWeatherForecastMap = ${ForecastMapJson};
	    var timeList = [];
	
	    var loopCount = 0;
	
	    // 바깥 루프를 제어하기 위한 카운터
	    for (var date in getWeatherForecastMap) {
	        if (loopCount >= 3) {
	            break;
	        }
	        loopCount++;
	
	        var timeMap = getWeatherForecastMap[date];
	        for (var time in timeMap) {
	        	timeList.push(timeMap[time]["fcstTime"]);
	        }
	    }
	    return timeList;
	}

        // 자바스크립트 코드로 기온 차트를 생성합니다.
        document.addEventListener("DOMContentLoaded", function() {
            // ECharts 인스턴스를 초기화합니다.
            var chart = echarts.init(document.getElementById('temperature-chart'));

            // 차트 옵션을 설정합니다.
            var options = {
                tooltip: {
                    trigger: 'item',
                    position: function (point, params, dom, rect, size) {
                    	  var x = 150; // x 좌표 조절
                    	  var y = 50; // y 좌표 조절
                   	   console.log(point[0])
                   	   if(point[0]<510){
                   	      	return [point[0], point[1] - y];
                    	   } else if (point[0]>510){
                    	     	return [point[0]-x, point[1] - y];
                    	   }
                    },
                    formatter: function(params) {
                        // params에는 현재 데이터 포인트의 정보가 포함되어 있습니다.
                        var temperature = params.value; // 현재 데이터 포인트의 기온
                        return '기온: ' + temperature + '°C'; // 툴팁 형식 설정
                    }
                },
                grid: {
           		    left: '1%',
           		    right: '4%',
           		    bottom: '10%',
           		    top: '10%',
           		    containLabel: true
           		},
                xAxis: {
                    type: 'category',
                    data: getTimeArray() // 시간 데이터
                },
                yAxis: {
                    type: 'value',
                    name: '기온 (°C)' // Y축 레이블
                },
                series: [{
                    data: getTemperatureArray(), // 기온 데이터
                    type: 'line',
                    smooth: true // 부드러운 선
                }]
            };

            // 옵션을 설정하고 차트를 렌더링합니다.
            chart.setOption(options);
        });
    </script>

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

<div>
<h1>지난 해 오늘의 날씨</h1>

<c:if test="${empty dataListMap}">
    현재 API 오류로 지난 해의 날씨 정보를 띄울 수 없습니다. 새로고침을 시도하시거나, 일정 시간이 지난 후 다시 페이지에 방문해주세요.
</c:if>

<c:if test="${not empty dataListMap}">
    <c:forEach var="wthrmap" items="${dataListMap}">
	<!-- 출력 내용 -->
	    <h2>${wthrmap.key}</h2>
	     <table border="1">
	        <tr>
	            <td>평균 기온</td>
	            <td>${wthrmap.value.avgTa}</td>
	        </tr>
	        <tr>
	            <td>최저 기온</td>
	            <td>${wthrmap.value.minTa}</td>
	        </tr>
	        <tr>
	            <td>최고 기온</td>
	            <td>${wthrmap.value.maxTa}</td>
	        </tr>
	        <tr>
	            <td>평균 풍속</td>
	            <td>${wthrmap.value.avgWs}</td>
	        </tr>
	        <tr>
	            <td>평균 상대습도</td>
	            <td>${wthrmap.value.avgRhm}</td>
	        </tr>
	        <tr>
	            <td>평균 전운량</td>
	            <td>${wthrmap.value.avgTca}</td>
	        </tr>
	        <tr>
	            <td>작년 이 시간의 파고</td>
	            <td>${wthrmap.value.wh}</td>
	        </tr>
	        <%-- ptySet이 null이 아닐 때 해당 리스트 항목도 추가 --%>
	        <c:if test="${wthrmap.value.ptySet ne null}">
	            <tr>
	                <td>강수 형태</td>
	                <td>
	                <c:forEach var="pty" items="${wthrmap.value.ptySet}">
					    <span>${pty}</span>
					</c:forEach>
					</td>
	            </tr>
	        </c:if>
	    </table>
	</c:forEach>
</c:if>

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
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert("종관기상관측 API 오류로 결과를 출력할 수 없습니다.");
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
                                           '<p>평균 전운량: ' + weather.avgTca + '</p>' +
                                           '<p>이 시간의 파고: ' + weather.wh + '</p>';
            
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