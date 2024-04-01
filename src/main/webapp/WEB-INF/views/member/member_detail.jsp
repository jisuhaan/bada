<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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


</head>
<body>

<c:choose>
	<c:when test="${loginstate==true && position=='admin'}">

	<div style="text-align: center;">
		<c:forEach items="${list}" var="li">
	    <table border="1" width="600" align="center">
	        <tr>
	        	<th>일련번호</th>
	        	<td>${li.user_number}</td> 
	        </tr>
	        <tr>
	        	<th>아이디</th>
	        	<td>
	        	${li.id}
	        	 <input type="hidden" name="id" id="id" value="${li.id}" readonly>
	        	</td> 
	        </tr>
	        <tr>
	        	<th>패스워드</th>
	        	<td>${li.pw}</td> 
	        </tr>
   	        <tr>
	        	<th>권한</th>
	        	<td>${li.role}</td> 
	        </tr>
	       	<tr>
	        	<th>닉네임</th>
	        	<td>${li.name}</td> 
	        </tr>
	       	<tr>
	        	<th>이메일</th>
	        	<td>${li.email}</td> 
	        </tr>
	       	<tr>
	        	<th>성별</th>
	        	<td>
		        	<c:choose>
						    <c:when test="${li.gender == 'male'}">남성</c:when>
						    <c:when test="${li.gender == 'female'}">여성</c:when>
						    <c:when test="${li.gender == 'other'}">밝히고 싶지 않음(기타)</c:when>
					</c:choose>
		        </td> 
	        </tr>	   
	       	<tr>
	        	<th>연령대</th>
	        	<td>
		        	<c:choose>
						    <c:when test="${li.age == 10}">10대 이하</c:when>
						    <c:when test="${li.age == 20}">20대</c:when>
						    <c:when test="${li.age == 30}">30대</c:when>
						    <c:when test="${li.age == 40}">40대</c:when>
						    <c:when test="${li.age == 50}">50대</c:when>
						    <c:when test="${li.age == 60}">60대 이상</c:when>
					</c:choose>
		        </td>
	        </tr>		
	       	<tr>
	        	<th>bbti</th>
	        	<td>나중에 bbti 결과 띄우기!</td> <!-- 아직 구현 안 함 -->
	        </tr>	
	       	<tr>
	        	<td colspan="2" align="center">
	        		<input type="button" value="삭제" id="memberdel" class="btn">&nbsp;/
      	 			<button type="button" onclick="location.href='member_modify_view?user_number=${li.user_number}'">수정</button>
      			</td>
	        </tr>	        	                     	        
	    </table>
	    </c:forEach>
	</div>

    <div style="text-align: center;"><a href="member_out">목록으로</a></div>
    
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