document.addEventListener("DOMContentLoaded", function() {
	    // 월 입력 요소
	    var monthInput = document.getElementById("beachMonth");
	    // 일 입력 요소
	    var dayInput = document.getElementById("beachDay");
	    // 현재 연도 가져오기
	    var currentYear = new Date().getFullYear();
	
	    // 월이 변경될 때 이벤트 처리
	    monthInput.addEventListener("change", function() {
	        updateDayInput(monthInput, dayInput, currentYear);
	    });
	
	    // 일의 입력 값이 변경될 때 이벤트 처리
	    dayInput.addEventListener("input", function() {
	        validateDayInput(dayInput);
	    });
	
	    // 월의 입력 값이 변경될 때 이벤트 처리
	    monthInput.addEventListener("input", function() {
	        validateMonthInput(monthInput);
	    });
	
	    document.querySelector('.box0').classList.remove('hidden');
	    document.querySelector('.fcstoday').style.backgroundColor = '#CDE4F2';
	
		// 검색 로직
		function handleSearch() {
		    var monthInput = parseInt($("#beachMonth").val());
		    var dayInput = parseInt($("#beachDay").val());
		
		    if (!validateInput(monthInput, dayInput)) {
		        return;
		    }
		
		    getWthrDataList(monthInput, dayInput, currentYear, beach_code);
		    alert("지난 바다 날씨 검색을 시작합니다.");
		}
		
		// 클릭 시
		$("#searchBtn").click(handleSearch);
		
		// 엔터 키 누를 시
		[monthInput, dayInput].forEach(function(input) {
	        input.addEventListener("keydown", function(event) {
	            if (event.key === "Enter") {
	                event.preventDefault(); // 기본 엔터 동작 방지
	                handleSearch();
	            }
	        });
	    });
	});
	
	function updateDayInput(monthInput, dayInput, currentYear) {
	    // 선택한 월 가져오기
	    var selectedMonth = parseInt(monthInput.value);
	    // 선택한 월에 따라 해당 월의 일수 계산
	    var daysInMonth = new Date(currentYear, selectedMonth, 0).getDate();
	    // 일의 최대값을 월에 따라 변경
	    dayInput.max = daysInMonth;
	}
	
	function validateDayInput(dayInput) {
	    // 입력된 값이 min/max 범위를 벗어나면 수정
	    if (parseInt(dayInput.value) < parseInt(dayInput.min)) {
	        dayInput.value = dayInput.min;
	    } else if (parseInt(dayInput.value) > parseInt(dayInput.max)) {
	        dayInput.value = dayInput.max;
	    }
	}
	
	function validateMonthInput(monthInput) {
	    // 사용자가 입력한 값이 최대값을 초과하는지 확인
	    if (parseInt(monthInput.value) > parseInt(monthInput.max)) {
	        // 최대값으로 변경
	        monthInput.value = monthInput.max;
	    } else if (parseInt(monthInput.value) < parseInt(monthInput.min)){
	        // 최소값으로 변경
	        monthInput.value = monthInput.min;
	    }
	}
	
	function validateInput(monthInput, dayInput) {
	    if (isNaN(monthInput) || monthInput < 1 || monthInput > 12) {
	        alert("월을 올바르게 입력해주세요 (1에서 12 사이).");
	        monthInput.value = monthInput.min;
	        return false;
	    }
	
	    var maxDay = parseInt($("#beachDay").attr("max"));
	
	    if (isNaN(dayInput) || dayInput < 1 || dayInput > maxDay) {
	        alert("일을 올바르게 입력해주세요 (1에서 " + maxDay + " 사이).");
	        dayInput.value = dayInput.min;
	        return false;
	    }
	
	    return true;
	}