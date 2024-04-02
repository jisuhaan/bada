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
    <div id="weather-info2" style="margin-top: 20px;"></div>
    
    <!-- 자바 스크립트 시작. 버튼이 눌린 다음 메소드들이 기능하도록 위치는 아래로 설정. -->
    <script>
    	// Date 함수
    	var currentDate = new Date();
    	// 날짜 변수
    	var year = currentDate.getFullYear();
        var month = (currentDate.getMonth() + 1).toString().padStart(2, '0'); // 문자열의 최종 길이를 2로 설정. 문자열의 길이가 그보다 짧으면 앞에 0을 붙이기
        var day = currentDate.getDate().toString().padStart(2, '0');
        var dateString = year+ month + day;
        // 시간 변수 -> 얘네는 기본으로 2자리로 설정
        var hours = currentDate.getHours();
        var minutes = currentDate.getMinutes();

        // 단기 예보 시간에 맞게 정시 설정
        function getNextBaseTime(){

        }
    
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
                return api_forecast(data.beach_code)// 받은 beach code만 인수로 넣기
                    .then(forecastData => {
                        return api_getTwBuoyBeach()
                            .then(twBuoyData => {
                               console.log(twBuoyData);
                                api_WeatherWarning();
                                 return { forecast: forecastData, twBuoy: twBuoyData, beachName: beachName};
                            });
                    });
            })
            .then(results => {
            // JSON 데이터 전송
                dtosave_result(JSON.stringify(results));
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
            queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('290');
            queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
            queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON');
            queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent('20240401');
            queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent('2300');
            queryParams += '&' + encodeURIComponent('beach_num') + '=' + beachnum;
          	console.log(url + queryParams);
            return fetch(url + queryParams)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
               console.log(JSON.stringify(data.response.body.items.item));
               
               var originalData = data;
               var extractedItems = data.response.body.items.item.filter(item => item.category === 'TMN' || item.category === 'TMX');
               
               originalData.response.body.items.item = originalData.response.body.items.item.filter(item => item.category !== 'TMN' && item.category !== 'TMX');
               // 변경된 JSON 데이터 출력
               console.log(originalData);
               console.log(extractedItems);
               
               // 시간대별로 묶인 날씨 정보를 담을 배열
               var hourlyData = [];
               
               for (var i = 0; i < 24; i++) {
            	   // 각 시간대에 해당하는 12개의 날씨 정보를 추출하여 hourlyData에 추가
            	   var startIndex = i * 12; // 시작 인덱스
            	   var endIndex = (i + 1) * 12; // 끝 인덱스
            	   var hourlyWeather = originalData.response.body.items.item.slice(startIndex, endIndex);
            	   hourlyData.push(hourlyWeather);
            	}

            	// 24개로 분리한 array 안의 array(12) 결과 출력 
            	console.log('24개로 분리한 array 안의 array(12) 결과 출력');
            	console.log(hourlyData);
               
            	// 각 시간대별로 category와 fcstValue를 저장할 객체
            	var hourlyCategoryValue = [];

            	// 각 시간대별로 순회하면서 category와 fcstValue를 추출하여 저장
            	hourlyData.forEach(function(hourlyWeather) {
            	  var hourlyObject = {}; // 각 시간대의 category와 fcstValue를 저장할 객체
            	  hourlyWeather.forEach(function(weatherInfo) {
            	    hourlyObject[weatherInfo.category] = weatherInfo.fcstValue;
            	  });
            	  hourlyCategoryValue.push(hourlyObject);
            	});

            	// 결과 출력
            	console.log('쌍이 잘 저장이 될까요');
            	console.log(hourlyCategoryValue);
            	 
            	 
               ////// 기존에 작동하던 코드 부분
               displayWeatherTable(data.response.body.items.item);
               var jsonDataString = createJSONData(data.response.body.items.item);
               console.log(jsonDataString);
               return jsonDataString;
            })
            .catch(error => {
                console.error('Fetch Error', error);
                throw error; // 에러를 상위로 전파
            });
        }
        
        function api_getTwBuoyBeach() {
           // API 호출
            var url = 'http://www.khoa.go.kr/api/oceangrid/tideObsTemp/search.do'; /*URL*/
            var serviceKey = 'C9p5sRvJfzIgyPb5hbCaA=='; /*Service Key*/
            var queryParams = '?' + encodeURIComponent('ResultType') + '=' + encodeURIComponent('json');
            queryParams += '&' + encodeURIComponent('ObsCode') + '=' + encodeURIComponent('DT_0005');
            queryParams += '&' + encodeURIComponent('Date') + '=' + encodeURIComponent(dateString);
            queryParams += '&' + encodeURIComponent('ServiceKey') + '=' + serviceKey;
             
            return fetch(url + queryParams)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            }).then(response => {
                console.log(response.result.data);
                const data = response.result.data;
                const lastData = JSON.stringify(data[data.length - 1]); // 가장 마지막 데이터의 수온(최신) 정보 가져오기
                console.log(lastData);
                return lastData;
             })
             .catch(error => {
                 console.error('Fetch Error', error);
                 throw error; // 에러를 상위로 전파
             });
        }
        
        function api_WeatherWarning() {
            // API 호출
            var url = 'https://apis.data.go.kr/1360000/WthrWrnInfoService/getPwnCd'; /*URL*/
            var serviceKey = 'QWzzzAb%2FUIqP2aANBL1yVlNW3plkWGVz5RX3OJRiMV9J%2BlicoY1Dffo51%2Fi5HTDfU00ZpDy2E4%2FASt2FgLknaA%3D%3D'; /*Service Key*/
            var queryParams = '?' + encodeURIComponent('dataType') + '=' + encodeURIComponent('json');
            queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10');
            queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
            queryParams += '&' + encodeURIComponent('areaCode') + '=' + encodeURIComponent('L1080100');
            queryParams += '&' + encodeURIComponent('ServiceKey') + '=' + serviceKey;

            return fetch(url + queryParams)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                	console.log(data);
                    if (data.response.header.resultCode === "03") {
                        // 정보가 없을 때 아무것도 출력하지 않음
                        console.log("경보 정보가 없습니다.");
                        return;
                    }

                    // 정보가 있을 때 데이터 처리
                    var items = data.response.body.items.item;
                    
                    // item 안에 배열로 json 정보가 저장. 따라서 반복문으로 특정 순서의 배열마다의 정보를 뽑아오도록 한다.
                    items.forEach(item => {
                        // 경보 종류와 강도에 따라 메시지 구성
                        var warningMessage = "";
                        if (item.warnVar === 1) {
                            warningMessage += "강풍 ";
                        } else if (item.warnVar === 2) {
                            warningMessage += "호우 ";
                        } else if (item.warnVar === 3) {
                            warningMessage += "한파 ";
                        } else if (item.warnVar === 4) {
                            warningMessage += "건조 ";
                        } else if (item.warnVar === 5) {
                            warningMessage += "폭풍해일 ";
                        } else if (item.warnVar === 6) {
                            warningMessage += "풍랑 ";
                        } else if (item.warnVar === 7) {
                            warningMessage += "태풍 ";
                        } else if (item.warnVar === 8) {
                            warningMessage += "대설 ";
                        } else if (item.warnVar === 9) {
                            warningMessage += "황사 ";
                        } else if (item.warnVar === 12) {
                            warningMessage += "폭염 ";
                        }

                        if (item.warnStress === 0) {
                            warningMessage += "주의보";
                        } else if (item.warnStress === 1) {
                            warningMessage += "경보";
                        }

                        // 발표 시각 및 메시지 출력
                        console.log("발표시각:", item.tmFc);
                        console.log("특보종류:", warningMessage);
                    });
                })
                .catch(error => {
                    console.error('Fetch Error', error);
                    throw error; // 에러를 상위로 전파
             });
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
           var dataObject = {};
           
              // beachNum과 baseDate와 baseTime을 설정
              if (weatherData.length > 0) {
                 var baseDate = weatherData[0].baseDate;
                 var baseTime = weatherData[0].baseTime;
                 var beachNum = weatherData[0].beachNum;
                 
                 dataObject["beach_code"] = beachNum;
                 dataObject["baseDate"] = baseDate;
                 dataObject["baseTime"] = baseTime;
              }
           
            // 각 item에서 category와 fcstValue를 가져와서 JSON 객체로 구성하여 배열에 추가
            weatherData.forEach(function(item) {
                dataObject[item.category] = item.fcstValue;
            });
            
            // JSON 객체를 문자열로 변환하여 반환
            return JSON.stringify(dataObject);
         }
        
        function dtosave_result(jsonDataString) {
            $.ajax({
                type: 'POST',
                url: 'weather_beach_DTO',
                contentType: 'application/json',
                data: jsonDataString,
                success: function(data) {
                    console.log(data); // 서버로부터 받은 응답 출력
                },
                error: function(error) {
                    console.error('Error:', error);
                }
            });
        }
    </script>
</body>
</html>