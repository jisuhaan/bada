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
        document.getElementById("searchBtn").addEventListener("click", function() {
            var beachName = document.getElementById("beachName").value;
            fetchWeather(beachName);
        });

        function fetchWeather(beachName) {
            fetch("weather_beachName?beachName=" + beachName)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Failed to fetch weather data");
                }
                return response.json();
            })
            .then(data => {
                displayWeatherTable(data);
            })
            .catch(error => {
                console.error("Error fetching weather data:", error);
            });
        }

        function displayWeatherTable(weatherData) {
            var tableHTML = "<table border='1'><tr><th>Category</th><th>Value</th></tr>";
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
            tableHTML += "</table>";
            document.getElementById("weather-info").innerHTML = tableHTML;
        }
    </script>
</body>
</html>