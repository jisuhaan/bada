<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/member_search.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>바라는 바다! :: 검색창</title>

<script>
    function setFormattedDate() {
        var dateInput = document.getElementsByName('i_date')[0];
        var selectedDate = dateInput.value;
        if (selectedDate === "") {
            dateInput.value = ""; // 날짜를 선택하지 않는 경우
        } else {
            var date = new Date(selectedDate);
            var formattedDate = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
            dateInput.value = formattedDate; // Set formatted date (yyyy-MM-dd)
        }
    }
</script>

</head>

<body>

<!-- 아마 div나 span 이름이 내용이랑 안 맞을 텐데 나중에 css 적용하실 때 편하시라고 이전의 member_search 그대로 가져다 썼어요 -->
	
<div class="search_form">
<form action="inquire_search" method="post" name="searchform">
	<div class="search_logo">
	</div>
	<br>
	<div class="search_contents">
	<div class="search_select">
	<span class="search_title">검색어</span>
	
	<select name="search_keyword">
		<option value="">선택 안 함</option>
		<option value="name">회원 닉네임</option>
		<option value="title">문의글 제목</option>
		<option value="content">문의 내용</option>
	</select>
	</div>
	<input type="text" name="search_value">
	
	<div class="search_select">
	<span class="search_title">문의 카테고리</span>
	
	<select name="category">
		<optgroup label="문의사항">
			<option value="">선택 안 함</option>
			<option value="계정 정보 문의">계정 정보 문의</option>
			<option value="바다 정보 문의">바다 정보 문의</option>
			<option value="홈페이지 기능 문의">홈페이지 기능 문의</option>
			<option value="기타 문의">기타 문의</option>
		</optgroup>
		<optgroup label="바다 추천">
			<option value="새로운 바다 추천">새로운 바다 추천</option>
		</optgroup>
	</select>
	
	<br>
		
	<span class="search_title">작성일자</span>
	
	<input type="date" name="i_date" onchange="setFormattedDate()">
	</div>
	<br>
	<div class="buttons">
	<button class="btn_2" onclick="document.forms['searchform'].submit();">
	
	<span id="btn_text">검색하기</span>
	</button>
	</div>
	</div>
	
</form>
</div>
</body>



</html>