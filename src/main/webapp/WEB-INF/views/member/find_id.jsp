<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style type="text/css">

    .main-container {
        width: 300px;
        height: 330px;
        margin: 120px auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    
    #name {
     	margin-top: 30px;
    }

    #name,#email,#search_id {
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

	#join {
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
	
	$("#search_id").click(function(){
	
	var name = $("#name").val();
	var email = $("#email").val();
	
	$.ajax({
		
		type:"POST",
		url:"look_id",
		async:true,
		dataType:"json",
		data:{"name":name,"email":email},
		success:function(result){
			
			 if(result.error){
                 alert(result.error);
             } else {
                 alert("이름 : " + result.name + "\n아이디 : " + result.id);
             }
			
		},error: function(){
			
			alert("데이터 전송 과정에 에러발생");
		}
		
	});
		
		
	});
	
	
	
});


</script>
</head>
<body>

<div class="main-container">
    <h2>아이디 찾기</h2>
    <input type="text" id="name" placeholder="이름">
    <input type="email" id="email" placeholder="이메일">
    <button id="search_id">아이디 찾기</button>
    <div class="link_text">
        <a id="join" onclick="location.href='member_join'">회원가입하기</a>
        <a id="login" onclick="location.href='login'">로그인하기</a>
    </div>
</div>




</body>
</html>