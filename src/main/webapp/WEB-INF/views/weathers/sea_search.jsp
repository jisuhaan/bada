<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다른 날의 바다 날씨는?</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    var beach_code = 1;
</script>
<style type="text/css">
.image-cards {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.image-card {
    width: 23%; /* 가로에 4개씩 담기 위한 너비 설정 */
    margin-bottom: 20px; /* 이미지 카드 간의 간격 조절 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
    border-radius: 8px; /* 카드의 모서리를 둥글게 만듦 */
}

.image-wrapper {
    width: 100%;
    overflow: hidden;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
}

img {
    width: 100%;
    height: auto;
    display: block;
}

.title {
    padding: 10px;
    text-align: center;
    font-weight: bold;
    background-color: #f5f5f5; /* 카드의 타이틀 배경색 지정 */
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
}

</style>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        // 월 입력 요소
        var monthInput = document.getElementById("beachMonth");
        // 일 입력 요소
        var dayInput = document.getElementById("beachDay");
        // 현재 연도 가져오기
        var currentYear = new Date().getFullYear();

        // 월이 변경될 때 이벤트 처리
        monthInput.addEventListener("change", function() {
            // 선택한 월 가져오기
            var selectedMonth = parseInt(monthInput.value);
            // 선택한 월에 따라 해당 월의 일수 계산
            var daysInMonth = new Date(currentYear, selectedMonth, 0).getDate();
            // 일의 최대값을 월에 따라 변경
            dayInput.max = daysInMonth;
        });
     	
        // 달 입력 필드의 값이 변경될 때 이벤트 처리
        dayInput.addEventListener("input", function() {
            // 입력된 값이 min/max 범위를 벗어나면 수정
            if (parseInt(dayInput.value) < parseInt(dayInput.min)) {
                dayInput.value = dayInput.min;
            } else if (parseInt(dayInput.value) > parseInt(dayInput.max)) {
                dayInput.value = dayInput.max;
            }
        });
        
     	// 일자 입력 필드의 값이 변경되는 이벤트 발생 시 처리
        monthInput.addEventListener("input", function() {
            // 사용자가 입력한 값이 최대값을 초과하는지 확인
            if (parseInt(monthInput.value) > parseInt(monthInput.max)) {
                // 최대값으로 변경
                monthInput.value = monthInput.max;
            }
        });
    });
</script>
<script type="text/javascript">
    $(document).ready(function() {
        $("#searchBtn").click(function() {
            // 월 입력 요소
            var monthInput = parseInt($("#beachMonth").val());
            // 일 입력 요소
            var dayInput = parseInt($("#beachDay").val());
            // 현재 연도 가져오기
            var currentYear = new Date().getFullYear();
            
            if (isNaN(monthInput) || monthInput < 1 || monthInput > 12) {
            	alert("현재 입력한 값: "+monthInput)
                alert("월을 올바르게 입력해주세요 (1에서 12 사이).");
                return;
            }
            
            var maxDay = parseInt($("#beachDay").attr("max"));
            
            if (isNaN(dayInput) || dayInput < 1 || dayInput > maxDay) {
                alert("일을 올바르게 입력해주세요 (1에서 " + maxDay + " 사이).");
                return;
            }
            
            getWthrDataList(monthInput, dayInput, currentYear, beach_code);
            alert("검색 버튼이 클릭되었습니다.");
        });
    });
</script>
</head>
<body>
    <h1>다른 날의 바다 날씨는?</h1>
    <div>
        <input type="number" id="beachMonth" name="beachMonth" min="1" max="12">월 
        <input type="number" id="beachDay" name="beachDay" min="1" max="31">일
        <button id="searchBtn">검색</button>
    </div>
    <div id="weather-info" style="margin-top: 20px;"></div>
    <div id="weather-info2" style="margin-top: 20px;"></div>
    <div id="weather-info2" style="margin-top: 20px;"></div>
    
    <a href="pythonBBTI">파이썬</a>
    <script type="text/javascript">
    function getWthrDataList(monthInput, dayInput, currentYear, beach_code) {
        var requestData = {
            monthInput: monthInput.toString().padStart(2, '0'),
            dayInput: dayInput.toString().padStart(2, '0'),
            currentYear: currentYear,
            beach_code: beach_code
        };
        
        fetch('getWthrDataList_DTO', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body : JSON.stringify(requestData)
        }).then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json(); // 서버로부터 JSON 형식의 응답을 받음
        })
        .then(data => {
            console.log(data); // 서버로부터 받은 응답 출력
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
</script>


    <!-- 이미지 카드들 -->
<div class="image-cards">
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_비.gif" width="50" alt="비">
        </div>
        <div class="title">비</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_비와눈.png" width="50" alt="비와 눈">
        </div>
        <div class="title">비와 눈</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_눈.gif" width="50" alt="눈">
        </div>
        <div class="title">눈</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_소나기.gif" width="50" alt="소나기">
        </div>
        <div class="title">소나기</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_빗방울.gif" width="50" alt="빗방울">
        </div>
        <div class="title">빗방울</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_빗방울눈날림.png" width="50" alt="빗방울·눈날림">
        </div>
        <div class="title">빗방울·눈날림</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_눈날림.png" width="50" alt="눈날림">
        </div>
        <div class="title">눈날림</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_맑음_봄.gif" width="50" alt="맑음">
        </div>
        <div class="title">맑음</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_맑음_기본.gif" width="50" alt="맑음">
        </div>
        <div class="title">맑음</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_구름_낮.gif" width="50" alt="구름많음">
        </div>
        <div class="title">구름많음</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_흐림.gif" width="50" alt="흐림">
        </div>
        <div class="title">흐림</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_맑음_밤.gif" width="50" alt="맑음">
        </div>
        <div class="title">맑음</div>
    </div>
    <div class="image-card">
        <div class="image-wrapper">
            <img src="./resources/image/날씨_구름_밤.gif" width="50" alt="구름많음">
        </div>
        <div class="title">구름많음</div>
    </div>
</div>



</body>
</html>
