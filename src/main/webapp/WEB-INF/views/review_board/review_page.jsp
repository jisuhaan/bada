<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/review_page.css" rel="stylesheet" type="text/css">
<title>바다리뷰 :: 전체보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	 $('#area').change(function() {
	        var select_area = $(this).val(); // 선택된 지역값
	        $.ajax({
	            type: "POST",
	            url: "review_area_search",
	            data: {'area' : select_area}, 
	            dataType: "html",
	            success: function(data) {
	                $('#board-list').html(data); 
	            },
	            error: function(xhr, status, error) {
	                console.error("Error: " + error);
	                alert("지역 게시글을 불러오는데 실패했습니다.");
	            }
	        });
	    });
	

    $('#search-form').submit(function(event) {
        event.preventDefault();
        var form_data = $(this).serialize();
        $.ajax({
            type: "POST",
            url: "review_search",
            data: form_data,
            dataType: "html",
            success: function(response) {
            	alert("입력하신 검색어를 포함한 리뷰를 찾는 중입니다.");
                $('#board-list').html(response);
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
                alert("검색 결과를 불러오는데 실패했습니다.");
            }
        });
    });
    
    // 검색 카테고리에 따른 placeholder 변경
    
    $('select[name="search_category"]').change(function() {
        var choice = $(this).val();
        var search = $('#search');
        var year = $('#year');
        var month = $('#month');
        
        if (choice === 'vdate' || choice === 'wdate') {
        	search.hide();
            year.show();
            month.show();
        } else {
        	search.show();
            year.hide();
            month.hide();
        }
    });
    
    $('#year').change(function() {
        var select_year = $(this).val();
        if (select_year === "2020") {
            $('#month').val(""); 
            $('#month').hide();   
        } else {
            $('#month').show();   
        }
    });
    
    
});

</script>

<script>
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
</script>
<style>
        .wide-cell {
        	padding: 10px;
            cursor: pointer; /* 커서를 포인터로 변경하여 사용자에게 클릭 가능한 요소임을 나타냄 */
        }
        .hidden {
            display: none; /* 숨겨진 요소 */
        }
        
    </style>
</head>
<body>


<%
    java.util.Calendar cal = java.util.Calendar.getInstance();
    int currentYear = cal.get(java.util.Calendar.YEAR);
    pageContext.setAttribute("currentYear", currentYear);
%>

<div class="review_container">

<section class="notice">
  <div class="page-title">
        <div class="container">
            <h3>바라는 바다 리뷰</h3>
        </div>
    </div>

    <!-- board seach area -->
    <div id="board-search">
        <div class="container">
            <div class="search-window">
            <div class="area_select">
            	<span>지역선택&nbsp;</span> 
        		<select name="area" id="area">
        			<option value="전체" selected>전체</option>
        			<option value="강원" id="강원">강원</option>
        			<option value="경남" id="경남">경남</option>
        			<option value="경북" id="경북">경북</option>
        			<option value="경인" id="경인">경인</option>
        			<option value="부산" id="부산">부산</option>
        			<option value="울산" id="울산">울산</option>
        			<option value="전남" id="전남">전남</option>
        			<option value="전북" id="전북">전북</option>
        			<option value="제주" id="제주">제주</option>
        			<option value="충남" id="충남">충남</option>
        			<option value="충북" id="충북">충북</option>
        		</select>
        	</div>
        	    
		    <div class="sort-options">
		    <label>정렬 방식</label>&nbsp;&nbsp;
		    <a href="review_page?sort=latest">최신순</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="review_page?sort=popular">추천순</a>
			</div>
			
			<form id="search-form">
			<div class="search-wrap">
				<select name="search_category">
					<option value="title">제목</option>
					<option value="intext">내용</option>
					<option value="beach_name">바다이름</option>
					<option value="name">작성자명</option>
					<option value="vdate">방문시기</option>
					<option value="wdate">작성일자</option>
				</select>
				<label for="search" class="blind">검색</label>
				<input id="search" type="search" name="search" placeholder="검색어를 입력해주세요." value="">
				        
				<select id="year" name="year" style="display:none;">
				<option value="" selected>연도 선택!</option>
				<option value="2020">2021년 이전</option>
				<c:forEach begin="2021" end="${currentYear}" var="year">
				<option value="${year}">${year}년</option>
				</c:forEach>
				</select>
				
				<select id="month" name="month" style="display:none;">
				<option value="">월 선택</option>
				 <c:forEach begin="1" end="12" var="month">
				<option value="${month}">${month}월</option>
				</c:forEach>
				</select>
				
				<button type="submit" class="btn btn-dark">검색</button>
			</div>
			</form>
            </div>
        </div>
    </div>
   
   <div id="board-intro">
        <div class="container">
            <table class="board-table">
                <tbody>
			      <tr>
			      	<td class="wide-cell" onclick="toggleContent(3)"> 리뷰 게시판 이용방법 <span id="toggleIcon3">▼</span> </td>
			      </tr>
			      
			      <tr class="hidden" id="content3">
			      	<td class="wide-cell" style="text-align: left;">
			      	<div class="notice_text">
			      	안녕하세요! <바라는 바다!> 개발자 팀입니다.  <br>
			      	<바라는 바다!> 시스템을 이용해주시는 사용자 분들께 감사의 말씀을 전하며, 리뷰 페이지 이용 방법을 간단하게 알려드리겠습니다. <br> <br>

					<바라는 바다>는 기본적으로 자유로운 리뷰를 지향하고 있습니다. 때문에 특별히 정해진 형식은 없지만, 유용한 정보를 공유하는 것을 추천하고 있습니다.  <br>
					해당 바다에서 가장 인상 깊었던 것은 무엇인지, 그 바다의 장점과 단점은 무엇인지 공유하여 <바라는 바다> 사용자들 간에서 알게 되는 정보가 양질의 정보이길 바랍니다! <br> <br>
					
					바다의 색깔이나 전경이 잘 보이는 사진들, 그 바다의 특징이 잘 살아있는 후기들은 다른 사용자들로부터 '추천'을 받아 best 글이 될 확률이 높습니다. <br>
					<바라는 바다>에서는 이러한 best 후기를 작성한 유저에게 소정의 상품을 지급하고 있으니, 함께 깨끗하고 맑은 정보의 바다를 형성해주시면 좋겠습니다. <br> <br>
					
					언제나 여러분이 여러분만의 아름다운 바다를 찾을 수 있길 소망합니다. <br>
					이상, <바라는 바다!> 개발자팀이었습니다. <br> <br>
					
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
   
  <!-- board list area -->
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class="th-num">번호</th>
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-writer">작성자</th>
                    <th scope="col" class="th-date vdate">방문일</th>
                    <th scope="col" class="th-date wdate">작성일</th>
                    <th scope="col" class="th-num recommend">추천수</th>
                    <th scope="col" class="th-num view">조회수</th>
                </tr>
                </thead>
                <tbody>
			      
               	<c:forEach items="${list}" var="list">
	                <tr>
	                  <td>${list.review_num}</td> 
	                  <td class="text_title">
	                  <a href="review_detail?review_num=${list.review_num}">
	                   ${list.review_title} <span class="reply_check">[${list.reply}]</span>
	                  </a>
	                  </td>
	                  <td>${list.name}(${fn:substring(list.id, 0, 4)}****)님</td>
	                  <td>${list.visit_day}</td>
	                  <td>${list.write_day}</td>
	                  <td>${list.recommend}</td>
	                  <td>${list.hits}</td> 
	                </tr>
	            </c:forEach>
	       <tr style="border-left: none;border-right: none;border-bottom: none">
		   <th colspan="7" style="text-align: center;">
		   
		   <c:if test="${paging.startPage!=1 }">
		      <a href="review_all_page?nowPage=${paging.startPage-1 }&cntPerPage=${paging.cntPerPage}">◀</a>
		      
		   </c:if>   
		   
		      <c:forEach begin="${paging.startPage }" end="${paging.endPage}" var="p"> 
		         <c:choose>
		         
		            <c:when test="${p == paging.nowPage }"> 
		            <!-- 현재페이지를 빨강색으로 표시 -->
		               <b><span style="color: red;">${p}</span></b>
		            </c:when>   
		            
		            
		            <c:when test="${p != paging.nowPage }">
		               <a href="review_all_page?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
		            </c:when> 
		              
		         </c:choose>
		      </c:forEach>
		     
		      <c:if test="${paging.endPage != paging.lastPage}">
		      <!-- 끝 페이지가 마지막 페이지가 아니라면 -->
		      <a href="review_all_page?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage }">▶</a>
		   </c:if>
		   
		   </th>
		</tr>
                </tbody>
            </table>
        </div>
    </div>

</section>
</div>          
</body>
</html>