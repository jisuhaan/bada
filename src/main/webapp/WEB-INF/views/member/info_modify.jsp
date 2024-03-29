<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#submitBtn").click(function (e) {
        e.preventDefault(); 
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

        var originalEmail = '${info.email}';
        if (email !== originalEmail) {
            $.ajax({
                type: "POST",
                url: "emailcheck",
                dataType:"text",
                data:{"email":email},
                success: function(result) {
                    if (result =="nope") {
                        alert('이미 등록된 이메일입니다.');
                    } else {
                        confirm_Pw();
                    }
                },
                error: function() {
                    alert('이메일 중복 검사 중 오류가 발생했습니다.');
                }
            });
        } else {
            
            confirm_Pw();
        }
    });

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

 <form action="infomodi_save" method="post" name="modify_form" onsubmit="return CheckForm()">
        <table>
            <caption>회원정보 수정</caption>

            <tr>
                <th>아이디</th>
                <td>
                    <input type="text" name="id" id="id" value="${info.id}" readonly>
                </td>
            </tr>
            <tr>
                <th>비밀번호 변경</th>
                <td>
                    <input type="password" name="pw" id="pw" placeholder="영어 소문자,숫자 포함 6-20자">
                </td>
            </tr>
            <tr>
                <th>변경된 비밀번호확인</th>
                <td>
                    <input type="password" name="pw2" id="pw2" placeholder="비밀번호 확인">
                </td>
            </tr>
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" id="name" value="${info.name }" readonly>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>
                    <input type="email" id="email" name="email" value="${info.email}" required>
                </td>
            </tr>
            <tr>
                <th>성별</th>
                <td>
                    <input type="radio" name="gender" value="male" ${info.gender.equals("male") ? "checked" : ""} required> 남성
                    <input type="radio" name="gender" value="female" ${info.gender.equals("female") ? "checked" : ""} required> 여성
                    <input type="radio" name="gender" value="other" ${info.gender.equals("other") ? "checked" : ""} required> 밝히고 싶지 않음(기타)
                </td>
            </tr>
            <tr>
                <th>연령대</th>
                <td>
                    <select id="age" name="age" required>
                        <option value="">나이대를 선택해주세요.</option>
                        <option value="10" ${info.age == '10' ? 'selected' : ''}>10대 이하</option>
                        <option value="20" ${info.age == '20' ? 'selected' : ''}>20대</option>
                        <option value="30" ${info.age == '30' ? 'selected' : ''}>30대</option>
                        <option value="40" ${info.age == '40' ? 'selected' : ''}>40대</option>
                        <option value="50" ${info.age == '50' ? 'selected' : ''}>50대</option>
                        <option value="60" ${info.age == '60' ? 'selected' : ''}>60대 이상</option>
                    </select>
                </td>
            </tr>
            
            <tr>
               <td colspan="2" align="center">
                  <input type="button" value="회원정보수정" id="submitBtn"  >
                  <a href="main">
                     <input type="button" value="수정취소">
                  </a>
               </td>
            </tr>
        </table>
    </form>


</body>
</html>