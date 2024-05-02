<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/notice_event.css" rel="stylesheet" type="text/css">

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
	            <div class="grid-item" onclick="show_contents('event?event_num=${event.event_num}')">
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
        아직 <a href="" onclick="window.open('member_try_bbti?id=${loginid}','BBTI 테스트','width=610,height=810,resizable=no,scrollbars=no,menubar=no')">bbti</a> 하지 않으셨다면 지금 바로 나의 <a href="" onclick="window.open('member_try_bbti?id=${loginid}','BBTI 테스트','width=610,height=810,resizable=no,scrollbars=no,menubar=no')">bbti</a> 확인하시고 상품 받아가세요!
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