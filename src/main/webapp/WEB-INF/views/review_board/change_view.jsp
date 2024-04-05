<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/review_input.css" rel="stylesheet" type="text/css">
</head>
<body>

	<form id="review_change_form" action="review_change_save" method="post" enctype="multipart/form-data">
		<table align="center">
		<caption>바다후기 게시글 수정</caption>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="name" id="name" value="${dto.name}" readonly="readonly">
					<input type="hidden" name="id" id="id" value="${dto.id}" >
					<input type="hidden" name="review_num" id="review_num" value="${dto.review_num}" >
				</td>
			</tr>
			
			<tr>
				<th>방문일</th>
				<td>
					<input type="date" name="visit_day" id="visit_day" value="${dto.visit_day }" onchange="checkDate()" required>
				</td>
			</tr>
			
			<tr>
				<th>후기 바다</th>
				<td>
					<select name="beach" id="beach" required>
					<option value="" disabled selected>방문한 바다를 선택해주세요!</option>
					    <c:forEach items="${beachList}" var="beach">
					        <option value="${beach.beach_code}" ${beach.beach_code == dto.beach_code ? 'selected' : ''}>${beach.beach}</option>
					    </c:forEach>
					</select>    
				</td>
			</tr>
			<tr>
				<th>제목 &nbsp;&nbsp;</th>
				<td><input type="text" name="review_title" id="review_title" required value="${dto.review_title }"></td>
			</tr>
			<tr>
				<th>썸네일</th>
	            <td>
	            <div id="thumbnail_view" style="margin-bottom: 15px">
					<c:if test="${not empty dto.thumbnail and dto.thumbnail ne 'no'}">
                		<img src="${pageContext.request.contextPath}/resources/image_user/${dto.thumbnail}" style="width:60px; height:60px;">
            		</c:if>
				</div>      
	            <input type="file" name="thumb_nail" id="thumb_nail" onchange="previewFile()">
	            </td>
			</tr>
			
			<tr>
				<th>사진첨부(최대 5장)</th>

	                <td id="pic_pack">
	                <div id="existing_photos">
	                        <c:forEach items="${photoList}" var="photo">
				            <c:if test="${photo ne 'no'}">
				                <div class="image-wrap" id="image-wrap-${photo}" style="display: inline-block; margin: 10px 10px;">
				                    <img src="${pageContext.request.contextPath}/resources/image_user/${photo}" width="60px" height="60px">
				                </div>
				            </c:if>
				        	</c:forEach>
				    </div>
				    <div id="photo_input" style="margin-top: 10px 0;"> 
				    	<p>새로운 이미지 파일 선택시 기존의 이미지 파일은 모두 삭제됩니다.</p><br>
	                    <input type="file" name="pic1" id="pic1">
	                    <button type="button" onclick="addPicField()"> + </button>
	                </div>
	                </td>

			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea cols="60" rows="30" name="review_contents" id="review_contents" required >${dto.review_contents }</textarea>
				</td>
			</tr>
			<tr>
				<th>별점</th>
				<td>
					<fieldset id="star">
					    <input type="radio" name="review_score" value="5" id="rate1" ${dto.review_score == 5 ? 'checked' : ''} ><label for="rate1">★</label>
					    <input type="radio" name="review_score" value="4" id="rate2" ${dto.review_score == 4 ? 'checked' : ''} ><label for="rate2">★</label>
					    <input type="radio" name="review_score" value="3" id="rate3" ${dto.review_score == 3 ? 'checked' : ''} ><label for="rate3">★</label>
					    <input type="radio" name="review_score" value="2" id="rate4" ${dto.review_score == 2 ? 'checked' : ''} ><label for="rate4">★</label>
					    <input type="radio" name="review_score" value="1" id="rate5" ${dto.review_score == 5 ? 'checked' : ''} ><label for="rate5">★</label>
					</fieldset>
			    </td>
			</tr>
			<tr>
                <th>해시태그</th>
                <input type="hidden" name="hashtags" id="hashtags" value="${dto.hashtag}">
                <td id="hasjtagFields">
                	<div class="hashtag-box" data-value="#사람이적어요">#사람이 적어요</div>
			        <div class="hashtag-box" data-value="#맛집이많아요">#맛집이 많아요</div>
			        <div class="hashtag-box" data-value="#깨끗해요">#깨끗해요</div>
			        <div class="hashtag-box" data-value="#바다색이예뻐요">#바다 색이 예뻐요</div>
			        <div class="hashtag-box" data-value="#모래가고와요">#모래가 고와요</div>
                </td>
            </tr>
	            <tr>
	                <th>재방문 의사</th>
	                <input type="hidden" name="re_visit" id="re_visit_input" value="${dto.re_visit}">
				    <td id="re_visit">
				        <div class="visit-box" data-value="Yes">Yes</div>
				        <div class="visit-box" data-value="No">No</div>
				    </td>
	            </tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="전송">
					<input type="reset" value="취소">
				</td>
			</tr>
		</table>
	</form>


<script>

	function previewFile() {
		  var thumbnail_view = document.getElementById('thumbnail_view'); // 미리보기를 표시할 요소 선택
		  var file    = document.getElementById('thumb_nail').files[0]; // 선택된 파일 가져오기
		  var reader  = new FileReader();
	
		  reader.onloadend = function () {
		    var img = document.createElement('img'); // 새로운 img 요소 생성
		    img.src = reader.result; // reader가 읽은 파일 내용을 img의 src로 설정
		    img.style.width = '60px';
	        img.style.height = '60px';
		    thumbnail_view.innerHTML = ''; // 이전에 표시된 이미지를 제거
		    thumbnail_view.appendChild(img); // 생성된 img 요소를 preview에 추가
		  }
	
		  if (file) {
		    reader.readAsDataURL(file); // 파일 읽기 시작, 이 작업이 끝나면 reader.onloadend가 호출됨
		  } else {
			 thumbnail_view.innerHTML = ""; // 파일이 선택되지 않았으면 미리보기를 비움
		  }
		}



	var PicCount = 1;
	function addPicField() {
	    // 사진 5장까지만 첨부 가능
	    if (PicCount >= 5) {
	        alert("사진은 최대 5장까지만 첨부할 수 있습니다.");
	        return;
	    }
	
	    PicCount++;
	
	    // 버튼을 누르면 새로운 사진 input창 생성
	    var newField = document.createElement('div');
	    newField.innerHTML = '<input type="file" name="pic' + PicCount + '" id="pic' + PicCount + '">';
	
	    // 위에서 추가한 것을 보이도록 해서 pic_pack에 추가
	    document.getElementById('pic_pack').appendChild(newField);
	}
	
	// 방문날짜 선택
	function checkDate() {
    var visitDayInput = document.getElementById('visit_day');
    var visitDay = new Date(visitDayInput.value);
    var today = new Date();
    today.setHours(0, 0, 0, 0); // 시간을 00:00:00으로 설정하여 오늘 날짜만 비교
    
    today.setDate(today.getDate() + 1);

    if (visitDay > today) {
        alert('방문한 날짜만 선택가능합니다!');
        visitDayInput.value = ""; // 입력 필드 초기화
    }
	}

	
	// 해시태그영역

	document.addEventListener("DOMContentLoaded", function() {
	    var hashtagBoxes = document.querySelectorAll('.hashtag-box');

	    function Hashtag_Input() {
	        var selectedHashtags = document.querySelectorAll('.hashtag-box.selected');
	        var hashtagsValue = Array.from(selectedHashtags).map(function(box) {
	            return box.getAttribute('data-value');
	        }).join(' ');
	        document.getElementById('hashtags').value = hashtagsValue;
	    }

	    hashtagBoxes.forEach(function(box) {
	        box.addEventListener('click', function() {
	            // 선택된 박스의 수 확인
	            var selectedBoxes = document.querySelectorAll('.hashtag-box.selected');
	            if (!box.classList.contains('selected') && selectedBoxes.length >= 3) {
	                alert('최대 3개까지만 선택할 수 있습니다.');
	                return;
	            }

	            // 박스의 선택 상태를 토글
	            box.classList.toggle('selected');
	            
	            Hashtag_Input();
	        });
	    });
	    
	    // 해시태그 수정 기본세팅
	    var hashtagsValue = document.getElementById('hashtags').value;
	    if (hashtagsValue) {
	        var selectedTags = hashtagsValue.split(' '); 
	        hashtagBoxes.forEach(function(box) {
	            if (selectedTags.includes(box.getAttribute('data-value'))) {
	                box.classList.add('selected'); // db저장 해시태그 박스 선택된 상태 표시
	            }
	        });
	    }
	    

	    // 재방문 의사 선택 기능
	    var visitBoxes = document.querySelectorAll('.visit-box');
	    visitBoxes.forEach(function(box) {
	        box.addEventListener('click', function() {
	            // 다른 박스의 선택 해제
	            visitBoxes.forEach(function(otherBox) {
	                otherBox.classList.remove('selected');
	            });
	            
	            // 현재 박스의 선택 상태를 설정
	            box.classList.add('selected');
	            document.getElementById('re_visit_input').value = box.getAttribute('data-value');
	        });
	    });
	    
	    // 재방문 의사 상태 기본설정
	    var reVisitValue = document.getElementById('re_visit_input').value;
	    if (reVisitValue) {
	        var visitBoxes = document.querySelectorAll('.visit-box');
	        visitBoxes.forEach(function(box) {
	            if (box.getAttribute('data-value') === reVisitValue) {
	                box.classList.add('selected'); // dto저장 재방문 의사 박스를 선택된 상태로 표시
	            }
	        });
	    }	    
	    
	});
	
	document.getElementById('review_form').onsubmit = function() {
	    
		
	    // 별점 유효성 검사
	    var reviewScoreSelected = document.querySelector('input[name="review_score"]:checked');
	    if (!reviewScoreSelected) {
	        alert('별점을 선택해주세요!');
	        return false; // 폼 제출 중단
	    }
		
		// 해시태그 유효성 검사
	    var hashtagsValue = document.getElementById('hashtags').value;
	    if (hashtagsValue.trim() === '') {
	        alert('최소 하나 이상의 해시태그를 선택해주세요.');
	        return false; // 폼 제출 중단
	    }

	    // 재방문 의사 유효성 검사
	    var reVisitValue = document.getElementById('re_visit_input').value;
	    if (reVisitValue !== 'Yes' && reVisitValue !== 'No') {
	        alert('재방문 의사를 선택해주세요.');
	        return false; // 폼 제출 중단
	    }

	    // 모든 검사 통과 시 폼 제출 계속
	    return true;
	};	

</script>

</body>
</html>