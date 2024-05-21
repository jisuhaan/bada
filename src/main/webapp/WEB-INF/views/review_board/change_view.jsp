<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/review_input.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="container">

<div id="container_title">리뷰 수정</div>

<form id="review_change_form" action="review_change_save" method="post" enctype="multipart/form-data">

<div class="listbox writer">
	<div id="list_title">작성자</div>
	<div id="list_contents"><input type="text" name="name" id="name" value="${dto.name}" readonly="readonly"></div>
	<input type="hidden" name="id" id="id" value="${dto.id}" >
	<input type="hidden" name="review_num" id="review_num" value="${dto.review_num}" >
</div>

<div class="listbox visitdate">
	<div id="list_title">방문일</div>
		<div id="list_contents"><input type="date" name="visit_day" id="visit_day" value="${dto.visit_day }" onchange="checkDate()" required></div>
</div>

<div class="listbox categories">
	<div id="list_title">후기 바다</div>
	<select name="beach" id="beach" required>
	<option value="" disabled selected>방문한 바다를 선택해주세요!</option>
    <c:forEach items="${beachList}" var="beach">
    <option value="${beach.beach_code}" ${beach.beach_code == dto.beach_code ? 'selected' : ''}>${beach.beach}</option>
   	</c:forEach>
	</select>    
</div>

<div class="listbox titles">
	<div id="list_title">제목</div>
	<div id="list_contents"><input type="text" name="review_title" id="review_title" required value="${dto.review_title }"></div>
</div>

<div class="listbox thumbnails">
<div id="list_title">썸네일</div>
<div id="thumbnail_view" style="margin-bottom: 15px">
<c:if test="${not empty dto.thumbnail and dto.thumbnail ne 'no'}">
<img src="${pageContext.request.contextPath}/resources/image_user/${dto.thumbnail}" style="width:60px; height:60px;">
</c:if>
</div>      
<input type="file" name="thumb_nail" id="thumb_nail" onchange="previewFile()" class="btn">
<div id="thumbnail_view"></div>
</div>
			
<div class="listbox addphoto">
	<div class="pic_add">
		<div id="list_title">사진(최대 5장)</div>		
		<div id="photo_input">
			<div id="existing_photos">
				<c:forEach items="${photoList}" var="photo">
				<c:if test="${photo ne 'no'}">
					<div class="image-wrap" id="image-wrap-${photo}" style="display: inline-block; margin: 10px 10px;">
					<img src="${pageContext.request.contextPath}/resources/image_user/${photo}" width="60px" height="60px">
					</div>
				</c:if>
				</c:forEach>
			</div>
			<div class="photofiles"> 
			<input type="file" name="pic1" id="pic1" class="btn">
			<div id="pic_pack"></div>
			</div>
			<button type="button" onclick="addPicField()" class="btn"> + </button>
		</div>
	</div>
</div>

<div class="listbox contents">
<div id="list_title">내용</div>
<div id="list_contents">
<textarea cols="60" rows="30" name="review_contents" id="review_contents" required >${dto.review_contents }</textarea>
</div>
</div>

<div class="listbox reviewstars">
<div id="list_title">별점</div>
<div id="list_contents">
	<fieldset id="star">
		<input type="radio" name="review_score" value="5" id="rate1" ${dto.review_score == 5 ? 'checked' : ''} ><label for="rate1">★</label>
		<input type="radio" name="review_score" value="4" id="rate2" ${dto.review_score == 4 ? 'checked' : ''} ><label for="rate2">★</label>
		<input type="radio" name="review_score" value="3" id="rate3" ${dto.review_score == 3 ? 'checked' : ''} ><label for="rate3">★</label>
		<input type="radio" name="review_score" value="2" id="rate4" ${dto.review_score == 2 ? 'checked' : ''} ><label for="rate4">★</label>
		<input type="radio" name="review_score" value="1" id="rate5" ${dto.review_score == 1 ? 'checked' : ''} ><label for="rate5">★</label>
	</fieldset>
</div>
</div>

<div class="listbox hashes">
	<div id="list_title">해시태그</div>
	<div id="list_contents">
	<input type="hidden" name="hashtags" id="hashtags" value="${dto.hashtag}">
	<div id="hashtagFields">
	<div class="hashtag-categories">
		<div class="category hashtag-box" data-category="누구와" onclick="changeColor(this)">누구와</div>
		<div class="category hashtag-box" data-category="편의시설" onclick="changeColor(this)">편의시설</div>
		<div class="category hashtag-box" data-category="바다" onclick="changeColor(this)">바다</div>
		<div class="category hashtag-box" data-category="액티비티" onclick="changeColor(this)">액티비티</div>
		<div class="category hashtag-box" data-category="풍경" onclick="changeColor(this)">풍경</div>
	</div>
	<div class="hashtag-dropdown" style="display: none;"></div>
	</div>
	</div>
</div>
<div class="listbox selectedhashes">
	<div id="list_title">선택된 태그</div>
	<div id="list_contents">
	<div id="selected-tags"></div><br>
	</div>  
</div>

<div class="listbox revisiting">      
<div id="list_title">재방문 의사</div>
<div id="list_contents">
<input type="hidden" name="re_visit" id="re_visit_input" value="${dto.re_visit}">
<div id="re_visit">
	<div class="visit-box" data-value="Yes">Yes</div>
	<div class="visit-box" data-value="No">No</div>
</div>
</div>
</div>
<br><hr><br>
<div class="listbox btns">   
	<input type="submit" value="전송" class="btn2">
	<input type="reset" value="리셋" class="btn2">
	<input type="button" value="돌아가기" class="btn2 goback" onclick="history.go(-1)">
</div>
			
</form>
</div>

<script>

function changeColor(selectedDiv) {
    // 모든 category div 요소를 선택합니다.
    const categories = document.querySelectorAll('.category');

    // 선택한 category div의 배경색을 변경합니다.
    categories.forEach(category => {
        if (category === selectedDiv) {
            category.style.backgroundColor = 'lightblue'; // 선택한 div의 배경색을 변경합니다.
        } else {
            category.style.backgroundColor = ''; // 선택하지 않은 div의 배경색을 초기화합니다.
        }
    });
}

function previewFile() {
	var thumbnail_view = document.getElementById('thumbnail_view'); // 미리보기를 표시할 요소 선택
	var file    = document.getElementById('thumb_nail').files[0]; // 선택된 파일 가져오기
	var reader  = new FileReader();
	
	reader.onloadend = function () {
		var img = document.createElement('img'); // 새로운 img 요소 생성
		img.src = reader.result; // reader가 읽은 파일 내용을 img의 src로 설정
		img.style.width = '60px';
		img.style.height = '60px';
		thumbnail_view.innerHTML = ''; // 이전에 표시된 이미지를 제거
		thumbnail_view.appendChild(img); // 생성된 img 요소를 preview에 추가
	}
	
	if (file) {
		reader.readAsDataURL(file); // 파일 읽기 시작, 이 작업이 끝나면 reader.onloadend가 호출됨
	} else {
		thumbnail_view.innerHTML = ""; // 파일이 선택되지 않았으면 미리보기를 비움
	}
}



var PicCount = 1;
function addPicField() {
    // 사진 5장까지만 첨부 가능
    if (PicCount >= 5) {
        alert("사진은 최대 5장까지만 첨부할 수 있습니다.");
        return;
    }

    PicCount++;

    // 버튼을 누르면 새로운 사진 input창 생성
    var newField = document.createElement('div');
    newField.innerHTML = '<input type="file" name="pic' + PicCount + '" id="pic' + PicCount + '" class="btn">';

    // 위에서 추가한 것을 보이도록 해서 pic_pack에 추가
    document.getElementById('pic_pack').appendChild(newField);
}
	
	// 방문날짜 선택
function checkDate() {
   var visitDayInput = document.getElementById('visit_day');
   var visitDay = new Date(visitDayInput.value);
   var today = new Date();
   today.setHours(0, 0, 0, 0); // 시간을 00:00:00으로 설정하여 오늘 날짜만 비교
   
   today.setDate(today.getDate() + 1);

   if (visitDay > today) {
       alert('방문한 날짜만 선택가능합니다!');
       visitDayInput.value = ""; // 입력 필드 초기화
   }
}

	
// 해시태그영역

$(document).ready(function() {
      // 초기 해시태그 설정
      choice_tags = '${dto.hashtag}'.split(' ').filter(tag => tag);
  
      // 선택된 해시태그 표시
      update_Hashtag();
  
      $('.category').click(function() {
          var category = $(this).data('category');
          show_hashtags(category);
      });
  
      $(document).on('click', '.hashtag', function() {
          var hashtag = $(this).text();
          if ($(this).hasClass('selected')) {
              // 해시태그 선택 해제
              $(this).removeClass('selected');
              choice_tags = choice_tags.filter(function(value) {
                  return value !== hashtag;
              });
          } else {
              // 새 해시태그 선택
              if (choice_tags.length < 6) {
                  $(this).addClass('selected');
                  choice_tags.push(hashtag);
              } else {
                  alert('해시태그는 최대 6개까지 선택 가능합니다.');
              }
          }
          update_Hashtag();
      });
  
      function show_hashtags(category) {
          var hashtags = get_tag(category);
          var dropdown = $('.hashtag-dropdown').empty().show();
          $.each(hashtags, function(index, hashtag) {
              var div = $('<div/>', {
                  text: hashtag,
                  class: 'hashtag'
              }).appendTo(dropdown);
  
              if (choice_tags.indexOf(hashtag) !== -1) {
                  div.addClass('selected');
              }
          });
      }
  
      function get_tag(category) {
          var hashtags = {
              "누구와": ["#가족", "#연인", "#혼자", "#친구", "#반려동물"],
              "편의시설": ["#대중교통", "#자차필요", "#번화가"],
              "바다": ["#에메랄드바다", "#백사장", "#고운모래", "#갯벌"],
              "액티비티": ["#스쿠버다이빙", "#서핑", "#물놀이", "#바다낚시", "#캠핑"],
              "풍경": ["#핫플", "#감성", "#사람이적어요", "#이국적", "#인생샷", "#일출맛집", "#전망대", "#항구"]
          };
          return hashtags[category];
      }
  
      function update_Hashtag() {
          $('#hashtags').val(choice_tags.join(' '));
          display_tags();
      }
  
      function display_tags() {
          var tags_Area = $('#selected-tags');
          tags_Area.empty(); // 이전 표시 내용 초기화
          choice_tags.forEach(function(tag) {
              $('<span/>', {
                  text: tag,
                  class: 'selected-tag'
              }).appendTo(tags_Area);
          });
      }
      
   display_tags();

});   
   
    // 재방문 의사 선택 기능
var visitBoxes = document.querySelectorAll('.visit-box');
visitBoxes.forEach(function(box) {
    box.addEventListener('click', function() {
        // 다른 박스의 선택 해제
        visitBoxes.forEach(function(otherBox) {
            otherBox.classList.remove('selected');
        });
        
        // 현재 박스의 선택 상태를 설정
        box.classList.add('selected');
        document.getElementById('re_visit_input').value = box.getAttribute('data-value');
    });
});

// 재방문 의사 상태 기본설정
var reVisitValue = document.getElementById('re_visit_input').value;
if (reVisitValue) {
    var visitBoxes = document.querySelectorAll('.visit-box');
    visitBoxes.forEach(function(box) {
        if (box.getAttribute('data-value') === reVisitValue) {
            box.classList.add('selected'); // dto저장 재방문 의사 박스를 선택된 상태로 표시
        }
    });
}	    
    

document.getElementById('review_change_form').onsubmit = function() {
	    		
    // 별점 유효성 검사
    var reviewScoreSelected = document.querySelector('input[name="review_score"]:checked');
    if (!reviewScoreSelected) {
        alert('별점을 선택해주세요!');
        return false; // 폼 제출 중단
    }
	
	// 해시태그 유효성 검사
    var hashtagsValue = document.getElementById('hashtags').value;
    if (hashtagsValue.trim() === '') {
        alert('최소 하나 이상의 해시태그를 선택해주세요.');
        return false; // 폼 제출 중단
    }

    // 재방문 의사 유효성 검사
    var reVisitValue = document.getElementById('re_visit_input').value;
    if (reVisitValue !== 'Yes' && reVisitValue !== 'No') {
        alert('재방문 의사를 선택해주세요.');
        return false; // 폼 제출 중단
    }

    // 모든 검사 통과 시 폼 제출 계속
    return true;
};	

</script>

</body>
</html>