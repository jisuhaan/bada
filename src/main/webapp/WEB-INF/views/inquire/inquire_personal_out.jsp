<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>바라는 바다! :: 1:1 문의 내역</title>
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
			<th>문의 카테고리</th>
			<th>문의 제목</th>
			<th>문의자</th>
			<th>문의자 이메일</th>
			<th>답변 여부</th>
			<th>문의 날짜</th>
		</tr>
		</thead>	         
		<tbody>

		<c:forEach items="${list}" var="l">
			<tr>
			<td>${l.category}</td>
			<td>
			<a href="inquire_personal_detail?ip_num=${l.ip_num}">
			${l.title}
			</a>
			</td>
			<td>
			<c:choose>
			<c:when test="${l.id == 'nope'}">${l.name}(비회원) 님</c:when>
			<c:otherwise>${l.name}(${l.id}) 님</c:otherwise>
			</c:choose>
			</td>
			<td>${l.email}</td>
			<td>${l.tf}</td>
			<td>${fn:substring(l.ip_date, 0, 19)}</td>
			</tr>
		</c:forEach>
            
 	<!--  페이징 처리 6단계 -->
		<!-- 페이징처리 -->
		<tr style="border-left: none; border-right: none; border-bottom: none;">
		   <td colspan="10" style="text-align: center;">
		   <c:if test="${paging.startPage!=1 }">
		   	 <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
		      <a href="inquire_personal_out?nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
		      
		   </c:if>   
		   
		      <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
		         <c:choose>
		            <c:when test="${p == paging.nowPage }">
		            <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
		               <b><span style="color: red;">${p}</span></b>
		            </c:when>   
		            <c:when test="${p != paging.nowPage }">
		            <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
		               <a href="inquire_personal_out?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
		            </c:when>   
		         </c:choose>
		      </c:forEach>
		     
		      <c:if test="${paging.endPage != paging.lastPage}">
		      <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
		      <a href="inquire_personal_out?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
		   </c:if>
		   
		   </td>
		</tr>
		<!-- 페이징처리 -->
	<!-- 페이징 처리 6단계 끝 -->
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