<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <h1>Weather Information</h1>
    <div>
        <label for="beachName">해변 이름:</label>
        <input type="text" id="beachName" name="beachName">
        <button id="searchBtn">검색</button>
    </div>
    <div id="weather-info" style="margin-top: 20px;"></div>
    
    <!-- 자바 스크립트 시작. 버튼이 눌린 다음 메소드들이 기능하도록 위치는 아래로 설정. -->
    <script>
        $(document).ready(function() {
            $("#searchBtn").click(function() {
                var beachName = $("#beachName").val();
                fetchWeather(beachName);
            });
        });

        function fetchWeather(beachName) {
    	 $.ajax({
    	        url: "weather_beachName", // URL 수정
    	        type: "GET", // GET 방식으로 전송
    	        data: { beachName: beachName },
    	        success: function(response) {
    	            displayWeatherTable(response);
    	        },
    	        error: function(xhr, status, error) {
    	            console.error("Failed to fetch weather data:", error);
    	        }
    	    });
        }

        // 컨트롤러에서 받아온 dto 정보를 json 타입으로 파싱하여 활용하기
		function displayWeatherTable(response) {
		    if (response.trim() === "") {
		        // JSON 데이터가 비어 있는 경우에 대한 처리
		        console.error("Empty JSON data received.");
		        return;
		    }
		
		    var weatherData;
		    try {
		        weatherData = JSON.parse(response);
		    } catch (error) {
		        // JSON 파싱 오류가 발생한 경우에 대한 처리
		        console.error("Failed to parse JSON data:", error);
		        return;
		    }
		
		    var tableHTML = "<table border='1'><tr><th>Category</th><th>Value</th></tr>";
		
		    // DTO에서 데이터를 읽어와서 테이블에 추가
		    tableHTML += "<tr><td>강수확률</td><td>" + weatherData.pop + "</td></tr>";
		    tableHTML += "<tr><td>강수형태</td><td>" + weatherData.pty + "</td></tr>";
		    tableHTML += "<tr><td>1시간 강수량</td><td>" + weatherData.pcp + "</td></tr>";
		    tableHTML += "<tr><td>습도</td><td>" + weatherData.reh + "</td></tr>";
		    tableHTML += "<tr><td>1시간 신적설</td><td>" + weatherData.sno + "</td></tr>";
		    tableHTML += "<tr><td>하늘상태</td><td>" + weatherData.sky + "</td></tr>";
		    tableHTML += "<tr><td>1시간 기온</td><td>" + weatherData.tmp + "</td></tr>";
		    tableHTML += "<tr><td>아침 최저기온</td><td>" + weatherData.tmn + "</td></tr>";
		    tableHTML += "<tr><td>낮 최고기온</td><td>" + weatherData.tmx + "</td></tr>";
		    tableHTML += "<tr><td>풍속(동서성분)</td><td>" + weatherData.uuu + "</td></tr>";
		    tableHTML += "<tr><td>풍속(남북성분)</td><td>" + weatherData.vvv + "</td></tr>";
		    tableHTML += "<tr><td>파고</td><td>" + weatherData.wav + "</td></tr>";
		    tableHTML += "<tr><td>풍향</td><td>" + weatherData.vec + "</td></tr>";
		    tableHTML += "<tr><td>풍속</td><td>" + weatherData.wsd + "</td></tr>";
		    // 나머지 필드에 대한 처리도 동일하게 추가
		
		    tableHTML += "</table>";
		    $("#weather-info").html(tableHTML);
		}

    </script>
</body>
</html>