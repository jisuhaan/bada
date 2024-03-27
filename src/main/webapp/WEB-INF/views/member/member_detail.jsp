<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:choose>
	<c:when test="${loginstate==true && position=='admin'}">

	<div style="text-align: center;">
		<c:forEach items="${list}" var="li">
	    <table border="1" width="600" align="center">
	        <tr>
	        	<th>일련번호</th>
	        	<td>${li.user_number}</td> 
	        </tr>
	        <tr>
	        	<th>아이디</th>
	        	<td>${li.id}</td> 
	        </tr>
	        <tr>
	        	<th>패스워드</th>
	        	<td>${li.pw}</td> 
	        </tr>
   	        <tr>
	        	<th>권한</th>
	        	<td>${li.role}</td> 
	        </tr>
	       	<tr>
	        	<th>이름</th>
	        	<td>${li.name}</td> 
	        </tr>
	       	<tr>
	        	<th>이메일</th>
	        	<td>${li.email}</td> 
	        </tr>
	       	<tr>
	        	<th>성별</th>
	        	<td>${li.gender}</td> 
	        </tr>	   
	       	<tr>
	        	<th>연령대</th>
	        	<td>${li.age}</td> 
	        </tr>		
	       	<tr>
	        	<th>bbti</th>
	        	<td>나중에 bbti 결과 띄우기!</td> <!-- 아직 구현 안 함 -->
	        </tr>	
	       	<tr>
	        	<td colspan="2" align="center">
	        		<button type="button" onclick="location.href='member_delete?user_number=${li.user_number}'">삭제</button>&nbsp;/
      	 			<button type="button" onclick="location.href='member_modify_view?user_number=${li.user_number}'">수정</button>
      			</td>
	        </tr>	        	                     	        
	    </table>
	    </c:forEach>
	</div>

    <div style="text-align: center;"><a href="member_out">목록으로</a></div>
    
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