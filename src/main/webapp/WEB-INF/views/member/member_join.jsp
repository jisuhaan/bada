<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html>

<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta charset="UTF-8">
	<title>바라는 바다! :: 회원가입</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {
        $("#idcheck").click(function () {
            var id = $("#id").val();
            
         	// 아이디가 비어 있을 때 아이디 중복 검사를 할 경우
            if (id.trim() === "") {
                alert("아이디를 입력해주세요.");
                return;
            }

            $.ajax({
                type: "post",
                async: true,
                dataType: "text",
                url: "idcheck",
                data: {"id": id},
                success: function (result) {
                    if (result == "ok") {
                        alert("사용 가능한 아이디입니다.");
                    } 
                    else {
                        alert("중복된 아이디입니다.");
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
		            url: "member_save",
		            data: {
		                id: id,
		                pw: pw,
		                name: name,
		                email: email,
		                gender: gender,
		                age: age
		            },
		            success: function (response) {
		                // 저장이 성공적으로 이루어졌을 때 알럿창을 띄움
		            	alert("회원가입이 완료되었습니다.");
		            	var result = confirm('바다성향테스트(BBTI) 페이지로 이동합니다!');
		            	if(result){
		            		window.location.href='member_try_bbti';
		            	}
		            	else{
		            		alert('메인화면으로 이동합니다.');
		            		window.location.href='main';
		            	}
		            },
		            error: function () {
		                alert("오류가 발생했습니다.");
		            }
		        });
		
		    });
		});
    </script>
</head>



<body>

    <form action="member_save" method="post" name="member_save_form">
        <table>
            <caption>회원가입창</caption>

            <tr>
                <th>아이디</th>
                <td>
                    <input type="text" name="id" id="id" placeholder="영어 소문자와 숫자를 포함해 6-20자" required>
                    <input type="button" value="중복 확인" id="idcheck">
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>
                    <input type="password" name="pw" id="pw" placeholder="영어 소문자와 숫자를 포함해 6-20자" required>
                </td>
            </tr>
            <tr>
                <th>비밀번호 확인</th>
                <td>
                    <input type="password" id="pw2" placeholder="비밀번호를 한 번 더 써주세요." required>
                </td>
            </tr>
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" id="name" placeholder="이름을 입력해주세요." required>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>
                    <input type="email" id="email" placeholder="이메일을 ----@--.- 형식으로 입력해주세요." required>
                </td>
            </tr>
            <tr>
                <th>성별</th>
                <td>
                    <input type="radio" name="gender" value="male" required> 남성
                    <input type="radio" name="gender" value="female" required> 여성
                    <input type="radio" name="gender" value="other" required> 밝히고 싶지 않음(기타)
                </td>
            </tr>
            <tr>
                <th>연령대</th>
                <td>
                    <select id="age" required>
                        <option value="">나이대를 선택해주세요.</option>
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
	            	<input type="button" value="회원가입하기" id="submitBtn">
	            	<a href="main">
	            		<input type="button" value="회원가입 취소">
	            	</a>
            	</td>
            </tr>
        </table>
    </form>

</body>

</html>