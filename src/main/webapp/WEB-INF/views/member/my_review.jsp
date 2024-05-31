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
</head>
<body>

<section class="notice">
  <div class="page-title">
        <div class="container">
            <h3>나의 리뷰</h3>
        </div>
    </div>

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
	                  <td>${fn:substring(list.write_day, 0, 10)}</td>
	                  <td>${list.recommend}</td>
	                  <td>${list.hits}</td> 
	                </tr>
	            </c:forEach>
	       <tr style="border-left: none;border-right: none;border-bottom: none">
		   <th colspan="7" style="text-align: center;">
		   
		   <c:if test="${paging.startPage!=1 }">
		      <a href="my_review?nowPage=${paging.startPage-1 }&cntPerPage=${paging.cntPerPage}">◀</a>
		      
		   </c:if>   
		   
		      <c:forEach begin="${paging.startPage }" end="${paging.endPage}" var="p"> 
		         <c:choose>
		         
		            <c:when test="${p == paging.nowPage }"> 
		            <!-- 현재페이지를 빨강색으로 표시 -->
		               <b><span style="color: red;">${p}</span></b>
		            </c:when>   
		            
		            
		            <c:when test="${p != paging.nowPage }">
		               <a href="my_review?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
		            </c:when> 
		              
		         </c:choose>
		      </c:forEach>
		     
		      <c:if test="${paging.endPage != paging.lastPage}">
		      <!-- 끝 페이지가 마지막 페이지가 아니라면 -->
		      <a href="my_review?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage }">▶</a>
		   </c:if>
		   
		   </th>
		</tr>
                </tbody>
            </table>
        </div>
    </div>

</section>
	           
</body>
</html>