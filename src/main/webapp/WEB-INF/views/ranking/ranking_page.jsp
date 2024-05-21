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

    <div id="container_title"><바라는 바다> 베스트 어워드</div>
    
    <div class="ranking-list best3">
    	
    	<div class="rankbox bestviewed">
    	<div id="rank_title">가장 궁금한 바다는</div>
    		<div class="bestviewed_no1">
    			<div id="thumbnail best1img"><img src="./resources/image/${viewCountlist[0].picture}"></div>
    			<div id="awardtitle best1title">${viewCountlist[0].beach}</div>
    		</div>
    		<div class="bestviewed_no2">
    			<div id="thumbnail best2img"><img src="./resources/image/${viewCountlist[1].picture}"></div>
    			<div id="awardtitle best3title">${viewCountlist[1].beach}</div>
    		</div>
    		<div class="bestviewed_no3">
    			<div id="thumbnail best3img"><img src="./resources/image/${viewCountlist[2].picture}"></div>
    			<div id="awardtitle best3title">${viewCountlist[2].beach}</div>
    		</div>
    		<div class="awards">
    		<img alt="" src="./resources/image/award.png">
    		</div>
    	</div>
    	
    	<div class="rankbox mostreviewed">
    	<div id="rank_title">후기 단골 맛집 바다는</div>
    		<div class="mostreviewed_no1">
    			<div id="thumbnail best1img"><img src="./resources/image/${reviewCountlist[0].picture}"></div>
    			<div id="awardtitle best1title">${reviewCountlist[0].beach}</div>
    		</div>
    		<div class="mostreviewed_no2">
    			<div id="thumbnail best2img"><img src="./resources/image/${reviewCountlist[1].picture}"></div>
    			<div id="awardtitle best3title">${reviewCountlist[1].beach}</div>
    		</div>
    		<div class="mostreviewed_no3">
    			<div id="thumbnail best3img"><img src="./resources/image/${reviewCountlist[2].picture}"></div>
    			<div id="awardtitle best3title">${reviewCountlist[2].beach}</div>
    		</div>
    		<div class="awards">
    		<img alt="" src="./resources/image/award.png">
    		</div>
    	</div>
    	
    	<div class="rankbox bestscored">
    	<div id="rank_title">별이 많이 뜬 바다는</div>
    		<div class="bestscored_no1">
    			<div id="thumbnail best1img"><img src="./resources/image/${reviewScorelist[0].picture}"></div>
    			<div id="awardtitle best1title">${reviewScorelist[0].beach}</div>
    		</div>
    		<div class="bestscored_no2">
    			<div id="thumbnail best2img"><img src="./resources/image/${reviewScorelist[1].picture}"></div>
    			<div id="awardtitle best3title">${reviewScorelist[1].beach}</div>
    		</div>
    		<div class="bestscored_no3">
    			<div id="thumbnail best3img"><img src="./resources/image/${reviewScorelist[2].picture}"></div>
    			<div id="awardtitle best3title">${reviewScorelist[2].beach}</div>
    		</div>
    		<div class="awards">
    		<img alt="" src="./resources/image/award.png">
    		</div>
    	</div>
    	    	
    	<div class="rankbox revisit">
    	<div id="rank_title">또 가고 싶은 바다는</div>
    		<div class="revisit_no1">
    			<div id="thumbnail best1img"><img src="./resources/image/${re_visitlist[0].picture}"></div>
    			<div id="awardtitle best1title">${re_visitlist[0].beach}</div>
    		</div>
    		<div class="revisit_no2">
    			<div id="thumbnail best2img"><img src="./resources/image/${re_visitlist[1].picture}"></div>
    			<div id="awardtitle best3title">${re_visitlist[1].beach}</div>
    		</div>
    		<div class="revisit_no3">
    			<div id="thumbnail best3img"><img src="./resources/image/${re_visitlist[2].picture}"></div>
    			<div id="awardtitle best3title">${re_visitlist[2].beach}</div>
    		</div>
    		<div class="awards">
    		<img alt="" src="./resources/image/award.png">
    		</div>
    	</div>
    	
   	</div>
   	
   	<br><hr><br>
    	
   	<div class="ranking-list etc">
    	
    	<div class="rankbox mostbbti">
    		<div id="rank_title">유저들의 BBTI는</div>
    		<img alt="" src="./resources/image/award.png">
    	</div>
    	
    	<div class="rankbox hashtags">
    		<div id="rank_title">해시태그별 베스트 바다</div>
    	</div>
    	
    </div>
    
</div>
<!-- 로딩 페이지 -->
<div id="loading" style="display: none;">
    <jsp:include page="../loading.jsp"/>
</div>    
</body>
</html>