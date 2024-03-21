<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">

.main {
    width: 350px;
    height: 300px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    border: 1px solid lightgrey;
    border-radius: 5px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); /* 수평 및 수직으로 50% 이동하여 가운데 정렬 */
    
}

.parent-container {
    position: relative; /* 부모 요소를 relative로 설정 */
}

.logo {
    margin-top: 0px;
    margin-bottom: 40px;
}

.account {
    display: block;
    margin: 5px 0;
    margin-bottom: 3px;
    padding: 3px;
    border: 1px solid lightgray;
    border-radius: 3px;
    width: calc(100% - 10px);
}

.account input {
    width: 100%;
}

.container {
    display: flex;
    flex-direction: column; /* 입력 필드와 버튼들을 수직으로 배치 */
    align-items: center; /* 수직정렬 */
    margin-top: 20px; /* 버튼과 입력 필드 사이의 간격 조절 */
}


#sign #login_search {
    width: 32%;
}


#login {
    width: 100%;
    background-color: skyblue;
    border-color: transparent;
    color: white;
}

#sign {
    width: 50%;
    background-color: #fba600;
    border-color: transparent;
    color: white;
}

#login_search {
    width: 50%;
    background-color: #0B909E;
    border-color: transparent;
    color: white;
}


</style>

<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">


$(document).ready(function(){
	
	var errstack = 0;
	
	$("#login").click(function(){
		
		var id = $("#id").val();
		var pw = $("#pw").val();
		
		
		$.ajax({
			
			type:"post",
			url:"login_save",
			async:true,
			dataType:"text",
			data:{"id":id,"pw":pw},
			success:function(result){
				
				if(result=="no"){
					
					errstack ++;
					
					if(errstack>=3){
						alert("로그인 3회 오류! 회원가입/회원정보 찾기 창으로 이동합니다!")
						window.location="sign" // 회원가입창으로 이동 or (회원정보 찾기)
					}
					else{
						alert("일치하는 회원정보가 존재하지 않습니다!")
						window.location="login"
					}
					
				}
				else{
					alert(id+"님, 로그인 되었습니다!")
					window.location.replace("./")
				}	
			},
			
			error: function(){
				alert("데이터 전송 과정에 에러가 발생했습니다!")
			}
			
		});
	});
	
});


</script>
<title>바라던 바다 :: 로그인</title>
</head>
<body>

<div class="main">
        <h1 class="logo">bada_login</h1>
        <div class="container">
            <input type="text" name="id" placeholder="ID" id="id" class="account">
            <input type="password" name="pw" placeholder="Password" id="pw" class="account">
            	<button id="login" class="account">로그인</button>
            	<button id="login_search" class="account">회원정보찾기</button>
            	<button id="sign" class="account">회원가입</button>

        </div>
    </div>   


</body>
</html>