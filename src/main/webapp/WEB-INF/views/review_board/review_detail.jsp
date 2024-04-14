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
    
	<c:if test="${not empty loginid}">
	   <div class="interaction-buttons">
	       <c:if test="${loginid != dto.id}">
	        <div class="button-container">
	            <a href="review_report_view?review_num=${dto.review_num}&loginid=${loginid}" class="report-button">
	                <img src="./resources/image/report_icon.png" width="20px" class="report_icon">
	                <span>신고</span>
	            </a>
	        </div>
	        </c:if>
	        <div class="button-container">
	            <a href="review_recommend?review_num=${dto.review_num}&loginid=${loginid}" class="like-button">
	                <img src="./resources/image/like_icon.png" width="20px" class="like_icon">
	                <span>추천 ${dto.recommend}</span>
	            </a>
	        </div>
	        <c:if test="${loginid == dto.id || 'admin' == loginid}">
	            <div class="button-container">
	                <button type="button" class="rounded-button" onclick="location.href='review_change?review_num=${dto.review_num}'">수정</button>
	            </div>
	            <div class="button-container">
	                <button type="button" class="rounded-button" onclick="confirmDelete('${dto.review_num}')">삭제</button>
	            </div>
	        </c:if>
	    </div>
	</c:if>
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
	           	<c:if test="${fn:trim(loginid) == fn:trim(re.id) || 'admin' == loginid}">
          			<button type="button" class="reply_modify" data-reply_num="${re.reply_num}">수정</button>
          			<button type="button" class="reply_delete" data-reply_num="${re.reply_num}">삭제</button>
        		</c:if>
        		<c:if test="${fn:trim(loginid) != fn:trim(re.id) && not empty loginid}">
          			<button type="button" class="reply_report" 
          			data-reply_num="${re.reply_num}" data-review_num="${dto.review_num}" 
          			data-reply_id="${re.id}">신고</button>
        		</c:if>
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
	
	<!-- 신고 모달창 -->
	
	<div id="report_modal" class="modal" style="display:none;">
	  <div class="modal-content">
	    <span class="close">&times;</span>
	    <h3 align="center">댓글 신고</h3>
	    <div>
			  <label>신고자 : </label>
			  <span id="reporter_id"></span> <br>
	    </div>
	    <div>
	        <label>신고대상 : </label>
  			<span id="reply_id"></span> <br>
	    </div>
	    <div>
			<label>신고 댓글 내용 : </label>
			<span id="reply_content"></span> <br>
	    </div>
	    <div>
	      <label for="reason">신고 사유:</label>
	      <select id="reason" name="reason" required> 
	        <option value="정보통신망법에 의거한 청소년 유해 컨텐츠">정보통신망법에 의거한 청소년 유해 컨텐츠</option>
					<option value="정보통신망법에 의거한 명예훼손, 모욕, 비방">정보통신망법에 의거한 명예훼손, 모욕, 비방</option>
					<option value="정보통신망법에 의거한 불법촬영물">정보통신망법에 의거한 불법촬영물</option>
					<option value="정보통신망법에 의거한 광고성 게시글(스팸, 바이럴)">정보통신망법에 의거한 광고성 게시글(스팸, 바이럴)</option>
					<option value="개인정보보호법에 의거한 개인정보 노출게시물">개인정보보호법에 의거한 개인정보 노출게시물</option>
					<option value="불법행위,불법링크 등 불법정보 포함게시글">불법행위,불법링크 등 불법정보 포함게시글</option>
					<option value="그 외(아래 '문의 내용'에 게재)">그 외(아래 '신고 내용'에 게재)</option>
	      </select>
	    </div>
	    <div>
	      <label for="detail">신고 내용:</label>
	      <textarea id="detail" name="detail" rows="2" cols="45" placeholder="신고 상세 내용을 입력해주세요!" required></textarea>
	    </div><br><br>
	    <div class="modal-footer">
		    <button type="button" onclick="submit_report()">신고하기</button>
		    <button type="button" class="close">취소하기</button>
	    </div>
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
                    	var new_html = '<div class="comment">' +
                        '<strong>' + data.loginid + '</strong><span class="comment-date"> (' + data.reply_day + ')</span>' +
                        '<p>' + data.reply + '</p>' +
                        '<button type="button" class="reply_modify" data-reply_num="' + data.reply_num + '">수정</button> ' +
                        '<button type="button" class="reply_delete" data-reply_num="' + data.reply_num + '">삭제</button>' +
                        '</div>';
                    $('.comments-list').append(new_html);
                    $('#reply').val(''); 
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
    
   	$('.comments-container').on('click', '.reply_delete', function() {
        var reply_num = $(this).data('reply_num');
        var review_num = $('#review_num').val();

        if(confirm('댓글을 삭제하시겠습니까?')) {
            $.ajax({
                url: 'delete_reply',
                type: 'POST',
                dataType: 'json',
                data: {
                    'reply_num': reply_num,
                    'review_num': review_num
                },
                success: function(data) {
                    if(data.success) {
                        $('button[data-reply_num="' + reply_num + '"]').closest('.comment').remove();
                    } else {
                        alert('댓글 삭제 실패');
                    }
                },
                error: function() {
                    alert('댓글 삭제 오류 발생');
                }
            });
        }
    });
   	
   	// 댓글 수정
   	
   	$('.comments-container').on('click', '.reply_modify', function() {
   	    var reply_num = $(this).data('reply_num');
   	    var original_reply = $(this).closest('.comment').find('p').text().trim();
   	    
   	 	$(this).siblings('button').hide();
   	    
   	    var edit_monitor = '<br> <textarea class="reply-edit">' + original_reply + '</textarea>' +
   	                   '<button type="button" class="reply-save" data-reply_num="' + reply_num + '">저장</button>';
   	    
   	    $(this).closest('.comment').find('p').replaceWith(edit_monitor);
   		$(this).hide();
   		
   	});
   	
   	$('.comments-container').on('click', '.reply-save', function() {
   	    var reply_num = $(this).data('reply_num');
   	    var update_reply = $(this).prev('.reply-edit').val().trim();
   	    var review_num = $('#review_num').val();

   	    if(update_reply) {
   	        $.ajax({
   	            url: 'modify_reply', 
   	            type: 'POST',
   	            dataType: 'json',
   	            data: {
   	                'reply_num': reply_num,
   	                'reply': update_reply,
   	                'review_num': review_num
   	            },
   	            success: function(data) {
   	                if(data.success) {
   	                    
   	                    var update_html = '<div class="comment">' +
                        	'<strong>' + data.id + '</strong><span class="comment-date"> (' + data.reply_day + ')</span>' +
                       		'<p>' + update_reply + '</p>' +
							'<button type="button" class="reply_modify" data-reply_num="' + reply_num + '">수정</button>' +
                        	'<button type="button" class="reply_delete" data-reply_num="' + data.reply_num + '">삭제</button>' +
                        	'</div>';
   	                    
   	                        $('button[data-reply_num="' + reply_num + '"]').closest('.comment').html(update_html);
   	                } else {
   	                    alert('댓글 수정 실패');
   	                }
   	            },
   	            error: function() {
   	                alert('댓글 수정 오류 발생');
   	            }
   	        });
   	    } else {
   	        alert('댓글 내용을 입력해주세요.');
   	    }
   	});
   	
});
   	
   	// 댓글 신고 모달창 시작
   	
    $('.reply_report').click(function() {
        // 댓글과 관련된 정보 
		  var reply_num = $(this).data('reply_num');
		  var reply_id = $(this).data('reply_id');
		  var reply_content = $(this).closest('.comment').find('p').text();
		  var reporter_id = $('#loginid').text(); // 신고자 아이디를 가져오는 코드
		
		  $('#reporter_id').text(reporter_id);
		  $('#reply_id').text(reply_id);
		  $('#reply_content').text(reply_content);
		  $('#detail').val('');

        $('#report_modal').show();
    });

    // 모달 닫기 
    $('.close').click(function() {
        $('#report_modal').hide();
    });
    

    function submit_report() {
    	  	  
    	  $.ajax({
    	    url:'report_reply',
    	    type: 'POST',
    	    data: {
    	      'reply_num' : $('.reply_report').data('reply_num'),
    	      'review_num' : $('#review_num').val(),
    	      'reporter_id' : $('#reporter_id').text().trim(),
    	      'reply_id' : $('#reply_id').text().trim(),
    	      'reply_content' : $('#reply_content').text().trim(),
    	      'reason' : $('#reason').val(),
    	      'detail' : $('#detail').val()
    	    },
    	    success: function(result) {
    	    	if (result === "ok") {
    	    	
    	    	alert('신고가 접수되었습니다.');
    	    	$('#report_modal').hide();
    	    	
    	    	} else if (result === "no") {
    	    		alert("동일한 사유의 중복 신고는 불가합니다.");
    	    	}
    	    },
    	    error: function() {
    	    	alert('신고 처리 중 오류 발생!');
    	    }
    	  });
    	}
   	
</script>
</body>
</html>