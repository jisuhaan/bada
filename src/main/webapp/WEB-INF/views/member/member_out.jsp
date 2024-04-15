<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/resources/css/member_out.css" rel="stylesheet" type="text/css">
<title>바라는 바다! :: 회원 기본정보 확인</title>
</head>

<body>

<div class="container">

<c:choose>
	<c:when test="${loginstate==true && position=='admin'}">	
	<section>
  	<!-- board list area -->
    <div id="board-list">
        <div class="container">
        	<div class="search">
        	<jsp:include page="member_search.jsp"/>
        	</div>
        	<div class="member_table">
            <table class="board-table">
                <thead>
                <tr>
                    <th scope="col" class="th-num">회원번호</th>
                    <th scope="col" class="th-id">아이디</th>
                    <th scope="col" class="th-name">닉네임</th>
                    <th scope="col" class="th-gender">성별</th>
                    <th scope="col" class="th-age">연령대</th>
                    <th scope="col" class="th-ect">비고</th>
                </tr>
                </thead>
                <tbody>
		      <c:forEach items="${list}" var="m">
		      <tr>
		      	<td>${m.user_number}</td>
				<td>${m.id}</td>
		        <td>${m.name}</td>
		        <td>
		        	<c:choose>
						    <c:when test="${m.gender == 'male'}">남성</c:when>
						    <c:when test="${m.gender == 'female'}">여성</c:when>
						    <c:when test="${m.gender == 'other'}">기타</c:when>
					</c:choose>
		        </td>
		        <td>
		        	<c:choose>
						    <c:when test="${m.age == 10}">10대↓</c:when>
						    <c:when test="${m.age == 20}">20대</c:when>
						    <c:when test="${m.age == 30}">30대</c:when>
						    <c:when test="${m.age == 40}">40대</c:when>
						    <c:when test="${m.age == 50}">50대</c:when>
						    <c:when test="${m.age == 60}">60대↑</c:when>
					</c:choose>
		        </td>
		        <td colspan="2" align="center">
		        	<a href="member_detail?user_number=${m.user_number}"><input type="button" value="상세 정보 확인"></a>
		        </td>
		      </tr>
		      </c:forEach>
	       <tr style="border-left: none;border-right: none;border-bottom: none">
		   <th colspan="7" style="text-align: center;">
		   
		   <c:if test="${paging.startPage!=1 }">
		      <a href="member_out?nowPage=${paging.startPage-1 }&cntPerPage=${paging.cntPerPage}">◀</a>
		      
		   </c:if>   
		   
		      <c:forEach begin="${paging.startPage }" end="${paging.endPage}" var="p"> 
		         <c:choose>
		         
		            <c:when test="${p == paging.nowPage }"> 
		            <!-- 현재페이지를 빨강색으로 표시 -->
		               <b><span style="color: red;">${p}</span></b>
		            </c:when>   
		            
		            
		            <c:when test="${p != paging.nowPage }">
		               <a href="member_out?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
		            </c:when> 
		              
		         </c:choose>
		      </c:forEach>
		     
		      <c:if test="${paging.endPage != paging.lastPage}">
		      <!-- 끝 페이지가 마지막 페이지가 아니라면 -->
		      <a href="member_out?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage }">▶</a>
		   </c:if>
		   
		   </th>
		</tr>
                </tbody>
            </table>
        </div>
    </div>
	</div>
	</section>	
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
	</div>
</body>



</html>