
function showLoadingPage() {
    // 로딩 페이지 표시
    document.getElementById("loading").style.display = "block";
}

function hideLoadingPage() {
    // 로딩 페이지 표시
    document.getElementById("loading").style.display = "none";
}

function moveToSeaResultPage(beach_code) {
    // 로딩 페이지 표시
    showLoadingPage();

    // body의 overflow-y 속성을 hidden으로 설정
    document.body.style.overflowY = 'hidden';

    // sea_result.jsp 페이지로 이동
    window.location.href = "sea_result?beach_code=" + beach_code ;

    // 함수 실행이 끝나면 body의 overflow-y 속성을 제거
    window.addEventListener('load', function() {
        document.body.style.overflowY = '';
        hideLoadingPage()
    });
}

function moveToWeatherDetailPage(beach_code) {
    // 로딩 페이지 표시
    showLoadingPage();
    
    // body의 overflow-y 속성을 hidden으로 설정
    document.body.style.overflowY = 'hidden';

    // sea_result.jsp 페이지로 이동
    window.location.href = "sea_weather_detail?beach_code="+ beach_code ;
    
    // 함수 실행이 끝나면 body의 overflow-y 속성을 제거
    window.addEventListener('load', function() {
        document.body.style.overflowY = '';
        hideLoadingPage()
    });
}

