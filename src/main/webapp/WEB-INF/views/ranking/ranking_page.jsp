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
    
	$(document).ready(function() {
		
		
		// 페이지 로드시 그래프 초기화
		$.ajax({
            url: 'generateGraph',
            type: 'GET',
            success: function(imgRelativePath) {
                const graphContainer = document.getElementById('graphContainer');
                // 이미지가 있으면 제거
                const imgElement = graphContainer.querySelector('img');
                if (imgElement) {
                    imgElement.remove(); // 이미지 제거
                }
                // 새로운 이미지 추가
                graphContainer.innerHTML = '<img src="'+imgRelativePath+'">';
            },
            error: function(xhr, status, error) {
                console.error('Error reloading graph:', status);
            }
        });
		
		$('.hashrank_container').hide();
		$('.category').click(function() {
		    var category = $(this).data('category');
		    show_hashtags(category);
		});
		
		$(document).on('click', '.hashtag', function() {
		    var hashtag = $(this).text();
		    if ($(this).hasClass('selected')) {
		        $(this).removeClass('selected');
		        $('#hashtagrank').empty(); // 선택 해제 시 테이블 비우기
		    } else {
		 	  $(".hashtag").removeClass('selected');
		         $(this).addClass('selected');
		         showHashtagRank(hashtag);
		    }
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
	
	function showHashtagRank(hashtag){
		
		console.log("해시태그 : "+hashtag);
		
		$.ajax({
	           url: "hashrank", 
	           type: "GET",
	           data: {'hashtag':hashtag},
	           dataType: "json",
	           success: function(response) {
	               console.log("해시태그 : "+hashtag);
	               console.log(response);
	               
	               $('#hash').text(hashtag);
	               
	               if(response[0].second_used_beach==null){
	            	   $('#title1').text(response[0].most_used_beach);
	            	   $('#title2').text('데이터 없음');
	            	   $('#title3').text('데이터 없음');
	            	   $('#hashimg1').html('<img src="./resources/image/'+response[0].most_used_beach_picture+'">');
	            	   $('#hashimg2').html('<img src="./resources/image/nobeach.png">');
		               $('#hashimg3').html('<img src="./resources/image/nobeach.png">');
		               $('.hash_r1').first().attr('onclick', 'moveToSeaResultPage(' + response[0].most_used_beach_code + ')');

	               }
	               else if(response[0].second_used_beach && response[0].third_used_beach==null){
	            	   $('#title1').text(response[0].most_used_beach);
	            	   $('#title2').text(response[0].second_used_beach);
	            	   $('#title3').text('데이터 없음');
	            	   $('#hashimg1').html('<img src="./resources/image/'+response[0].most_used_beach_picture+'">');
		               $('#hashimg2').html('<img src="./resources/image/'+response[0].second_used_beach_picture+'">');
		               $('#hashimg3').html('<img src="./resources/image/nobeach.png">');
		               $('.hash_r1').first().attr('onclick', 'moveToSeaResultPage(' + response[0].most_used_beach_code + ')');
		               $('.hash_r2').first().attr('onclick', 'moveToSeaResultPage(' + response[0].second_used_beach_code + ')');

	               }
	               else{
	            	   $('#title1').text(response[0].most_used_beach);
		               $('#title2').text(response[0].second_used_beach);
		               $('#title3').text(response[0].third_used_beach);
		               $('#hashimg1').html('<img src="./resources/image/'+response[0].most_used_beach_picture+'">');
		               $('#hashimg2').html('<img src="./resources/image/'+response[0].second_used_beach_picture+'">');
		               $('#hashimg3').html('<img src="./resources/image/'+response[0].third_used_beach_picture+'">');
		               $('.hash_r1').first().attr('onclick', 'moveToSeaResultPage(' + response[0].most_used_beach_code + ')');
		               $('.hash_r2').first().attr('onclick', 'moveToSeaResultPage(' + response[0].second_used_beach_code + ')');
		               $('.hash_r3').first().attr('onclick', 'moveToSeaResultPage(' + response[0].third_used_beach_code + ')');

	               }

	               $('.hashrank_container').show();
	               
	               
	           },
	           error: function(xhr, status, error) {
	               console.error('ajax오류 : '+error); 
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
	    		<div class="revisited no2" onclick="">
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
		
			<div class="hashrank_container">
				<div class="hash_info"><span id="hash"></span>&nbsp;해시태그가 많이 쓰인 바다는...</div>
				<div class="hashtag_rank">
					<div class="hash_r1">
						<div class="titlebox"><img src="./resources/image/1위.png" width="50px"><div id="title1"></div></div>
						<div id="hashimg1"></div>
					</div>
					<div class="hash_r2">
						<div class="titlebox"><img src="./resources/image/2위.png" width="50px"><div id="title2"></div></div>
						<div id="hashimg2"></div>
					</div>
					<div class="hash_r3">
						<div class="titlebox"><img src="./resources/image/3위.png" width="50px"><div id="title3"></div></div>
						<div id="hashimg3"></div>
					</div>					
				</div>
			</div>
    
    	</div>
    	
    	
    	<div class="bbti_container">
    	
    	<div id="rank_title">BBTI(바다성향) 분포도</div>
    	<div id="rank_subtitle">* <바라는 바다> 유저들의 BBTI는 어떨까요? *</div>
   		    <div id="graphContainer">
			</div>
    	</div>
    	
    </div>
    
</div>

<!-- 로딩 페이지 -->
<div id="loading" style="display: none;">
    <jsp:include page="../loading.jsp"/>
</div>

<script type="text/javascript">

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

</body>
</html>