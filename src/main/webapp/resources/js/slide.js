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
  if (i === 0) pagination.innerHTML += `<li class="active">•</li>`;
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

// 슬라이드 스타일을 설정하는 함수
function setSlideStyle(offset) {
  slideItems.forEach((i) => {
    i.style.left = `${-offset}px`;
  });
}

// 이전 슬라이드로 이동
function prevMove() {
  currSlide--;
  if (currSlide > 0) {
    const offset = slideWidth * currSlide;
    setSlideStyle(offset);
    updatePagination();
  } else {
    handleInfiniteSlide();
  }
}

// 다음 슬라이드로 이동
function nextMove() {
  currSlide++;
  if (currSlide <= maxSlide) {
    const offset = slideWidth * currSlide;
    setSlideStyle(offset);
    updatePagination();
  } else {
    handleInfiniteSlide();
  }
}

// 페이지네이션 업데이트
function updatePagination() {
  paginationItems.forEach((i) => i.classList.remove("active"));
  paginationItems[currSlide - 1].classList.add("active");
}

// 무한 슬라이드 처리
function handleInfiniteSlide() {
  currSlide = (currSlide === 0) ? maxSlide : 1;
  const offset = slideWidth * currSlide;
  setSlideStyle(offset);
  setTimeout(() => {
    setSlideStyle(slideWidth * currSlide);
  }, 0);
  updatePagination();
}

// 버튼 엘리먼트에 클릭 이벤트 추가하기
prevBtn.addEventListener("click", () => {
  prevMove();
});

nextBtn.addEventListener("click", () => {
  nextMove();
});

// 브라우저 화면이 조정될 때 마다 slideWidth를 변경하기 위해
window.addEventListener("resize", () => {
  slideWidth = slide.clientWidth;
});

// 각 페이지네이션 클릭 시 해당 슬라이드로 이동하기
for (let i = 0; i < maxSlide; i++) {
  paginationItems[i].addEventListener("click", () => {
    currSlide = i + 1;
    const offset = slideWidth * currSlide;
    setSlideStyle(offset);
    updatePagination();
  });
}