<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/sea_info.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$("#arrow_box").hide();
	$("#weather_infobox").hide();
	
	let area = localStorage.getItem('area');
	console.log('검색에서 지역 가져왔니? : '+area);
	
	if(area) {
		clickarea(area);
        showarea(area);
        localStorage.removeItem('area');
    }
});

function showarea(area){
	
$.ajax({
	
       type:"post",
       url:"bada_listup",
       async:true,
       method:"GET",
       dataType:"json",
       contentType: "application/json; charset=UTF-8",
       data:{"area":area},
       success:function(response){

    		$("#arrow_box").show();
    		$("#weather_infobox").show();
    		
           
    	   var badalist="<div class='beach_list'>";
    	   
           if(response.length > 0){
        	  
        	  for(var i = 0; i < response.length; i++) {
                  badalist += "<div id='beaches'><a href='sea_result?beach_code=" + response[i].beach_code + "'>" +response[i].beach + "</a></div><br>";
              }
        	  
        	  badalist += "</div>"

              $('#badalist_container').html(badalist);
               
           } else {
        	   
        	  $('#badalist_container').html('<p id="no_beach">이 지역의 해수욕장 데이터는<br>아직 준비되지 않았어요 ㅠ.ㅠ</p><br><br><p id="inquire_link"><a href="./inquire_input">☞ 해수욕장 추천하기 ☜</a></p>');

           }
       },
       error: function(xhr, status, error){
           console.error("데이터 전송 과정에 에러가 발생했습니다!", error);
       }
       
   });
	
}

</script>
</head>
<body>
<div class="container">

<div class="sea_main_left">
<div id="map_text">가고싶은 지역을 선택해보세요!</div>
	<div class="sea_main_maps">
	<object type="image/svg+xml" data="./resources/svg/southKoreamap.svg" width="650px" height="800px" id="select_map"></object>
		<div class="map">
			<ul class="map-step1"><!--링크 클릭 시 해당지역 추가-->
				<li class="kyungin">
					<a href="#" onclick="clickarea('경인'); showarea('경인');" id="kyungin">
					<img src="./resources/image/경인-01.png" width="100px">
					</a>
				</li>
				<li class="kangwon">
					<a href="#" onclick="clickarea('강원'); showarea('강원');" id="kangwon">
					<img src="./resources/image/강원-01.png" width="100px">
					</a>
				</li>
				<li class="chungnam">
					<a href="#" onclick="clickarea('충남'); showarea('충남');" id="chungnam">
					<img src="./resources/image/충남-01.png" width="100px">
					</a>
				</li>
				<li class="jeonbuk">
					<a href="#" onclick="clickarea('전북'); showarea('전북');" id="jeonbuk">
					<img src="./resources/image/전북-01.png" width="100px">
					</a>
				</li>
				<li class="jeonnam">
					<a href="#" onclick="clickarea('전남'); showarea('전남');" id="jeonnam">
					<img src="./resources/image/전남-01.png" width="100px">
					</a>
				</li>
				<li class="kyungbuk">
					<a href="#" onclick="clickarea('경북'); showarea('경북');" id="kyungbuk">
					<img src="./resources/image/경북-01.png" width="100px">
					</a>
				</li>
				<li class="kyungnam">
					<a href="#" onclick="clickarea('경남'); showarea('경남');" id="kyungnam">
					<img src="./resources/image/경남-01.png" width="100px">
					</a>
				</li>
				
				<li class="buul">
					<a href="#" onclick="clickarea('부울'); showarea('부울');" id="buul">
					<img src="./resources/image/부울-01.png" width="100px">
					</a>
				</li>
				<li class="jeju">
					<a href="#" onclick="clickarea('제주'); showarea('제주');" id="jeju">
					<img src="./resources/image/제주-01.png" width="100px">
					</a>
				</li>
			</ul>
			</div>
		</div>	
	
</div>

<div class="sea_main_right" id="sea_main_right">

<div class="weather_infobox" id="weather_infobox">
<span id="result_top">검색 결과를 보여드릴게요!</span>
<br><br><hr><br><br>

<div id="badalist_container">
</div>

</div>

</div>

</div>
<script src="./resources/js/sea_map.js"></script>

</body>
</html>