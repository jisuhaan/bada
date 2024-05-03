<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>바라는 바다! :: 문의 신고 내역</title>
<link href="${pageContext.request.contextPath}/resources/css/ban_lists.css" rel="stylesheet" type="text/css">
</head>

<body>

<c:choose>
	<c:when test="${loginstate==true && position=='admin'}">	
  	<!-- board list area -->
	<div class="container">
		<div class="ban_table">
		<table class="board-table">
		<thead>
		<tr>
			<th scope="col" class="th-r_title">신고글 제목</th>
			<th scope="col" class="th-r_user">신고자</th>
			<th scope="col" class="th-r_text">신고된 원본글</th>
			<th scope="col" class="th-r_reported">신고된 회원</th>
			<th scope="col" class="th-r_reason">신고 사유</th>
			<th scope="col" class="th-r_date">신고 날짜</th>
		</tr>
		</thead>
		<tbody>	         

	<c:forEach items="${list}" var="l">
		<tr>
		<td>
		<a href="inquire_ban_detail?i_banned_num=${l.i_banned_num}&ban_id=${l.ban_id}">
		${l.title}
		</a>
		</td>
		<td>${l.name}(${l.id})</td>
		<td>
		<a href="to_inquire_detail?inquire_num=${l.ban_inquire_num}">원본글 보기</a>
		</td>
		<td> <a href="member_detail?user_number=${l.ban_user_number}">
		${l.ban_name}(${l.ban_id})</a></td>
		<td>${l.category}</td>
		<td>${fn:substring(l.ban_date, 0, 19)}</td>
		</tr>
	</c:forEach>
	
            
 	<!--  페이징 처리 6단계 -->
	<!-- 페이징처리 -->
	<tr style="border-left: none; border-right: none; border-bottom: none;">
	   <td colspan="10" style="text-align: center;">
	   <c:if test="${paging.startPage!=1 }">
	   	 <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
	      <a href="inquire_ban_listout?nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
	      
	   </c:if>   
	   
	      <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
	         <c:choose>
	            <c:when test="${p == paging.nowPage }">
	            <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
	               <b><span style="color: red;">${p}</span></b>
	            </c:when>   
	            <c:when test="${p != paging.nowPage }">
	            <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
	               <a href="inquire_ban_listout?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
	            </c:when>   
	         </c:choose>
	      </c:forEach>
	     
	      <c:if test="${paging.endPage != paging.lastPage}">
	      <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
	      <a href="inquire_ban_listout?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
	   </c:if>
	   
	   </td>
	</tr>
	<!-- 페이징처리 -->
	<!-- 페이징 처리 6단계 끝 -->
    </tbody>
	</table>
	</div>
</div>

</c:when>

<c:otherwise>

	<script>
		window.onload = function() {
		    alert("관리자 외 접근할 수 없는 페이지 입니다.");
		    window.location.href = "${pageContext.request.contextPath}/main";
		};
    </script>
    
</c:otherwise>
</c:choose>
	
</body>
</html>