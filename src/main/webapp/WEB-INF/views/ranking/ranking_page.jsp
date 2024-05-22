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
    <script src="./resources/js/loading.js"></script>
</head>
<body>
<div class="container">

    <div class="container_title">
    	<div id="title_logo"><img alt="" src="./resources/image/bestaward_logo.png" width="900px"></div>
    	<div id="title_info">바라는 바다 속 다양한 순위를 살펴보세요!</div>
    </div>
    
    <div class="ranking-list best3">
    	
    	<div id="rank_title">가장 궁금한 바다는</div>
    	<div class="rankbox_container">
	   		<div class="awards">
	    		<img alt="" src="./resources/image/award.png">
	   		</div>
	    	<div class="rankbox bestview">
	    		<div class="bestviewed no2">
	    			<div class="awardtitle best3title">${viewCountlist[1].beach}</div>
	    			<div class="thumbnail best2img"><img src="./resources/image/${viewCountlist[1].picture}"></div>
	    		</div>
	    		<div class="bestviewed no1">
	    			<div class="awardtitle best1title">${viewCountlist[0].beach}</div>
	    			<div class="thumbnail best1img"><img src="./resources/image/${viewCountlist[0].picture}"></div>
	    		</div>
	    		<div class="bestviewed no3">
	    			<div class="awardtitle best3title">${viewCountlist[2].beach}</div>
	    			<div class="thumbnail best3img"><img src="./resources/image/${viewCountlist[2].picture}"></div>
	    		</div>
	    	</div>
    	</div>
    	
    	<div id="rank_title">후기 단골 맛집 바다는</div>
    	<div class="rankbox_container">
	   		<div class="awards">
	    		<img alt="" src="./resources/image/award.png">
	   		</div>
	    	<div class="rankbox mostreview">
	    		<div class="mostreviewed no2">
	    			<div class="awardtitle best2title">${reviewCountlist[1].beach}</div>
	    			<div class="thumbnail best2img"><img src="./resources/image/${reviewCountlist[1].picture}"></div>
	    		</div>
	    		<div class="mostreviewed no1">
	    			<div class="awardtitle best1title">${reviewCountlist[0].beach}</div>
	    			<div class="thumbnail best1img"><img src="./resources/image/${reviewCountlist[0].picture}"></div>
	    			
	    		</div>
	    		<div class="mostreviewed no3">
	    			<div class="awardtitle best3title">${reviewCountlist[2].beach}</div>
	    			<div class="thumbnail best3img"><img src="./resources/image/${reviewCountlist[2].picture}"></div>
	    		</div>
	    	</div>
    	</div>
    	
    	<div id="rank_title">별이 많이 뜬 바다는</div>
    	<div class="rankbox_container">
	   		<div class="awards">
	    		<img alt="" src="./resources/image/award.png">
	   		</div>
	    	<div class="rankbox bestscore">
	    		<div class="bestscored no2">
	    			<div class="awardtitle best2title">${reviewScorelist[1].beach}</div>
	    			<div class="thumbnail best2img"><img src="./resources/image/${reviewScorelist[1].picture}"></div>
	    		</div>
	    		<div class="bestscored no1">
	    			<div class="awardtitle best1title">${reviewScorelist[0].beach}</div>
	    			<div class="thumbnail best1img"><img src="./resources/image/${reviewScorelist[0].picture}"></div>
	    		</div>
	    		<div class="bestscored no3">
	    			<div class="awardtitle best3title">${reviewScorelist[2].beach}</div>
	    			<div class="thumbnail best3img"><img src="./resources/image/${reviewScorelist[2].picture}"></div>
	    		</div>
	    	</div>
	    </div>
    	    	
    	<div id="rank_title">또 가고 싶은 바다는</div>    	    	
    	<div class="rankbox_container">
	   		<div class="awards">
	    		<img alt="" src="./resources/image/award.png">
	   		</div>
	    	<div class="rankbox revisit">
	    		<div class="revisited no2">
	    			<div class="awardtitle best2title">${re_visitlist[1].beach}</div>
	    			<div class="thumbnail best2img"><img src="./resources/image/${re_visitlist[1].picture}"></div>
	    		</div>
	    		<div class="revisited no1">
	    			<div class="awardtitle best1title">${re_visitlist[0].beach}</div>
	    			<div class="thumbnail best1img"><img src="./resources/image/${re_visitlist[0].picture}"></div>
	    		</div>
	    		<div class="revisited no3">
	    			<div class="awardtitle best3title">${re_visitlist[2].beach}</div>
	    			<div class="thumbnail best3img"><img src="./resources/image/${re_visitlist[2].picture}"></div>
	    		</div>
	    	</div>
	    </div>
    	
   	</div>
   	
   	<br><hr><br>
    	
   	<div class="ranking-list etc">
    	
    	
    </div>
    
</div>
<!-- 로딩 페이지 -->
<div id="loading" style="display: none;">
    <jsp:include page="../loading.jsp"/>
</div>    
</body>
</html>