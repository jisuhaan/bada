<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/097b31c9b8.js" crossorigin="anonymous"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
HttpSession hs = request.getSession();
if(hs.getAttribute("loginstate")==null){
   hs.setAttribute("loginstate", false);
}
%>

   <div class="main_logo">
      <img src ="./resources/image/로고 9-1.png" width="300px">
   </div>
   
   <div class="container">
   
   <div class="main_search">
      <input type="text" name="area" id="area" placeholder="도·시·군을 뺀 지역명 입력 ex)강원, 강릉, 부산..">&nbsp;
      <a href="#" onclick="search_area();"><i class="fa-solid fa-magnifying-glass fa-xl" style="color: #1B70A6;"></i></a>&nbsp;
   </div>
   
   <div class="main_container">
      <div class="main_left">
         <jsp:include page="main_suggest_view.jsp" />
      </div>
      <div class="main_right">
         <div class="main_right_top">
         
         <div class="main_banner_wrap">
         <div class="main_banner">
            <div class="banner first" onclick="window.location.href='event?event_num=1'"><img src="./resources/image/main_banner_1.png"></div>
            <div class="banner second" onclick="window.location.href='event?event_num=2'"><img src="./resources/image/main_banner_2.png"></div>
            <div class="banner third" onclick="window.location.href='event?event_num=3'"><img src="./resources/image/main_banner_3.png"></div>
            <div class="banner fourth" onclick="window.location.href='event?event_num=4'"><img src="./resources/image/main_banner_4.png"></div>
         </div>
         </div>   
         
         <script type="text/javascript">
            $(document).ready(function(){            
                $('.main_banner').bxSlider({
                  mode:'vertical',
                  slideMargin: 5,
                  auto:true,
                  stopAutoOnClick:true,
                  autoHover:false,
                  controls:true,
                  infiniteLoop: true,
                  pager: true      
                });       
            });   
         </script>
         
         </div>
         <div class="main_right_bottom">
         <jsp:include page="main_recommend_view.jsp" />
         </div>
      </div>
   </div>
</div>

<script type="text/javascript">


function search_area() {
   
   let area = $("#area").val();
   
   if(area=="" || area.length==1){
      alert("검색어는 두 글자 이상 입력해주세요!");
   }
   else {
      $.ajax({
         url: "main_search",
         type: "GET",
         async: true,
         data: {"area":area},
         dataType:"text",
         success: function(response) {
            
            if(response=='no'){
               alert("해당 지역은 저희 바다 데이터에 존재하지 않습니다 ㅠ.ㅠ!");
            }
            else if(response=='city'){
               alert("해당 도시에 있는 바다 목록을 팝업창으로 보여드릴게요!")
               window.open("search_city?city="+area, "바라는바다::바다목록", "width=605,height=605,resizable=no,scrollbars=no,menubar=no,location=no");
            }
            else{
               
               if(area=='부산'||area=='울산'){
                  area='부울';
               }
               if(area=='인천'||area=='경기'){
                  area='경인';
               }
               
               localStorage.setItem('area', area);
               window.location.href="sea_info";
            }
      
         },
         error:function(xhr, status, error) {
               console.error(xhr.responseText); 
            alert('데이터 전송과정에서 문제가 발생했습니다!');
         }
      });
   }
}
   
</script>

</body>
</html>