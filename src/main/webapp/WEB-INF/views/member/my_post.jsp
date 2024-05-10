<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/my_post.css" rel="stylesheet" type="text/css">
<title>바라는 바다 :: 나의 게시글</title>

</head>
<body>

<div class="my_post_table">
<div class="content-container">
<div class="table-title" >나의 리뷰 현황</div>
<div class="table-container">
	<table class="my_review" border="1" width="1000px">
                <thead>
                <tr>
                    <th scope="col" class="th-title">리뷰 제목</th>
                    <th scope="col" class="th-date vdate">바다 방문일</th>
                    <th scope="col" class="th-date wdate">리뷰 작성일</th>
                    <th scope="col" class="th-num recommend">추천수</th>
                    <th scope="col" class="th-num view">조회수</th>
                </tr>
                </thead>
                <tbody>

               	<c:forEach items="${list1}" var="list">
	                <tr>
	                  <td class="text_title ellipsis">
	                  <a href="review_detail?review_num=${list.review_num}">
	                   ${list.review_title}
	                  </a>
	                  </td>
	                  <td>${list.visit_day}</td>    
	                  <td>${fn:substring(list.write_day, 0, 16)}</td>
	                  <td>${list.recommend}</td>
	                  <td>${list.hits}</td> 
	                </tr>
	            </c:forEach>
<!-- 페이징 시작 -->	            
	       <tr style="border-left: none;border-right: none; border-bottom: none; background-color: transparent;">
		   <th colspan="5" style="text-align: center;  border: none; background-color: transparent;">
		   
		   <c:if test="${paging.startPage!=1 }">
		      <a href="mypage?nowPage=${paging.startPage-1 }&cntPerPage=${paging.cntPerPage}&nowPage2=${paging_i.nowPage}">◀</a>
		      
		   </c:if>   
		   
		      <c:forEach begin="${paging.startPage }" end="${paging.endPage}" var="p"> 
		         <c:choose>
		         
		            <c:when test="${p == paging.nowPage }"> 
		            <!-- 현재페이지를 빨강색으로 표시 -->
		               <b><span style="color: red;">${p}</span></b>
		            </c:when>   
		            
		            
		            <c:when test="${p != paging.nowPage }">
		               <a href="mypage?nowPage=${p}&cntPerPage=${paging.cntPerPage}&nowPage2=${paging_i.nowPage}">${p}</a>
		            </c:when> 
		              
		         </c:choose>
		      </c:forEach>
		     
		      <c:if test="${paging.endPage != paging.lastPage}">
		      <!-- 끝 페이지가 마지막 페이지가 아니라면 -->
		      <a href="mypage?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage }&nowPage2=${paging_i.nowPage}">▶</a>
		   </c:if>
		   
		   </th>
		</tr>	            
	            
	 <!-- 페이징 끝 -->            
	            
                </tbody>
            </table>
            </div>
            </div>
            
   <div class="content-container">
   <div class="table-title">나의 문의 현황</div>     
   <div class="table-container">      
	<table class="my_inquire" border="1" width="1000px">
                <thead>
                <tr>
                    <th scope="col" >문의글 제목</th>
                    <th scope="col" >문의 카테고리</th>
                    <th scope="col" >문의 날짜</th>
                    <th scope="col" >추천수</th>
                    <th scope="col" >조회수</th>
                </tr>
                </thead>
                <tbody>

               	<c:forEach items="${list2}" var="list">
	                <tr>
	                  <td class="text_title ellipsis">
	                  <a href="to_inquire_detail?inquire_num=${list.inquire_num}">
	                   ${list.title}
	                  </a>
	                  </td>
	                  <td>${list.category}</td>    
	                  <td>${fn:substring(list.i_date, 0, 16)}</td>
	                  <td>${list.rec}</td>
	                  <td>${list.cnt}</td> 
	                </tr>
	            </c:forEach>
	            
<!-- 문의 페이징 시작 -->	            
	       <tr style="border-left: none;border-right: none; border-bottom: none; background-color: transparent;">
		   <th colspan="5" style="text-align: center;  border: none; background-color: transparent;">
		   
		   <c:if test="${paging_i.startPage!=1 }">
		      <a href="mypage?nowPage2=${paging_i.startPage-1 }&cntPerPage2=${paging_i.cntPerPage}&nowPage=${paging.nowPage}">◀</a>
		      
		   </c:if>   
		   
		      <c:forEach begin="${paging_i.startPage }" end="${paging_i.endPage}" var="p"> 
		         <c:choose>
		         
		            <c:when test="${p == paging_i.nowPage }"> 
		            <!-- 현재페이지를 빨강색으로 표시 -->
		               <b><span style="color: red;">${p}</span></b>
		            </c:when>   
		            
		            
		            <c:when test="${p != paging_i.nowPage }">
		               <a href="mypage?nowPage2=${p}&cntPerPage2=${paging_i.cntPerPage}&nowPage=${paging.nowPage}">${p}</a>
		            </c:when> 
		              
		         </c:choose>
		      </c:forEach>
		     
		      <c:if test="${paging_i.endPage != paging_i.lastPage}">
		      <!-- 끝 페이지가 마지막 페이지가 아니라면 -->
		      <a href="mypage?nowPage2=${paging_i.endPage+1}&cntPerPage2=${paging_i.cntPerPage }&nowPage=${paging.nowPage}">▶</a>
		   </c:if>
		   
		   </th>
		</tr>	            
	            
	 <!-- 페이징 끝 -->     	            
	            
                </tbody>
            </table>   
         </div>         
	</div>
</div>

</body>
</html>