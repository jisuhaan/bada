<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>바라는 바다! :: 문의 수정</title>
<link href="${pageContext.request.contextPath}/resources/css/inquire_input.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    $(document).ready(function() {
        // 페이지 로드 시 비밀글 여부에 따라 비밀번호 입력란 보이기/숨기기 처리
        if ($("input[name='secret']:checked").val() === 'y') {
            $("#secret_pw").prop("required", true).show();
        } else {
            $("#secret_pw").prop("required", false).hide();
        }

        // 비밀글 여부 라디오 버튼 클릭에 따른 처리
        $("input[name='secret']").change(function() {
            if ($(this).val() === 'y') {
                $("#secret_pw").prop("required", true).show(); // 비밀글 선택 시 비밀번호 입력란 보이고, 필수로 설정
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
<c:when test="${loginid == dto.name ||position == 'admin'}">

<form id="inquire_modify_form" action="inquire_modify_save" method="post" enctype="multipart/form-data">
		
	<div class="container">
		
	<div class="inquire_container">
	
		<div id="inquire_title">문의 수정하기</div>
		
		<div class="listbox titles">
			<div id="list_title">제목</div>
			<div id="list_contents">
				<input type="text" name="title" id="title" value="[${dto.title}] 수정글" readonly="readonly">
				<input type="hidden" name="inquire_num" id="inquire_num" value="${dto.inquire_num}">
			</div>
		</div>
		<hr>
		<div class="listboxout line2">
			<div class="listbox categories">
				<div id="list_title">카테고리</div>
					<select name="category" id="category" required="required">
						<optgroup label="문의사항">
						<option value="계정 정보 문의" <c:if test="${dto.category eq '계정 정보 문의'}">selected</c:if>>계정 정보 문의</option>
						<option value="바다 정보 문의" <c:if test="${dto.category eq '바다 정보 문의'}">selected</c:if>>바다 정보 문의</option>
						<option value="홈페이지 기능 문의" <c:if test="${dto.category eq '홈페이지 기능 문의'}">selected</c:if>>홈페이지 기능 문의</option>
						<option value="기타 문의" <c:if test="${dto.category eq '기타 문의'}">selected</c:if>>기타 문의</option>
						</optgroup>
						<optgroup label="바다 추천">
						<option value="새로운 바다 추천" <c:if test="${dto.category eq '새로운 바다 추천'}">selected</c:if>>새로운 바다 추천</option>
						</optgroup>
					</select>
				</div>

			<div class="listbox writer">
				<div id="list_title">문의 작성자</div>
				<div id="list_contents"><input type="text" name="name" id="name" value="${dto.name}" readonly="readonly">
				<input type="hidden" name="id" id="id" value="${dto.id}" >
			</div>
			</div>
		</div>
		
		<hr>
		
		<div class="listbox secret">
			<div id="list_title">비밀글 여부</div>
			<div id="list_select">
		        <input type="radio" name="secret" value="n" id="n" <c:if test="${dto.secret eq 'n'}">checked</c:if>> 공개문의
		        <input type="radio" name="secret" value="y" id="y" <c:if test="${dto.secret eq 'y'}">checked</c:if>> 비밀문의
		    </div>
		</div>
		<div id="list_contents"><input type="text" name="secret_pw" id="secret_pw"
		<c:if test="${dto.secret eq 'y'}"> value="${dto.secret_pw}" </c:if>
		style="display: none;"></div>
		<div class="listbox secret2">
			<div class="list_infomation">
			<h6>'비밀 문의'를 선택하면 답변 확인 시 사용하는 <br>
			본인확인 용 비밀번호(숫자 4자리)를 입력하는 창이 나타납니다.</h6>
			</div>
		</div>
		
		<hr>

		<div class="listbox contents">
			<div id="list_title">문의 내용</div>
			<textarea cols="50" rows="7" name="content" id="content" required >${dto.content}</textarea>
		</div>	
			
		<div class="listbox addphoto">
			<div class="pic_add">
				<div id="list_title">사진(최대 5장)</div>		
				<div id="photo_input">
					<div id="existing_photos">
						<c:forEach items="${photoList}" var="p">
						<c:if test="${p ne 'nope'}">
						<div class="image-wrap" id="image-wrap-${p}" style="display: inline-block; margin: 10px 10px;">
						<img src="${pageContext.request.contextPath}/resources/image_user/${p}" width="60px" height="60px">
						</div>
						</c:if>
						</c:forEach>
					</div>
					<div class="photofiles"> 
					<input type="file" name="pic1" id="pic1" class="btn">
					<div id="pic_pack"></div>
					</div>
					<button type="button" onclick="addPicField()" class="btn"> + </button>
				</div>
			</div>
		</div>

		<div class="list_buttons">
			<input type="submit" value="작성하기" class="btn2">
			<input type="button" value="돌아가기" class="btn2" onclick="history.go(-1)">
		</div>	

	</div>
	</div>
</form>


<script>
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
	    newField.innerHTML = '<input type="file" name="pic' + PicCount + '" id="pic' + PicCount + '"class="btn">';
	
	    // 위에서 추가한 것을 보이도록 해서 pic_pack에 추가
	    document.getElementById('pic_pack').appendChild(newField);
	    
	}
</script>

	</c:when>
	<c:otherwise>
	
		<script>
			window.onload = function() {
			    alert("자신의 글만 수정할 수 있습니다!");
			    window.location.href = "${pageContext.request.contextPath}/login";
			};
	    </script>
	    
	</c:otherwise>
</c:choose>

</body>
</html>