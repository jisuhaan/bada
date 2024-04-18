<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BBTI 결과지</title>
<style type="text/css">
*{
	margin:0;
	padding:0;
}

.bbti_body {
	position: relative;
	height: 800px; /* 필요에 따라 높이 조정 */
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}


.bbti_btn2 {
	position: absolute;
	display:flex;
	justify-content: space-around;
	bottom: 20px; /* 원하는 여백 조정 */
}

.bbti_inputself,
.bbti_restart {
	display: block;
	margin-right: 10px;
}

.bbti_inputself,
.bbti_restart:hover{
	cursor:pointer;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

function go_list(id){
	window.opener.location.href='bbti_list?id='+id;
	window.close();
}

function go_restart(id){
	alert('BBTI 테스트를 새로 하러 이동할게요!');
	window.location.href='member_try_bbti?id='+id;
}

</script>
</head>
<body>

<input type="hidden" name="id" id="id" value="${id}">
<div class="bbti_body result ${bbti}">
	<img src="./resources/image_bbti/bbti_result_${bbti}.png" width="600px" height="800px">
	<div class="bbti_btn2">
		<div class="bbti_inputself" onclick="go_list('${id}')"><img src="./resources/image_bbti/bbti_inputself.png" width="150px"></div>
		<div class="bbti_restart" onclick="go_restart('${id}')"><img src="./resources/image_bbti/bbti_restart.png" width="150px"></div>
	</div>
	<input type="hidden" name="bbti" id="bbti" value="${bbti}">
</div>

</body>
</html>