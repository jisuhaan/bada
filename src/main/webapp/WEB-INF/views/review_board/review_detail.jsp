<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/review_detail.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="review-box">
    <h1>${dto.review_title}</h1> 

    <div class="review-info1">
        <p>방문해변 : ${beach}</p> 
    </div>
    <div class="review-info2">
        <p>작성자 : ${dto.name}(${fn:substring(dto.id, 0, 4)}****)님</p>
        <p>작성일 : ${fn:substring(dto.write_day, 0, 16)}</p>
    </div>
    <div class="score">
        <c:forEach begin="1" end="5" var="i">
            <c:choose>
                <c:when test="${i <= dto.review_score}">
                    <span class="star filled">&#9733;</span> <!-- 색칠된 별 -->
                </c:when>
                <c:otherwise>
                    <span class="star">&#9734;</span> <!-- 빈 별 -->
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
    <div class="revisit-check">
        <c:if test="${dto.re_visit == 'Yes'}">
            <div class="revisit-yes">재방문 할래요!</div>
        </c:if>
        <c:if test="${dto.re_visit == 'No'}">
            <div class="revisit-no">다른 해변으로 갈래요!</div>
        </c:if>
    </div>    
	<div class="review-images">
	    <c:forEach items="${gallery}" var="gallery">
	        <img src="${pageContext.request.contextPath}/resources/image_user/${gallery}">
	    </c:forEach>
	</div>
    <div class="review_content">
        <p>${dto.review_contents}</p>
    </div>
    
    <div class="hashtags">
       <c:forEach var="hashtag" items="${fn:split(dto.hashtag, ' ')}">
           <span class="hashtag">${hashtag.trim()}</span>
       </c:forEach>
    </div>
    
    <div class="user_click">
     <div class="all-buttons">
        <button type="button" onclick="#">추천</button>
        <button type="button" onclick="#">신고</button>
        <c:if test="${loginid == dto.id || 'admin' == loginid}">
        <button type="button" onclick="location.href='review_change?review_num=${dto.review_num}'">수정</button>
        <button type="button" onclick="confirmDelete('${dto.review_num}')">삭제</button>
        </c:if>
     </div>
    </div>
</div>

<script type="text/javascript">

function confirmDelete(review_num) {
    if(confirm('정말 삭제하시겠습니까?')) {
        location.href = 'review_delete?review_num=' + review_num;
    }
}

</script>
</body>
</html>