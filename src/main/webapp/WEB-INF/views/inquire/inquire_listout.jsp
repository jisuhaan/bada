<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="inquire_search.jsp" %>

<!DOCTYPE html>

<html>

<head>

 <meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/review_page.css" rel="stylesheet" type="text/css">
<title>바라는 바다! :: 문의 목록</title>
<style>
    .wide-cell {
    	padding: 10px;
        cursor: pointer; /* 커서를 포인터로 변경하여 사용자에게 클릭 가능한 요소임을 나타냄 */
    }
    .hidden {
        display: none; /* 숨겨진 요소 */
    }
    
    .sort-options {
    	text-align: right;
	}
 	
 	.notice {
 		display:flex;
 		justify-content: center;
 		align-items: center;
 		text-align: left;
 		padding:30px;
 		word-wrap: break-word;
 		font-family:Pretendard-Regular';
		font-size: 12px;
		line-height:1.4;
 	}     
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	var urlParams = new URLSearchParams(window.location.search);
	var sortParam = urlParams.get('sort');
	   
	if (sortParam) {
		$('.sort-box').removeClass('active');
		if (sortParam === 'latest') {
		    $('.sort-box.latest').addClass('active');
		} else if (sortParam === 'popular') {
		    $('.sort-box.popular').addClass('active');
		}
	}
	else{
		$('.sort-box.latest').addClass('active');
	}
});

function toggleContent(id) {
    var content = document.getElementById("content" + id);
    var toggleIcon = document.getElementById("toggleIcon" + id);
    if (content.style.display === "none" || content.style.display === "") {
        content.style.display = "table-row"; // 숨겨진 요소를 보이게 함
        toggleIcon.innerText = "▲"; // 아이콘 변경
    } else {
        content.style.display = "none"; // 보이는 요소를 숨김
        toggleIcon.innerText = "▼"; // 아이콘 변경
    }
}

function sortAndColor(selectDiv, sortType){
	
    $('.sort-box').removeClass('active');
    $(selectDiv).addClass('active');
    window.location.href = "inquire_listout?sort=" + sortType;
	
}

</script>

</head>

<body>
<br>
<br>
<div class="sort-options">
	<label id="sort-title">정렬 방식</label>&nbsp;
	<div class="sort-box latest" onclick="sortAndColor(this, 'latest')"><span>최신순</span></div>
	<div class="sort-box popular" onclick="sortAndColor(this, 'popular')"><span>추천순</span></div>
</div>
<br>
<div id="board-list">
        <div class="container">
            <table class="board-table">
                <tbody>
			      <tr>
			      	<td class="wide-cell" onclick="toggleContent(3)"> 자주 하는 질문(QnA) <span id="toggleIcon3">▼</span> </td>
			      </tr>
			      
			      <tr class="hidden" id="content3">
			      	<td class="wide-cell" style="text-align: left;">
			      	<div class="notice">
				      	안녕하세요! <바라는 바다!> 개발자 팀입니다. <br>
				      	<바라는 바다!> 시스템을 이용해주시는 사용자 분들께 감사의 말씀을 전하며, 홈페이지 이용 시 자주 들어오는 질문을 정리해 답변해드리겠습니다. <br>
				      	혹시 지금 남기려는 문의가 아래 문의에 해당하지 않는지 확인하신 후, 더 자세한 사항이 궁금하시다면 문의해주세요! <br>
						 <br>
						 <br>
						Q. 제가 찾아보려는 바다가 <바라는 바다!>에 없어요. <br>
						A. <바라는 바다!>는 사용자와 함께 소통하며 새로운 바다 정보를 개척해나가는 시스템입니다. <br>
						만일 <바라는 바다!>에 여러분이 원하는 바다가 없다면, 문의란의 <새로운 바다 추천> 카테고리로 새로운 바다를 추천해주세요. <br>
						저희도 여러분이 궁금해 하는 바다가 궁금해요! <br>
						 <br>
						Q. 바다의 기상 정보에 관련된 용어를 잘 모르겠어요. <br>
						A. 정확한 어휘 사용을 위해 최대한 기상청의 용어를 그대로 차용했으나, 혹시 용어가 어렵다면 좀 더 자세히 설명해드릴게요. <br>
						<바라는 바다!>의 시스템에 사용된 기상 정보 용어가 아주 많아서, 가장 자주 묻는 용어 top3를 알려드리겎습니다! <br>
						<br>
						파고: 파고란 파도의 높이를 뜻하는 단어이며, 단위는 m(미터)입니다. 즉, 파고 0.5라면 파도의 높이가 50cm라는 뜻이겠죠? <br>
						박무, 연무: 박무와 연무는 안개와 관련된 용어입니다.<br>
						이때 연무는 매연이나 연기를 모두 포괄해 말하는 단어이고, 박무는 옅게 낀 안개를 말하는 단어입니다.<br>
						상대습도: 상대습도는 기온에 따른 습도를 백분율로 나타낸 용어입니다.<br>
						절대적으로 허공에 얼만큼의 물방울이 포함되어 있느냐를 따지는 절대습도와 달리, 온도 등의 외부 여건에 의해 결정되는 습도이죠.<br>
						따라서 불쾌지수 등을 구할 땐 상대습도가 이용됩니다.<br>
						 <br>
						Q. 로그인/회원가입 시 오류가 있어요. <br>
						A. <바라는 바다!> 팀은 로그인, 회원가입 등 회원의 개인정보를 다루는 지점에서 엄격하고 진중한 태도로 홈페이지 관리에 임합니다. <br>
						때문에 오류가 있다면 1:1 문의나 비밀문의 등을 통해 자세한 질문을 해주신다면 더 빠르고 정확하게 해결할 수 있습니다. <br>
						 <br>
						Q. 로그인이 안 돼서 문의를 남길 수 없어요. <br>
						A. <바라는 바다!> 팀은 다른 사용자를 보호하기 위해 각종 게시글과 문의는 로그인한 회원만 작성할 수 있도록 조치를 취해두었습니다. <br>
						그러나 만일 예상치 못한 문제로 로그인이 되지 않아 문의를 작성할 수 없다면, 1:1 문의를 통해 로그인 과정에서의 도움을 받을 수 있습니다. <br>
						해당 문의는 1:1로 부탁드립니다. <br>
						 <br>
						Q. 한반도 지도에 독도가 없어요. <br>
						A. 그럴리가요! 독도는 <바라는 바다!> 홈페이지 내 한반도 지도에 확실하게 존재하지만, 실제 면적이 크지 않은 관계로 아주 작게 표시되었습니다. <br>
						혹시 한반도 지도를 4배 확대, 즉 400% 크기로 살펴본 적이 있으신가요? <br>
						동해안 바다에 조그맣고 소중하고 확실하게 대한민국의 독도가 위치해 있습니다. <br>
						바다를 사랑하는 <바라는 바다!>팀은 우리나라의 모든 바다를 잊지 않고 기록하고 있습니다. <br>
						 <br>
						 <br>
						위 내용에 여러분이 질문하려던 내용이 없다면, 또는 더 자세한 1:1 맞춤 답변이 필요하다면, 비밀 문의나 1:1 문의를 통해 질문해 주시거나 저희에게 직접 연락해주세요. <br>
						보다 세밀하고 정확한 답을 통해 여러분의 궁금증을 해결해드리겠습니다. 이상, <바라는 바다!> 개발자팀이었습니다. <br>
						 <br>
						Contact us: <br>
						경기 수원시 팔달구 향교로 2(매산로1가 60-3) [16455] <br>
						031-253-6776 <br>
						ezen.bada@gmail.com <br>
					</div>
			      	</td>
			      </tr>
            
	   </tbody>
            </table>
        </div>
    </div>

      <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
               <tr>
                   <th colspan="2">문의글 제목</th>
                  <th>문의 카테고리</th>
                  <th>문의 작성자</th>
                  <th>문의 날짜</th>
                  <th>답변</th>
                  <th>추천수</th>
                  <th>조회수</th>
               </tr>
                  </thead>
                  
<tbody>


<c:choose>
<c:when test="${sort=='latest'}">




<c:choose>
<c:when test="${loginstate==true && position=='admin'}">



<c:forEach items="${list2}" var="l2">
         <tr class="notice_line">
            <td colspan="2">
            [추천순 top3]
            <a href="to_inquire_detail?inquire_num=${l2.inquire_num}">
                   <c:choose>
                       <c:when test="${l2.secret == 'y'}">
                           <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                           ${l2.title}
                       </c:when>
                       <c:otherwise>
                           ${l2.title}
                       </c:otherwise>
                   </c:choose>
               </a>
               </td>
            <td>${l2.category}</td>
            <td>
            ${l2.name}(${fn:substring(l2.id, 0, 4)}****) 님
            </td>
            <td>
               ${fn:substring(l2.i_date, 0, 19)}
            </td>
            <td>
               <c:choose>
                <c:when test="${l2.reply == 0}">미응답</c:when>
                <c:otherwise>완료</c:otherwise>
            </c:choose>
            </td>
            <td>${l2.rec}</td>
            <td>${l2.cnt}</td>
         </tr>
         </c:forEach>



<c:forEach items="${list}" var="l">
               <tr>
                  <td colspan="2">
                  <a href="to_inquire_detail?inquire_num=${l.inquire_num}">
                       <c:choose>
                           <c:when test="${l.secret == 'y'}">
                               <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                               ${l.title}
                           </c:when>
                           <c:otherwise>
                               ${l.title}
                           </c:otherwise>
                       </c:choose>
                   </a>
                   </td>
                  <td>${l.category}</td>
                  <td>
                  ${l.name}(${fn:substring(l.id, 0, 4)}****) 님
                  </td>
                  <td>
                     ${fn:substring(l.i_date, 0, 19)}
                  </td>
                  <td>
                     <c:choose>
                      <c:when test="${l.reply == 0}">미응답</c:when>
                      <c:otherwise>완료</c:otherwise>
                  </c:choose>
                  </td>
                  <td>${l.rec}</td>
                  <td>${l.cnt}</td>
               </tr>
               </c:forEach>
            
    <!--  페이징 처리 6단계 -->
      <!-- 페이징처리 -->
      <tr style="border-left: none; border-right: none; border-bottom: none;">
         <td colspan="10" style="text-align: center;">
         <c:if test="${paging.startPage!=1 }">
             <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=latest&nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
            
         </c:if>   
         
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
               <c:choose>
                  <c:when test="${p == paging.nowPage }">
                  <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
                     <b><span style="color: red;">${p}</span></b>
                  </c:when>   
                  <c:when test="${p != paging.nowPage }">
                  <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
                     <a href="inquire_listout?sort=latest&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
                  </c:when>   
               </c:choose>
            </c:forEach>
           
            <c:if test="${paging.endPage != paging.lastPage}">
            <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=latest&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
         </c:if>
         
         </td>
      </tr>
      <!-- 페이징처리 -->
   <!-- 페이징 처리 6단계 끝 -->
</c:when>







<c:otherwise>

<c:forEach items="${list2}" var="l2">
         <tr class="notice_line">
            <td colspan="2">
            [추천순 top3]
            <a href="to_inquire_detail?inquire_num=${l2.inquire_num}">
                   <c:choose>
                       <c:when test="${l2.secret == 'y'}">
                           <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                           ${l2.title}
                       </c:when>
                       <c:otherwise>
                           ${l2.title}
                       </c:otherwise>
                   </c:choose>
               </a>
               </td>
            <td>${l2.category}</td>
            <td>
            ${l2.name}(${fn:substring(l2.id, 0, 4)}****) 님
            </td>
            <td>
               ${fn:substring(l2.i_date, 0, 19)}
            </td>
            <td>
               <c:choose>
                <c:when test="${l2.reply == 0}">미응답</c:when>
                <c:otherwise>완료</c:otherwise>
            </c:choose>
            </td>
            <td>${l2.rec}</td>
            <td>${l2.cnt}</td>
         </tr>
         </c:forEach>



               <c:forEach items="${list}" var="l">
               <tr>
                  <td colspan="2">
                  <a href="inquire_secret_yn?inquire_num=${l.inquire_num}&secret=${l.secret}">
                       <c:choose>
                           <c:when test="${l.secret == 'y'}">
                               <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                               비밀글입니다.
                           </c:when>
                           <c:otherwise>
                               ${l.title}
                           </c:otherwise>
                       </c:choose>
                   </a>
                   </td>
                  <td>${l.category}</td>
                  <td>
                  ${l.name}(${fn:substring(l.id, 0, 4)}****) 님
                  </td>
                  <td>
                     ${fn:substring(l.i_date, 0, 19)}
                  </td>
                  <td>
                     <c:choose>
                      <c:when test="${l.reply == 0}">미응답</c:when>
                      <c:otherwise>완료</c:otherwise>
                  </c:choose>
                  </td>
                  <td>${l.rec}</td>
                  <td>${l.cnt}</td>
               </tr>
               </c:forEach>
            
    <!--  페이징 처리 6단계 -->
      <!-- 페이징처리 -->
      <tr style="border-left: none; border-right: none; border-bottom: none;">
         <td colspan="10" style="text-align: center;">
         <c:if test="${paging.startPage!=1 }">
             <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=latest&nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
            
         </c:if>   
         
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
               <c:choose>
                  <c:when test="${p == paging.nowPage }">
                  <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
                     <b><span style="color: red;">${p}</span></b>
                  </c:when>   
                  <c:when test="${p != paging.nowPage }">
                  <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
                     <a href="inquire_listout?sort=latest&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
                  </c:when>   
               </c:choose>
            </c:forEach>
           
            <c:if test="${paging.endPage != paging.lastPage}">
            <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=latest&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
         </c:if>
         
         </td>
      </tr>
      <!-- 페이징처리 -->
   <!-- 페이징 처리 6단계 끝 -->   
       
       </c:otherwise>    

       </c:choose>
       
      </c:when>
      
      
      
      <c:otherwise>
      
      <c:choose>
      
<c:when test="${loginstate==true && position=='admin'}">


<c:forEach items="${list2}" var="l2">
         <tr class="notice_line">
            <td colspan="2">
            [추천순 top3]
            <a href="to_inquire_detail?inquire_num=${l2.inquire_num}">
                   <c:choose>
                       <c:when test="${l2.secret == 'y'}">
                           <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                           ${l2.title}
                       </c:when>
                       <c:otherwise>
                           ${l2.title}
                       </c:otherwise>
                   </c:choose>
               </a>
               </td>
            <td>${l2.category}</td>
            <td>
            ${l2.name}(${fn:substring(l2.id, 0, 4)}****) 님
            </td>
            <td>
               ${fn:substring(l2.i_date, 0, 19)}
            </td>
            <td>
               <c:choose>
                <c:when test="${l2.reply == 0}">미응답</c:when>
                <c:otherwise>완료</c:otherwise>
            </c:choose>
            </td>
            <td>${l2.rec}</td>
            <td>${l2.cnt}</td>
         </tr>
         </c:forEach>



<c:forEach items="${list}" var="l">
               <tr>
                  <td colspan="2">
                  <a href="to_inquire_detail?inquire_num=${l.inquire_num}">
                       <c:choose>
                           <c:when test="${l.secret == 'y'}">
                               <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                               ${l.title}
                           </c:when>
                           <c:otherwise>
                               ${l.title}
                           </c:otherwise>
                       </c:choose>
                   </a>
                   </td>
                  <td>${l.category}</td>
                  <td>
                  ${l.name}(${fn:substring(l.id, 0, 4)}****) 님
                  </td>
                  <td>
                     ${fn:substring(l.i_date, 0, 19)}
                  </td>
                  <td>
                     <c:choose>
                      <c:when test="${l.reply == 0}">미응답</c:when>
                      <c:otherwise>완료</c:otherwise>
                  </c:choose>
                  </td>
                  <td>${l.rec}</td>
                  <td>${l.cnt}</td>
               </tr>
               </c:forEach>
            
    <!--  페이징 처리 6단계 -->
      <!-- 페이징처리 -->
      <tr style="border-left: none; border-right: none; border-bottom: none;">
         <td colspan="10" style="text-align: center;">
         <c:if test="${paging.startPage!=1 }">
             <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=popular&nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
            
         </c:if>   
         
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
               <c:choose>
                  <c:when test="${p == paging.nowPage }">
                  <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
                     <b><span style="color: red;">${p}</span></b>
                  </c:when>   
                  <c:when test="${p != paging.nowPage }">
                  <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
                     <a href="inquire_listout?sort=popular&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
                  </c:when>   
               </c:choose>
            </c:forEach>
           
            <c:if test="${paging.endPage != paging.lastPage}">
            <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=popular&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
         </c:if>
         
         </td>
      </tr>
      <!-- 페이징처리 -->
   <!-- 페이징 처리 6단계 끝 -->
</c:when>
<c:otherwise>

<c:forEach items="${list2}" var="l2">
         <tr class="notice_line">
            <td colspan="2">
            [추천순 top3]
            <a href="to_inquire_detail?inquire_num=${l2.inquire_num}">
                   <c:choose>
                       <c:when test="${l2.secret == 'y'}">
                           <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                           ${l2.title}
                       </c:when>
                       <c:otherwise>
                           ${l2.title}
                       </c:otherwise>
                   </c:choose>
               </a>
               </td>
            <td>${l2.category}</td>
            <td>
            ${l2.name}(${fn:substring(l2.id, 0, 4)}****) 님
            </td>
            <td>
               ${fn:substring(l2.i_date, 0, 19)}
            </td>
            <td>
               <c:choose>
                <c:when test="${l2.reply == 0}">미응답</c:when>
                <c:otherwise>완료</c:otherwise>
            </c:choose>
            </td>
            <td>${l2.rec}</td>
            <td>${l2.cnt}</td>
         </tr>
         </c:forEach>

               <c:forEach items="${list}" var="l">
               <tr>
                  <td colspan="2">
                  <a href="inquire_secret_yn?inquire_num=${l.inquire_num}&secret=${l.secret}">
                       <c:choose>
                           <c:when test="${l.secret == 'y'}">
                               <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                               비밀글입니다.
                           </c:when>
                           <c:otherwise>
                               ${l.title}
                           </c:otherwise>
                       </c:choose>
                   </a>
                   </td>
                  <td>${l.category}</td>
                  <td>
                  ${l.name}(${fn:substring(l.id, 0, 4)}****) 님
                  </td>
                  <td>
                     ${fn:substring(l.i_date, 0, 19)}
                  </td>
                  <td>
                     <c:choose>
                      <c:when test="${l.reply == 0}">미응답</c:when>
                      <c:otherwise>완료</c:otherwise>
                  </c:choose>
                  </td>
                  <td>${l.rec}</td>
                  <td>${l.cnt}</td>
               </tr>
               </c:forEach>
            
    <!--  페이징 처리 6단계 -->
      <!-- 페이징처리 -->
      <tr style="border-left: none; border-right: none; border-bottom: none;">
         <td colspan="10" style="text-align: center;">
         <c:if test="${paging.startPage!=1 }">
             <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=popular&nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
            
         </c:if>   
         
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
               <c:choose>
                  <c:when test="${p == paging.nowPage }">
                  <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
                     <b><span style="color: red;">${p}</span></b>
                  </c:when>   
                  <c:when test="${p != paging.nowPage }">
                  <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
                     <a href="inquire_listout?sort=popular&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
                  </c:when>   
               </c:choose>
            </c:forEach>
           
            <c:if test="${paging.endPage != paging.lastPage}">
            <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=popular&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
         </c:if>
         
         </td>
      </tr>
      <!-- 페이징처리 -->
   <!-- 페이징 처리 6단계 끝 -->
          
       </c:otherwise>
       
       
       </c:choose>
      
      
      
      </c:otherwise>
      
       
           
   </c:choose>        
           
       </tbody>
            </table>
        </div>
    </div>


   <br> <br> <br> <br> <br>
   
</body>
</html>