<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/member_modify.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	var originalEmail = '${info.email}';
	var email_check = true;
	
	$('#email').change(function() {
		
		var email = $('#email').val();
		if(email !== originalEmail){
			email_check = false;
		}
		
	});
	
    $("#emailcheck").click(function() {
        email = $('#email').val();
        if (email === originalEmail) {
            alert('이메일 변경이 없습니다.');
            email_check = true;
        } else {
            $.ajax({
                type: "POST",
                url: "emailcheck",
                dataType: "text",
                data: {"email": email},
                success: function(result) {
                    if (result === "nope") {
                        alert('이미 등록된 이메일입니다.');
                        email_check = false;
                    } else {
                        alert('사용 가능한 이메일입니다.');
                        email_check = true;
                    }
                },
                error: function() {
                    alert('이메일 중복 검사 중 오류가 발생했습니다.');
                    email_check = false;
                }
            });
        }
    });
	
	
    $("#submitBtn").click(function (e) {
        e.preventDefault();
        
        if(!email_check) {
        	alert('이메일 중복확인이 필요합니다.');
        	return false;
        }
        
        if(allinfo_check()){
        	confirm_Pw();
        }

    });
    
    
   function allinfo_check() {
	   
       var pw = document.getElementById('pw').value;
       var pw2 = document.getElementById('pw2').value;
       var email = $('#email').val();
       var gender = document.querySelector('input[name="gender"]:checked');
       var age = document.getElementById('age').value;

       if (!email || !gender || age === "") {
           alert('필수 정보를 모두 입력해주세요.');
           return false;
       }

       if (pw && pw2 !== null) {
           var pwPattern = /^[a-zA-Z0-9]{6,20}$/;
           if (!pwPattern.test(pw)) {
               alert("비밀번호는 영문, 숫자를 포함해 6자~20자 사이여야 합니다.");
               $('#pw').focus();
               return false;
           }

           if (pw !== pw2) {
               alert('비밀번호가 일치하지 않습니다.');
               $('#pw2').focus();
               return false;
           }
       }

       var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
       if (!emailPattern.test(email)) {
           alert("올바른 이메일 형식이 아닙니다.");
           $('#email').focus();
           return false;
       }
       
       return true;
   }
       

    window.confirm_Pw = function() {
        var password = prompt("본인 확인을 위해 비밀번호를 입력해주세요.");
        if (password !== null && password !== "") {
            $.ajax({
                type: "POST",
                url: "checkPassword",
                data: {
                    "password": password
                },
                success: function(result) {
                    if(result == "yes") {
                        document.forms["modify_form"].submit();
                    } else {
                        alert("비밀번호가 일치하지 않습니다.");
                    }
                },
                error: function() {
                    alert("비밀번호 확인 중 오류가 발생했습니다.");
                }
            });
        } else {
            alert("비밀번호를 입력해주세요.");
        }
    };
});

</script>
<script>console.log("${info.gender}");</script>
</head>
<body>

<div class="memberform">

	<form action="infomodi_save" method="post" name="modify_form" onsubmit="return CheckForm()">
			
	<div class="form_text">
	회원정보 수정
	</div>
	<br><hr><br>
		<div class="form_title">&nbsp;아이디</div>
		<div class="join_input">
		<input type="text" name="id" id="id" value="${info.id}" readonly>
		</div>
		<br>
		<div class="form_title">&nbsp;비밀번호</div>
		<div class="join_input">
		<input type="password" name="pw" value="${info.pw}" id="pw" placeholder="영어 소문자와 숫자를 포함해 6-20자" required>
		<input type="hidden" name="original_pw" value="${info.pw}">
		</div>
		<br>
		 <div class="form_title">&nbsp;비밀번호 확인</div>
		<div class="join_input">
		<input type="password" id="pw2" placeholder="비밀번호를 한 번 더 써주세요." required>
		</div>
		<br>
		 <div class="form_title">&nbsp;닉네임</div>
		<div class="join_input">
		<input type="text" id="name" name="name" value="${info.name}" placeholder="이름을 입력해주세요." required>
		</div>
		<br>
		 <div class="form_title">&nbsp;이메일</div>
		<div class="join_input">
		<input type="text" id="email" name="email" value="${info.email}" placeholder="이메일을 ----@--.- 형식으로 입력해주세요." required>
		<input type="button" value="중복 확인" id="emailcheck" class="btn_1">
		</div>
		<br>
		<div class="join_radio">
		<div class="form_title">&nbsp;성별</div>
		<label for="male" class="radio_btn">
		<input type="radio" name="gender" value="male" id="male" ${info.gender.equals("male") ? "checked" : ""}>
		<span class="on"></span>
		남성
		</label>
		<label for="female" class="radio_btn">
		<input type="radio" name="gender" value="female" id="female" ${info.gender.equals("female") ? "checked" : ""}>
		<span class="on"></span>
		여성
		</label>
		<label for="other" class="radio_btn">
		<input type="radio" name="gender" value="other" id="other" ${info.gender.equals("other") ? "checked" : ""}>
		<span class="on"></span>
		기타(밝히고 싶지 않음 외)
		</label>
		</div>
		<br>
		<div class="form_title">&nbsp;연령대</div>
		<div class="join_select">
		<select id="age" name="age" required>
		<option value="">나이대를 선택해주세요.</option>
		<option value="10" ${info.age == '10' ? 'selected' : ''}>10대 이하</option>
		<option value="20" ${info.age == '20' ? 'selected' : ''}>20대</option>
		<option value="30" ${info.age == '30' ? 'selected' : ''}>30대</option>
		<option value="40" ${info.age == '40' ? 'selected' : ''}>40대</option>
		<option value="50" ${info.age == '50' ? 'selected' : ''}>50대</option>
		<option value="60" ${info.age == '60' ? 'selected' : ''}>60대 이상</option>
		</select>
		</div>
	<br><hr><br>
	<div class="submit_btns">
	<button id="submitBtn" class="btn_2"><span id="btn_text">수정하기</span></button>
	<button onclick="location.href='member_out'"class="btn_2 backbtn"><span id="btn_text">돌아가기</span></button>
	</div>
	</form>
</div>

</body>
</html>