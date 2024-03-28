<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

function CheckForm() {
    var pw = document.getElementById('pw').value;
    var pw2 = document.getElementById('pw2').value;
    var email = document.getElementById('email').value;
    var gender = document.querySelector('input[name="gender"]:checked');
    var age = document.getElementById('age').value;

    // 비밀번호는 변경을 원하지 않는 경우 비워두기
    // 비밀번호 필드 검증 제외
    if (!email || !gender || age === "") {
        alert('필수 정보를 모두 입력해주세요.');
        return false;
    }

    // 비밀번호 변경을 원하는 경우 비밀번호 패턴 검사진행
    if (pw && pw2) {
        
        var pwPattern = /^[a-zA-Z0-9]{6,20}$/;
        if (!pwPattern.test(pw)) {
            alert("비밀번호는 영문, 숫자를 포함해 6자~20자 사이여야 합니다.");
            return false;
        }


        if (pw !== pw2) {
            alert('비밀번호가 일치하지 않습니다.');
            return false;
        }
    }

    return true;
}



</script>
</head>
<body>

 <form action="infomodi_save" method="post" name="member_save_form" onsubmit="return CheckForm()">
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
                    <input type="password" name="pw" id="pw" placeholder="영어 소문자와 숫자를 포함해 6-20자" required>
                </td>
            </tr>
            <tr>
                <th>변경된 비밀번호확인</th>
                <td>
                    <input type="password" id="pw2" placeholder="비밀번호 확인" required>
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
                    <input type="email" id="email" value="${info.email}" required>
                </td>
            </tr>
            <tr>
                <th>성별</th>
                <td>
                    <input type="radio" name="gender" value="male" ${info.gender == 'male' ? 'checked' : ''} required> 남성
                    <input type="radio" name="gender" value="female" ${info.gender == 'female' ? 'checked' : ''} required> 여성
                    <input type="radio" name="gender" value="other" ${info.gender == 'other' ? 'checked' : '' }required> 밝히고 싶지 않음(기타)
                </td>
            </tr>
            <tr>
                <th>연령대</th>
                <td>
                    <select id="age" required>
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
	            	<input type="submit" value="회원정보수정">
	            	<a href="main">
	            		<input type="button" value="수정취소">
	            	</a>
            	</td>
            </tr>
        </table>
    </form>


</body>
</html>