<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="inquire_search.jsp" %>
<%@ include file="inquire_notice_list.jsp" %>

<!DOCTYPE html>

<html>

<head>

	<meta charset="UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="${pageContext.request.contextPath}/resources/css/review_page.css" rel="stylesheet" type="text/css">
	<title>바라는 바다! :: 검색결과</title>

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

	<div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
			      <tr>
			      	 <th colspan="2">문의글 제목</th>
			         <th>문의 카테고리</th>
			         <th>문의 작성자</th>
			         <th>문의 날짜</th>
			         <th>답변</th>
			         <th>추천수</th>
			         <th>조회수</th>
			      </tr>
			         
			         </thead>
			         
<tbody>
			         <c:choose>

<c:when test="${loginstate==true && position=='admin'}">
<c:forEach items="${list}" var="l">
			      <tr>
			      	<td colspan="2">
			      	<a href="to_inquire_detail?inquire_num=${l.inquire_num}">
	                    <c:choose>
	                        <c:when test="${l.secret == 'y'}">
	                            <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
	                            ${l.title}
	                        </c:when>
	                        <c:otherwise>
	                            ${l.title}
	                        </c:otherwise>
	                    </c:choose>
	                </a>
	                </td>
			      	<td>${l.category}</td>
			      	<td>
			      	${l.name}(${fn:substring(l.id, 0, 4)}****) 님
			      	</td>
			      	<td>
				      	${fn:substring(l.i_date, 0, 19)}
			      	</td>
			      	<td>
			      		<c:choose>
						    <c:when test="${l.reply == 0}">미응답</c:when>
						    <c:otherwise>완료</c:otherwise>
						</c:choose>
			      	</td>
			      	<td>${l.rec}</td>
			      	<td>${l.cnt}</td>
			      </tr>
			      </c:forEach> 
</c:when>

<c:otherwise>
			      <c:forEach items="${list}" var="l">
			      <tr>
			      	<td colspan="2">
			      	<a href="inquire_secret_yn?inquire_num=${l.inquire_num}&secret=${l.secret}">
	                    <c:choose>
	                        <c:when test="${l.secret == 'y'}">
	                            <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
	                            비밀글입니다.
	                        </c:when>
	                        <c:otherwise>
	                            ${l.title}
	                        </c:otherwise>
	                    </c:choose>
	                </a>
	                </td>
			      	<td>${l.category}</td>
			      	<td>
			      	${l.name}(${fn:substring(l.id, 0, 4)}****) 님
			      	</td>
			      	<td>
				      	${fn:substring(l.i_date, 0, 19)}
			      	</td>
			      	<td>
			      		<c:choose>
						    <c:when test="${l.reply == 0}">미응답</c:when>
						    <c:otherwise>완료</c:otherwise>
						</c:choose>
			      	</td>
			      	<td>${l.rec}</td>
			      	<td>${l.cnt}</td>
			      </tr>
			      </c:forEach> 
	    
	        </c:otherwise>
	        </c:choose>
	        
	    </tbody>
            </table>
        </div>
    </div>
	    
	<br> <br> <br> <br> <br>
	
	
</body>
</html>