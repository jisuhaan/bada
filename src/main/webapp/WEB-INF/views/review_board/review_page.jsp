<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>바다리뷰 :: 전체보기</title>

<style type="text/css">

    table {
        table-layout: auto; /* 셀 내용에 기반한 너비 조정 활성화 */
        margin: auto; /* 테이블을 페이지 중앙에 배치 */
    }
    
    th, td {
        text-align: center; /* 셀 내용을 가운데 정렬 */
    }
    td.title {
        text-align: left; /* 제목 셀 내용을 왼쪽 정렬 */
    }
</style>
</head>
<body>
<h2>바다리뷰 게시판</h2> <br><br>
	<table border="1" align="center" width="1200px">
	            <tr>
	                <th>글번호</th>
	                <th style="width:400px;">제목</th>
	                <th>방문일</th>
	                <th>작성자</th>
	                <th>작성일</th>
	                <th>조회수</th>
	                <th>추천수</th>
	            </tr>
	        
	            <c:forEach items="${list}" var="list">
	                <tr>
	                  <td>${list.review_num}</td> 
	                  <td class="title">
	                  <a href="review_detail?review_num=${list.review_num}">
	                   ${list.review_title}
	                  </a>
	                  </td>
	                  <td>${list.visit_day}</td>
	                  <td>${list.name}(${fn:substring(list.id, 0, 4)}****)님</td>
	                  <td>${list.write_day}</td>
	                  <td>${list.hits}</td>
	                  <td>${list.recommend}</td> 
	                </tr>
	            </c:forEach>
	            
	           <!-- 페이징 처리 6단계 -->
		   <!-- 페이징처리 -->
		<tr style="border-left: none;border-right: none;border-bottom: none">
		   <td colspan="7" style="text-align: center;">
		   
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
		   
		   </td>
		</tr>
		<!-- 페이징처리 --> 
	           
	    </table>
</body>
</html>