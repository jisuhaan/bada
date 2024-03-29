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
                return response.json(); // json 형식으로 받아오기
            })
            .then(data => {
               console.log("Received beach code:", data); // 받은 beach code 출력
               api_forecast(data.beach_code); // 원하는 코드만 받아오기
            })
            .catch(error => {
                console.error("Error fetching weather data:", error);
            });
        }

        function api_forecast(beachnum) {
           // API 호출
            var url = 'http://apis.data.go.kr/1360000/BeachInfoservice/getVilageFcstBeach'; /*URL*/
            var serviceKey = 'QWzzzAb%2FUIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J%2BlicoY1Dffo51%2Fi5HTDfU00ZpDy2E4%2FASt2FgLknaA%3D%3D'; /*Service Key*/
            var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + serviceKey;
            queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('14');
            queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
            queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON');
            queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent(getFormattedDate());
            queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent('0500');
            queryParams += '&' + encodeURIComponent('beach_num') + '=' + beachnum;
          
            fetch(url + queryParams)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
               console.log('결과 : ', data);
                displayWeatherTable(data.response.body.items.item);
                var jsonDataString = createJSONData(data.response.body.items.item);
               console.log(jsonDataString);
            })
            .catch(error => {
                console.error('Fetch Error', error);
            });
        }
        
        function getFormattedDate() {
            var currentDate = new Date();
            var year = currentDate.getFullYear();
            var month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
            var day = currentDate.getDate().toString().padStart(2, '0');
            return year + month + day;
        }
        
        function displayWeatherTable(weatherData) {
            var tableHTML = "<table border='1'><tr><th>Category</th><th>Value</th></tr>";

            // 각 item에서 category와 fcstValue 추출하여 표에 추가
            weatherData.forEach(function(item) {
                tableHTML += "<tr><td>" + item.category + "</td><td>" + item.fcstValue + "</td></tr>";
            });

            tableHTML += "</table>";
            document.getElementById("weather-info").innerHTML = tableHTML;
        }
        
        function createJSONData(weatherData) {
           var jsonData = [];
           var dataObject = {};
           
              // beachNum과 baseDate와 baseTime을 설정
              if (weatherData.length > 0) {
                 var baseDate = weatherData[0].baseDate;
                 var baseTime = weatherData[0].baseTime;
                 var beachNum = weatherData[0].beachNum;
                 
                 dataObject["beachNum"] = beachNum;
                 dataObject["baseDate"] = baseDate;
                  dataObject["baseTime"] = baseTime;
              }
           
            // 각 item에서 category와 fcstValue를 가져와서 JSON 객체로 구성하여 배열에 추가
            weatherData.forEach(function(item) {
                dataObject[item.category] = item.fcstValue;
            });
            jsonData.push(dataObject);
            
            // JSON 객체를 문자열로 변환하여 반환
            return JSON.stringify(jsonData);
      }
    </script>
</body>
</html>