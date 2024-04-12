<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>바라는 바다! :: 신고 내역</title>
</head>
<body>

	<br> <br> <br>
	
	<div style="margin-bottom: 20px;">
    <select id="report_type">
        <option value="post_report">게시글 신고</option>
        <option value="reply_report">댓글 신고</option>
    </select>
	</div>
	
	<br>
		<table border="1">
	
			      <tr>
			      	 <th>신고글 제목</th>
			         <th>신고자</th>
			         <th>신고된 원본글</th>
			         <th>신고된 회원</th>
			         <th>신고 사유</th>
			         <th>신고 날짜</th>
			      </tr>
		         
<c:choose>

<c:when test="${loginstate==true && position=='admin'}">

<c:forEach items="${list}" var="l">
			      <tr>
			      	<td>
			      	<a href="inquire_ban_detail?i_banned_num=${l.i_banned_num}">
			      	${l.title}
			      	</a>
			      	</td>
			      	<td>${l.name}(${fn:substring(l.id, 0, 4)}****) 님</td>
			      	<td>
			      	<a href="to_inquire_detail?inquire_num=${l.ban_inquire_num}">신고된 원본글로 이동</a>
			      	</td>
			      	<td> <a href="member_detail?user_number=${l.ban_user_number}">
			      	${l.ban_name}(${fn:substring(l.ban_id, 0, 4)}****) 님 </a> </td>
			      	<td>${l.category}</td>
			      	<td>${fn:substring(l.ban_date, 0, 19)}</td>
			      </tr>
			      </c:forEach>
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
	        
	    </table>
	    
	<br> <br> <br> <br> <br>

</body>
</html>