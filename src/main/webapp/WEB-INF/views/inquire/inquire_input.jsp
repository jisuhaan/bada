<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>

<html>

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta charset="UTF-8">
	<title>바라는 바다! :: 문의 작성</title>
    <link href="${pageContext.request.contextPath}/resources/css/inquire_input.css" rel="stylesheet" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // 초기화면에선 비밀번호 입력란을 숨김
            $("#secret_pw").hide();

            // 비밀글 여부 라디오 버튼 클릭 여부에 따라 비밀번호 창 보이고/숨기는 기능
            $("input[name='secret']").change(function() {
                if ($(this).val() === 'y') {
                    $("#secret_pw").prop("required", true).show(); // 비밀글 선택 시 비밀번호 입력란 보이고, 비밀번호 필수로 설정
                } else {
                    $("#secret_pw").prop("required", false).hide(); // 공개글 선택 시 비밀번호 입력란 숨기고 필수 해제
                }
            });
        
            $("#inquireForm").submit(function(event) {
            	// 폼 제출 시 비밀번호 유효성 검사(숫자 4자리)
                var password = $("#secret_pw").val();
                if ($("#secret_pw").is(":visible") && !(/^\d{4}$/.test(password))) {
                    alert("비밀문의 비밀번호는 숫자 4자리로 입력해주세요.");
                    event.preventDefault(); // 조건과 맞지 않으면 폼 제출 금지
                }
                //폼 제출 시 글자수(1500자) 제한 유효성 검사
                var contentLength = $("#content").val().length;
                if (contentLength > 1500) {
                    alert("문의 내용은 최대 1500자까지 입력 가능합니다.");
                    event.preventDefault();
                }
            });
            
            
        });
    </script>
    
    
</head>


<body>
	<c:choose>
	<c:when test="${loginstate==true}">
	
	<form id="inquireForm" action="inquire_save" method="post" enctype="multipart/form-data">
	
	<div class="container">
	
	<div class="inquire_container">
	
		<div id="inquire_title">문의하기</div>

		<div class="listbox titles">
			<div id="list_title">제목</div>
			<div id="list_contents"><input type="text" name="title" id="title" required="required" placeholder="제목을 입력하세요."></div>
		</div>
		<hr>
		<div class="listboxout line2">
			<div class="listbox categories">
				<div id="list_title">카테고리</div>
				<select name="category" id="category" required="required">
				<optgroup label="문의사항">
				<option value="계정 정보 문의">계정 정보 문의</option>
				<option value="바다 정보 문의">바다 정보 문의</option>
				<option value="홈페이지 기능 문의">홈페이지 기능 문의</option>
				<option value="기타 문의">기타 문의</option>
				</optgroup>
				<optgroup label="바다 추천">
				<option value="새로운 바다 추천">새로운 바다 추천</option>
				</optgroup>
				</select>
			</div>
			
			<div class="listbox writer">
				<div id="list_title">문의 작성자</div>
				<div id="list_contents"><input type="text" name="name" id="name" value="${dto.name}" readonly="readonly">
				<input type="hidden" name="id" id="id" value="${dto.id}"></div>
			</div>
		</div>
		
		<hr>
		
		<div class="listbox secret">
			<div id="list_title">비밀글 여부</div>
			<div id="list_select">
				<input type="radio" name="secret" value="n" required>공개 문의
				<input type="radio" name="secret" value="y" required>비밀 문의
			</div>
		</div>   
		<div id="list_contents"><input type="text" name="secret_pw" id="secret_pw" placeholder="문의글 비밀번호를 입력하세요." style="display: none;"></div>
		<div class="listbox secret2">
			<div class="list_infomation">
			<h6>'비밀 문의'를 선택하면 답변 확인 시 사용하는 <br>
			본인확인 용 비밀번호(숫자 4자리)를 입력하는 창이 나타납니다.</h6>
			</div>
		</div>
			
		<hr>
		
		<div class="listbox contents">
			<div id="list_title">문의 내용</div>
			<textarea cols="50" rows="7" name="content" id="content" placeholder="문의 내용은 1500자 이하로 입력하세요." required></textarea>
		</div>	
		
		<hr>
		
		<div class="listbox addphoto">
			<div class="pic_add">
			<div id="list_title">사진 첨부(최대 5장)</div>		
			<input type="file" name="pic1" id="pic1" class="btn">
			<button type="button" onclick="addPicField()" class="btn"> + </button>
			</div>
			<div id="pic_pack"></div>
		</div>		           
		       
	</div>
		
		<div class="list_buttons">
			<input type="submit" value="작성하기" class="btn">
			<input type="button" value="돌아가기" class="btn" onclick="window.location.href='main'">
		</div>		
								
	</div>
	
	</form>
	
	<script>
	    var PicCount = 1;
	    
	    function addPicField() {
	    	
	        // 이미 추가된 사진 입력 필드의 수를 세서 5개 이상이면 추가하지 않음(사진 5장까지만 첨부 가능)
	        if (PicCount >= 5) {
	            alert("사진은 최대 5장까지만 첨부할 수 있습니다.");
	            return;
	        }
	
	        PicCount++;
	
	        // 버튼을 누르면 새로운 사진 input창 생성
	        var newDiv = document.createElement("div");
	        var newField = document.createElement("input");
	        newField.type = "file";
	        newField.name = "pic" + PicCount;
	        newField.id = "pic" + PicCount;
	        newField.className = "btn";

	        // 새로운 파일 입력 필드를 pic_pack div에 추가
	        newDiv.appendChild(newField);
	        document.getElementById("pic_pack").appendChild(newDiv);
	        
	    }
	</script>
	
	</c:when>
	<c:otherwise>
	
		<script>
			window.onload = function() {
			    alert("로그인한 회원만 문의를 남길 수 있습니다.");
			    window.location.href = "${pageContext.request.contextPath}/login";
			};
	    </script>
	    
	</c:otherwise>
</c:choose>
	
	
</body>



</html>