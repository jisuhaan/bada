<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.hashtag-box {
	    border: 1px solid #ccc;
	    display: inline-block;
	    padding: 5px 10px;
	    margin: 5px;
	    cursor: pointer;
	}
	
	.hashtag-box.selected {
	    background-color: #007bff;
	    color: white;
	    border-color: #007bff;
	}
	
	.visit-box {
	    border: 2px solid #ccc;
	    display: inline-block;
	    padding: 10px 20px;
	    margin: 5px;
	    cursor: pointer;
	    transition: background-color 0.3s, color 0.3s;
	}
	
	.visit-box.selected {
	    background-color: #007bff;
	    color: white;
	    border-color: #007bff;
	}	
	
	fieldset{
	    display: inline-block;
	    direction: rtl;
	    border:0;
	}
	fieldset legend{
	    text-align: right;
	}
	input[type=radio]{
	    display: none;
	}
	label{
	    font-size: 1.5em;
	    color: transparent;
	    text-shadow: 0 0 0 #9c9c9c;
	}
	label:hover,
		#star input[type=radio]:hover ~ label,
		#star input[type=radio]:checked ~ label{
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	
	
	input[type=radio]:checked + label {
	   text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	
	#star label:hover ~ label,
	#star input[type=radio]:checked + label ~ label {
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}

	.insert {
	    display: block;
	    width: 600px;
	    height: 10vh;
	    border: 1px solid #dbdbdb;
	    -webkit-box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    box-sizing: border-box;
	}
	.insert .file-list {
	    height: 50px;
	    overflow: auto;
	    border: 1px solid #989898;
	   
	}
	.insert .file-list .filebox p {
	    font-size: 14px;
	    margin-top: 10px;
	    display: inline-block;
	}
	.insert .file-list .filebox .delete i{
	    color: #ff5353;
	    margin-left: 5px;
	}
	
	.file-list {
    display: flex;
    gap: 10px; /* 파일 목록 사이의 간격 */
	}

	.filebox .name:hover {
	    text-decoration: underline; /* 마우스 오버 시 밑줄 */
	}
</style>
</head>
<body>

	<form id="review_form" action="review_save" method="post" enctype="multipart/form-data">
		<table align="center">
		<caption>바다후기 게시글 입력</caption>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="name" id="name" value="${dto.name}" readonly="readonly">
					<input type="hidden" name="id" id="id" value="${dto.id}" >
					<input type="hidden" name="write_day" id="write_day">
				</td>
			</tr>
			
			<tr>
				<th>방문일</th>
				<td>
					<input type="date" name="visit_day">
				</td>
			</tr>
			
			<tr>
				<th>후기 바다</th>
				<td>
					<select name="beach" id="beach" required="required">
					    <c:forEach items="${beachList}" var="beach">
					        <option value="${beach.beach_code}">${beach.beach}</option>
					    </c:forEach>
					</select>    
				</td>
			</tr>
			<tr>
				<th>제목 &nbsp;&nbsp;</th>
				<td><input type="text" name="review_title" id="review_title" required="required" placeholder="제목을 입력하세요."></td>
			</tr>
			<tr>
				<th>사진첨부(최대 5장)</th>
				<td>
					<div class="insert">
      				  	<input type="file" id="gallery" name="gallery" onchange="updateFileList(this);" multiple />
        				<div class="file-list"></div>
        			</div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea cols="60" rows="30" name="review_contents" id="review_contents" placeholder="후기를 입력하세요." ></textarea>
				</td>
			</tr>
			<tr>
				<th>별점</th>
				<td>
					<fieldset id="star">
					    <input type="radio" name="review_score" value="5" id="rate1"><label for="rate1">★</label>
					    <input type="radio" name="review_score" value="4" id="rate2"><label for="rate2">★</label>
					    <input type="radio" name="review_score" value="3" id="rate3"><label for="rate3">★</label>
					    <input type="radio" name="review_score" value="2" id="rate4"><label for="rate4">★</label>
					    <input type="radio" name="review_score" value="1" id="rate5"><label for="rate5">★</label>
					</fieldset>
			    </td>
			</tr>
			<tr>
                <th>해시태그</th>
                <input type="hidden" name="hashtags" id="hashtags" value="">
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
	                <input type="hidden" name="re_visit" id="re_visit_input">
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

document.addEventListener('DOMContentLoaded', function () {
    var fileInput = document.getElementById('gallery');
    var fileListContainer = document.querySelector('.file-list');
    
    // 파일을 추가하는 함수
    function updateFileList() {
        fileListContainer.innerHTML = ''; // 목록 초기화
        var files = fileInput.files;
        
        // 파일 수 확인
        if (files.length > 5) {
            alert('최대 5개의 파일만 업로드할 수 있습니다.');
            fileInput.value = '';
            return;
        }
        
        // 파일 목록을 HTML에 추가
        for (var i = 0; i < files.length; i++) {
            (function (file) {
                var fileDiv = document.createElement('div');
                fileDiv.classList.add('filebox');
                
                var fileNameSpan = document.createElement('span');
                fileNameSpan.classList.add('name');
                fileNameSpan.textContent = file.name;
                
                var deleteButton = document.createElement('button');
                deleteButton.textContent = '삭제';
                deleteButton.type = 'button';
                deleteButton.onclick = function () {
                    // 파일 삭제 로직
                    // 해당 파일을 input에서 제거하고 목록을 업데이트합니다.
                    var newFileList = Array.from(files).filter(function (f) {
                        return f !== file;
                    });
                    fileInput.files = createFileList(newFileList);
                    updateFileList();
                };
                
                fileDiv.appendChild(fileNameSpan);
                fileDiv.appendChild(deleteButton);
                fileListContainer.appendChild(fileDiv);
            })(files[i]);
        }
    }
    
    // DataTransfer 객체를 사용하여 파일 목록을 생성하는 함수
    function createFileList(files) {
        var dataTransfer = new DataTransfer();
        files.forEach(function (file) {
            dataTransfer.items.add(file);
        });
        return dataTransfer.files;
    }
    
    fileInput.addEventListener('change', updateFileList);
});
	

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
	});

</script>

</body>
</html>