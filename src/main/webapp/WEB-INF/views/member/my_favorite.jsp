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

function unrecommend(reviewNum,loginid) {
    if (confirm('정말 추천을 취소하시겠습니까?')) {
        window.location.href = 'review_unrecommend?review_num='+reviewNum+'&user_id='+loginid;
    }else{
    	event.preventDefault();
    }
}

function goToReviewPage() {
    window.location.href = 'review_all_page';
}

</script>
<link href="${pageContext.request.contextPath}/resources/css/my_favorite.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="grid-container">
    	<c:choose>
        <c:when test="${not empty list}">
        <c:forEach var="list" items="${list}">
            <div class="grid-item" onclick="gogo('review_detail?review_num=${list.review_num}')">
				<c:choose>
					<c:when test="${list.thumbnail eq 'no'}">
						<img src="./resources/image/로고 9-2.png" class="logo-thumbnail">
					</c:when>
					<c:otherwise>
						<img src="./resources/image_user/${list.thumbnail}"
							id="f_thumbnail" class="user-thumbnail">
					</c:otherwise>
				</c:choose>
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
                	<!-- 추천 취소 버튼 -->
                <div class="close-button" onclick="unrecommend('${list.review_num}','${loginid}'); event.stopPropagation();">
                    X
                </div>
            </div>  
        </c:forEach>
        </c:when>
            <c:otherwise>
            <div class="empty-message-wrapper">
                <div class="empty-message">
                    <img src="./resources/image/empty_bookmark.png" class="empty-image">
                    <p class="empty-text">북마크 목록이 비어 있습니다!</p>
                    <button class="review-button" onclick="goToReviewPage()">북마크에 리뷰 담으러 가기 😀</button>
                </div>
            </div> 
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>