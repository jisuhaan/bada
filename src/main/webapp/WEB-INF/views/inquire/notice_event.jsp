<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
    .notice_logo {
        text-align: center; /* 로고를 페이지 중앙에 배치 */
        margin-top: 20px;
        margin-bottom: 60px;
    }

    .notice-content {
    	
        background-color: white; /* 배경색은 하얀색 */
        border-radius: 15px; /* 둥근 모서리 */
        box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* 상자 그림자 효과 */
        margin: 0 auto;
        font-size: 16px; /* 글자 크기 */
        width: 1400px;
        height: 1300px;
    }
    
    .category-box {
        background-color: transparent; /* 배경색은 투명 */
        height: 70px; /* 높이 설정 */
        margin-bottom: 20px; /* 박스 간의 여백 */
        cursor: pointer; /* 마우스 오버 시 커서 변경 */
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 24px; /* 글자 크기 */
        width: calc(50% - 10px); /* 전체 너비의 절반에서 양쪽 여백을 고려하여 조정 */
    }
    
    .notice_img {
        border-radius: 15px 15px 0 0; /* 위쪽 끝만 둥글게 */
        overflow: hidden; /* 이미지가 둥근 테두리를 벗어나지 않도록 처리 */
        width: 100%; /* 컨테이너의 전체 너비 */
        height: auto; /* 이미지의 높이를 자동으로 설정 */
        display: block; /* 블록 레벨 요소로 설정 */
        margin-bottom: 0; 
    }    

    .category-box:first-child {
        margin-right: 20px; /* 첫 번째 박스의 오른쪽 여백 설정 */
    }

    .flex-container {
        display: flex;
        height: 100px;
        justify-content: space-between; /* 내용 사이의 여백을 동일하게 설정 */3
        margin-top: 0;
    }    

    .notice-popup {
        position: fixed;
        top: 20px;
        right: 20px;
	    min-width: 300px; /* 팝업창의 최소 너비를 고정 */
	    min-height: 200px; /* 팝업창의 최소 높이를 고정 */
        background: white;
        box-shadow: 0 0 10px rgba(0,0,0,0.2);
        border-radius: 10px;
        padding: 20px;
        display: none; /* 초기 상태는 숨김 */
        z-index: 100; /* 다른 요소 위에 보이도록 z-index 설정 */
    }
    .notice-popup input[type="checkbox"] {
        margin-right: 5px;
    }
    
	.notice-popup .close-popup {
	    float: right;
	    font-weight: bold; /* 텍스트를 볼드체로 만듭니다 */
	    cursor: pointer; /* 클릭 가능하다는 것을 명확하게 합니다 */
	}

	.notice-popup p {
	    margin-top: 0; /* 상단 여백 제거 */
	    font-weight: bold; /* 제목을 더 두껍게 */
	    border-bottom: 1px solid #ccc; /* 제목 아래에 경계선 추가 */
	    padding-bottom: 10px; /* 경계선과 내용 사이의 여백 */
	    margin-bottom: 10px;
	}
	
	.notice-popup .content {
	    padding: 10px 10px; /* 내용의 상하 여백 */
	    margin-top: 20px 0;
	}
	
	.notice-popup .actions {
	    padding: 10px 15px; /* 체크박스와 닫기 버튼 사이의 여백 */
	    text-align: right; 
	    margin-bottom: -10px;
	}
	
	.close-popup {
		font-weight: bold;
		cursor: pointer;
		margin-left: 20px;
	}

	.category-box:first-child {
	    background-color: #FFD545; /* 공지사항 박스 초기 색상은 노란색 */
	}
	
	.notice-content .grid-container {
	    display: grid;
	    grid-template-columns: repeat(3, 1fr); /* 각 열의 너비가 동등하도록 설정 */
	    padding: 10px;
	    grid-gap: 10px; /* 그리드 사이의 간격 */
	}
	
	.notice-content .grid-item {
	    padding: 10px; /* 패딩 값을 줄여 그리드 아이템 사이의 간격 감소 */
	    text-align: center;

	}
      
	.notice-content .grid-item img {
	    width: 100%; /* 이미지의 너비를 그리드 아이템의 너비에 맞춤 */
	    height: auto; /* 이미지의 높이를 자동으로 조절하여 비율 유지 */
	    border-radius: 15px; /* 이미지의 모서리를 둥글게 */
	    display: block; /* 이미지를 블록 레벨 요소로 설정 */
	    overflow: hidden; /* 이미지가 모서리를 벗어나지 않도록 처리 */
	    margin-bottom: 20px;
	}
	      
  .grid-item:hover {
    transform: scale(1.05); /* 호버 시 약간 확대 */
  }	

</style>

<script type="text/javascript">

document.addEventListener('DOMContentLoaded', function() {
    var popup = document.querySelector('.notice-popup');
    var hide_popupcheck= document.querySelector('#hide-popup');
    var close_button = document.querySelector('.close-popup');

    // '오늘 하루동안 보지 않기' 설정을 확인하는 함수
    function popup_setting() {
        var hidePopup = localStorage.getItem('hidePopup');
        var currentDate = new Date().toDateString();
        if (hidePopup === currentDate) {
            // 설정된 날짜가 오늘 날짜와 같다면 팝업을 표시하지 않음
            return;
        } else {
            // 그렇지 않다면 팝업을 표시
            popup.style.display = 'block';
        }
    }

    // '닫기' 버튼에 대한 클릭 이벤트 핸들러
    close_button.addEventListener('click', function() {
        // '오늘 하루동안 보지 않기'가 체크되었다면
        if (hide_popupcheck.checked) {
            // 현재 날짜를 localStorage에 저장
            localStorage.setItem('hidePopup', new Date().toDateString());
        }
        // 팝업창 숨기기
        popup.style.display = 'none';
    });

    // 페이지 로드 시 '오늘 하루동안 보지 않기' 설정을 확인
    popup_setting();
});

	function choice_category(selected) {
		
	    var categories = document.querySelectorAll('.category-box');
	    
	    categories.forEach(function(category) {
	        // 모든 카테고리 박스의 배경색을 투명으로 설정
	        category.style.backgroundColor = 'transparent';
	    });
	    // 선택된 카테고리의 배경색을 노란색으로 설정
	    selected.style.backgroundColor = '#FFD545';
	    
	}
	
	document.querySelectorAll('.category-box').forEach(function(box) {
	    box.addEventListener('click', function() {
	        choice_category(this);
	    });
	});


	document.addEventListener('DOMContentLoaded', function() {
	    var categories = document.querySelectorAll('.category-box');
	    categories.forEach(function(category) {
	        category.addEventListener('click', function() {
	            var categoryType = this.textContent.trim();
	            showCategory(categoryType);
	        });
	    });
	});

	function showCategory(categoryType) {
	    var notices = document.getElementById('notices');
	    var events = document.getElementById('events');
	    
	    if (categoryType === '공지사항') {
	        notices.style.display = 'grid';
	        events.style.display = 'none';
	    } else if (categoryType === '이벤트') {
	        notices.style.display = 'none';
	        events.style.display = 'grid';
	    }
	}
	
	function show_contents(url) {
		 window.location.href = url;
		}	
	
</script>
<meta charset="UTF-8">
<title>바라는 바다 :: 공지/이벤트</title>
</head>
<body>

<div class="notice_logo">
<img src ="./resources/image/로고 9-1.png" width="300px">
</div>


<div class="notice-content">
	<div class="notice_img">
		<img src ="./resources/image/notice.jpg" width="1400px">
	</div>
    <div class="flex-container">
        <div class="category-box" onclick="choice_category(this);">
            공지사항
        </div>
        <div class="category-box" onclick="choice_category(this);">
            이벤트
        </div>
    </div>
    
	<div class="grid-container" id="notices">
	        <!-- 공지사항 데이터 -->
	        <c:forEach var="notice" items="${list}">
	            <div class="grid-item" onclick="show_contents('notice?notice_num=${notice.notice_num}')">
	                <img src="./resources/image/${notice.thumbnail}">
	                <h3>${notice.title}</h3>
	            </div>
	        </c:forEach>
	    </div>
	    
	    <div class="grid-container" id="events" style="display: none;">
	        <!-- 이벤트 데이터 -->
	        <c:forEach var="event" items="${list2}">
	            <div class="grid-item" onclick="show_contents('notice?event_num=${event.event_num}')">
	                <img src="./resources/image/${event.thumbnail}">
	                <h3>${event.title}</h3><br>
	                <h3>${event.start_day} ~ ${event.expire_day}</h3>
	            </div>
	        </c:forEach>
	    </div>
</div>


<div class="notice-popup">
    <p>바라는 바다 긴급공지</p>
    <div class="content">
        아직 bbti 하지 않으셨다면 지금 바로 나의 bbti 확인하시고 상품 받아가세요!
    </div>
    <div class="actions">
    <label style="cursor: pointer;">
    <input type="checkbox" id="hide-popup">오늘 하루동안 보지 않기
    </label>
    <span class="close-popup" style="">닫기</span>
    </div>
</div>


</body>
</html>