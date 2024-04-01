<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta charset="UTF-8">
	<title>바라는 바다! :: 관리자 권한 회원 정보 수정</title>
	<link href="${pageContext.request.contextPath}/resources/css/member_modify.css" rel="stylesheet" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {
        
	        $("#emailcheck").click(function () {
	            var email = $("#email").val();
	            
	         	// 이메일이 비어 있을 때 이메일 중복 검사를 할 경우
	            if (email.trim() === "") {
	                alert("이메일을 입력해주세요.");
	                return;
	            }
	
	            $.ajax({
	                type: "post",
	                async: true,
	                dataType: "text",
	                url: "emailcheck",
	                data: {"email": email},
	                success: function (result) {
	                    if (result == "ok") {
	                        alert("사용 가능한 이메일입니다.");
	                    } 
	                    else {
	                        alert("이미 가입된 이메일입니다.");
	                    }
	                },
	                error: function () {
	                    alert("오류가 발생했습니다.");
	                }
	            });
	        });
        

		    $("#submitBtn").click(function () {
		        var id = $("#id").val();
		        var pw = $("#pw").val();
		        var pw2 = $("#pw2").val();
		        var name = $("#name").val();
		        var email = $("#email").val();
		        var gender = $("input[name='gender']:checked").val();
		        var age = $("#age").val();
				var user_number = $("#user_number").val();
				
				var admin_pw=prompt("관리자 비밀번호를 입력해주세요."); //모든 조건 통과 시 전송 전에 관리자 비밀번호 한 번 더 확인
				
				if(admin_pw.trim() === "") {
	                alert("관리자 비밀번호를 공란으로 둘 수 없습니다.");
	                return;
	            } //관리자 비밀번호를 공란으로 제출한 경우
				
		        // 아이디 유효성 검사
		        var idPattern = /^[a-zA-Z0-9]{6,20}$/;
		        
		        if(!idPattern.test(id)) {
		            alert("아이디는 영문, 숫자를 포함해 6자~20자 사이여야 합니다.");
		            return false;
		        }
		
		        // 패스워드 유효성 검사
		        var pwPattern = /^[a-zA-Z0-9]{6,20}$/;
		        if (!pwPattern.test(pw)) {
		            alert("비밀번호는 영문, 숫자를 포함해 6자~20자 사이여야 합니다.");
		            return false;
		        }
		
		        // 패스워드 확인
		        if (pw != pw2) {
		            alert("비밀번호가 일치하지 않습니다.");
		            return false;
		        }
		        
		        // 이름 확인
		        var namePattern = /^[가-힣]{2,10}$/;
		        if(!namePattern.test(name)){
		        	alert("이름은 한글 2~10글자 이내여야 합니다.");
		        	return false;
		        }
		
		        // 이메일 유효성 검사
		        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		        if (!emailPattern.test(email)) {
		            alert("올바른 이메일 형식이 아닙니다.");
		            return false;
		        }
		        
		     	// 성별 선택 확인
		        if (!$("input[name='gender']").is(":checked")) {
		            alert("성별을 선택해주세요.");
		            return false;
		        }

		        // 연령대 선택 확인
		        if ($("#age").val() == "") {
		            alert("연령대를 선택해주세요.");
		            return false;
		        }
		
		        // 모든 조건 통과 시 폼 제출
		        $.ajax({
		            type: "post",
		            url: "member_admin_check",
		            data: {
		            	user_number : user_number,
		                id: id,
		                pw: pw,
		                name: name,
		                email: email,
		                gender: gender,
		                age: age,
		                admin_pw: admin_pw
		            },
		            dataType: "json",
	                success: function (response) {
	                    if (response.result === "ok") {
	                        alert("회원 정보 변경이 완료되었습니다.");
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

<div class="memberform">
	
	<form action="member_admin_check" method="post">
	<c:forEach items="${list}" var="li">
	<input type="hidden" name="user_number" id="user_number" value="${li.user_number}">
		
		<div class="form_text">
		회원정보 수정
		</div>
		<br><hr><br>
		<div class="form_title">&nbsp;아이디</div>
		<div class="join_input">
		<input type="text" name="id" id="id" value="${li.id}" readonly>
		</div>
		<br>
	    <div class="form_title">&nbsp;비밀번호</div>
	    <div class="join_input">
	    <input type="password" name="pw" value="${li.pw}" id="pw" placeholder="영어 소문자와 숫자를 포함해 6-20자" required>
	    </div>
	    <br>
		 <div class="form_title">&nbsp;비밀번호 확인</div>
		<div class="join_input">
		<input type="password" id="pw2" placeholder="비밀번호를 한 번 더 써주세요." required>
		</div>
		<br>
		 <div class="form_title">&nbsp;닉네임</div>
		<div class="join_input">
		<input type="text" id="name" value="${li.name}" placeholder="이름을 입력해주세요." required>
		</div>
		<br>
		 <div class="form_title">&nbsp;이메일</div>
		<div class="join_input">
		<input type="text" id="email" value="${li.email}" placeholder="이메일을 ----@--.- 형식으로 입력해주세요." required>
		<input type="button" value="중복 확인" id="emailcheck" class="btn_1">
		</div>
		<br>
		<div class="join_radio">
		<div class="form_title">&nbsp;성별</div>
		<label for="radio_male" class="radio_btn">
		<input type="radio" name="gender" value="male" id="male" <c:if test="${li.gender eq 'male'}">checked</c:if>>
		<span class="on"></span>
		남성
		</label>
		<label for="radio_female" class="radio_btn">
		<input type="radio" name="gender" value="female" id="female" <c:if test="${li.gender eq 'female'}">checked</c:if>>
		<span class="on"></span>
		여성
		</label>
		<label for="radio_other" class="radio_btn">
		<input type="radio" name="gender" value="other" id="other" <c:if test="${li.gender eq 'other'}">checked</c:if>>
		<span class="on"></span>
		기타(밝히고 싶지 않음 외)
		</label>
		</div>
		<br>
		<div class="form_title">&nbsp;연령대</div>
		<div class="join_select">
		<select id="age" required>
		    <option value="">나이대를 선택해주세요.</option>
		    <option value="10" <c:if test="${li.age eq 10}">selected</c:if>>10대 이하</option>
		    <option value="20" <c:if test="${li.age eq 20}">selected</c:if>>20대</option>
		    <option value="30" <c:if test="${li.age eq 30}">selected</c:if>>30대</option>
		    <option value="40" <c:if test="${li.age eq 40}">selected</c:if>>40대</option>
		    <option value="50" <c:if test="${li.age eq 50}">selected</c:if>>50대</option>
		    <option value="60" <c:if test="${li.age eq 60}">selected</c:if>>60대 이상</option>
		</select>
		</div>
		<br><hr><br>
		<div class="submit_btns">
		<button id="submitBtn" class="btn_2"><span id="btn_text">수정하기</span></button>
		<button onclick="location.href='member_out'"class="btn_2 backbtn"><span id="btn_text">돌아가기</span></button>
     	</div>                   	        
	    </c:forEach>
	  </form>  
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