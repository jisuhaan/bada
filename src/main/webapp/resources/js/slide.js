// 슬라이드 전체 크기(width 구하기)
const slide = document.querySelector(".slide");
let slideWidth = slide.clientWidth;

// 버튼 엘리먼트 선택하기
const prevBtn = document.querySelector(".slide_prev_button");
const nextBtn = document.querySelector(".slide_next_button");

// 슬라이드 전체를 선택해 값을 변경해주기 위해 슬라이드 전체 선택하기
let slideItems = document.querySelectorAll(".slide_item");
// 현재 슬라이드 위치가 슬라이드 개수를 넘기지 않게 하기 위한 변수
const maxSlide = slideItems.length;

// 버튼 클릭할 때 마다 현재 슬라이드가 어디인지 알려주기 위한 변수
let currSlide = 1;

// 페이지네이션 생성
const pagination = document.querySelector(".slide_pagination");

for (let i = 0; i < maxSlide; i++) {
  if (i == 0) pagination.innerHTML += `<li class="active">•</li>`;
  else pagination.innerHTML += `<li>•</li>`;
}

const paginationItems = document.querySelectorAll(".slide_pagination > li");

// 무한 슬라이드를 위해 start, end 슬라이드 복사하기
const startSlide = slideItems[0];
const endSlide = slideItems[slideItems.length - 1];
const startElem = document.createElement("div");
const endElem = document.createElement("div");

endSlide.classList.forEach((c) => endElem.classList.add(c));
endElem.innerHTML = endSlide.innerHTML;

startSlide.classList.forEach((c) => startElem.classList.add(c));
startElem.innerHTML = startSlide.innerHTML;

// 각 복제한 엘리먼트 추가하기
slideItems[0].before(endElem);
slideItems[slideItems.length - 1].after(startElem);

// 슬라이드 전체를 선택해 값을 변경해주기 위해 슬라이드 전체 선택하기
slideItems = document.querySelectorAll(".slide_item");

// 각 슬라이드의 초기 위치 설정
let offset = slideWidth + currSlide;
slideItems.forEach((item) => {
  item.style.left = `-${offset}px`;
});

// 슬라이드 이동 함수 정의
function moveSlides(offset) {
  slideItems.forEach((item, index) => {
    const itemOffset = (index - currSlide) * slideWidth + offset;
    item.style.left = `${itemOffset}px`;
  });
}

// 이전 슬라이드로 이동하는 함수
function prevMove() {
  currSlide--;
  if (currSlide < 1) {
    currSlide = maxSlide;
    let offset = slideWidth * currSlide;
    slideItems.forEach((item) => {
      item.style.transition = "0s";
      item.style.left = `-${offset}px`;
    });
    currSlide--;
    offset = slideWidth * currSlide;
    setTimeout(() => {
      slideItems.forEach((item) => {
        item.style.transition = "0.15s";
        item.style.left = `-${offset}px`;
      });
    }, 0);
  } else {
    const offset = slideWidth * currSlide;
    moveSlides(-offset);
  }
  updatePagination();
}

// 다음 슬라이드로 이동하는 함수
function nextMove() {
  currSlide++;
  if (currSlide > maxSlide) {
    currSlide = 1;
    let offset = slideWidth * currSlide;
    slideItems.forEach((item) => {
      item.style.transition = "0s";
      item.style.left = `-${offset}px`;
    });
    currSlide++;
    offset = slideWidth * currSlide;
    setTimeout(() => {
      slideItems.forEach((item) => {
        item.style.transition = "0.15s";
        item.style.left = `-${offset}px`;
      });
    }, 0);
  } else {
    const offset = slideWidth * currSlide;
    moveSlides(-offset);
  }
  updatePagination();
}

// 페이지네이션 업데이트 함수
function updatePagination() {
  paginationItems.forEach((item, index) => {
    if (index === currSlide - 1) {
      item.classList.add("active");
    } else {
      item.classList.remove("active");
    }
  });
}

// 버튼 클릭 이벤트 추가
prevBtn.addEventListener("click", prevMove);
nextBtn.addEventListener("click", nextMove);

// 윈도우 리사이즈 이벤트 핸들러 추가
window.addEventListener("resize", () => {
  slideWidth = slide.clientWidth;
  const offset = slideWidth * currSlide;
  moveSlides(-offset);
});

// 페이지네이션 클릭 이벤트 추가
paginationItems.forEach((item, index) => {
  item.addEventListener("click", () => {
    currSlide = index + 1;
    const offset = slideWidth * currSlide;
    moveSlides(-offset);
    updatePagination();
  });
});

// 드래그(스와이프) 이벤트 핸들러 추가
let touchStartX = 0;
let touchEndX = 0;

slide.addEventListener("touchstart", (event) => {
  touchStartX = event.touches[0].clientX;
});

slide.addEventListener("touchend", (event) => {
  touchEndX = event.changedTouches[0].clientX;
  handleGesture();
});

function handleGesture() {
  const gestureOffset = touchStartX - touchEndX;
  const threshold = 100; // 드래그로 인식하는 최소 이동 거리

  if (gestureOffset > threshold) {
    // 오른쪽에서 왼쪽으로 스와이프한 경우 (다음 슬라이드로 이동)
    nextMove();
  } else if (gestureOffset < -threshold) {
    // 왼쪽에서 오른쪽으로 스와이프한 경우 (이전 슬라이드로 이동)
    prevMove();
  }
}

// 자동 슬라이드 기능 추가
let autoSlideInterval = setInterval(nextMove, 3000);

// 마우스 오버시 자동 슬라이드 멈춤
slide.addEventListener("mouseover", () => {
  clearInterval(autoSlideInterval);
});

// 마우스 아웃시 자동 슬라이드 재개
slide.addEventListener("mouseout", () => {
  autoSlideInterval = setInterval(nextMove, 3000);
});