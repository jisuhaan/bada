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

.result {
    position: relative;
    height: 800px; /* 필요에 따라 높이 조정 */
    display: flex;
    flex-direction: row; /* 수평으로 나열 */
    text-align: center;
    justify-content: center;
    align-items: center;
}

.bbti_btn2 {
	position: absolute;
	display:flex;
	justify-content: space-around;
	bottom: 20px; /* 원하는 여백 조정 */
}

.bbti_selected,
.bbti_inputself,
.bbti_restart {
	display: block;
	margin-right: 10px;
}

.bbti_selected,
.bbti_inputself,
.bbti_restart:hover{
	cursor:pointer;
}

.bbti_yes,
.bbti_choose,
.bbti_no {
	display: block;
	margin-bottom: 10px; /* 각 버튼 사이의 여백 조정 */
}

.bbti_yes,
.bbti_choose,
.bbti_no:hover {
	cursor:pointer;
}

.selectE,
.selectI,
.selectA,
.selectP,
.selectF,
.selectN {
	display: block;
	margin-bottom: 10px; /* 각 버튼 사이의 여백 조정 */
	bottom: 30px;
}

.selectE,
.selectI,
.selectA,
.selectP,
.selectF,
.selectN:hover{
	cursor:pointer;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$(".question").hide();
	$(".result").hide();

	const id = $("#id").val(); 
	
	let countE = 0;
	let countI = 0;
	let countA = 0;
	let countP = 0;
	let countF = 0;
	let countN = 0;
	let resultcode;
	
	$(".bbti_no").click(function(){
		alert("아쉬워요... 다음엔 해주실거죠?");
		window.location.href='main';
	});
	
	$(".bbti_choose").click(function(){
		
		console.log("userid : "+id);
		
		var conf = confirm("큰 화면에서 bbti 전체 목록을 보여드릴게요! 이동할까요?")
		if(conf){
			window.opener.location.href="bbti_list?id="+id;
			self.close();
		}
		
	});
	
	$(".bbti_yes").click(function(){
		$(".start").hide();
		$(".q1").show();
		console.log("userid : "+id);
		console.log("-------start-------");
	});
	
	$(".selectE").click(function(){
		countE++;
		console.log("E : "+countE);
		console.log("I : "+countI);
		console.log("A : "+countA);
		console.log("P : "+countP);
		console.log("F : "+countF);
		console.log("N : "+countN);
		console.log("-------------")
	});
	
	$(".selectI").click(function(){
		countI++;
		console.log("E : "+countE);
		console.log("I : "+countI);
		console.log("A : "+countA);
		console.log("P : "+countP);
		console.log("F : "+countF);
		console.log("N : "+countN);
		console.log("-------------")
	});

	$(".selectA").click(function(){
		countA++;
		console.log("E : "+countE);
		console.log("I : "+countI);
		console.log("A : "+countA);
		console.log("P : "+countP);
		console.log("F : "+countF);
		console.log("N : "+countN);
		console.log("-------------")
	});
	
	$(".selectP").click(function(){
		countP++;
		console.log("E : "+countE);
		console.log("I : "+countI);
		console.log("A : "+countA);
		console.log("P : "+countP);
		console.log("F : "+countF);
		console.log("N : "+countN);
		console.log("-------------")
	});
	
	$(".selectF").click(function(){
		countF++;
		console.log("E : "+countE);
		console.log("I : "+countI);
		console.log("A : "+countA);
		console.log("P : "+countP);
		console.log("F : "+countF);
		console.log("N : "+countN);
		console.log("-------------")
	});
	
	$(".selectN").click(function(){
		countN++;
		console.log("-------------")
		console.log("E : "+countE);
		console.log("I : "+countI);
		console.log("A : "+countA);
		console.log("P : "+countP);
		console.log("F : "+countF);
		console.log("N : "+countN);
		console.log("-------------")
	});
	
	$(".bbti_q1").click(function(){
		$(".q1").hide();
		$(".q2").show();		
	});
	
	$(".bbti_q2").click(function(){
		$(".q2").hide();
		$(".q3").show();		
	});
	
	$(".bbti_q3").click(function(){
		$(".q3").hide();
		$(".q4").show();		
	});
	
	$(".bbti_q4").click(function(){
		$(".q4").hide();
		$(".q5").show();		
	});
	
	$(".bbti_q5").click(function(){
		$(".q5").hide();
		$(".q6").show();		
	});
	
	$(".bbti_q6").click(function(){
		$(".q6").hide();
		$(".q7").show();		
	});
	
	$(".bbti_q7").click(function(){
		$(".q7").hide();
		$(".q8").show();		
	});
	
	$(".bbti_q8").click(function(){
		$(".q8").hide();
		$(".q9").show();		
	});
	
	$(".bbti_q9").click(function(){
		$(".q9").hide();
		$(".q10").show();		
	});
	
	$(".bbti_q10").click(function(){	
		
		
		if(countE>countI){
			if(countA>countP){
				if(countF>countN){
					resultcode = "EAF";
				}
				else{
					resultcode = "EAN";
				}
			}
			else{
				if(countF>countN){
					resultcode = "EPF";
				}
				else{
					resultcode = "EPN";
				}
			}
		}
		else{
			if(countA>countP){
				if(countF>countN){
					resultcode = "IAF";
				}
				else{
					resultcode = "IAN";
				}
			}
			else{
				if(countF>countN){
					resultcode = "IPF";
				}
				else{
					resultcode = "IPN";
				}
			}
		}
		
		console.log("bbti : "+resultcode);
		
		$(".q10").hide();
		$("."+resultcode).show();
		
		$(".bbti_restart").click(function(){
			
			alert('테스트를 처음부터 다시 진행할게요!');
			
			$("."+resultcode).hide();
			$(".start").show();
			
			resultcode = null;
			countE = 0;
			countI = 0;
			countA = 0;
			countP = 0;
			countF = 0;
			countN = 0;
		});
		
		$(".bbti_inputself").click(function(){
			
			var conf = confirm("큰 화면에서 bbti 전체 목록을 보여드릴게요! 이동할까요?")
			if(conf){
				window.opener.location.href="bbti_list?id="+id;
				self.close();
			}
			
		});
		
		$(".bbti_selected").click(function(){
			
			if(!id || id.trim() === ''){
				
				var bbti_join = confirm("아직 로그인을 안 하셨네요! 로그인하시겠어요? (로그인하면 bbti 정보가 자동으로 저장된답니다! 해당 페이지에서 회원가입을 하셔도 저장됩니다!)");
				
				if(bbti_join){
					window.opener.location.href="login_with?bbti="+resultcode;
					self.close();
				}
				else{
					var bbti_quit = confirm("로그인하지 않으면 bbti 테스트 정보를 잃게 돼요. 로그인하지 않고 메인으로 이동할까요?")
					if(bbti_quit){
		                window.opener.location.href = './';
		                self.close();
					}
				}
			}
			
			else{
			
				$.ajax({
					type:"POST",
		            url:"bbti_save",
		            async:true,
		            dataType:"text",
		            data:{"id":id,"bbti":resultcode},
		            success:function(result){
		            	
		            	if(result=='ok'){
		            		
			                alert("bbti가 성공적으로 저장되었어요. 메인으로 이동할게요!");
			                window.opener.location.href = './';
			                self.close();
			                
		            	}
		            	
		            	else{
		            		
		            		var conf2 = confirm("이미 테스트하신적이 있네요! bbti 정보를 현재 결과로 덮어쓸까요?");
		            		if(conf2){
		            			window.location.href="bbti_save2?id="+id+"&bbti="+resultcode;
		            		}
		            		else{
		            			alert("기존 정보를 유지합니다! 메인으로 돌아갈게요.");
				                window.opener.location.href = './';
				                self.close();
		            		}
		            	}
		            	
		            },
		            error: function(){
		                alert("데이터 전송 과정에 에러가 발생했습니다!");
		            }
			            				
				});
			
			}

		});
		
	});
	
	
});


</script>
</head>
<body>

<div class="bbti_body start">
	<input type="hidden" name="id" id="id" value="${id}">
	<img src="./resources/image_bbti/bbti_main.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_yes"><img src="./resources/image_bbti/bbti_yes.png" width="300px"></div>
		<div class="bbti_choose"><img src="./resources/image_bbti/bbti_choose.png" width="300px"></div>
		<div class="bbti_no"><img src="./resources/image_bbti/bbti_no.png" width="300px"></div>
	</div>
</div>

<div class="bbti_body question q1">
	<img src="./resources/image_bbti/bbti_q1.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q1 selectE"><img src="./resources/image_bbti/bbti_q1_E.png" width="400px"></div>
		<div class="bbti_q1 selectI"><img src="./resources/image_bbti/bbti_q1_I.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body question q2">
	<img src="./resources/image_bbti/bbti_q2.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q2 selectE"><img src="./resources/image_bbti/bbti_q2_E.png" width="400px"></div>
		<div class="bbti_q2 selectI"><img src="./resources/image_bbti/bbti_q2_I.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body question q3">
	<img src="./resources/image_bbti/bbti_q3.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q3 selectI"><img src="./resources/image_bbti/bbti_q3_I.png" width="400px"></div>
		<div class="bbti_q3 selectE"><img src="./resources/image_bbti/bbti_q3_E.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body question q4">
	<img src="./resources/image_bbti/bbti_q4.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q4 selectP"><img src="./resources/image_bbti/bbti_q4_P.png" width="400px"></div>
		<div class="bbti_q4 selectA"><img src="./resources/image_bbti/bbti_q4_A.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body question q5">
	<img src="./resources/image_bbti/bbti_q5.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q5 selectA"><img src="./resources/image_bbti/bbti_q5_A.png" width="400px"></div>
		<div class="bbti_q5 selectP"><img src="./resources/image_bbti/bbti_q5_P.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body question q6">
	<img src="./resources/image_bbti/bbti_q6.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q6 selectA"><img src="./resources/image_bbti/bbti_q6_A.png" width="400px"></div>
		<div class="bbti_q6 selectP"><img src="./resources/image_bbti/bbti_q6_P.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body question q7">
	<img src="./resources/image_bbti/bbti_q7.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q7 selectF"><img src="./resources/image_bbti/bbti_q7_F.png" width="400px"></div>
		<div class="bbti_q7 selectN"><img src="./resources/image_bbti/bbti_q7_N.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body question q8">
	<img src="./resources/image_bbti/bbti_q8.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q8 selectF"><img src="./resources/image_bbti/bbti_q8_F.png" width="400px"></div>
		<div class="bbti_q8 selectN"><img src="./resources/image_bbti/bbti_q8_N.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body question q9">
	<img src="./resources/image_bbti/bbti_q9.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q9 selectN"><img src="./resources/image_bbti/bbti_q9_N.png" width="400px"></div>
		<div class="bbti_q9 selectF"><img src="./resources/image_bbti/bbti_q9_F.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body question q10">
	<img src="./resources/image_bbti/bbti_q10.png" width="600px" height="800px">
	<div class="bbti_btn">
		<div class="bbti_q10 weather"><img src="./resources/image_bbti/bbti_q10_weather.png" width="400px"></div>
		<div class="bbti_q10 review"><img src="./resources/image_bbti/bbti_q10_review.png" width="400px"></div>
	</div>
</div>

<div class="bbti_body result EAF">
	<img src="./resources/image_bbti/bbti_result_EAF.png" width="600px" height="800px">
	<div class="bbti_btn2">
		<div class="bbti_selected"><img src="./resources/image_bbti/bbti_selected.png" width="170px"></div>
		<div class="bbti_inputself"><img src="./resources/image_bbti/bbti_inputself.png" width="170px"></div>
		<div class="bbti_restart"><img src="./resources/image_bbti/bbti_restart.png" width="170px"></div>
	</div>
	<form action="login_with_bbti" name="bbti_form">
	<input type="hidden" name="bbti" id="bbti" value="EAF">
	</form>
</div>

<div class="bbti_body result EAN">
	<img src="./resources/image_bbti/bbti_result_EAN.png" width="600px" height="800px">
	<div class="bbti_btn2">
		<div class="bbti_selected"><img src="./resources/image_bbti/bbti_selected.png" width="170px"></div>
		<div class="bbti_inputself"><img src="./resources/image_bbti/bbti_inputself.png" width="170px"></div>
		<div class="bbti_restart"><img src="./resources/image_bbti/bbti_restart.png" width="170px"></div>
	</div>
	<form action="login_with_bbti" name="bbti_form">
	<input type="hidden" name="bbti" id="bbti" value="EAN">
	</form>
</div>

<div class="bbti_body result EPF">
	<img src="./resources/image_bbti/bbti_result_EPF.png" width="600px" height="800px">
	<div class="bbti_btn2">
		<div class="bbti_selected"><img src="./resources/image_bbti/bbti_selected.png" width="170px"></div>
		<div class="bbti_inputself"><img src="./resources/image_bbti/bbti_inputself.png" width="170px"></div>
		<div class="bbti_restart"><img src="./resources/image_bbti/bbti_restart.png" width="170px"></div>
	</div>
	<form action="login_with_bbti" name="bbti_form">
	<input type="hidden" name="bbti" id="bbti" value="EPF">
	</form>
</div>

<div class="bbti_body result EPN">
	<img src="./resources/image_bbti/bbti_result_EPN.png" width="600px" height="800px">
	<div class="bbti_btn2">
		<div class="bbti_selected"><img src="./resources/image_bbti/bbti_selected.png" width="170px"></div>
		<div class="bbti_inputself"><img src="./resources/image_bbti/bbti_inputself.png" width="170px"></div>
		<div class="bbti_restart"><img src="./resources/image_bbti/bbti_restart.png" width="170px"></div>
	</div>
	<form action="login_with_bbti" name="bbti_form">
	<input type="hidden" name="bbti" id="bbti" value="EPN">
	</form>
</div>

<div class="bbti_body result IAF">
	<img src="./resources/image_bbti/bbti_result_IAF.png" width="600px" height="800px">
	<div class="bbti_btn2">
		<div class="bbti_selected"><img src="./resources/image_bbti/bbti_selected.png" width="170px"></div>
		<div class="bbti_inputself"><img src="./resources/image_bbti/bbti_inputself.png" width="170px"></div>
		<div class="bbti_restart"><img src="./resources/image_bbti/bbti_restart.png" width="170px"></div>
	</div>
	<form action="login_with_bbti" name="bbti_form">
	<input type="hidden" name="bbti" id="bbti" value="IAF">
	</form>
</div>

<div class="bbti_body result IAN">
	<img src="./resources/image_bbti/bbti_result_IAN.png" width="600px" height="800px">
	<div class="bbti_btn2">
		<div class="bbti_selected"><img src="./resources/image_bbti/bbti_selected.png" width="170px"></div>
		<div class="bbti_inputself"><img src="./resources/image_bbti/bbti_inputself.png" width="170px"></div>
		<div class="bbti_restart"><img src="./resources/image_bbti/bbti_restart.png" width="170px"></div>
	</div>
	<form action="login_with_bbti" name="bbti_form">
	<input type="hidden" name="bbti" id="bbti" value="IAN">
	</form>
</div>

<div class="bbti_body result IPF">
	<img src="./resources/image_bbti/bbti_result_IPF.png" width="600px" height="800px">
	<div class="bbti_btn2">
		<div class="bbti_selected"><img src="./resources/image_bbti/bbti_selected.png" width="170px"></div>
		<div class="bbti_inputself"><img src="./resources/image_bbti/bbti_inputself.png" width="170px"></div>
		<div class="bbti_restart"><img src="./resources/image_bbti/bbti_restart.png" width="170px"></div>
	</div>
	<form action="login_with_bbti" name="bbti_form">
	<input type="hidden" name="bbti" id="bbti" value="IPF">
	</form>
</div>

<div class="bbti_body result IPN">
	<img src="./resources/image_bbti/bbti_result_IPN.png" width="600px" height="800px">
	<div class="bbti_btn2">
		<div class="bbti_selected"><img src="./resources/image_bbti/bbti_selected.png" width="170px"></div>
		<div class="bbti_inputself"><img src="./resources/image_bbti/bbti_inputself.png" width="170px"></div>
		<div class="bbti_restart"><img src="./resources/image_bbti/bbti_restart.png" width="170px"></div>
	</div>
	<form action="login_with_bbti" name="bbti_form">
	<input type="hidden" name="bbti" id="bbti" value="IPN">
	</form>
</div>

</body>
</html>