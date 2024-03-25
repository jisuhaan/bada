<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<!DOCTYPE html>

<html>

<head>
	
	<style>
        table {
            margin: 0 auto;
        }
        th, td {
            text-align: center;
        }
    </style>
    
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>



<body>
	
	<form action="member_search" method="post">
		<table border="1" width="80%" align="center">
			<caption>회원 정보 검색창</caption>
			
			<tr>
				<th>검색 항목</th>
				<td>
					<select name="search_keyword">
						<option value="user_number">회원 번호</option>
						<option value="id">회원 아이디</option>
						<option value="name">회원 성명</option>
					</select>
					<input type="text" name="search_value">
				</td>
			</tr>
			<tr>
				<th>회원 성별</th>
				<td>
					<select name="gender">
						<option value="">선택 안 함</option>
						<option value="male">남성</option>
						<option value="female">여성</option>
						<option value="other">밝히고 싶지 않음(기타)</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>회원 나이대</th>
				<td>
					<select name="age">
						<option value="0">선택 안 함</option>
						<option value="10">10대 이하</option>
						<option value="20">20대</option>
						<option value="30">30대</option>
						<option value="40">40대</option>
						<option value="50">50대</option>
						<option value="60">60대 이상</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="검색">
				</td>
			</tr>
		</table>
	</form>
	
</body>



</html>