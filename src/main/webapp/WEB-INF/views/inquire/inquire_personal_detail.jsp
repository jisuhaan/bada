<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html>

<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>바라는 바다! :: 1:1 문의 상세 내역</title>
<style type="text/css">
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

.container {
	margin: 0 auto;
	margin-top:100px;
	display: flex;
	justify-content: center;
	align-items: center;
	width:700px;
}
form {
	margin: 0 auto;
	display: flex;
	justify-content: center;
	align-items: center;
	width:100%;		
}

.detail_table{
	width:100%;
	margin: 0 auto;
	border-collapse: collapse;
	font-size: 14px;
	border-spacing: 0;
	background-color: rgba(247,247,247,0.9);
}

table a {
	color: #1c1c1c;
	display: inline-block;
	line-height: 1.4;
	word-break: break-all;
	vertical-align: middle;
	cursor: pointer;
}

th, td {
    text-align: left;
    padding: 8px;
}
th {
	color: #1c1c1c;
	background-color: #B3B3B3;
	vertical-align: middle;
}
td {
	border-bottom: 1px solid #ddd;
	vertical-align: middle;
}

.contents {
	display:flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	gap:20px;
}

.inquire-images {
	width:400px;
	height:200px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-bottom: 50px;
}
  
.inquire-images div img {
  	width:400px;
	height:200px;
  	object-fit: cover;	
}

.slick-arrow {
	display:flex;
	justify-content: space-around;
	width: 30px;
	height: 30px;
	border: 1px solid gray;
	border-radius: 50%;
	background-color: rgba(241,241,241,0.5);
	font-size: 0;
}

.slick-next {
	position: absolute;
	top:150px;
	left:560px;
	z-index: 1;
}

.slick-prev {
	position: absolute;
	top:150px;
	left:10px;
	z-index: 1;
}

.slick-dots {
	width:100%;
	position: absolute;
	bottom:10px;
	display:flex;
	flex-direction: row;
	list-style: none;
	justify-content: center;
	gap:5px;
}

.slick-dots li {
	display: inline-block; /* 각 dots li를 인라인 블록 요소로 설정하여 가로로 배열되도록 합니다. */
}

.slick-dots li,
.slick-dots li button:hover{
	cursor: pointer;
}

.slick-dots li button{
	font-size: 0;
	width:8px;
	height:8px;
	border-radius: 50%;
	background-color: rgba(241,241,241,0.5);
	border: 0px;
}

.slick-dots > .slick-active > button{
	background-color: rgba(27,112,166,0.5);
}

textarea {
	width:450px;
	height:100px;
	font-family: 'Pretendard-Regular';
	font-size:12px;
	padding:5px;
	border: 1px solid gray;
	resize: none;
}

.inq_rep {
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	gap:15px;
}

.con_text {
	width:100%;
	display:flex;
	align-items:center;
	margin:0 auto;
	font-family:Pretendard-Regular';
	font-size: 12px;
	word-wrap: break-word; /* 글자 단위로 줄 바꿈 설정 */
	text-align: left;
	padding-left:30px;
	padding-right:30px;
	line-height:1.4;
}

.btn2 {
	box-sizing: border-box;
    background-color: #f5f5f5;
    border-color: #424242;
    border-width: 1px;
    box-shadow: 1px black;
    padding: 4px 8px;
    min-height: 12px;
    min-width: 36px;
    font-size: 16px;
}
</style>
</head>

<body>

<c:choose>
<c:when test="${loginstate==true && position=='admin'}">

<div class="container">

<form action="inquire_personal_reply" method="post">

<table class="detail_table">
	<tr>
		<th width="15%">제목</th>
		<td width="40%">${dto.title}</td>
		<th width="15%">작성자</th>
		<c:choose>
		<c:when test="${dto.id == 'nope'}"><td width="30%">${dto.name}(비회원)</td></c:when>
		<c:otherwise><td width="30%">${dto.name}(${dto.id})</td></c:otherwise>
		</c:choose>
	</tr>
	<tr>
		<th>카테고리</th>
		<td>[${dto.category}]</td>
		<th>작성일자</th>
		<td>${fn:substring(dto.ip_date, 0, 19)}</td>
	</tr>
	<tr>
		<th>이메일 주소</th>
		<td>${dto.email}
		<th>답변여부</th>
		<td>${dto.tf}</td>
	</tr>
	<tr>
		<td colspan="4" style="padding:30px;">
		<div class="contents">
			<c:choose>
			<c:when test="${dto.pic1.equals('nope')}">
			</c:when>
			<c:otherwise>
				<div class="inquire-images">
					<c:choose>
					<c:when test="${not dto.pic1.equals('nope')}">
						<div><img src="./resources/image_user/${dto.pic1}"></div>
					</c:when>
					<c:otherwise> </c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${not dto.pic2.equals('nope')}">
						<div><img src="./resources/image_user/${dto.pic2}"></div>
					</c:when>
					<c:otherwise> </c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${not dto.pic3.equals('nope')}">
						<div><img src="./resources/image_user/${dto.pic3}"></div>
					</c:when>
					<c:otherwise> </c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${not dto.pic4.equals('nope')}">
						<div><img src="./resources/image_user/${dto.pic4}"></div>
					</c:when>
					<c:otherwise> </c:otherwise>
					</c:choose>
					<c:choose>
					<c:when test="${not dto.pic5.equals('nope')}">
						<div><img src="./resources/image_user/${dto.pic5}"></div>
					</c:when>
					<c:otherwise> </c:otherwise>
				</c:choose>
				</div>
				
				<c:choose>
					<c:when test="${dto.pic1.equals('nope')}">
					
					</c:when>
					<c:otherwise>
					<script type="text/javascript">
						$(document).ready(function(){
							
							 $('.inquire-images').slick({
							 	autoplay:true,
							 	autoplaySpeed: 2000,
								dots: true,
								arrows: true,
								infinite: true,
							 	pauseOnHover: true,
							 	fade:false,
								draggable: true,
								cssEase: 'linear'
							 });
							 
						});	
					</script>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
			</c:choose>
			<div class="con_text">${dto.content}</div>
		</div>
		</td>
	</tr>
	        
	<tr>
		<td colspan="4" style="text-align: center; padding-left:20px;">
		<div class="btnlists"  style="display:flex; justify-content:space-between; gap:500px; align-items:center; text-align: center;">
			<div class="deletebtn" onclick="confirmDeleteip('${dto.ip_num}')" style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
			<img src="./resources/image/delete_icon.png" width="20px" class="">
			<span>문의삭제</span>
			</div>
			<div class="listbtn" onclick="window.location.href='inquire_personal_out'" style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
			<img src="./resources/image/icon_tolist.png" width="20px" class="">
			<span>목록으로</span>
			</div>
		</div>
		</td>
	</tr>
	<tr>
		<c:choose>
		
		<c:when test="${dto.tf == '답변 완료'}">
		<th colspan="1">추가답변전송</th>
		<td colspan="3" align="center">
		<h3>이미 답변을 완료한 문의입니다. <br>
		ezen.bada@gmail.com의 <a href="https://mail.google.com/mail/u/0/#sent">보낸 메일함</a>에서 보낸 답변을 확인할 수 있습니다.<br><br><br> </h3>
		<input type="hidden" name="ip_num" id="ip_num" value="${dto.ip_num}">
		<input type="hidden" name="title" id="title" value="${dto.title}">
		<input type="hidden" name="name" id="name" value="${dto.name}">
		<input type="hidden" name="email" id="email" value="${dto.email}">
		<input type="hidden" name="category" id="category" value="${dto.category}">
		<input type="hidden" name="content" id="content" value="${dto.content}">
		<input type="hidden" name="tf" id="tf" value="${dto.tf}">
		<div class="inq_rep">
		<textarea cols="50" rows="5" name="reply" id="reply" placeholder="${dto.email}(으)로 답을 한 번 더 전송합니다." required></textarea>
		<input type="submit" value="추가전송" class="btn2">
		</div>
		</td>
		</c:when>
		
		<c:otherwise>
		<th colspan="1">답변전송</th>
		<td colspan="3" >
		<div class="inq_rep">
		<input type="hidden" name="ip_num" id="ip_num" value="${dto.ip_num}">
		<input type="hidden" name="title" id="title" value="${dto.title}">
		<input type="hidden" name="name" id="name" value="${dto.name}">
		<input type="hidden" name="email" id="email" value="${dto.email}">
		<input type="hidden" name="category" id="category" value="${dto.category}">
		<input type="hidden" name="content" id="content" value="${dto.content}">
		<input type="hidden" name="tf" id="tf" value="${dto.tf}">
		<textarea cols="50" rows="5" name="reply" id="reply" placeholder="${dto.email}(으)로 답을 전송합니다." required></textarea>
		<input type="submit" value="답변하기" class="btn2">
		</div>
		</td>
		</c:otherwise>
		
		</c:choose>
	</tr>
	
	<c:forEach items="${list}" var="l">
	<tr>
		<td colspan="4">관리자
		<span>${fn:substring(l.ip_r_date, 0, 19)}</span>
		</td>
	</tr>
	<tr>
		<td colspan="4">
		${l.reply}
		</td>
	</tr>
	</c:forEach>

</table>
</form>
</div>
</c:when>

<c:otherwise>

	<script>
		window.onload = function() {
		    alert("관리자 외 접근할 수 없는 페이지 입니다.");
		    window.location.href = "./";
		};
	</script>
			     
</c:otherwise>
	    </c:choose>
	    
	
<script type="text/javascript">
function confirmDeleteip(ip_num ) {
    if(confirm('해당 문의 내역을 정말 삭제하시겠습니까?')) {
        location.href = 'inquire_personal_delete?ip_num='+ip_num;
    }
}
</script>
	
	
</body>
</html>