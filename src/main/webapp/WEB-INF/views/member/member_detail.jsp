<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

	<script src="https://ajax.googleapis.com/ajax/list.s/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#memberdel").click(function(){
				
				var id = $("#id").val();
				var admin_pw=prompt("삭제 하려면 관리자 비밀번호를 입력해주세요."); //모든 조건 통과 시 전송 전에 관리자 비밀번호 한 번 더 확인
				
				if(admin_pw.trim() === "") {
	                alert("관리자 비밀번호를 공란으로 둘 수 없습니다.");
	                return;
	            } //관리자 비밀번호를 공란으로 제출한 경우
				
				// 모든 조건 통과 시 폼 제출
		        $.ajax({
		            type: "post",
		            url: "member_delete",
		            data: {
		            	id : id,
		                admin_pw: admin_pw
		            },
		            dataType: "json",
	                success: function (response) {
	                    if (response.result === "ok") {
	                        alert("회원 정보 삭제가 완료되었습니다.");
	                        window.location.href = 'member_out';
	                    } else {
	                        alert("관리자 비밀번호가 맞지 않습니다.");
	                        window.location.href = 'main';
	                    }
	                },
	                error: function () {
	                    alert("서버 오류가 발생했습니다.");
	                    window.location.href = 'member_out';
	                }
		        });
	            
			});
			
		});
	</script>

<style type="text/css">
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

container{
	margin: 0 auto;
	margin-top: 100px;
	display: flex;
	justify-content: center;
	align-items: center;
}

table {
	margin-top: 100px;
	border-collapse: collapse;
	border-spacing: 0;
	border:1px solid gray;
	width: 400px;
	background-color: #F1F1F1;
	font-family: 'Pretendard-Regular';
	font-size: 16px;
}

th {
	padding:5px;
	border-bottom: 1px solid gray;
	background-color: #B3B3B3;
}

td {
	padding:5px; 
	text-align: center;
	vertical-align: middle;
	border-bottom: 1px solid gray;
}

</style>

</head>
<body>

<c:choose>
<c:when test="${loginstate==true && position=='admin'}">

	<div class="container">
	    <table class="detail_table">
	    	<tr>
	    		<th colspan="2">회원정보</th>
	    	</tr>
	        <tr>
	        	<th>일련번호</th>
	        	<td>${list.user_number}</td> 
	        </tr>
	        <tr>
	        	<th>아이디</th>
	        	<td>
	        	${list.id}
	        	 <input type="hidden" name="id" id="id" value="${list.id}" readonly>
	        	</td> 
	        </tr>
	        <tr>
	        	<th>패스워드</th>
	        	<td>${list.pw}</td> 
	        </tr>
   	        <tr>
	        	<th>권한</th>
	        	<td>${list.role}</td> 
	        </tr>
	       	<tr>
	        	<th>닉네임</th>
	        	<td>${list.name}</td> 
	        </tr>
	       	<tr>
	        	<th>이메일</th>
	        	<td>${list.email}</td> 
	        </tr>
	       	<tr>
	        	<th>성별</th>
	        	<td>
		        	<c:choose>
						    <c:when test="${list.gender == 'male'}">남성</c:when>
						    <c:when test="${list.gender == 'female'}">여성</c:when>
						    <c:when test="${list.gender == 'other'}">밝히고 싶지 않음(기타)</c:when>
					</c:choose>
		        </td> 
	        </tr>	   
	       	<tr>
	        	<th>연령대</th>
	        	<td>
		        	<c:choose>
						    <c:when test="${list.age == 10}">10대 이하</c:when>
						    <c:when test="${list.age == 20}">20대</c:when>
						    <c:when test="${list.age == 30}">30대</c:when>
						    <c:when test="${list.age == 40}">40대</c:when>
						    <c:when test="${list.age == 50}">50대</c:when>
						    <c:when test="${list.age == 60}">60대 이상</c:when>
					</c:choose>
		        </td>
	        </tr>		
	       	<tr>
	        	<th>bbti</th>
	        	<td>
	        	<c:choose>
						    <c:when test="${empty list.bbti}">미정</c:when>
						    <c:when test="${list.bbti == 'EAF'}">EAF::해운대</c:when>
						    <c:when test="${list.bbti == 'EAN'}">EAN::양양</c:when>
						    <c:when test="${list.bbti == 'EPF'}">EPF::월미도</c:when>
						    <c:when test="${list.bbti == 'EPN'}">EPN::다대포</c:when>
						    <c:when test="${list.bbti == 'IAF'}">IAF::서귀포</c:when>
						    <c:when test="${list.bbti == 'IAN'}">IAN::제부도</c:when>
						    <c:when test="${list.bbti == 'IPF'}">IPF::여수밤바다</c:when>
						    <c:when test="${list.bbti == 'IPN'}">IPN::독도</c:when>
				</c:choose>
	        	</td>
	        </tr>	
	       	<tr>
	        	<th colspan="2" align="center">
	        		<input type="button" value="수정" class="btn" onclick="window.location.href='member_modify_view?user_number=${list.user_number}'">
	        		<input type="button" value="삭제" id="memberdel" class="btn">
	        		<input type="button" value="목록으로" class="btn" onclick="window.location.href='member_out'">
      			</th>
	        </tr>	        	                     	        
	    </table>
	</div>
    
</c:when>   
<c:otherwise>
	
		<script>
			window.onload = function() {
			    alert("관리자 외 접근할 수 없는 페이지 입니다.");
			    window.location.href = "${pageContext.request.contextPath}/main";
			};
	    </script>
	    
</c:otherwise>
</c:choose>
</body>
</html>