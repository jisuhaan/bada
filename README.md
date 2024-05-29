![로고 9-1](https://github.com/doh3e/bada/assets/151860111/ce83434a-1a6f-4d18-9ad8-578b1cc8112a)


 　

# 🌊 바다 여행할 땐, <바라는 바다!>


<바라는 바다!>는 Spring framework와 Java를 기반으로 제작된 프로젝트입니다.

이 플랫폼에서는 전국 각 지역의 유명 해수욕장 정보를 DB화 하고 기상청 API와 카카오지도 API를 활용하여

바다 여행을 가고자 하는 사람들이 쉽게 해수욕장 정보와 기상 정보를 얻을 수 있으며,

바다에 다녀온 사람들이 후기와 댓글을 남기며 소통할 수 있습니다.

또 BBTI(바다성향 테스트)를 통해 유저 맞춤형 바다를 추천받을 수 있습니다.

　

## <바라는 바다!> 소개

　
## 프로젝트 기간

2024.03.21. ~ 2024.04.19. 총 30일.
　

## 팀원 소개


|   Name   | 정지은 👑                         | 한지수                                            | 정지수                             | 홍문선                                                       |
| :------: | ------------------------------------ | ------------------------------------------------- | ---------------------------------- | ------------------------------------------------------------ |
| Profile  |<p align="center"><img src = "https://github.com/doh3e/bada/assets/151860111/232142ac-9b04-4d54-8869-409d1a584d4f" width="127px" height="160px"></p>|<p align="center"><img src = "https://github.com/doh3e/bada/assets/151860111/3d5623ad-9984-4889-adc3-794e9c411330" width="127px" height="160px"></p>|<p align="center"><img src = "https://github.com/doh3e/bada/assets/151860111/535117e8-d2fb-42f9-95de-d0678debf770" width="127px" height="160px" ></p>|<p align="center"><img src = "https://github.com/doh3e/bada/assets/151860111/f8115a50-ab00-47fd-9cd8-f49a794020c9" width="127px" height="160px"></p>| 
| Position | Front/Backend Develop  | Front/Backend Develop                                  | Front/Backend Develop                   | Front/Backend Develop                              |
|   Git    | [@doh3e](https://github.com/doh3e) | [@jisuhaan](https://github.com/jisuhaan)            | [@jisu301203](https://github.com/jisu301203) | [@annesolHong](https://github.com/annesolHong)                 |
|   E-mail    | wldms3333@gmail.com| haanjisu@gmail.com| jisu301203@naver.com| seizemyred@gmail.com|

　

### 세부 역할

`정지은(팀장)`

UI/UX 설계 / 전체 로직 설계 / 유스케이스 다이어그램 제작 / 메인화면(검색, 회원별 바다추천, 이벤트 배너, 베스트리뷰 슬라이드) / 추천, 바다(지도 선택 페이지, 결과 페이지 해수욕장 정보 및 지도) / 리뷰,바다(싸이월드 스타일의 레트로&도트 디자인, 개별 리뷰 페이지 CSS 작업) / BBTI(바다성향테스트) 로직 및 이미지 제작 / 전체 페이지 CSS 제작 관리 / 전반적인 코드 관리 / 깃허브 관리 담당
　
`한지수(부팀장)`

　
`정지수`

회원 관리(회원 가입, 회원 목록, 회원 탈퇴, 회원 검색) / 문의,바다(문의게시판 내 공지사항, 문의게시판 CRUD, 문의 검색, 추천 및 최신&추천순 정렬, 관리자 문의 답변, 1:1 문의 기능 및 이메일 전송 등 기능 전체), 리뷰, 바다(리뷰게시판 내 공지사항, 나도 한마디 메뉴 CSS, 지역별 실시간 채팅 CRUD, 채팅 신고 기능 등) 담당
　
`홍문선` 
DB 설계 및 ERD 제작 및 관리 / 리뷰,바다(리뷰 게시판 CRUD 및 추천&신고&댓글 기능, 리뷰 작성시 해시태그 드롭다운 및 별점 구현) / 문의,바다(공지이벤트 게시판 UI/UX 디자인 및 기능 이미지 작업) / 로그인(로그인 로직 및 CSS, 시도 횟수 별 반응 설계, 아이디&비밀번호 찾기 페이지 로직 및 CSS) / 마이페이지(북마크, 나의 리뷰 및 문의 보기, 전반적인 기능 및 CSS) 담당
　


# 📝 프로젝트 설계 및 구성

## 기획

**여행**은 시대를 막론하고 사람들에게 인기 있는 키워드입니다. 특히나 경쟁과 과제에 지친 한국의 현대인들에게 국내 바다 여행은 비교적 쉽게 이룰 수 있는 로망이죠. 팬데믹 이후 여행과 이동이 자유로워지면서, 답답함에 지친 사람들의 여행에 대한 수요가 급증하기도 했고요.

>**"아, 힘든데 바다에 가고 싶다!"**

<바라는 바다!>는 모두가 한 번쯤 느낄 법한 이런 생각에서 출발했습니다. 하지만 바다에 가기 위해 `일기예보`나 `바다 상태`, 해수욕장에 있는 `편의시설` 유무, 사람들의 리뷰 등을 일일이 검색해서 찾는 건 제법 불편한 일이죠. 기상정보, 해수욕장 샤워실이 무료인지, 근처에 캠핑장은 있는지를 확인하고 바다에 실제로 다녀온 사람들의 리뷰를 함께 읽을 수 있는 복합 플랫폼이 있다면 얼마나 좋을까요?

그래서 저희는 바다 여행을 계획할 때 유용한 정보를 한 번에 모아 볼 수 있는 웹사이트를 기획하게 되었습니다. <바라는 바다!>는 다양한 곳에서 단편적으로 제공되는 API 정보를 모아 한 번에 제공하는 정보 제공처이자, 동시에 유저 간에 소통을 중계하는 SNS입니다.
　

## 유스케이스 다이어그램
![bada_유스케이스다이어그램](https://github.com/doh3e/bada/assets/151860111/ce08a401-c4b9-47c5-8ff8-d76fa08886ea)

　

## 데이터베이스 ERD
![ERD](https://github.com/doh3e/bada/assets/151860111/66375dc5-89d8-4140-ab48-783594ef4470)

　

## 사용 기술

<div align=left> 

<img src="https://img.shields.io/badge/Java-3766AB?style=flat-square&logo=Java&logoColor=white"/>
<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black"/>
<img src="https://img.shields.io/badge/Spring-6DB33F?style=flat-square&logo=Spring&logoColor=white"/>
<img src="https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=html5&logoColor=white"/>
<img src="https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=css3&logoColor=white"/>
<img src="https://img.shields.io/badge/jQuery-0769AD?style=flat-square&logo=jQuery&logoColor=white"/>
<img src="https://img.shields.io/badge/ORACLE-F80000?style=flat-square&logo=oracle&logoColor=white"/>
<img src="https://img.shields.io/badge/Apache Tomcat-F8DC75?style=flat-square&logo=apachetomcat&logoColor=black"/>
<img src="https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white"/>
<img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=GitHub&logoColor=white"/>

</div>
　

<details>
<summary><b> 백엔드</b></summary>
<ul>
  <li>JAVA 11</li>
  <li>Spring MVC</li>
  <li>JSP</li>
  <li>MyBatis</li>
  <li>AJAX</li>
  <li>JSON</li>
</ul>
</details>

 <details>
<summary><b> 프론트엔드</b></summary>
<ul>
  <li>HTML</li>
  <li>CSS</li>
  <li>JavaScript</li>
  <li>JQuery</li>
</ul>
</details>

<details>
<summary><b> DB & WAS</b></summary>
<ul>
  <li>Oracle(Oracle Database 11g Express Edition Release 11.2.0.2.0)</li>
  <li>Tomcat 9(9.0.85)</li>
</ul>
</details>

<details>
<summary><b> API & OpenData</b></summary>
<ul>
  <li><a href="https://www.data.go.kr/data/15084084/openapi.do">기상청_단기예보 ((구)_동네예보) 조회서비스</a></li>
  <li><a href="https://www.data.go.kr/data/15012688/openapi.do)">한국 천문 연구원 출몰시각</a></li>
  <li><a href="https://www.data.go.kr/data/15102239/openapi.do)">기상청 전국 해수욕장 날씨조회 서비스</a></li>
  <li><a href="https://www.data.go.kr/data/15059093/openapi.do">기상청_지상(종관, ASOS) 일자료 조회서비스</a></li>
</ul>
</details>

<details>
<summary><b> Environment & Tool</b></summary>
<ul>
  <li>Windows 11</li>
  <li>STS(3.9.18)</li>
  <li>Git</li>
  <li>GitHub</li>
  <li>Oracle SQL Developer</li>
</ul>
</details>
　

# 💻 <바라는 바다!> 주요 기능 소개
　
## 메인페이지

　
 
## 회원가입 및 로그인

　
 
## 추천, 바다!

　
 
## 순위, 바바!

　
 
## 리뷰, 바다!

　
 
## 문의, 바다!

　
 
## 관리자 모드


 
