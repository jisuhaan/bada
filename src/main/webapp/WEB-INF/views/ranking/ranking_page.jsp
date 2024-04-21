<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>연말 결산 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .ranking-list {
            margin-top: 20px;
        }

        .ranking-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }

        .ranking-item:last-child {
            border-bottom: none;
        }

        .ranking-item h3 {
            margin-top: 5px;
            margin-bottom: 10px;
            color: #555;
        }

        .ranking-item p {
            margin: 5px 0;
            color: #777;
        }

        .ranking-item .rank {
            font-size: 24px;
            font-weight: bold;
            color: #ff5733;
        }
        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            padding: 20px;
        }

        .card-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .card-content {
            color: #777;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>바라는 바다 속 Top3</h1>
        <div class="ranking-list">
            <div class="ranking-item">
                <div class="rank">1</div>
                <h3>바라는바다 유저들이 많이 찾은 바다</h3>
                <c:forEach var="vcl" items="${viewCountlist}" varStatus="vclloop">
				    <a href="sea_result?beach_code=${vcl.beach_code}" class="card-link">
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
				    <a href="sea_result?beach_code=${rcl.beach_code}" class="card-link">
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
				    <a href="sea_result?beach_code=${rsl.beach_code}" class="card-link">
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
				    <a href="sea_result?beach_code=${rvl.beach_code}" class="card-link">
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
	                	<span>${ht.most_used_beach}</span>
	                	<c:if test="${not empty ht.second_used_beach}">
	                	<span>, ${ht.second_used_beach}</span>
	                	</c:if>
	                	<c:if test="${not empty ht.third_used_beach}">
	                	<span>, ${ht.third_used_beach}</span>
	                	</c:if>
	                	</p>
                  </div>
                </div>
            </c:forEach>
            </div>
        </div>
    </div>
</body>
</html>