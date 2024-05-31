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
            <div class="button-container">
               <button type="button" class="rounded-button" onclick="window.location.href='review_page'">목록</button>
          	</div>
	    </div>
	    
	<c:if test="${not empty loginid}">	    
   	   	<div class="user_interaction">
			<div class="button-container hit_btn">
				<img src="./resources/image/icon_eye.png" width="20px" class="eye_icon">
				<span>${dto.hits}</span>
			</div>
			<div class="button-container rec_btn" onclick="recommend('${dto.review_num}','${loginid}')">
				<c:choose>
					<c:when test="${dto.rec_id.contains(loginid)}">
						<img src="./resources/image/like_on.png" width="20px" class="like_icon recommended">
					</c:when>
					<c:otherwise>
						<img src="./resources/image/icon_like.png" width="20px" class="like_icon">
					</c:otherwise>
				</c:choose>
						<span>${dto.recommend}</span>
			</div>
			<c:if test="${loginid != dto.id}">
			<div class="button-container rep_btn" onclick="window.open('review_report_view?review_num=${dto.review_num}&loginid=${loginid}','_blank','width=600px height=500px resizable=no scrollbar=no location=no toolbars=no')">
				<img src="./resources/image/report_icon.png" width="20px" class="report_icon">
				<span>신고</span>
			</div>
	   		</c:if>
        </div>
	</c:if>	    	    
	</div>
</div> 

<script>

function recommend(review_num, loginid) {
    const recBtn = document.querySelector('.rec_btn');

    recBtn.addEventListener('click', function() {
      const likeIcon = recBtn.querySelector('.like_icon');
      
      // 아이콘에 bounce 클래스를 추가합니다.
      likeIcon.classList.add('bounce');

      // 애니메이션이 끝난 후 bounce 클래스를 제거하고 페이지를 이동합니다.
      likeIcon.addEventListener('animationend', function() {
        likeIcon.classList.remove('bounce');
        window.location.href = 'review_recommend?review_num=' + review_num + '&loginid=' + loginid;
      }, { once: true });
    });

    // 트리거 클릭 이벤트
    recBtn.click();
  }

</script>
 
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
	          <div id="loginid" class="user-id2">${loginid}</div>
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
	  	<div class="modal-report">
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
		      <textarea id="detail" name="detail" rows="2" cols="45" placeholder="신고 상세 내용을 입력해주세요!(1500자까지)" required></textarea>
		    </div>
	    </div>
	    <br><hr>
	    <div class="modal-footer">
		    <button type="button" onclick="submit_report()" class="btn">신고하기</button>
		    <button type="button" class="btn close">취소하기</button>
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
                    	var maskedId = loginid.substring(0, 4) + "****";
	                    	var new_html = '<div class="comment" data-reply_num="' + data.reply_num + '">' +
	                        '<div class="user-id"><strong>' + data.name + '&nbsp;(' + maskedId + ')</strong>&nbsp;<span class="comment-date"><strong>(' + data.reply_day + ')</strong></span></div>' +
	                        '<div class="user_comments">' + data.reply + '</div>' +
	                        '<div class="comment_buttons">' +
	                        '<button type="button" class="btn reply_modify" data-reply_num="' + data.reply_num + '">수정</button> ' +
	                        '<button type="button" class="btn reply_delete" data-reply_num="' + data.reply_num + '">삭제</button>';
	                    
	                    if (data.loginid === 'admin') {
	                        new_html += ' <button type="button" onclick="location.href=\'reply_ban_listout\'" class="btn">댓글 신고 확인</button>';
	                    }
	                    
	                    new_html += '</div></div>';
	                    $('.comments-list').append(new_html);
	                    $('#reply').val('');
	                    
	                    window.location.reload();
	                    
	                    
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
                        window.location.reload();
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
        var $comment = $(this).closest('.comment');
        var original_reply = $comment.find('.user_comments').text().trim();
        
        $comment.find('.comment_modify_view').remove();
        
        var edit_html = '<div class="comment_modify_view">' +
        '<textarea class="reply-edit">' + original_reply + '</textarea>' +
        '<div class="comment_modify_btn" >' +
        '<button type="button" class="btn reply-save" data-reply_num="' + reply_num + '">저장</button>' +
        '<button type="button" class="btn reply-cancel" data-original_reply="' + original_reply + '" style=" margin-left: 5px;" >취소</button>';
        '</div></div>';
        
        $comment.find('.user_comments').hide();
        $(this).hide();
        $comment.find('.reply_delete').hide();
        $comment.append(edit_html);
   		
   	});
   	
   	$('.comments-container').on('click', '.reply-save', function() {
   	    var reply_num = $(this).data('reply_num');
   	 	var $comment = $(this).closest('.comment');
	 	var $reply_edit = $comment.find('.reply-edit');
   	    var update_reply = $reply_edit.val().trim();
   	    var review_num = $('#review_num').val();
   	    var id = $('#loginid').text();
   	 	
	   	 console.log('저장 버튼이 클릭되었습니다.');
	     console.log('댓글 번호:', reply_num);
	     console.log('수정된 댓글 내용:', update_reply);

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
   	                	
   	                	$comment.find('.comment_modify_view').remove();
   	                	
   	                	$comment.find('.reply-edit, .reply-save, .reply-cancel').remove();
                        $comment.find('.user_comments').text(update_reply).show();
                        $comment.find('.reply_modify, .reply_delete').show();
                        
                        
                        var new_html = '<strong>' + id + '</strong><span class="comment-date"> (' +reply_day + ')</span>' +
                        '<p class="user_comments">' + update_reply + '</p>' +
                        '<button type="button" class="btn reply_modify" data-reply_num="' + reply_num + '">수정</button> ' +
                        '<button type="button" class="btn reply_delete" data-reply_num="' + reply_num + '">삭제</button>';
                       
                        $comment.html(new_html);
                        $comment.find('.reply_modify').show();
                        $comment.find('.reply_delete').show();
                        
                        
   	                    
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
   	
   	$('.comments-container').on('click', '.reply-cancel', function() {
   	    var $comment = $(this).closest('.comment');
   	    var original_reply = $(this).data('original_reply');
   	    
   	    $comment.find('.comment_modify_view').remove();
   	    $comment.find('.user_comments').text(original_reply).show();
   	    $comment.find('.reply_modify, .reply_delete').show();
   	});
   	
});
   	
   	// 댓글 신고 모달창 시작
   	
    $('.reply_report').click(function() {
        // 댓글과 관련된 정보 
		  var reply_num = $(this).data('reply_num');
		  var reply_id = $(this).data('reply_id');
		  var reply_content = $(this).closest('.comment').find('.user_comments').text();
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