<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/main_suggest_view.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>

<script type="text/javascript">

$(document).ready(function(){
	
	$(".location_suggest").hide();
	
	var isLocationEnabled = false;
	
	 var idElement = $("#id");
	    if(idElement.length > 0){
	        var id = idElement.val();
	        if(id.trim() == "" || id == null){
	            // AJAX 요청 등 필요한 작업 수행
	            $.ajax({
	                url: "default_view", 
	                type: "GET", 
	                dataType: "json",
	                success: function(response) {
	                    console.log("결과 가져오기 성공");
	                    console.log(response);
	              
	                    $("#beachname").text('여기서 가장 가까운 바다는 <span id="beachname">'+beach+'</span>(으)로');
	                    $("#distance").text('직선거리 <span id="beachdistance">'+distance+'km</span>에 위치해있어요!');
	                },
	                error: function(xhr, status, error) {
	                    console.error('ajax오류 : '+error); 
	                }
	            });
	        }
	    } else {
	        console.error("#id 요소를 찾을 수 없습니다.");
	    }
	
});

</script>

</head>
<body>

<div class="suggest_container">
	<c:choose>
	<c:when test="${loginstate==false || empty loginstate}">
		<div id="titles">게스트 님께 이 바다를 추천드려요!</div>
		<div class="suggest_switch">
		<label class="switch">
		  <input type="checkbox">
		  <span class="slider round"></span>
		</label>
		<p>기본추천</p><p style="display:none;">위치추천</p>
		</div>
		<div class="default_suggest">
			<div id="d_beachname"></div>
			<div id="beachimg"></div>
			<div id="hashtags"></div>
			<div id="review"></div>
			<div id="score"></div>
		</div>
		<div class="location_suggest">
	        <div id="beachname"></div>
	        <div id="distance"></div>
		</div>
	</c:when>
	
	<c:otherwise>
	<div id="titles">${name} 님께 이 바다를 추천드려요</div>
	<input type="hidden" name="id" id="id" value="${loginid}">
	<div class="suggest_switch">
	<label class="switch">
	  <input type="checkbox">
	  <span class="slider round"></span>
	</label>
	<p>기본추천</p><p style="display:none;">위치추천</p>
	</div>
	<div class="default_suggest">
		<div id="d_beachname"></div>
		<div id="beachimg"></div>
		<div id="hashtags"></div>
		<div id="review"></div>
		<div id="score"></div>
	</div>
	<div class="location_suggest">
        <div id="beachname"></div>
        <div id="distance"></div>
	</div>
</c:otherwise>
</c:choose>

	<div class="bada_container">
	</div>
	
<script type="text/javascript">

$("input[type='checkbox']").click(function(){
    // 체크박스의 상태 확인
    if ($(this).is(":checked")) {
        // 체크박스가 체크된 경우
        $("p").toggle();
        isLocationEnabled = true;
        myLocation(); // 위치 정보 가져오기
    } else {
        // 체크박스가 체크 해제된 경우
        isLocationEnabled = false;
        $("p").toggle();
        // 위치 정보를 가져오지 않음
        $(".location_suggest").hide();
        
    }
});

</script>

<script type="text/javascript">

let myLatitude = 0;
let myLongitude = 0;
let beach_code = 0;
let beach = 0;
let distance = 0;

function myLocation() {        
    // Geolocation API에 액세스할 수 있는지를 확인
    
    if (navigator.geolocation) {
        //위치 정보를 얻기
        navigator.geolocation.getCurrentPosition (function(pos) {
            myLatitude = pos.coords.latitude; // 위도
            myLongitude = pos.coords.longitude; // 경도
            console.log("위도:"+myLatitude+", 경도:"+myLongitude)
            
            $.ajax({
                url: "distance_view", 
                type: "GET",
                data: {"myLatitude":myLatitude,"myLongitude":myLongitude},
                dataType: "json",
                success: function(response) {
                	
                    console.log("거리 계산 결과 가져오기 성공");
                    console.log(response);
                    beach_code = response.beach_code;
                    beach = response.beach;
                    distance = response.distance.toFixed(1);
                    
                    $(".default_suggest").hide();
                    $(".location_suggest").show();
                    
                    $("#beachname").html('여기서 가장 가까운 바다는 <span id="beach">'+beach+'</span>(으)로');
                    $("#distance").html('직선거리 약 <span id="beachdistance">'+distance+'km</span>에 위치해있어요!');
                    
                },
                error: function(xhr, status, error) {
                    console.error('ajax오류 : '+error); 
                }
            });
           
        });
    } else {
        alert("위치 설정을 허용해주세요!")
    }
    
    console.log("해변코드:"+beach_code+", 바다명:"+beach+", 현재 위치부터 직선거리:"+distance);
}

</script>

</div>

</body>
</html>