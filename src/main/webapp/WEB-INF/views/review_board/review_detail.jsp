<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/review_detail.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="review-box">
    <div class="review-title">${dto.review_title}</div>
    <div class="evaluation">
    <div class="score">
    	<span>별점</span>
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
            <div class="revisit-no">다신 안 갈래요!</div>
        </c:if>
    </div>
    </div> 
    <hr><br>
    <div class="review-infos">
    <div class="review-info1">방문해변 : ${beach}</div>
    <div class="review-info2">
        <p>작성자 : ${dto.name}(${fn:substring(dto.id, 0, 4)}****)</p>
        <p>작성일 : ${fn:substring(dto.write_day, 0, 16)}</p>
    </div>
    </div>

<c:if test="${not empty gallery}">
	<div class="review-images">
	    <c:forEach items="${gallery}" var="gallery">
	        <div><img src="./resources/image_user/${gallery}"></div>
	    </c:forEach>
	</div>
		<script type="text/javascript">
			$(document).ready(function(){
				
				 $('.review-images').slick({
				 	autoplay:true,
				 	autoplaySpeed: 2000,
					dots: true,
					arrows: true,
					infinite: true,
				 	pauseOnHover: true,
				 	fade:false,
					draggable: true,
					cssEase: 'linear'
				 });
				 
			});	
		</script>
</c:if>
    <div class="review_content">
        <p>${dto.review_contents}</p>
    </div>
    
    <br><hr><br>
    <div class="hashtag_box">
    <div id="hash_title">#해시태그 #hashtag</div>
    <div class="hashtags">
       <c:forEach var="hashtag" items="${fn:split(dto.hashtag, ' ')}">
           <span class="hashtag">${hashtag.trim()}</span>
       </c:forEach>
    </div>
    </div>
    
<c:if test="${not empty loginid}">
   <div class="interaction-buttons">
        <div class="text_control">
	        <c:if test="${loginid == dto.id || 'admin' == loginid}">
	            <div class="button-container">
	                <button type="button" class="rounded-button" onclick="location.href='review_change?review_num=${dto.review_num}'">수정</button>
	            </div>
	            <div class="button-container">
	                <button type="button" class="rounded-button" onclick="confirmDelete('${dto.review_num}')">삭제</button>
	            </div>
	        </c:if>
	    </div>
	    
   	   	<div class="user_interaction">
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
        </div>
	    	    
	</div>
</c:if>
</div> 
 
<!-- 댓글 영역 전체를 감싸는 상자 -->
<div class="comments-container">
	
	  <!-- 댓글 목록 섹션 -->
<c:if test="${not empty reply}">
	  <div class="comments-list-section">
	    <div class="comments-list">
	      <c:forEach items="${reply}" var="re">
	      <div class="comment">
	        <c:set var="maskedId" value="${fn:substring(re.id, 0, 4)}****" />
				
	          <div class="user-id"><strong>${re.name}&nbsp;(${maskedId})</strong>&nbsp;<span class="comment-date"><strong>(${fn:substring(re.reply_day, 0, 16)})</strong></span></div>
	          <div class="user_comments">${re.reply_contents}</div>
	          <div class="comment_buttons">
	           	<c:if test="${fn:trim(loginid) == fn:trim(re.id) || 'admin' == loginid}">
          			<button type="button" class="btn reply_modify" data-reply_num="${re.reply_num}">수정</button>
          			<button type="button" class="btn reply_delete" data-reply_num="${re.reply_num}">삭제</button>
        		</c:if>
        		<c:if test="${fn:trim(loginid) != fn:trim(re.id) && not empty loginid}">
          			<button type="button" class="btn reply_report" 
          			data-reply_num="${re.reply_num}" data-review_num="${dto.review_num}" 
          			data-reply_id="${re.id}">신고</button>
        		</c:if>
        		<c:if test="${'admin' == loginid}">
	                <button type="button" onclick="location.href='reply_ban_listout'" class="btn">댓글 신고 확인</button>
	        	</c:if>
	       	 </div>
	      </div>
	      </c:forEach>
	    </div>
	  </div>
</c:if>	
	  <!-- 댓글 작성 섹션 -->
<form id="commentForm" class="comment-form">
	  <div class="comments-writing-section">
	    <c:choose>
	      <c:when test="${not empty loginid}">
	          <input type="hidden" id="review_num" name="review_num" value="${dto.review_num}" />
	          <div id="loginid" class="user-id"> ${loginid} </div>
	          <div class="reply_input_area">
	          <textarea id="reply" name="reply" placeholder="댓글을 입력하세요"></textarea>
	          </div>
	          <div class="button_area">
	          <button id="replybtn" type="submit" class="btn">댓글쓰기</button>
	          </div>  
	      </c:when>
	      <c:otherwise>
	        <p>댓글을 작성하려면 로그인해주세요.</p>
	      </c:otherwise>
	    </c:choose>
	  </div>
</form>	  
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
		    <button type="button" onclick="submit_report()" class="btn">신고하기</button>
		    <button type="button" class="btn close" >취소하기</button>
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

<script>
$(document).ready(function() {
    $('#commentForm').submit(function(e) {
        e.preventDefault();

        var review_num = $('#review_num').val();
        var reply = $('#reply').val().trim();
        var loginid = $('#loginid').text().trim();

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
                    	alert('댓글을 등록했습니다!');
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
                error: function(xhr, status, error) {
                    alert('댓글 등록에 실패했습니다.');
                    console.error(xhr.responseText); 
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