<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

@font-face {
    font-family: 'Ownglyph_meetme-Rg';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_1@1.0/Ownglyph_meetme-Rg.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

	body {
		display: flex;
		justify-content:center;
		align-items: center;
		
	}
	.bbti_container{
		width: 1200px;
		height: 90%;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	
	.title_box{
		width:400px;
		height:100px;
		display:flex;
		justify-content: center;
		align-items: center;
		border: 1px solid gray;
		border-radius:10px;
		box-shadow: 2px 2px 2px gray;
		background-color: white;
		margin-bottom: 50px;
	}
	
	#bbti_title{
		text-align: center;
		font-family:'Ownglyph_meetme-Rg';
		font-size: 72px;
	}
	
	img{
		width:400px;
	}
	
	.col{
		margin-bottom: 20px;
		display: flex;
		flex-direction:row;
		align-items: center;
		justify-content: center;
	}
	
	.row{
		margin-right: 20px;
		display: flex;
		justify-content: center;
		align-items: center;
		position: relative;
	}
	
	.bbti_selector{
		position: absolute;
		bottom: 10px;
		width:200px;
	}
	
	.bbti_selector:hover {
		cursor:pointer;
	}
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

function bbti_select(bbti) {
		
		var id = $("#id").val();
		console.log("아이디 : "+id);
		
		if(!id || id.trim() === ''){
			
			var bbti_join = confirm("아직 로그인을 안 하셨네요! 로그인하시겠어요? (로그인하면 bbti 정보가 자동으로 저장된답니다! 해당 페이지에서 회원가입을 하셔도 저장됩니다!)");
			
			if(bbti_join){
				window.location.href="login_with?bbti="+bbti;
			}
			else{
				var bbti_quit = confirm("로그인하지 않으면 bbti 테스트 정보를 잃게 돼요. 로그인하지 않고 메인으로 이동할까요?")
				if(bbti_quit){
	                window.location.href = './';
				}
			}
		}
		
		else{
		
			$.ajax({
				type:"POST",
	            url:"bbti_save",
	            async:true,
	            dataType:"text",
	            data:{"id":id,"bbti":bbti},
	            success:function(result){
	            	
	            	if(result=='ok'){
		                alert("bbti가 성공적으로 저장되었어요. 메인으로 이동할게요!");
		                window.location.href = './';
	            	}
	            	
	            	else{
	            		var conf2 = confirm("이미 테스트하신적이 있네요! bbti 정보를 현재 결과로 덮어쓸까요?");
	            		if(conf2){
	            			window.location.href="bbti_list_save?id="+id+"&bbti="+bbti;
	            		}
	            		else{
	            			alert("기존 정보를 유지합니다! 메인으로 돌아갈게요.");
			                window.location.href = './';
	            		}
	            	}
	            	
	            },
	            error: function(){
	                alert("데이터 전송 과정에 에러가 발생했습니다!");
	            }
		            				
			});
		
		}
}

</script>
</head>
<body>


<div class="bbti_container">
<div class="title_box">
	<h3 id="bbti_title">BBTI 리스트</h3>
</div>
<input type="hidden" name="id" id="id" value="${id}">
	<div class="col cline1">
		<div class="row rline1">
			<img src="./resources/image_bbti/bbti_result_EAF.png" class="bbti_image">
			<img src="./resources/image_bbti/bbti_selectthis.png" onclick="bbti_select('EAF')" class="bbti_selector">
		</div>
		<div class="row rline2">
			<img src="./resources/image_bbti/bbti_result_EAN.png">
			<img src="./resources/image_bbti/bbti_selectthis.png" onclick="bbti_select('EAN')" class="bbti_selector">
		</div>
	</div>
	<div class="col cline2">
		<div class="row rline1">
			<img src="./resources/image_bbti/bbti_result_EPF.png">
			<img src="./resources/image_bbti/bbti_selectthis.png" onclick="bbti_select('EPF')" class="bbti_selector">
		</div>
		<div class="row rline2">
			<img src="./resources/image_bbti/bbti_result_EPN.png">
			<img src="./resources/image_bbti/bbti_selectthis.png" onclick="bbti_select('EPN')" class="bbti_selector">
		</div>
	</div>
	<div class="col cline3">
		<div class="row rline1">
			<img src="./resources/image_bbti/bbti_result_IAF.png">
			<img src="./resources/image_bbti/bbti_selectthis.png" onclick="bbti_select('IAF')" class="bbti_selector">
		</div>
		<div class="row rline2">
			<img src="./resources/image_bbti/bbti_result_IAN.png">
			<img src="./resources/image_bbti/bbti_selectthis.png" onclick="bbti_select('IAN')" class="bbti_selector">
		</div>
	</div>
	<div class="col cline4">
		<div class="row rline1">
			<img src="./resources/image_bbti/bbti_result_IPF.png">
			<img src="./resources/image_bbti/bbti_selectthis.png" onclick="bbti_select('IPF')" class="bbti_selector">
		</div>
		<div class="row rline2">
			<img src="./resources/image_bbti/bbti_result_IPN.png">
			<img src="./resources/image_bbti/bbti_selectthis.png" onclick="bbti_select('IPN')" class="bbti_selector">
		</div>
	</div>
</div>
</body>
</html>