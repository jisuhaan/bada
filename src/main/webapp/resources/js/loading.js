
function showLoadingPage() {
    // 로딩 페이지 표시
    document.getElementById("loading").style.display = "block";
}

function hideLoadingPage() {
    // 로딩 페이지 표시
    document.getElementById("loading").style.display = "none";
}

function moveToSeaResultPage(beach_code) {
	// 기본적으로 이동은 부모창에서 하도록. 부모창이 부재한 경우 자식창에서 작동하도록
	var targetWindow = window.opener && !window.opener.closed ? window.opener : window;
    
    // 로딩 페이지 표시
    targetWindow.showLoadingPage();

    // body의 overflow-y 속성을 hidden으로 설정
    targetWindow.document.body.style.overflowY = 'hidden';

    // sea_result.jsp 페이지로 이동
    targetWindow.location.href = "sea_result?beach_code=" + beach_code;

    // 함수 실행이 끝나면 body의 overflow-y 속성을 제거
    targetWindow.addEventListener('load', function() {
        targetWindow.document.body.style.overflowY = '';
        targetWindow.hideLoadingPage();
    });

    // 자식 창인 경우 창을 닫음
    if (targetWindow !== window) {
        setTimeout(function() { window.close(); }, 2000);
    }
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

