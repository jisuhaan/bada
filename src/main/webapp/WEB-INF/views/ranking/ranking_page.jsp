<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/resources/css/ranking_page.css" rel="stylesheet" type="text/css">
    <title>바라는 바다 :: 베스트 어워드</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="./resources/js/loading.js"></script>
    <script type="text/javascript">
    
    var choice_tags = [];
    
    $(document).ready(function() {
 	   $('.category').click(function() {
 	       var category = $(this).data('category');
 	       show_hashtags(category);
 	   });

 	   $(document).on('click', '.hashtag', function() {
 	       var hashtag = $(this).text();
 	       if ($(this).hasClass('selected')) {
 	           // 해시태그를 선택 해제
 	           $(this).removeClass('selected');
 	           choice_tags = choice_tags.filter(function(value) {
 	               return value !== hashtag;
 	           });
 	       } else {
	               $(this).addClass('selected');
 	               choice_tags.push(hashtag);
 	       }
 	       update_Hashtag();
 	   });
    });
    
 	   function show_hashtags(category) {
 	       var hashtags = get_tag(category);
 	       var dropdown = $('.hashtag-dropdown').empty().show();
 	       $.each(hashtags, function(index, hashtag) {
 	           var div = $('<div/>', { 
 	               text: hashtag,
 	               class: 'hashtag'
 	           }).appendTo(dropdown);
 	           
 	           if (choice_tags.indexOf(hashtag) !== -1) {
 	               div.addClass('selected');
 	           }
 	       });
 	   }

 	   function get_tag(category) {
 	       
 	       var hashtags = {
 	           "누구와": ["#가족", "#연인", "#혼자", "#친구", "#반려동물"],
 	           "편의시설": ["#대중교통", "#자차필요", "#번화가"],
 	           "바다": ["#에메랄드바다", "#백사장", "#고운모래", "#갯벌"],
 	           "액티비티": ["#스쿠버다이빙", "#서핑", "#물놀이", "#바다낚시", "#캠핑"],
 	           "풍경": ["#핫플", "#감성", "#사람이적어요", "#이국적", "#인생샷", "#일출맛집", "#전망대", "#항구"]
 	       };
 	       return hashtags[category];
 	   }

 	   function update_Hashtag() {
 	       
 	       $('#hashtags').val(choice_tags.join(' '));
 	       display_tags();
 	   }
 	   
 	   function display_tags() {
 	       var tags_Area = $('#selected-tags');
 	       tags_Area.empty(); // 이전 표시 내용 초기화
 	       choice_tags.forEach(function(tag) {
 	           $('<span/>', {
 	               text: tag,
 	               class: 'selected-tag'
 	           }).appendTo(tags_Area);
 	       });
	   }

    
	    function changeColor(selectedDiv) {
	        // 모든 category div 요소를 선택합니다.
	        const categories = document.querySelectorAll('.category');
	
	        // 선택한 category div의 배경색을 변경합니다.
	        categories.forEach(category => {
	            if (category === selectedDiv) {
	                category.style.backgroundColor = 'lightblue'; // 선택한 div의 배경색을 변경합니다.
	            } else {
	                category.style.backgroundColor = ''; // 선택하지 않은 div의 배경색을 초기화합니다.
	            }
	        });
	    }
    
    </script>
</head>
<body>
<div class="container">

    <div class="container_title">
    	<div id="title_logo"><img alt="" src="./resources/image/bestaward_logo.png" width="900px"></div>
    	<div id="title_info">바라는 바다 속 다양한 순위를 살펴보세요!</div>
    </div>
    
    <div class="ranking-list best3">
    	
    	<div id="rank_title">가장 궁금한 바다는</div>
    	<div id="rank_subtitle">* 유저들이 검색 및 날씨 보기를 많이 한 바다예요 *</div>
    	<div class="rankbox_container">
	   		<div class="awards">
	    		<img alt="" src="./resources/image/award.png">
	   		</div>
	    	<div class="rankbox bestview">
	    		<div class="bestviewed no2" onclick="moveToSeaResultPage(${viewCountlist[1].beach_code})">
	    			<div class="awardtitle best2title">${viewCountlist[1].beach}</div>
	    			<div class="thumbnail best2img"><img src="./resources/image/${viewCountlist[1].picture}"></div>
	    		</div>
	    		<div class="bestviewed no1" onclick="moveToSeaResultPage(${viewCountlist[0].beach_code})">
	    			<div class="awardtitle best1title">${viewCountlist[0].beach}</div>
	    			<div class="thumbnail best1img"><img src="./resources/image/${viewCountlist[0].picture}"></div>
	    		</div>
	    		<div class="bestviewed no3" onclick="moveToSeaResultPage(${viewCountlist[2].beach_code})">
	    			<div class="awardtitle best3title">${viewCountlist[2].beach}</div>
	    			<div class="thumbnail best3img"><img src="./resources/image/${viewCountlist[2].picture}"></div>
	    		</div>
	    	</div>
    	</div>
    	
    	<div id="rank_title">후기 단골 맛집 바다는</div>
    	<div id="rank_subtitle">* 유저들이 후기를 많이 작성한 바다예요 *</div>
    	<div class="rankbox_container">
	   		<div class="awards">
	    		<img alt="" src="./resources/image/award.png">
	   		</div>
	    	<div class="rankbox mostreview">
	    		<div class="mostreviewed no2" onclick="moveToSeaResultPage(${reviewCountlist[1].beach_code})">
	    			<div class="awardtitle best2title">${reviewCountlist[1].beach}</div>
	    			<div class="thumbnail best2img"><img src="./resources/image/${reviewCountlist[1].picture}"></div>
	    		</div>
	    		<div class="mostreviewed no1" onclick="moveToSeaResultPage(${reviewCountlist[0].beach_code})">
	    			<div class="awardtitle best1title">${reviewCountlist[0].beach}</div>
	    			<div class="thumbnail best1img"><img src="./resources/image/${reviewCountlist[0].picture}"></div>
	    			
	    		</div>
	    		<div class="mostreviewed no3" onclick="moveToSeaResultPage(${reviewCountlist[2].beach_code})">
	    			<div class="awardtitle best3title">${reviewCountlist[2].beach}</div>
	    			<div class="thumbnail best3img"><img src="./resources/image/${reviewCountlist[2].picture}"></div>
	    		</div>
	    	</div>
    	</div>
    	
    	<div id="rank_title">별이 많이 뜬 바다는</div>
    	<div id="rank_subtitle">* 유저 리뷰 평균 별점이 높은 바다예요 *</div>
    	<div class="rankbox_container">
	   		<div class="awards">
	    		<img alt="" src="./resources/image/award.png">
	   		</div>
	    	<div class="rankbox bestscore">
	    		<div class="bestscored no2" onclick="moveToSeaResultPage(${reviewScorelist[1].beach_code})">
	    			<div class="awardtitle best2title">${reviewScorelist[1].beach}</div>
	    			<div class="thumbnail best2img"><img src="./resources/image/${reviewScorelist[1].picture}"></div>
	    		</div>
	    		<div class="bestscored no1" onclick="moveToSeaResultPage(${reviewScorelist[0].beach_code})">
	    			<div class="awardtitle best1title">${reviewScorelist[0].beach}</div>
	    			<div class="thumbnail best1img"><img src="./resources/image/${reviewScorelist[0].picture}"></div>
	    		</div>
	    		<div class="bestscored no3" onclick="moveToSeaResultPage(${reviewScorelist[3].beach_code})">
	    			<div class="awardtitle best3title">${reviewScorelist[2].beach}</div>
	    			<div class="thumbnail best3img"><img src="./resources/image/${reviewScorelist[2].picture}"></div>
	    		</div>
	    	</div>
	    </div>
    	    	
    	<div id="rank_title">또 가고 싶은 바다는</div>
    	<div id="rank_subtitle">* 많은 유저들이 재방문 의사를 표시했어요 *</div>    	    	
    	<div class="rankbox_container">
	   		<div class="awards">
	    		<img alt="" src="./resources/image/award.png">
	   		</div>
	    	<div class="rankbox revisit">
	    		<div class="revisited no2" onclick="moveToSeaResultPage(${re_visitlist[1].beach_code})">
	    			<div class="awardtitle best2title">${re_visitlist[1].beach}</div>
	    			<div class="thumbnail best2img"><img src="./resources/image/${re_visitlist[1].picture}"></div>
	    		</div>
	    		<div class="revisited no1" onclick="moveToSeaResultPage(${re_visitlist[0].beach_code})">
	    			<div class="awardtitle best1title">${re_visitlist[0].beach}</div>
	    			<div class="thumbnail best1img"><img src="./resources/image/${re_visitlist[0].picture}"></div>
	    		</div>
	    		<div class="revisited no3" onclick="moveToSeaResultPage(${re_visitlist[2].beach_code})">
	    			<div class="awardtitle best3title">${re_visitlist[2].beach}</div>
	    			<div class="thumbnail best3img"><img src="./resources/image/${re_visitlist[2].picture}"></div>
	    		</div>
	    	</div>
	    </div>
    	
   	</div>
   	
   	<br><hr><br>
    	
   	<div class="ranking-list etc">
    	
    	<div class="hashtag_container">
    	
    	<div id="rank_title">해시태그별 바다 랭킹</div>
    	<div id="rank_subtitle">* 보고싶은 해시태그를 클릭해보세요! *</div>
    	
    	<div class="hashtaglist">
    	
			<input type="hidden" name="hashtags" id="hashtags" value="">
			<div id="hashtagFields">
				<div class="hashtag-categories">
				<div class="category" data-category="누구와" onclick="changeColor(this)">누구와</div>
				<div class="category" data-category="편의시설" onclick="changeColor(this)">편의시설</div>
				<div class="category" data-category="바다" onclick="changeColor(this)">바다</div>
				<div class="category" data-category="액티비티" onclick="changeColor(this)">액티비티</div>
				<div class="category" data-category="풍경" onclick="changeColor(this)">풍경</div>
				</div>
				<div class="hashtag-dropdown" style="display: none;"></div>
			</div>
    	
    	</div>
    
    	</div>
    	
    </div>
    
</div>

<!-- 로딩 페이지 -->
<div id="loading" style="display: none;">
    <jsp:include page="../loading.jsp"/>
</div>

</body>
</html>