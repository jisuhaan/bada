<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/bada_review.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>

</head>
<body>
    <div class="bookcover">
      <div class="bookdot">
        <div class="page">
          <div class="profile-container">
            <div class="header profile-title font-neo">
              TODAY <span class="color-red">&nbsp;52</span> | TOTAL 240419
            </div>
            <div class="box profile-box">
              <div class="profile-image">
                <img
                  class="profile-image-img"
                  src="./resources/image/로고 9-2.png"
                  alt="프로필 이미지"
                />
              </div>
              <div class="profile-text font-kyobohand">
                <바라는 바다!> 를 많이<br>
                사랑해주세요!<br><br>
                
                게시판ver. :: 게시판 형태<br>
                전체보기 :: 지역 상관없이<br>
                지역선택 :: 해당 지역만
              </div>
              <div class="profile-username font-kyobohand">
                <span style="color: #0f1b5c">${name}(${id})</span>
              </div>
              <div class="profile-dropdown">
                <div class="dropdown-button">
                  <div class="dropdown-title">파도타기</div>
                  <div class="triangle-down"></div>
                </div>
                <div class="dropdown-content">
                <c:choose>
                <c:when test="${id ne '*badalove123*'}">
                   <a href="#">--------</a>
                     <a href="mypage?loginid=${id}">마이 페이지</a>
                     <a href="#">--------</a>
                </c:when>
                <c:otherwise>
                   <a href="#">회원만 이용할 수 있어요!</a>
                </c:otherwise>
                </c:choose>
                </div>
              </div>
            </div>
          </div>
          <div class="content-container">
            <div class="header content-title">
              <div class="content-title-name">바라는 바다 리뷰 페이지</div>
              <div class="content-title-url">https://bada_review.com</div>
            </div>
            <div class="box content-box">
              <div class="box-title">바다레코드</div>
              <div class="news-flex-box">
                <div class="news-box">
                <c:forEach items="${list2}" var="rr" varStatus="loop">            
                  <div class="news-row">
					<c:choose>
						<c:when test="${loop.index % 2 == 0}">
						<div class="news-category category-post">리뷰${loop.index + 1}위</div>
						</c:when>
						<c:otherwise>
						<div class="news-category category-pic">리뷰${loop.index + 1}위</div>
						</c:otherwise>
					</c:choose>
                    <div class="news-title">${rr}</div>
                  </div>
                </c:forEach>
                </div>
                <div class="update-box">
                  <div class="menu-row">
                    <div class="menu-item">전국<span class="menu-num">${clist[9].today_review}/${clist[9].all_review}</span>
                    <c:if test="${clist[9].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if>
                    </div>
                    <div class="menu-item">강원<span class="menu-num">${clist[0].today_review}/${clist[0].all_review}</span>
                    <c:if test="${clist[0].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if></div>
                  </div>                
                  <div class="menu-row">
                    <div class="menu-item">경기·인천<span class="menu-num">${clist[1].today_review}/${clist[1].all_review}</span>
                    <c:if test="${clist[1].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if></div>
                    <div class="menu-item">제주<span class="menu-num">${clist[7].today_review}/${clist[7].all_review}</span>
                    <c:if test="${clist[7].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if>
                    </div>
                  </div>
                  <div class="menu-row">
                    <div class="menu-item">경상남도<span class="menu-num">${clist[2].today_review}/${clist[2].all_review}</span>
                    <c:if test="${clist[2].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if></div>
                    <div class="menu-item">경상북도<span class="menu-num">${clist[3].today_review}/${clist[3].all_review}</span>
                    <c:if test="${clist[3].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if></div>
                  </div>
                  <div class="menu-row">
                    <div class="menu-item">전라남도<span class="menu-num">${clist[5].today_review}/${clist[5].all_review}</span>
                    <c:if test="${clist[5].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if></div>
                    <div class="menu-item">전라북도<span class="menu-num">${clist[6].today_review}/${clist[6].all_review}</span>
                    <c:if test="${clist[6].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if></div>
                  </div>
                  <div class="menu-row">
                    <div class="menu-item">부산·울산<span class="menu-num">${clist[4].today_review}/${clist[4].all_review}</span>
                    <c:if test="${clist[4].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if></div>
                    <div class="menu-item">충청남도<span class="menu-num">${clist[8].today_review}/${clist[8].all_review}</span>
                    <c:if test="${clist[8].today_review ne 0}"><img src="./resources/image/new_icon-01.png" width="10px"></c:if></div>
                  </div>                                  
                </div>
              </div>
              <div class="miniroom">
                <div class="box-title"><span class="box-title2">최신리뷰</span><a class="gogo" href="review_input"><span class="go_write">나도쓰러가기 →</span></a></div>
                <div class="miniroom-gif-box">
                  <div class="review_slide">
                  <c:forEach items="${list}" var="aa">
                     <div class="review_card" onclick="window.location.href='review_detail?review_num=${aa.review_num}'">
                        <c:choose>
                        <c:when test="${aa.thumbnail eq 'no'}">
                        <div class="r_thumbnail"><img src="./resources/image/로고 9-2.png"></div>
                        </c:when>
                        <c:otherwise>
                        <div class="r_thumbnail"><img src="./resources/image_user/${aa.thumbnail}"></div>
                        </c:otherwise>
                        </c:choose>
                        <c:choose>
                        <c:when test="${fn:length(aa.review_title) > 17}">
                        <div class="r_title">[${fn:substring(aa.review_title, 0, 16)}…]</div>
                        </c:when>
                        <c:otherwise>
                        <div class="r_title">[${aa.review_title}]</div>
                        </c:otherwise>
                        </c:choose>
                        <div class="r_user">
                           <c:choose>
                           <c:when test="${fn:length(aa.name) > 4}">
                           <span>${fn:substring(aa.name, 0, 5)}…(${fn:substring(aa.id, 0, 4)}***)</span>
                           </c:when>
                           <c:otherwise>
                           <span>${aa.name}(${fn:substring(aa.id, 0, 4)}***)</span>
                           </c:otherwise>
                           </c:choose>
                        </div>
                        <div class="r_date">${fn:substring(aa.write_day, 0, 16)}</div>
                     </div>
                  </c:forEach>
                  </div>
               <script type="text/javascript">
               $('.review_slide').slick({
                  autoplay:true,
                  autoplaySpeed:3000,
                  infinite: true,
                  slidesToShow: 3,
                  slidesToScroll: 3
                  });
                </script>
                </div>
              </div>
              
              <div class="onesentence">
                
                 <div class="box-title"><span class="box-title3">바닷속외침</span><span class="now_area">현재 : ${area}</span></div>
                 <div class="one_container">
                    <div class="write_sentence">
                       <input type="hidden" name="id" id="id" value="${id}" readonly>
                       <input type="hidden" name="name" id="name" value="${name}" readonly>
                       <div class="loc_area">
                       <select name="loc" id="loc" disabled>
                          <option value="${area}" selected>${area}</option>
                       </select></div>
                       <div class="content_area">
                          <c:choose>
                          <c:when test="${id eq '*badalove123*'}">
                             <input type="text" name="content" id="content" placeholder="로그인 한 회원만 이용 가능합니다!" disabled>
                          </c:when>
                          <c:otherwise>
                             <input type="text" name="content" id="content" placeholder="지금 나의 한마디는?">
                          </c:otherwise>
                          </c:choose>
                       </div>
                       <div class="btn_area">
                          <c:choose>
                          <c:when test="${id eq '*badalove123*'}">
                             <input type="button" value="보내기" id="send_sentence" class="btn" disabled style="background-color:darkgray;">
                          </c:when>
                          <c:otherwise>                       
                             <input type="button" value="보내기" id="send_sentence" class="btn">
                          </c:otherwise>
                          </c:choose>
                       </div>
                    </div>
                    <div class="show_sentence">
                       <div class="sentences">
                       <c:forEach items="${olist}" var="bb">
                       <div class="sentence">
                        <div class="o_user">
                              <b><span>${bb.name}(${fn:substring(bb.id, 0, 4)}***)</span></b>
                           </div>
                           <div class="o_text">${bb.content}</div>
                           <div class="o_date">
                           ${fn:substring(bb.one_date, 2, 16)}
                           </div>
                        </div>
                       </c:forEach>
                       </div>
                    </div>
                 </div>
              
              </div>
            </div>
          </div>
          
          <div class="menu-container">
            <div class="menu-button">
             <a href="review_all_page"><button id="btn1" class="menubtn">게시판<br>ver.</button></a>
             <a href="bada_review?area=전국"><button id="btn2" class="menubtn" onclick="changeColor(this)">전국</button></a>
             <a href="bada_review?area=강원"><button id="btn3" class="menubtn" onclick="changeColor(this)">강원</button></a>
             <a href="bada_review?area=경남"><button id="btn4" class="menubtn" onclick="changeColor(this)">경남</button></a>
             <a href="bada_review?area=경북"><button id="btn5" class="menubtn" onclick="changeColor(this)">경북</button></a>
             <a href="bada_review?area=경기인천"><button id="btn6" class="menubtn" onclick="changeColor(this)">경기인천</button></a>
             <a href="bada_review?area=부산울산"><button id="btn7" class="menubtn" onclick="changeColor(this)">부산울산</button></a>
             <a href="bada_review?area=전남"><button id="btn8" class="menubtn" onclick="changeColor(this)">전남</button></a>
             <a href="bada_review?area=전북"><button id="btn9" class="menubtn" onclick="changeColor(this)">전북</button></a>
             <a href="bada_review?area=제주"><button id="btn10" class="menubtn" onclick="changeColor(this)">제주</button></a>
             <a href="bada_review?area=충남"><button id="btn11" class="menubtn" onclick="changeColor(this)">충남</button></a>
            </div>
          
          </div>
        </div>
      </div>
    </div>

<script type="text/javascript">

$(document).ready(function(){
   
   $("#send_sentence").click(function(){
      
      var id = $("#id").val();
      var name = $("#name").val();
      var loc = $("#loc").val();
      var content = $("#content").val();
      
      $.ajax({
         type:"POST",
            url:"say_one_save",
            async:true,
            dataType:"text",
            data:{"id":id,"name":name,"loc":loc,"content":content},
            success:function(result){
               alert("한마디를 남겼습니다!");
               window.location.reload();
            },
            error:function(){
               alert("데이터 전송 과정에 에러가 발생했습니다!");
            }
        });

   });
   
});

//페이지 로드 시 실행되는 함수
window.onload = function() {
  // 로컬 스토리지에서 이전에 선택한 버튼 정보 가져오기
  var selectedButton = localStorage.getItem('selectedButton');
  if (selectedButton) {
    // 이전에 선택한 버튼이 있다면 해당 버튼의 스타일을 변경
    document.getElementById(selectedButton).classList.add('clicked');
    localStorage.removeItem('selectedButton');
  }
}

// 클릭한 버튼의 스타일 변경 및 선택 정보 저장
function changeColor(button) {
  // 모든 버튼의 클래스 제거
  var buttons = document.querySelectorAll('.menubtn');
  buttons.forEach(function(btn) {
    btn.classList.remove('clicked');
  });
  
  // 클릭된 버튼에 클래스 추가
  button.classList.add('clicked');
  
  // 선택한 버튼의 id를 로컬 스토리지에 저장
  localStorage.setItem('selectedButton', button.id);
}

</script>
 
</body>
</html>