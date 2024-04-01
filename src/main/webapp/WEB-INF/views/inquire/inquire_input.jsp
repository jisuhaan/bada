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
	<link href="${pageContext.request.contextPath}/resources/css/join.css" rel="stylesheet" type="text/css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // 비밀번호 입력란을 숨김
            $("#secret_pw").hide();

            // 비밀글 여부 라디오 버튼 클릭 시 이벤트 핸들러
            $("input[name='secret']").change(function() {
                if ($(this).val() === 'y') {
                    $("#secret_pw").prop("required", true).show(); // 비밀글 선택 시 비밀번호 입력란 보이고 필수로 설정
                } else {
                    $("#secret_pw").prop("required", false).hide(); // 공개글 선택 시 비밀번호 입력란 숨기고 필수 해제
                }
            });
        
            // 폼 제출 시 비밀번호 유효성 검사
            $("#inquireForm").submit(function(event) {
                var password = $("#secret_pw").val();
                if ($("#secret_pw").is(":visible") && !(/^\d{4}$/.test(password))) {
                    alert("비밀문의 비밀번호는 숫자 4자리로 입력해주세요.");
                    event.preventDefault(); // 폼 제출 중지
                }
            });
        });
    </script>
</head>


<body>
	<c:choose>
	<c:when test="${loginstate==true}">
	
	<form id="inquireForm" action="inquire_save" method="post" enctype="multipart/form-data">
		<table align="center">
		
		<caption>문의 작성창</caption>
		
			<tr>
				<th>제목 &nbsp;&nbsp;</th>
				<td><input type="text" name="title" id="title" required="required" placeholder="제목을 입력하세요."></td>
			</tr>
			<tr>
				<th>문의 작성자</th>
				<td>
					<input type="text" name="writer_name" id="writer_name" value="${loginname}" readonly="readonly">
					<input type="text" name="writer_id" id="writer_id" value="${loginid}" readonly="readonly">
				</td>
			</tr>
			<tr>
			    <th>비밀글 여부</th>
			    <td>
			        <input type="radio" name="secret" value="n" required>공개 문의
			        <input type="radio" name="secret" value="y" required>비밀 문의
			        <br> 비밀글일 시 비밀번호(숫자 4자리) <br>
			        <input type="text" name="secret_pw" id="secret_pw" placeholder="문의글 비밀번호를 입력하세요." style="display: none;">
			    </td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>
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
				</td>
			</tr>
			<tr>
				<th>문의 내용</th>
				<td>
					<textarea cols="50" rows="7" name="content" id="content" placeholder="문의 내용을 입력하세요."></textarea>
				</td>
			</tr>
			<tr>
				<th>사진 첨부</th>
				<td>
					<input type="file" name="pic1"> <br>
					<input type="file" name="pic2"> <br>
					<input type="file" name="pic3"> <br>
					<input type="file" name="pic4"> <br>
					<input type="file" name="pic5"> <br>
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
	
	</c:when>
	<c:otherwise>
	
		<script>
			window.onload = function() {
			    alert("로그인한 회원만 문의를 남길 수 있습니다.");
			    window.location.href = "${pageContext.request.contextPath}/main";
			};
	    </script>
	    
	</c:otherwise>
</c:choose>
	
	
</body>



</html>