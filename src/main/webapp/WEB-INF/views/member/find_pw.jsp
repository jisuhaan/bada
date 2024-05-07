<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 찾기</title>
<style type="text/css">

    .main-container {
        width: 300px;
        height: 330px;
        margin: 120px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    
    #id {
     	margin-top: 30px;
    }

    #id,#email,#search_pw {
        width: 90%;
        padding: 10px;
        margin: 10px auto;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
    }

    button {
        background-color: #0047ab;
        margin-top: 15px;
        color: white;
        font-weight: bold;
        cursor: pointer;
    }

    button:hover {
        background-color: #00337f;
    }

	#search_id {
		margin-top: 5px;
        float: left;
    }
    
    #login {
    	margin-top: 5px;
        float: right;
    }

</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	$("#search_pw").click(function(){
	
	var id = $("#id").val();
	var email = $("#email").val();
	
	$.ajax({
		
		type:"POST",
		url:"look_pw",
		async:true,
		dataType:"json",
		data:{"id":id,"email":email},
		success:function(result){
			
			 if(result.error){
                 alert(result.error);
             } else {
                 alert(result.name+" 님의 비밀번호 찾기 결과입니다." + "\n비밀번호 : " + result.pw);
             }
			
		},error: function(){
			
			alert("데이터 전송 과정에서 에러가 발생했습니다.");
		}
		
	});
		
		
	});
	
	
	
});


</script>
</head>
<body>

<div class="main-container">
    <h2>비밀번호 찾기</h2>
    <input type="text" id="id" placeholder="아이디">
    <input type="email" id="email" placeholder="이메일">
    <button id="search_pw">비밀번호 찾기</button>
    <div class="link_text">
        <a id="search_id" onclick="location.href='find_id'">아이디찾기</a>
        <a id="login" onclick="location.href='login'">로그인하기</a>
    </div>
</div>




</body>
</html>