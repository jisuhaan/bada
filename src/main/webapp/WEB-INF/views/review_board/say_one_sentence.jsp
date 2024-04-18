<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>바라는 바다! :: 나도 한마디</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css"/>
    <script src="https://code.jquery.com/jquery-1.8.3.min.js" integrity="sha256-YcbK69I5IXQftf/mYD8WY0/KmEDCv1asggHpJk1trM8=" crossorigin="anonymous"></script>

    <style>
        .chat_wrap { border:1px solid #999; width:700px; padding:5px; font-size:13px; color:#333}
        .chat_wrap .inner{background-color:#acc2d2; border-radius:5px; padding:10px; overflow-y:scroll;height: 700px;}
        .chat_wrap .item{margin-top:15px}
        .chat_wrap .item:first-child{margin-top:0px}
        .chat_wrap .item .box{display:inline-block; max-width: 400px; position:relative}
        .chat_wrap .item .box::before{content:""; position:absolute; left:-8px; top:9px; border-top:0px solid transparent; border-bottom:8px solid transparent;border-right:8px solid #fff;}
        .chat_wrap .item .box .msg {background:#fff; border-radius:10px; padding:8px; text-align:left; word-break: break-word;}
        .chat_wrap .item .box .time {font-size:11px; color:#999; position:absolute; right: -75px; bottom:5px; width:70px}
        .chat_wrap .item.mymsg{text-align:right}
        .chat_wrap .item.mymsg .box::before{left:auto; right:-8px; border-left:8px solid #fee600; border-right:0;}
        .chat_wrap .item.mymsg .box .msg{background:#fee600}
        .chat_wrap .item.mymsg .box .time{right:auto; left:-75px}
        .chat_wrap .item .box{transition:all .3s ease-out; margin:0 0 0 20px;opacity:1;} /* 초기 메시지의 투명도를 1로 설정하여 표시 */
        .chat_wrap .item.mymsg .box{transition:all .3s ease-out; margin:0 20px 0 0;}
        .chat_wrap .item.on .box{margin:0; opacity: 1;}
        
        .loginplz {border: 0; width: 99%; background: #ddd; border-radius: 5px; height: 60px; padding-left: 5px; box-sizing: border-box; margin-top: 5px; text-align: center; line-height: 60px;}

		.chat_wrap .inner .header{border: 0; width: 79%; background: #F8F8FF; border-radius: 3px; height: 40px; box-sizing: border-box; text-align: center; padding-top: 10px; display: inline-block; vertical-align: middle;}
		select#sort_loc{border:0; width:20%;background:#ddd; border-radius:5px; height:40px; padding-left:5px; box-sizing:border-box; display: inline-block; vertical-align: middle;}
		.chat_wrap .inner .header h2{margin: 0; font-size: 20px; }		
		
        input[type="text"]{border:0; width:73%;background:#FFFFFF; border-radius:5px; height:40px; padding-left:5px; box-sizing:border-box; margin-top:5px; }
		input[type="submit"]{border:0; width:14%; background:#ffc400; border-radius:5px; height:40px; padding-left:5px; box-sizing:border-box; margin-top:5px;}	
		select#loc{border:0; width:11%;background:#ddd; border-radius:5px; height:40px; padding-left:5px; box-sizing:border-box; margin-top:5px;}
    </style>
    
    <script type="text/javascript">
$(document).ready(function() {
    $('#sort_loc').change(function() {
        var selectedLoc = $(this).val(); // sort_loc에서 선택된 값

        // 각 메시지 아이템에 대하여 반복
        $('.item').each(function() {
            // 메시지에서 지역과 닉네임을 추출합니다.
            var messageInfo = $(this).find('.msg').text().match(/\[(.*?)\/(.*?)\]/);
            if (messageInfo) {
                var messageLoc = messageInfo[1]; // 지역 정보
                var messageName = messageInfo[2]; // 닉네임 정보
            }

            // 전국이 선택된 경우 모든 메시지를 보이게 설정
            if (selectedLoc === "전국") {
                $(this).show();
            } else {
                // 선택된 지역과 메시지의 지역이 일치하는 경우 해당 메시지를 보이게 설정
                if (selectedLoc === messageLoc) {
                    $(this).show();
                } else {
                    // 선택된 지역과 메시지의 지역이 일치하지 않는 경우 해당 메시지를 숨김
                    $(this).hide();
                }
            }
        });
    });
});
</script>

    
</head>
<body>

<form action="say_one_save" method="post">

    <div class="chat_wrap">
    <div class="inner">
    
    <div class="header">
    <h2>실시간 나도 한마디 채팅창♡</h2>
    </div><!-- header의 끝 -->
    
    <select name="sort_loc" id="sort_loc">
		<option value="전국">전국 한마디</option>
		<option value="경인">경인 한마디</option>
		<option value="강원">강원 한마디</option>
		<option value="충남">충남 한마디</option>
		<option value="경북">경북 한마디</option>
		<option value="전북">전북 한마디</option>
		<option value="전남">전남 한마디</option>
		<option value="경남">경남 한마디</option>
		<option value="부산·울산">부산/울산 한마디</option>
		<option value="제주">제주 한마디</option>
	</select>
	
    
    <c:forEach items="${list}" var="l">
    <c:choose>
    <c:when test="${dto.id != l.id}">

        <div class="item">
            <div class="box">
                <p class="msg">
                	[${l.loc}/${l.name}]: ${l.content}
                </p>
                <span class="time">${fn:substring(l.one_date, 2, 19)}</span>
            </div><!-- box 끝 -->
        </div><!-- item 끝 -->
        
        </c:when>
        
        <c:otherwise>
        <div class="item mymsg">
            <div class="box">
                <p class="msg">
					[${l.loc}/나]: ${l.content}
                </p>
                <span class="time">${fn:substring(l.one_date, 2, 19)}</span>
            </div><!-- box 끝 -->
             </div> <!-- item mymsg 끝 -->
            
        </c:otherwise>
	</c:choose>
	</c:forEach>
	
    </div><!-- inner 끝 -->
	<c:choose>
	<c:when test="${loginstate==true}">
	
	<select name="loc" id="loc" required="required">
		<option value="전국">전국</option>
		<option value="경인">경인</option>
		<option value="강원">강원</option>
		<option value="충남">충남</option>
		<option value="경북">경북</option>
		<option value="전북">전북</option>
		<option value="전남">전남</option>
		<option value="경남">경남</option>
		<option value="부산·울산">부산/울산</option>
		<option value="제주">제주</option>
	</select>
	
	<input type="hidden" name="id" value="${dto.id}">
	<input type="hidden" name="name" value="${dto.name}">
    <input type="text" class="mymsg" name="content" placeholder="지금, ${dto.name} 님도 한마디!">
    <input type="submit" class="msgbutton" value="전송">
    
     </c:when>
	
	<c:otherwise>
	
	<div class="loginplz">
	<h3>로그인한 회원은 '나도 한마디'에 참여할 수 있어요.</h3>
	</div>
	
	</c:otherwise>
	
	</c:choose>
 
 </div> <!-- chat_wrap 끝 -->
 

</form>
    
</body>
</html>
