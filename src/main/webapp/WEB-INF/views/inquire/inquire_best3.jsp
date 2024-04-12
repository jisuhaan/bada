<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html>

<head>

	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>바라는 바다! :: 문의 목록 베스트3</title>

	<style>
        table {
            margin: 0 auto;
            width: 95%;
            border-collapse: collapse;
        }
        th, td {
            text-align: center;
            font-size: 13px; /* 텍스트 크기를 작게 설정 */
            padding: 4px; /* 셀 안의 여백 설정 */
        }
        th:nth-child(1) {
            width: 45%; /* 첫 번째 열의 너비를 70%로 설정 */
        }
        th:nth-child(2){
        width: 12%;
        }
        th:nth-child(3){
        width: 10%;
        }
        .lock-icon {
            display: inline-block; /* 이미지를 인라인 블록 요소로 설정하여 텍스트와 같이 정렬 */
            vertical-align: middle; /* 아이콘을 수직 가운데 정렬 */
        }
    </style>
</head>

<body>

	<table border="1">
		<tr>
         <th colspan="2" class="just_th">추천순 인기글 best3</th>
      </tr>

	      <tr>
	      	 <th colspan="2">문의글 제목</th>
	         <th>문의 카테고리</th>
	         <th>문의 작성자</th>
	         <th>문의 날짜</th>
	         <th>답변</th>
	         <th>추천수</th>
	         <th>조회수</th>
	      </tr>
	         
	      
<c:forEach items="${list2}" var="l2">
	      <tr>
	      	<td colspan="2">
	      	<a href="to_inquire_detail?inquire_num=${l2.inquire_num}">
                   <c:choose>
                       <c:when test="${l2.secret == 'y'}">
                           <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                           ${l2.title}
                       </c:when>
                       <c:otherwise>
                           ${l2.title}
                       </c:otherwise>
                   </c:choose>
               </a>
               </td>
	      	<td>${l2.category}</td>
	      	<td>
	      	${l2.name}(${fn:substring(l2.id, 0, 4)}****) 님
	      	</td>
	      	<td>
		      	${fn:substring(l2.i_date, 0, 19)}
	      	</td>
	      	<td>
	      		<c:choose>
				    <c:when test="${l2.reply == 0}">미응답</c:when>
				    <c:otherwise>완료</c:otherwise>
				</c:choose>
	      	</td>
	      	<td>${l2.rec}</td>
	      	<td>${l2.cnt}</td>
	      </tr>
	      </c:forEach>
        
    </table>
	
	
</body>
</html>