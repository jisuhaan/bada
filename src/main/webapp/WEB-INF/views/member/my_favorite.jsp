<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>

<script>

function gogo(url) {
 window.location.href = url;
}

</script>
<link href="${pageContext.request.contextPath}/resources/css/my_favorite.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="grid-container">
        <c:forEach var="list" items="${list}">
            <div class="grid-item" onclick="gogo('review_detail?review_num=${list.review_num}')">
                <img src="./resources/image_user/${list.thumbnail}">
                <div class="info-container">
                
                <div class="score">
				        <c:forEach begin="1" end="5" var="i">
				            <c:choose>
				                <c:when test="${i <= list.review_score}">
				                    <span class="star filled">&#9733;</span> <!-- 색칠된 별 -->
				                </c:when>
				                <c:otherwise>
				                    <span class="star">&#9734;</span> <!-- 빈 별 -->
				                </c:otherwise>
				            </c:choose>
				        </c:forEach>
				</div>
				
			    <div class="revisit-check">
			        <c:if test="${list.re_visit == 'Yes'}">
			            <div class="revisit-yes">재방문 할래요!</div>
			        </c:if>
			        <c:if test="${list.re_visit == 'No'}">
			            <div class="revisit-no">다신 안 갈래요!</div>
			        </c:if>
			    </div>				
				
		        <div class="hashtag_box">
					    <div class="hashtags">
					       <c:forEach var="hashtag" items="${fn:split(list.hashtag, ' ')}">
					           <span class="hashtag">${hashtag.trim()}</span>
					       </c:forEach>
					    </div>
				</div>   
                </div>
	                <p>${list.beach}</p>
	                <h3>${list.review_title}</h3>
	                <div class="small-text-container">
	                <p class="small-text">작성일 | ${fn:substring(list.write_day, 0, 10)}</p>
	                <p class="small-text">방문일 | ${list.visit_day}</p>
                	</div>
            </div>  
        </c:forEach>
    </div>
</body>
</html>