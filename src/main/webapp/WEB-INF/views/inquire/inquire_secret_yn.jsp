<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inquire Secret</title>
    <style>
        /* 모달 스타일 */
        .modal {
            display: none; /* 기본적으로 숨김 */
            position: fixed; /* 고정 위치 */
            z-index: 1; /* 위로 올림 */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto; /* 스크롤 가능하도록 */
            background-color: rgba(0, 0, 0, 0.4); /* 배경 어둡게 */
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 화면 중앙 정렬 */
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px;
            text-align: center;
        }
    </style>
</head>
<body>

<!-- 비밀번호 입력 모달 -->
<div id="passwordModal" class="modal">
    <div class="modal-content">
        <h2>비밀번호를 입력하세요</h2>
        <input type="password" id="passwordInput">
        <br><br>
        <button onclick="checkPassword()">확인</button>
    </div>
</div>

<script>
    // 모달 열기
    function openModal() {
        document.getElementById('passwordModal').style.display = 'block';
    }

    // 모달 닫기
    function closeModal() {
        document.getElementById('passwordModal').style.display = 'none';
    }

    // 비밀번호 확인
    function checkPassword() {
        var password = document.getElementById('passwordInput').value;

        // 비밀번호 검증 예시
        var correctPassword = "${dto.secret_pw}"; // 비밀번호는 dto에서 가져옴

        if (password === correctPassword) {
            // 비밀번호가 맞으면 페이지로 이동
            window.location.href = "to_inquire_detail?inquire_num=${dto.inquire_num}";
        } else {
            // 비밀번호가 틀리면 오류 메시지 출력 후 모달 유지
            alert("비밀번호가 맞지 않습니다.");
        }
    }

    // 페이지 로드 시 모달 열기
    window.onload = openModal;
</script>

</body>
</html>
