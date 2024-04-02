<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/sea_info.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

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
           
           if(response.length > 0){
               
        	  var badalist = "<ul>";
        	  for(var i = 0; i < response.length; i++) {
                  badalist += "<li><a href='sea_result?beach_code=" +response[i].beach_code +
                		  "'>" + response[i].beach + '</a></li>';
              }
              
              badalist += "</ul>";
              
              $('#badalist_container').html(badalist);
               
           } else {
        	   
        	  $('#badalist_container').html('<p>해당 지역의 해수욕장 데이터는 아직 준비되지 않았어요 ㅠ.ㅠ</p>');

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
<div class="seamain">

<div class="seamainleft">
<div id="maptext">가고싶은 지역을 선택해보세요!</div>
	<div class="seamainmaps">
	<object type="image/svg+xml" data="./resources/svg/southKoreamap.svg" width="650px" height="800px" id="selectmap"></object>
		<div class="map">
			<ul class="map-step1"><!--링크 클릭 시 해당지역 추가-->
				<li class="kyungin">
					<a href="#" onclick="clickarea('gyeongin'); showarea('경인')" id="kyungin">
					<img src="./resources/image/경인-01.png" width="100px">
					</a>
				</li>
				<li class="kangwon">
					<a href="#" onclick="clickarea('kangwon'); showarea('강원');" id="kangwon">
					<img src="./resources/image/강원-01.png" width="100px">
					</a>
				</li>
				<li class="chungnam">
					<a href="#" onclick="clickarea('chungnam'); showarea('충남');" id="chungnam">
					<img src="./resources/image/충남-01.png" width="100px">
					</a>
				</li>
				<li class="jeonbuk">
					<a href="#" onclick="clickarea('jeonbuk'); showarea('전북');" id="jeonbuk">
					<img src="./resources/image/전북-01.png" width="100px">
					</a>
				</li>
				<li class="jeonnam">
					<a href="#" onclick="clickarea('jeonnam'); showarea('전남');" id="jeonnam">
					<img src="./resources/image/전남-01.png" width="100px">
					</a>
				</li>
				<li class="kyungbuk">
					<a href="#" onclick="clickarea('kyungbuk'); showarea('경북');" id="kyungbuk">
					<img src="./resources/image/경북-01.png" width="100px">
					</a>
				</li>
				<li class="kyungnam">
					<a href="#" onclick="clickarea('kyungnam'); showarea('경남');" id="kyungnam">
					<img src="./resources/image/경남-01.png" width="100px">
					</a>
				</li>
				
				<li class="buul">
					<a href="#" onclick="clickarea('buul'); showarea('부울');" id="buul">
					<img src="./resources/image/부울-01.png" width="100px">
					</a>
				</li>
				<li class="jeju">
					<a href="#" onclick="clickarea('jeju'); showarea('제주');" id="jeju">
					<img src="./resources/image/제주-01.png" width="100px">
					</a>
				</li>
			</ul>
			</div>
		</div>	
	
</div>

<div class="seamainright">

<div class="">
<div id="badalist_container"></div>
</div>

</div>

</div>
<script src="./resources/js/sea_map.js"></script>

</body>
</html>