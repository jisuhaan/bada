<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>

<html>

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta charset="UTF-8">
	<title>바라는 바다! :: 1:1 문의 작성</title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
        	$("#InquirePersonalForm").submit(function(event) {
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
	<form id="InquirePersonalForm" action="inquire_personal_save" method="post" enctype="multipart/form-data">
		<table align="center">
		
		<caption>1:1 문의 작성창</caption>
		
			<tr>
				<th>제목 &nbsp;&nbsp;</th>
				<td><input type="text" name="title" id="title" required="required" placeholder="제목을 입력하세요."></td>
			</tr>
			<tr>
				<th>문의 작성자</th>
				<c:choose>
					<c:when test="${loginstate==true}">
				<td>
					<input type="text" name="name" id="name" value="${dto.name}" readonly="readonly">
					<input type="hidden" name="id" id="id" value="${dto.id}">
				</td>
				</c:when>
				<c:otherwise>
				<td>
					<input type="text" name="name" id="name" placeholder="임시 닉네임을 입력해주세요." required="required">
					<input type="hidden" name="id" id="id" value="nope">
				</td>
				</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<th>이메일 주소</th>
				<c:choose>
					<c:when test="${loginstate==true}">
				<td>
					<input type="text" name="email" id="email" value="${dto.email}" required="required">
					<br><h6>답을 수신 받고자 하는 이메일 주소를 입력해주세요. <br>
					해당 이메일로 1:1 문의에 대한 답이 전송됩니다.</h6>
				</td>
				</c:when>
				<c:otherwise>
				<td>
					<input type="text" name="email" id="email" placeholder="이메일을 입력해주세요." required="required">
					<br><h6>답을 수신 받고자 하는 이메일 주소를 입력해주세요. <br>
					해당 이메일로 1:1 문의에 대한 답이 전송됩니다.</h6>
				</td>
				</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>
					<select name="category" id="category" required="required">
							<option value="계정 정보 문의">계정 정보 문의</option>
							<option value="바다 정보 문의">바다 정보 문의</option>
							<option value="홈페이지 기능 문의">홈페이지 기능 문의</option>
							<option value="기타 문의">기타 문의</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>문의 내용</th>
				<td>
					<textarea cols="50" rows="7" name="content" id="content" placeholder="문의 내용은 1500자 이하로 입력하세요." required></textarea>
				</td>
			</tr>
			<tr>
                <th>사진 첨부(최대 5장)</th>
                <td id="pic_pack">
                    <input type="file" name="pic1" id="pic1">
                    <button type="button" onclick="addPicField()"> + </button>
                </td>
            </tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="전송">
					<a href="main">
						<input type="button" value="입력 취소">
					</a>
				</td>
			</tr>
		</table>
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
	        var newField = document.createElement('div');
	        newField.innerHTML = '<input type="file" name="pic' + PicCount + '" id="pic' + PicCount + '">';
	
	        // 위에서 추가한 것을 보이도록 해서 pic_pack에 추가시키기
	        document.getElementById('pic_pack').appendChild(newField);
	    }
	</script>
	
	
</body>



</html>