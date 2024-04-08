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
	        <img src="./resources/image_user/${gallery}">
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

	<!-- 댓글 영역 전체를 감싸는 상자 -->
	<div class="comments-container">
	
	  <!-- 댓글 목록 섹션 -->
	  <div class="comments-list-section">
	    <div class="comments-list">
	      <c:forEach items="${reply}" var="re">
	        <div class="comment">
	          <strong>${re.id}</strong><span class="comment-date"> (${fn:substring(re.reply_day, 0, 16)})</span>
	          <p>${re.reply_contents}</p>
	        </div>
	      </c:forEach>
	    </div>
	  </div>
	
	  <!-- 댓글 작성 섹션 -->
	  <div class="comments-writing-section">
	    <c:choose>
	      <c:when test="${not empty loginid}">
	        <form id="commentForm" class="comment-form">
	          <input type="hidden" id="review_num" name="review_num" value="${dto.review_num}" />
	          <span id="loginid" class="user-id"> ${loginid} </span>
	          <textarea id="reply" name="reply" placeholder="댓글을 입력하세요"></textarea>
	          <button id="replybtn" type="submit">댓글쓰기</button>
	        </form>
	      </c:when>
	      <c:otherwise>
	        <p>댓글을 작성하려면 로그인해주세요.</p>
	      </c:otherwise>
	    </c:choose>
	  </div>
	  
	</div>

<script type="text/javascript">

function confirmDelete(review_num) {
    if(confirm('정말 삭제하시겠습니까?')) {
        location.href = 'review_delete?review_num=' + review_num;
    }
}


</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function() {
    $('#commentForm').submit(function(e) {
        e.preventDefault();

        var review_num = $('#review_num').val();
        var reply = $('#reply').val().trim();
        var loginid = $('#loginid').text();

        if (reply) {
            $.ajax({
                url: 'reply_save',
                type: 'POST',
                dataType: 'json',
                data: {
                    'review_num': review_num,
                    'reply': reply,
                    'loginid': loginid
                },
                success: function(data) {
                    if(data.success) {
                        // 서버로부터 반환된 댓글 데이터를 목록에 추가
                        $('.comments-list').append('<div class="comment"><p>' + data.loginid + ': ' + data.reply + '</p></div>');
                        $('#reply').val(''); // 입력창을 비웁니다.
                    } else {
                        alert('댓글을 등록하지 못했습니다.');
                    }
                },
                error: function() {
                    alert('댓글 등록에 실패했습니다.');
                }
            });
        } else {
            alert('댓글을 입력해주세요.');
        }
    });
});
</script>
</body>
</html>