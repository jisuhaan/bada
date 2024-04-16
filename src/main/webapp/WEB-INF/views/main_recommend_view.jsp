<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/main_recommend_view.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>				
<title>Insert title here</title>
<script>
$(document).ready(function(){
    // 페이지 로드될 때 실행될 코드
    loadSlides();
});

// 슬라이드 생성 함수
function loadSlides() {
    $.ajax({
        url: "recommend_view", 
        type: "GET",
        dataType: "json",
        success: function(response) {
            console.log("추천페이지 결과 가져오기 성공"); 
            console.log(response);
            
            if(response != null && response.length > 0){
                var slideTrack = $('.slide-track'); // 슬라이드 트랙 선택
                
                // 각 항목에 대한 정보를 받아옴
                response.forEach(function(item) {
                	
                	var review_num = item.review_num
                    
                    var slide = $('<div class="slide"></div>');
                    var trainCard = $('<div class="train-card" onclick="goReview('+review_num+')"></div>');
                    var cardBody = $('<div class="card-body"></div>');
                    var bodyContents = $('<div class="body-contents"></div>');
                    var contentsTitle = $('<div class="contents_title"></div>');
                    var contentsUser = $('<div class="contents_user"></div>');
                    var contentsNumber = $('<div class="contents_number"></div>');
                    
                    // 각 항목에서 필요한 속성들을 가져옴
                    var thumbnail = item.thumbnail;
                   	var id = item.id.substring(0, 3) + "***";
                    var name = item.name;
                    var review_title = item.review_title.substring(0,10) + "...";
                    var hits = item.hits;
                    var recommend = item.recommend;
                   
                    // 각 항목에 대한 정보를 가지고 새로운 슬라이드를 생성하고 정보를 채움
                    var thumbnailImg = $('<img id="slide_thumbnail">').attr('src', './resources/image_user/' + thumbnail);
                    var titleElement = $('<span id="slide_title"></span>').text("["+review_title+"]");
                    var nameElement = $('<span id="slide_name"></span>').text("작성자 : "+name+"("+id+")");
                    var hitsElement = $('<span id="slide_hits"></span>').text("🧐"+hits);
                    var recElement = $('<span id="slide_rec"></span>').text("💙"+recommend);
                    
                    // 각 요소들을 조립
                    contentsTitle.append(titleElement);
                    contentsUser.append(nameElement);
                    contentsNumber.append(hitsElement);
                    contentsNumber.append(recElement);
                    
                    bodyContents.append(contentsTitle);
                    bodyContents.append(contentsUser);
                    bodyContents.append(contentsNumber);
                    
                    cardBody.append(thumbnailImg);
                    cardBody.append(bodyContents);
                    trainCard.append(cardBody);
                    slide.append(trainCard);
                    
                    // 슬라이드 트랙에 슬라이드 추가
                    slideTrack.append(slide);
                });
                
            }
            
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText); 
        }
    });
}

function goReview(review_num){
	window.location.href='review_detail?review_num='+review_num;
}
</script>
</head>
<body>

<div class="view_container">
    <div class="review_box">
        <div class="review_title"><h3>추천리뷰</h3></div>
        <div class="card-slide">
            <div class='slide-track'> 
        	</div>
        </div>
    </div>
</div>

</body>
</html>