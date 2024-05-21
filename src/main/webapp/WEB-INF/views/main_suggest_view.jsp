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
<script src="./resources/js/loading.js"></script>
<script type="text/javascript">

$(document).ready(function(){
   
   $(".location_suggest").hide();
   
   var isLocationEnabled = false;
   
   var id = $("#id").val();
   console.log("아이디값 : " + id);
        
   if(id==null){
      
      console.log("비로그인 회원입니다.");
    $.ajax({
           url: "default_view2", 
           type: "GET",
           dataType: "json",
           success: function(response) {
               console.log("비회원 유저 기본 추천 가져오기 성공");
               console.log(response);
               
               $(".default_suggest").show();
         
               $("#d_beachname").html('<input type="hidden" name="beach_code" id="beach_code" value="'+response.beach_code+'" ><span id="beach1">'+response.beach+'</span>');
               $("#beachimg").html('<img src="./resources/image/'+response.picture1+'">');
               $("#review").html(response.reviewsu);
               $("#score").html(response.avgscore);
               
               var hashtagsContainer = $("#hashtags");
               hashtagsContainer.empty(); // 기존 해시태그 제거
               response.hashtags.forEach(function(hashtag) {
                   var hashtagElement = $('<div class="hash"></div>').html('<span class="hash">'+hashtag+'</span>');
                   hashtagsContainer.append(hashtagElement);
               });
           },
           error: function(xhr, status, error) {
               console.error('ajax오류 : '+error); 
           }
       });
         
   }
   else {
   
   $.ajax({
          url: "default_view", 
          type: "GET",
          data: {"id":id},
          dataType: "json",
          success: function(response) {
              console.log("로그인 유저 기본 추천 가져오기 성공");
              console.log(response);
           
              $(".default_suggest").show();
              $("#d_beachname").html('<input type="hidden" name="beach_code" id="beach_code" value="'+response.beach_code+'" ><span id="beachname">'+response.beach+'</span>');
              $("#beachimg").html('<img src="./resources/image/'+response.picture1+'">');
              $("#review").html(response.reviewsu);
              $("#score").html(response.avgscore);
              
              var hashtagsContainer = $("#hashtags");
              hashtagsContainer.empty(); // 기존 해시태그 제거
              response.hashtags.forEach(function(hashtag) {
                  var hashtagElement = $('<div class="hash"></div>').html('<span class="hash">'+hashtag+'</span>');
                  hashtagsContainer.append(hashtagElement);
              });
              
          },
          error: function(xhr, status, error) {
              console.error('ajax오류 : '+error); 
          }
      });
      
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
         <div class="review_score">
              <span id="review"></span>&nbsp;명의 유저가
                 평균&nbsp;<span id="score"></span>&nbsp;점을 남겨주었어요.
         </div>
         <div class="see_details">
               <div id="detail_text">▼ 자세히 보려면 ▼</div>
               <div class="detailbtn" id="infobtn">
               <span id="btntext">바다 정보 & 날씨</span>
               </div>
               <div class="detailbtn" id="reviewbtn">
               <span id="btntext">바다 리뷰 검색</span>
            </div>
         </div>
      </div>
      <div class="location_suggest">
           <div id="beachname2"></div>
           <div id="distance"></div>
           <div id="beachimg2"></div>
           <div id="hashtags2"></div>
           <div class="review_score">
              <span id="review2"></span>&nbsp;명의 유저가
                 평균&nbsp;<span id="score2"></span>&nbsp;점을 남겨주었어요.
            </div>
         <div class="see_details">
            <div id="detail_text">▼ 자세히 보려면 ▼</div>
            <div class="detailbtn" id="infobtn2">
            <span id="btntext">바다 정보 & 날씨</span>
            </div>
            <div class="detailbtn" id="reviewbtn2">
            <span id="btntext">바다 리뷰 검색</span>
            </div>
         </div>
      </div>
   </c:when>
   
   <c:otherwise>
   <div id="titles">${name} 님께 이 바다를 추천드려요!</div>
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
      <div class="review_score">
           <span id="review"></span>&nbsp;명의 유저가
              평균&nbsp;<span id="score"></span>&nbsp;점을 남겨주었어요.
      </div>
      <div class="see_details">
            <div id="detail_text">▼ 자세히 보려면 ▼</div>
            <div class="detailbtn" id="infobtn">
            <span id="btntext">바다 정보 & 날씨</span>
            </div>
            <div class="detailbtn" id="reviewbtn">
            <span id="btntext">바다 리뷰 검색</span>
            </div>
         </div>
   </div>
   <div class="location_suggest">
        <div id="beachname2"></div>
        <div id="distance"></div>
        <div id="beachimg2"></div>
        <div id="hashtags2"></div>
        <div class="review_score">
           <span id="review2"></span>&nbsp;명의 유저가
              평균&nbsp;<span id="score2"></span>&nbsp;점을 남겨주었어요.
         </div>
         <div class="see_details">
            <div id="detail_text">▼ 자세히 보려면 ▼</div>
            <div class="detailbtn" id="infobtn2">
            <span id="btntext">바다 안내와 날씨 보러가기</span>
            </div>
            <div class="detailbtn" id="reviewbtn2">
            <span id="btntext">리뷰 검색결과 보러가기</span>
            </div>
         </div>
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
        $(".location_suggest").show();
        isLocationEnabled = true;
        myLocation(); // 위치 정보 가져오기
    } else {
        // 체크박스가 체크 해제된 경우
        isLocationEnabled = false;
        $("p").toggle();
        // 위치 정보를 가져오지 않음
        $(".location_suggest").hide();
        $(".default_suggest").show();
        
        
    }
});

</script>

<script type="text/javascript">


function myLocation() {        
    // Geolocation API에 액세스할 수 있는지를 확인
    
    if (navigator.geolocation) {
        //위치 정보를 얻기
        navigator.geolocation.getCurrentPosition (function(pos) {
            var myLatitude = pos.coords.latitude; // 위도
            var myLongitude = pos.coords.longitude; // 경도
            console.log("위도:"+myLatitude+", 경도:"+myLongitude)
            
            $.ajax({
                url: "distance_view", 
                type: "GET",
                data: {"myLatitude":myLatitude,"myLongitude":myLongitude},
                dataType: "json",
                success: function(response) {
                   
                    console.log("거리 계산 결과 가져오기 성공");
                    console.log(response);
                    
                    $(".default_suggest").hide();
                    $(".location_suggest").show();
                    
                    $("#beachname2").html('<input type="hidden" name="beach_code" id="beach_code2" value="'+response.beach_code+'" >여기서 가장 가까운 바다는 <span id="beach">'+response.beach+'</span>(으)로');
                    $("#distance").html('직선거리 약 <span id="beachdistance">'+response.distance.toFixed(1)+'km</span>에 위치해있어요!');
                    $("#beachimg2").html('<img src="./resources/image/'+response.picture1+'">');
                    $("#review2").html(response.reviewsu);
                    $("#score2").html(response.avgscore);
                    
                    var hashtagsContainer = $("#hashtags2");
                    hashtagsContainer.empty(); // 기존 해시태그 제거
                    response.hashtags.forEach(function(hashtag) {
                        var hashtagElement = $('<div class="hash"></div>').html('<span class="hash">'+hashtag+'</span>');
                        hashtagsContainer.append(hashtagElement);
                    });
                    
                },
                error: function(xhr, status, error) {
                    console.error('ajax오류 : '+error); 
                }
            });
           
        });
        
    } else {
        alert("위치 설정을 허용해주세요!");
    }
   
}

   $(document).on("click", "#infobtn", function() {
       showbadainfo();
   });
   
   $(document).on("click", "#reviewbtn", function() {
       showreview();
   });
   
   $(document).on("click", "#infobtn2", function() {
       showbadainfo2();
   });
   
   $(document).on("click", "#reviewbtn2", function() {
       showreview2();
   });
   
   
   function showbadainfo() {
       var beach_code = $("#beach_code").val();
       alert("바다 정보를 보러 이동할게요! 잠시만 기다려주세요.");
       moveToSeaResultPage(beach_code);;
   }
   
   function showreview() {
       var beach_code = $("#beach_code").val();
       alert("해당 바다 리뷰들을 보러 이동할게요! 잠시만 기다려주세요.");
       window.location.href="#";
   }
   
   function showbadainfo2() {
       var beach_code = $("#beach_code2").val();
       alert("바다 정보를 보러 이동할게요! 잠시만 기다려주세요.");
       moveToSeaResultPage(beach_code);
   }
   
   function showreview2() {
       var beach_code = $("#beach_code2").val();
       alert("해당 바다 리뷰들을 보러 이동할게요! 잠시만 기다려주세요.");
       window.location.href="#";
   }

</script>

</div>

<!-- 로딩 페이지 -->
<div id="loading" style="display: none;">
    <jsp:include page="./loading.jsp"/>
</div>
</body>
</html>