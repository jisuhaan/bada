<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/resources/css/ranking_page.css" rel="stylesheet" type="text/css">
    <title>연말 결산 페이지</title>
    <script src="./resources/js/loading.js"></script>
</head>
<body>
    <div class="container">
        <h1>바라는 바다 속 Top3</h1>
        <div class="ranking-list">
            <div class="ranking-item">
                <div class="rank">1</div>
                <h3>바라는바다 유저들이 많이 찾은 바다</h3>
                <c:forEach var="vcl" items="${viewCountlist}" varStatus="vclloop">
				    <a href="#" onclick="moveToSeaResultPage(${vcl.beach_code})" class="card-link">
				        <div class="card">
				            <div class="card-content">
				                <p>${vclloop.index + 1}. ${vcl.beach}</p>
				            </div>
				        </div>
				    </a>
				</c:forEach>
            </div>
            <div class="ranking-item">
                <div class="rank">2</div>
                <h3>후기 맛집 바다</h3>
                <c:forEach var="rcl" items="${reviewCountlist}" varStatus="rclloop">
				    <a href="#" onclick="moveToSeaResultPage(${rcl.beach_code})" class="card-link">
				        <div class="card">
				            <div class="card-content">
				                <p>${rclloop.index + 1}. ${rcl.beach}</p>
				            </div>
				        </div>
				    </a>
				</c:forEach>
            </div>
            <div class="ranking-item">
                <div class="rank">3</div>
                <h3>리뷰 별점 높은 바다</h3>
                <c:forEach var="rsl" items="${reviewScorelist}" varStatus="rslloop">
				    <a href="#" onclick="moveToSeaResultPage(${rsl.beach_code})" class="card-link">
				        <div class="card">
				            <div class="card-content">
				                <p>${rslloop.index + 1}. ${rsl.beach}</p>
				            </div>
				        </div>
				    </a>
				</c:forEach>
            </div>
            <div class="ranking-item">
                <div class="rank">4</div>
                <h3>재방문 의사가 높은 바다</h3>
                <c:forEach var="rvl" items="${re_visitlist}" varStatus="rvlloop">
				    <a href="#" onclick="moveToSeaResultPage(${rvl.beach_code})" class="card-link">
				        <div class="card">
				            <div class="card-content">
				                <p>${rvlloop.index + 1}. ${rvl.beach}</p>
				            </div>
				        </div>
				    </a>
				</c:forEach>
            </div>
            <div class="ranking-item">
                <div class="rank">5</div>
                <h3>바라는바다 유저들의 BBTI Top3</h3>
                <c:forEach var="bb" items="${topBBTIlist}" varStatus="bbloop">
                <div class="card">
                    <div class="card-content">
                        <p>${bbloop.index + 1}. ${bb.bbti}</p>
                        <img id="bbti-popup-image" src="${pageContext.request.contextPath}/resources/image_bbti/bbti_result_${bb.bbti_code}.png" alt="BBTI 결과 이미지" style="width:500px">
                    </div>
                </div>
            </c:forEach>
            </div>
            <div class="ranking-item">
                <div class="rank">6</div>
                <h3>해시태그 별 추천 바다 Top3</h3>
                <c:forEach var="ht" items="${tophashtaglist}" varStatus="htloop">
                <div class="card">
                    <div class="card-content">
	                	<p class="card-title">${ht.hashtag}</p>
	                	<p>
	                	<span><a href="#" onclick="moveToSeaResultPage(${ht.most_used_beach_code})">${ht.most_used_beach}</a></span>
	                	<c:if test="${not empty ht.second_used_beach}">
	                	<span>, <a href="#" onclick="moveToSeaResultPage(${ht.second_used_beach_code})">${ht.second_used_beach}</a></span>
	                	</c:if>
	                	<c:if test="${not empty ht.third_used_beach}">
	                	<span>, <a href="#" onclick="moveToSeaResultPage(${ht.third_used_beach_code})">${ht.third_used_beach}</a></span>
	                	</c:if>
	                	</p>
                  </div>
                </div>
            </c:forEach>
            </div>
        </div>
    </div>
<!-- 로딩 페이지 -->
<div id="loading" style="display: none;">
    <jsp:include page="../loading.jsp"/>
</div>    
</body>
</html>