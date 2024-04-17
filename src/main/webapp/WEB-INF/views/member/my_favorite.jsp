<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

  .grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 3열 그리드 */
    padding: 10px;
    gap: 20px; /* 각 그리드 아이템 사이의 간격 */
  }
  .grid-item {
    padding: 20px;
    text-align: center; /* 텍스트 중앙 정렬 */
    background-color: white; /* 배경색을 흰색으로 설정 */
    border-radius: 15px; /* 모서리를 둥글게 */
    box-shadow: 0 0 10px rgba(0,0,0,0.1); /* 그림자 효과 */
    transition: transform 0.3s; /* 호버 시 변환 효과를 위한 전환 설정 */
    height: 320px; /* 고정 높이 */
    width: 350px;
    transition: all 0.3s ease;
  }

  .grid-item:hover {
    transform: scale(1.05); /* 호버 시 약간 확대 */
  }

  img {
    width: 200px; /* 이미지 너비 */
    height: 180px; /* 이미지 높이 */
    object-fit: cover; /* 이미지 비율 유지하면서 채우기 */
    border-radius: 2%;
    margin-bottom: 10px;
  }
  .item-content {
    padding: 10px; /* 내용 패딩 */
    text-align: center; /* 텍스트 중앙 정렬 */
    flex-grow: 1; /* 나머지 공간을 채움 */
  }
  .small-text {
    font-size: 0.8em; /* 글자 크기 작게 */
    color: #666; /* 글자 색상 */
    
  }
 
  .small-text-container {
    display: flex; /* 플렉스박스 설정 */
    justify-content: space-between; /* 내용 사이에 공간을 균등하게 배분 */
  }  
  
  h3 {
    white-space: nowrap; /* 공백을 무시하고 한 줄에 표시 */
    overflow: hidden; /* 넘치는 텍스트 숨기기 */
    text-overflow: ellipsis; /* 말줄임표로 처리 */
    max-width: 320px; /* 최대 너비 설정 */
    margin-bottom: 10px;
  }
  
  .score .star {
	    font-size: 24px; /* 별의 크기를 설정 */
	    color: #ccc; /* 기본 별 색상은 회색 */
	    text-align: right;
	    margin-bottom: 30px;
	}
	
  .score .star.filled {
	    color: #f5c518; /* 색칠된 별의 색상을 설정 (골드색) */
}

 .info-container {
    display: none; /* 기본적으로 보이지 않음 */
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  
 .grid-item:hover .info-container {
    display: flex; /* 호버 시에만 표시 */
  }
  
  .grid-item:hover img,
  .grid-item:hover p,
  .grid-item:hover h3,
  .grid-item:hover .small-text-container {
    opacity: 0.05; /* 흐릿한 효과 */
  }
  
   .score {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    display: none; /* 초기 상태에서 숨김 */
    flex-direction: row;
    align-items: center;
    justify-content: center;
    z-index: 10;
  }
  
   .grid-item:hover .score {
    display: flex; /* 호버 시 표시 */
  }
  
</style>

<script>

function gogo(url) {
 window.location.href = url;
}

</script>

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