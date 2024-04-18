<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>바다 검색 결과</title>
<style type="text/css">

@font-face {
    font-family: 'YEONGJU';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/2403@1.0/YEONGJUSeonbiTTF.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

@font-face {
    font-family: 'Ownglyph_meetme-Rg';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_1@1.0/Ownglyph_meetme-Rg.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'DOSGothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_eight@1.0/DOSGothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

*{
	margin:0;
	padding:0;
}

.search_body {
    height: 600px;
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.search_body img {
	object-fit:cover;
}

.beach_button {
    width: 470px;
    height: 250px;
    position: absolute;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    margin-bottom: 50px;
}

/* 각 beach_button의 위치를 임의로 지정하여 간격 조절 */
.beach_button:nth-child(1) {
    top: -50px;
}

.beach_button:nth-child(2) {
    top: 100px; /* 예시로 250px 간격 설정 */
}

.beach_button:nth-child(3) {
    top: 250px; /* 예시로 500px 간격 설정 */
}

.beach_button:nth-child(4) {
    top: 400px; /* 예시로 500px 간격 설정 */
}
/* 필요한 만큼 각 beach_button에 대해 위치 조절 */
/* 나머지 beach_button에 대해서도 동일한 방법으로 간격 조절 가능 */


.infomation{
	width:100%;
	height:180px;
	position:absolute;
	display: flex;
	flex-direction:column;
	align-items: center;
	justify-content: center;
	margin-bottom: 20px;
}

.beach_name {
	font-family: 'Ownglyph_meetme-Rg';
	font-size: 30px;
	text-align: center;
	background-color: rgba(255,255,255,0.5);
	margin-bottom: 10px;
}

.beach_address{
	font-family: 'DOSGothic';
	font-size: 16px;
	text-align: center;
}



</style>
</head>
<body>
<div class="search_body">
<img alt="" src="./resources/image/dlvpDzohdp_20230531151658.jpg" width="600px" height="800px">
	<c:forEach items="${list}" var="aa">
	
		<div class="beach_button" onclick="alert('바다 정보를 보러갈게요! 로딩에는 시간이 조금 걸리니 기다려주세요!'); window.opener.location.href='sea_result?beach_code=${aa.beach_code}';
		setTimeout(function() { self.close(); }, 2000)">
		<img alt="" src="./resources/image/Surfboard-01.png" width="450px">
			<div class="infomation">
				<div class="beach_name">${aa.beach_name}</div>
				<div class="beach_address">${aa.address}</div>
			</div>
		</div>
		
	</c:forEach>
	
</div>
</body>
</html>