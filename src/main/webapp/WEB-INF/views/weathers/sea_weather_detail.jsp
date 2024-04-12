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

</body>
</html>