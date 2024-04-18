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
	        var selecte_area = $(this).val(); // 선택된 지역값
	        $.ajax({
	            type: "POST",
	            url: "review_area_search",
	            data: {'area' : selecte_area}, 
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
            success: function(data) {
                $('#board-list').html(data);
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
            <h3>리뷰게시판</h3>
        </div>
    </div>

    <!-- board seach area -->
    <div id="board-search">
        <div class="container">
            <div class="search-window">
            <div class="area_select">
            지역선택 : 
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
                <form id="search-form">
                    <div class="search-wrap">
                    	<select name="search_category">
                    		<option value="title">제목</option>
                    		<option value="intext">내용</option>
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
                <tr class="notice_line">
                    <td>3</td>
                    <td class="text_title"><a href="#">[공지사항] 3번 </a></td>
                    <td>관리자</td>
                    <td></td>
                    <td>2024-04-08</td>
                    <td></td>
                    <td></td>
                </tr>

                <tr class="notice_line">
                    <td>2</td>
                    <td class="text_title"><a href="#">[공지사항] 2번 </a></td>
                    <td>관리자</td>
                    <td></td>
                    <td>2024-04-08</td>
                    <td></td>
                    <td></td>
                </tr>

                <tr class="notice_line">
                    <td>1</td>
                    <td class="text_title"><a href="#">[공지사항] 1번 </a></td>
                    <td>관리자</td>
                    <td></td>
                    <td>2024-04-08</td>
                    <td></td>
                    <td></td>
                </tr>
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