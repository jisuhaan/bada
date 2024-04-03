<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
	    <h1>바다리뷰 게시판</h1>
	    <table border="1" class="table table-striped" align="center" width="1000px">
	        
	            <tr>
	                <th>No.</th>
	                <th>제목</th>
	                <th>작성자</th>
	                <th>작성일</th>
	                <th>조회수</th>
	                <th>추천수</th>
	            </tr>
	        
	            <c:forEach items="${list}" var="li">
	                <tr>
	                    <td>${li.review_num}</td> 
	                    <td>${li.review_title}</td>
	                    <td >
	                      <a href="review_detail?review_num=${li.review_num}">
	                    	${li.title}
	                      </a>
	                    </td>
	                    <td>${li.write_day}</td>
	                    <td>${li.hits}</td>
	                    <td>${li.recommend}</td> 
	         
	                </tr>
	            </c:forEach>
	
	    </table>
	</div>
</body>
</html>