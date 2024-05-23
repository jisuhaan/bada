<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body id="body-pd">
<div class="l-navbar" id="navbar">
    <div class="nav_background">
        <nav class="nav">
            <div>
            
				<div class="nav__brand">
				    <img src="./resources/image/로고 9-2.png" class="nav__toggle" id="nav-toggle" width="100px">
				</div>

                <div class="nav__list">
                    <a href="./" class="nav__link active">
                        <ion-icon name="home-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">메인으로</span>
                    </a>
                    <a href="sea_info" class="nav__link" onclick="window.location.href='sea_info'">
                       <ion-icon name="map-outline" class="nav__icon"></ion-icon>
                       <span class="nav_name">추천, 바다!</span>
                    </a>                                   
                     
                    <a href="ranking_page" class="nav__link">
                        <ion-icon name="pie-chart-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">순위, 바바!</span>
                    </a>

                    <div class="nav__link collapse">
                     <ion-icon name="heart-circle-outline" class="nav__icon"></ion-icon>
                     <span class="nav_name">&nbsp;리뷰, 바다!</span>
                     
                        <ul class="collapse__menu">
                            <a href="bada_review?area=전국" class="collapse__sublink">바다리뷰</a><br>
                            <a href="review_input" class="collapse__sublink">리뷰작성</a><br>
                            <a href="say_one_sentence"  class="collapse__sublink">바닷속외침</a><br>
                            <c:if test="${position=='admin'}">
                            <a href="review_ban_listout" class="collapse__sublink">리뷰 신고내역</a>
                            </c:if>       
                        </ul>
                   
                    </div>

                    <div class="nav__link collapse">
                        <ion-icon name="people-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;문의, 바다!</span>

                        <ul class="collapse__menu">
                            <a href="notice_event" class="collapse__sublink">공지/이벤트</a>
                            <a href="inquire_listout?sort=latest" class="collapse__sublink">문의게시판</a>
                            <a href="inquire_input" class="collapse__sublink">문의글작성</a>
                            <a href="inquire_personal_view" class="collapse__sublink">1:1문의</a>
                            <c:if test="${position=='admin'}">
                            <a href="inquire_ban_listout" class="collapse__sublink">문의 신고내역</a>
                            <a href="inquire_personal_out" class="collapse__sublink">1:1 문의내역</a>
                            </c:if>
                        </ul>
                    </div>
                        
                </div>
                <c:if test="${position=='admin'}">
                    <div class="nav__link collapse">
                        <ion-icon name="settings-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;회원관리</span>
                        
                        <ul class="collapse__menu">
                            <a href="member_join" class="collapse__sublink">회원입력</a><br>
                            <a href="member_out" class="collapse__sublink">회원목록</a>
                        </ul>
                        
                    </div>
                </c:if>
                <c:choose>
                <c:when test="${loginstate==true}">
                    <a href="mypage?loginid=${loginid}" class="nav__link">
                       <ion-icon name="person-circle-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">마이페이지</span>
                    </a>
                    <a href="logout" class="nav__link">
                        <ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">로그아웃</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="login" class="nav__link">
                        <ion-icon name="log-in-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">로그인</span>
                    </a>
                    <a href="member_join" class="nav__link">
                       <ion-icon name="add-circle-outline" class="nav__icon">></ion-icon>
                        <span class="nav_name">회원가입</span>
                    </a>
                </c:otherwise>
                </c:choose>
            </div>
        </nav>
    </div>
</div>

<!-- IONICONS -->
<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
<!-- JS -->
<script src="./resources/js/sidebar.js"></script>

</body>
</html>
