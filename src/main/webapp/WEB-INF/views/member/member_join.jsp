<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>

<html>

<head>
   <meta http-equiv="X-UA-Compatible" content="IE=edge" />
   <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <meta charset="UTF-8">
   <title>바라는 바다! :: 회원가입</title>
   <link href="${pageContext.request.contextPath}/resources/css/join.css" rel="stylesheet" type="text/css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {
    	var idValid = false; // 아이디 중복 검사 결과를 저장할 변수
        var emailValid = false; // 이메일 중복 검사 결과를 저장할 변수
        checkSubmitButton();
        
        function checkSubmitButton() {
            if (idValid && emailValid) { // 아이디와 이메일 중복 검사 모두 성공 시
                $("#submitBtn").prop("disabled", false); // 제출 버튼 활성화
            } else {
                $("#submitBtn").prop("disabled", true); // 제출 버튼 비활성화
            }
            console.log('checkSubmitButton 이후 idValid: '+idValid);
        	console.log('checkSubmitButton 이후 emailValid: '+emailValid);
        }
        
        
        $("#idcheck").click(function () {
            var id = $("#id").val();
            
            // 아이디가 비어 있을 때 아이디 중복 검사를 할 경우
            if (id.trim() === "") {
                alert("아이디를 입력해주세요.");
                return;
            }
            
            var id = $("#id").val();
            
            // 아이디 유효성 검사
            var idPattern = /^[a-zA-Z0-9]{6,20}$/;
            
            if(!idPattern.test(id)) {
                alert("아이디는 영문, 숫자를 포함해 6자~20자 사이여야 합니다.");
                return false;
            }

            $.ajax({
                type: "post",
                async: true,
                dataType: "text",
                url: "idcheck",
                data: {"id": id},
                success: function (result) {
                    if (result == "ok") {
                        alert("사용 가능한 아이디입니다.");
                        idValid = true; // 아이디 중복 검사 결과를 true로 설정
                        checkSubmitButton();
                    } 
                    else {
                        alert("중복된 아이디입니다.");
                        idValid = false; // 아이디 중복 검사 결과를 false로 설정
                        checkSubmitButton();
                    }
                },
                error: function () {
                    alert("오류가 발생했습니다.");
                }
            });
        });
        
        
        $("#emailcheck").click(function () {
            var email = $("#email").val();
            
            // 이메일이 비어 있을 때 이메일 중복 검사를 할 경우
            if (email.trim() === "") {
                alert("이메일을 입력해주세요.");
                return;
            }

            $.ajax({
                type: "post",
                async: true,
                dataType: "text",
                url: "emailcheck",
                data: {"email": email},
                success: function (result) {
                    if (result == "ok") {
                        alert("사용 가능한 이메일입니다.");
                        emailValid = true; // 이메일 중복 검사 결과를 true로 설정
                        checkSubmitButton();
                    } 
                    else {
                        alert("이미 가입된 이메일입니다.");
                        emailValid = false; // 이메일 중복 검사 결과를 false로 설정
                        checkSubmitButton();
                    }
                },
                error: function () {
                    alert("오류가 발생했습니다.");
                }
            });
        });

        
        // 아이디나 이메일 입력창 값 변경 시 중복 검사 결과 초기화
        $("#id").on("input", function () {
            idValid = false;
            checkSubmitButton();
            console.log('input 변경 시 idValid: '+idValid);
        });
        
        $("#email").on("input", function () {
            emailValid = false;
            checkSubmitButton();
          	console.log('input 변경 시 emailValid: '+emailValid);
        });
        
        
        // 회원 가입 버튼 클릭 시
          $("#submitBtn").click(function () {
          	console.log('idValid: '+idValid);
          	console.log('emailValid: '+emailValid);
          	
       	    if (!idValid || !emailValid) {
       	        alert("아이디와 이메일 중복 검사를 먼저 완료해주세요.");
       	        return false; // 회원가입 제출 중단
       	    }
       	    
       	    if (idValid && emailValid){
              
              var pw = $("#pw").val();
              var pw2 = $("#pw2").val();
              var name = $("#name").val();
              var email = $("#email").val();
              var gender = $("input[name='gender']:checked").val();
              var age = $("#age option:selected").val();
      
      
              // 패스워드 유효성 검사
              var pwPattern = /^[a-zA-Z0-9]{6,20}$/;
              if (!pwPattern.test(pw)) {
                  alert("비밀번호는 영문, 숫자를 포함해 6자~20자 사이여야 합니다.");
                  return false;
              }
      
              // 패스워드 확인
              if (pw != pw2) {
                  alert("비밀번호가 일치하지 않습니다.");
                  return false;
              }
              
              // 닉네임 확인
              var namePattern = /^[가-힣a-zA-Z0-9]{2,10}$/;
              if(!namePattern.test(name)){
                 alert("닉네임은 한글, 영어 대소문자, 숫자만을 포함하여 2~10글자 사이여야 합니다.");
                 return false;
              }
      
              // 이메일 유효성 검사
              var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
              if (!emailPattern.test(email)) {
                  alert("올바른 이메일 형식이 아닙니다.");
                  return false;
              }
              
              // 성별 선택 확인
              if (!$("input[name='gender']").is(":checked")) {
                  alert("성별을 선택해주세요.");
                  return false;
              }

              // 연령대 선택 확인
              if ($("#age option:selected").val() == "") {
                  alert("연령대를 선택해주세요.");
                  return false;
              }
      
              // 모든 조건 통과 시 폼 제출
				document.forms['member_save_form'].submit();
       	    }
				
          });
      });
    </script>
</head>



<body>

<c:choose>
<c:when test="${loginstate==false || position=='admin'}">

<div class="join_logo">
<img src="./resources/image/로고 9-1.png" width="200px" >
</div>

<div class="memberform">
   
   <form action="member_save" method="post" name="member_save_form">
      
      <div class="form_text">
      회원이 되어주세요!
      </div>
      <br><hr><br>
      <div class="form_title">&nbsp;아이디</div>
      <div class="join_input">
      <input type="text" name="id" id="id" placeholder="영어 소문자와 숫자를 포함해 6-20자" required>
      <input type="button" value="중복 확인" id="idcheck" class="btn_1">
      </div>
      <br>
       <div class="form_title">&nbsp;비밀번호</div>
       <div class="join_input">
       <input type="password" name="pw" id="pw" placeholder="영어 소문자와 숫자를 포함해 6-20자" required>
       </div>
       <br>
       <div class="form_title">&nbsp;비밀번호 확인</div>
      <div class="join_input">
      <input type="password" id="pw2" placeholder="비밀번호를 한 번 더 써주세요." required>
      </div>
      <br>
       <div class="form_title">&nbsp;닉네임</div>
      <div class="join_input">
      <input type="text" id="name" name="name" placeholder="닉네임을 입력해주세요." required>
      </div>
      <br>
       <div class="form_title">&nbsp;이메일</div>
      <div class="join_input">
      <input type="text" id="email" name="email" placeholder="이메일을 ----@--.- 형식으로 입력해주세요." required>
      <input type="button" value="중복 확인" id="emailcheck" class="btn_1">
      </div>
      <br>
      <div class="join_radio">
      <div class="form_title">&nbsp;성별</div>
      <label for="male" class="radio_btn">
      <input type="radio" name="gender" value="male" id="male" required>
      <span class="on"></span>
      남성
      </label>
      <label for="female" class="radio_btn">
      <input type="radio" name="gender" value="female" id="female" required>
      <span class="on"></span>
      여성
      </label>
      <label for="other" class="radio_btn">
      <input type="radio" name="gender" value="other" id="other" required>
      <span class="on"></span>
      기타(밝히고 싶지 않음 외)
      </label>
      </div>
      <br>
      <div class="form_title">&nbsp;연령대</div>
      <div class="join_select">
      <select id="age" name="age" required>
          <option value="">나이대를 선택해주세요.</option>
          <option value="10">10대 이하</option>
          <option value="20">20대</option>
          <option value="30">30대</option>
          <option value="40">40대</option>
          <option value="50">50대</option>
          <option value="60">60대 이상</option>
      </select>
      </div>
      <input type="hidden" name="bbti" value="${bbti}">
      <br><hr><br>
      <div class="submit_btns">
      <button id="submitBtn" class="btn_2"><span id="btn_text">회원가입</span></button>
      <button onclick="location.href='./'"class="btn_2 backbtn"><span id="btn_text">돌아가기</span></button>
      </div>

    </form>
    
</div>
    
    </c:when>
    
    <c:otherwise>

      <script>
         window.onload = function() {
             alert("로그인한 회원은 새로 회원가입할 수 없습니다.");
             window.location.href = "${pageContext.request.contextPath}/main";
         };
       </script>

   </c:otherwise>
   
</c:choose>

</body>

</html>