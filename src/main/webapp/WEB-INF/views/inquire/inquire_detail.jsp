<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/inquire_detail.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<meta charset="UTF-8">
<title>바라는 바다! :: 문의글</title>

</head>
<body>

<div class="container">

<div class="inquire_container">
       
	<table class="title_table">
	<tr>     
		<th id="category" width="25%">[${dto.category}]</th>
		<td id="list_contents" width="75%">${dto.title}</td>
	</tr>
	</table>
	
	<div class="listboxout">
		<div class="listbox replies"> 
			<div id="replystate">${dto.reply == 0 ? '답변없음' : '답변완료'}</div>
			<c:if test="${dto.reply == 1}">
			<style>
				.replies {
					background-color: #48B0D9;
				}
			</style>
			</c:if>
		</div>
		<div class="listbox writers">
			<div id="writeday">${fn:substring(dto.i_date, 0, 19)}</div>
			<div class="writer_name">
				<div id="list_title">작성자 :</div>
				<div id="inquire_writer">${dto.name}(${fn:substring(dto.id, 0, 4)}****)</div>
			</div>
		</div>
	</div>

	<c:choose>
		<c:when test="${dto.pic1.equals('nope')}">
		</c:when>
		<c:otherwise>
		<div class="inquire-images">
			<c:choose>
			<c:when test="${not dto.pic1.equals('nope')}">
				<div><img src="./resources/image_user/${dto.pic1}"></div>
			</c:when>
			<c:otherwise> </c:otherwise>
			</c:choose>
			<c:choose>
			<c:when test="${not dto.pic2.equals('nope')}">
				<div><img src="./resources/image_user/${dto.pic2}"></div>
			</c:when>
			<c:otherwise> </c:otherwise>
			</c:choose>
			<c:choose>
			<c:when test="${not dto.pic3.equals('nope')}">
				<div><img src="./resources/image_user/${dto.pic3}"></div>
			</c:when>
			<c:otherwise> </c:otherwise>
			</c:choose>
			<c:choose>
			<c:when test="${not dto.pic4.equals('nope')}">
				<div><img src="./resources/image_user/${dto.pic4}"></div>
			</c:when>
			<c:otherwise> </c:otherwise>
			</c:choose>
			<c:choose>
			<c:when test="${not dto.pic5.equals('nope')}">
				<div><img src="./resources/image_user/${dto.pic5}"></div>
			</c:when>
			<c:otherwise> </c:otherwise>
			</c:choose>
		</div>
		
		<c:choose>
			<c:when test="${dto.pic1.equals('nope')}">
			
			</c:when>
			<c:otherwise>
			<script type="text/javascript">
				$(document).ready(function(){
					
					 $('.inquire-images').slick({
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
			</c:otherwise>
		</c:choose>
	</c:otherwise>
	</c:choose>

	<div class="content_title">문 의 내 용</div>
	<div class="listbox content">
	 	<div class="list_contents">${dto.content}</div>
	</div>

	<div class="inquire_btns">
	<c:choose>
		<c:when test="${loginid eq dto.id || position=='admin'}">
			<div class="action_btns">
				<div class="update_btn">
					<img src="./resources/image/modify_icon.png" width="20px" class="like_icon" onclick="window.location.href='inquire_modify?inquire_num=${dto.inquire_num}'">
					<span>수정</span>
				</div>
				<div class="delete_btn">
					<img src="./resources/image/delete_icon.png" width="20px" class="report_icon" onclick="confirmDelete('${dto.inquire_num}')">
					<span>삭제</span>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="action_btns">
				<div class="update_btn">
					<img src="./resources/image/modify_icon.png" width="20px" class="like_icon" onclick="window.location.href='inquire_modify?inquire_num=${dto.inquire_num}'">
					<span>수정</span>
				</div>
				<div class="delete_btn">
					<img src="./resources/image/delete_icon.png" width="20px" class="report_icon" onclick="confirmDelete('${dto.inquire_num}')">
					<span>삭제</span>
				</div>
				<div class="list_btn">
					<img src="./resources/image/icon_tolist.png" width="20px" class="report_icon" onclick="window.location.href='inquire_listout?sort=latest'">
					<span>목록으로</span>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${loginstate==true}">
			<div class="rechit_btns">
				<div class="rec_btn" onclick="window.location.href='inquire_recommand?inquire_num=${dto.inquire_num}&loginid=${loginid}'">
					<img src="./resources/image/icon_like.png" width="20px" class="like_icon">
					<span>${dto.rec}</span>
				</div>
				<div class="hit_btn">
					<img src="./resources/image/icon_eye.png" width="20px" class="eye_icon">
					<span>${dto.cnt}</span>
				</div>
				<div class="rep_btn" onclick="window.location.href='inquire_report_view?inquire_num=${dto.inquire_num}&loginid=${loginid}'">
					<img src="./resources/image/report_icon.png" width="20px" class="report_icon">
					<span>신고하기</span>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="rechit_btns">
				<div class="hit_btn">
					<img src="./resources/image/icon_eye.png" width="20px" class="eye_icon">
					<span>${dto.cnt}</span>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	</div>
</div>

<!-- 문의콘테이너 끝 -->
   
<!-- 댓글 영역 시작-->  

<div class="comments_container">
 
	<div class="comments_list">
	
		<c:forEach items="${list}" var="l">
		
			<div class="admin_reply_list">
				<span id="admin_name">관리자</span>
				<span id="admin_date">(${fn:substring(l.inquire_reply_date, 0, 19)})</span>
			</div>
			
			<div class="reply_lists">${l.content}</div>
			
			<c:choose>
			<c:when test="${loginstate==true && position=='admin'}">
			   
				<span id="reply_${l.inquire_reply_num}"></span>
				<div class="reply_btns">
					<img src="./resources/image/modify_icon.png" width="20px" onclick="createEditForm('${l.inquire_reply_num}', '${dto.inquire_num}', '${l.content}')">
					<img src="./resources/image/delete_icon.png" width="20px" onclick="confirm_reply_Delete('${l.inquire_reply_num}' , '${dto.inquire_num}')">
				</div>
			</c:when>
			</c:choose>
		
		</c:forEach>
		
	</div>
	
	<form action="inquire_reply_save" method="post">
	
	<div class="comment_area">
	
		<c:choose>
		<c:when test="${loginstate==true && position=='admin'}">		    
		            
		<div class="reply_input_area">
			<textarea name="content" id="content" placeholder="문의에 대한 답은 1500자 이하로 입력하세요." required></textarea>
		</div>
		
		<div class="button_area">
			<input type="hidden" name="inquire_num" value="${dto.inquire_num}">
			<input type="submit" id="replybtn" value="작성" class="btn2">
		</div>
		
		</c:when>
		</c:choose>
	
	</div>
	            
	</form>
  
</div>

</div>

<script type="text/javascript">

function confirmDelete(inquire_num) {
    if(confirm('문의를 정말 삭제하시겠습니까?')) {
        window.location.href = 'inquire_delete?inquire_num=' + inquire_num;
    }
}

function confirm_reply_Delete(inquire_reply_num, inquire_num) {
    if(confirm('답변을 정말 삭제하시겠습니까?')) {
    	window.location.href = 'inquire_reply_delete?inquire_reply_num=' + inquire_reply_num + '&inquire_num=' + inquire_num;
    }
}

function createEditForm(inquire_reply_num, inquire_num, content) {
    console.log('inquire_reply_num:', inquire_reply_num);
    console.log('inquire_num:', inquire_num);
    console.log('content:', content);
    
    // 수정 폼 HTML 생성
    var formHtml = '<form id="editForm_' + inquire_reply_num + '">' +
                       '<textarea cols="90" rows="5" id="content_' + inquire_reply_num + '" name="newcontent">' + content + '</textarea><br>' +
                       '<span style="float: right;"> <input type="button" value="답변 수정" onclick="submitEditedReply(\'' + inquire_reply_num + '\', \'' + inquire_num + '\')"> </span>' +
                       '<input type="hidden" name="inquire_reply_num" value="' + inquire_reply_num +'">' +
                       '<input type="hidden" name="inquire_num" value="' + inquire_num +'">' +
                   '</form>';
    
    // 수정 폼을 해당 댓글 영역에 추가
    var targetElement = document.getElementById('reply_' + inquire_reply_num);
    if(targetElement) {
        console.log('targetElement found:', targetElement);
        var parentElement = targetElement.parentNode; // 부모 요소를 찾습니다.
        var newRow = parentElement.insertRow(targetElement.rowIndex + 1); // 새로운 행을 삽입합니다.
        var newCell = newRow.insertCell(); // 새로운 셀을 삽입합니다.
        newCell.colSpan = "2"; // 새로운 셀이 전체 행을 차지하도록 설정합니다.
        newCell.innerHTML = formHtml; // 수정 폼 HTML을 삽입합니다.
    } else {
        console.error('Target element not found:', 'reply_' + inquire_reply_num);
    }
}

function submitEditedReply(inquire_reply_num, inquire_num) {
    var newcontent = document.getElementById('content_' + inquire_reply_num).value;
    var formData = new FormData();
    formData.append('inquire_reply_num', inquire_reply_num);
    formData.append('inquire_num', inquire_num);
    formData.append('newcontent', newcontent);

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                console.log('답변 수정이 성공적으로 완료되었습니다.');
                window.location.reload(); // 답변 수정 후 페이지 새로고침
            } else {
                console.error('서버 오류:', xhr.status);
                alert('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
            }
        }
    };
    xhr.open('POST', 'inquire_reply_modify');
    xhr.send(formData);
}
</script>



</body>
</html>
