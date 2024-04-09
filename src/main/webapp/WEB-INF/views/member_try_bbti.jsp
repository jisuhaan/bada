<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
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

.bbti_btn {
	position: absolute;
	bottom: 20px; /* 원하는 여백 조정 */
}

.bbti_yes,
.bbti_choose,
.bbti_no {
	display: block;
	margin-bottom: 10px; /* 각 버튼 사이의 여백 조정 */
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$(".question").hide();

	const id = $("#id").val(); 
	
	const countE = 0;
	const countI = 0;
	const countA = 0;
	const countP = 0;
	const countF = 0;
	const countN = 0;
	
	$(".bbti_yes").click(function(){
		$(".start").hide();
		$(".q1").show();
	});
	
	
});


</script>
</head>
<body>
	
<div class="bbti_body start">
	<input type="hidden" name="id" id="id" value="${id}">
	<img src="./resources/image/bbti_main.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_yes"><a href=""><img src="./resources/image/bbti_yes.png" width="300px"></a></div>
		<div class="bbti_choose"><img src="./resources/image/bbti_choose.png" width="300px"></div>
		<div class="bbti_no"><img src="./resources/image/bbti_no.png" width="300px"></div>
	</div>
</div>

<div class="bbti_body question q1">
	<img src="./resources/image/bbti_main.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_no"><a href=""><img src="./resources/image/bbti_choose.png" width="300px"></a></div>
		<div class="bbti_choose"><img src="./resources/image/bbti_no.png" width="300px"></div>
	</div>
</div>

<div class="bbti_body question q2">
	<img src="./resources/image/bbti_main.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_yes"><a href=""><img src="./resources/image/bbti_yes.png" width="300px"></a></div>
		<div class="bbti_choose"><img src="./resources/image/bbti_choose.png" width="300px"></div>
		<div class="bbti_no"><img src="./resources/image/bbti_no.png" width="300px"></div>
	</div>
</div>
	
</body>
</html>