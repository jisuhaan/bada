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
        .chat_wrap .item.mymsg .box .msg{background:#fee600;}
        
        .chat_wrap .item .box1{display:inline-block; max-width: 400px; position:relative}
        .chat_wrap .item .box1::before{content:""; position:absolute; left:-8px; top:9px; border-top:0px solid transparent; border-bottom:8px solid transparent;border-right:8px solid #fff;}
        .chat_wrap .item .box1 .msg {background:#fff; border-radius:10px; padding:8px; text-align:left; word-break: break-word;}
        .chat_wrap .item .box1 .time {font-size:11px; color:#999; position:absolute; right: -75px; bottom:5px; width:70px}
        .chat_wrap .item.mymsg .box1::before{left:auto; right:-8px; border-left:8px solid #ffb6c1; border-right:0;}
        .chat_wrap .item.mymsg .box1 .msg{background:#ffb6c1;}
        .chat_wrap .item.mymsg .box1 .time{right:auto; left:-75px}
        .chat_wrap .item.mymsg .box1{transition:all .3s ease-out; margin:0 20px 0 0; }
        
        .chat_wrap .item .box3{display:inline-block; max-width: 400px; position:relative}
        .chat_wrap .item .box3::before{content:""; position:absolute; left:-8px; top:9px; border-top:0px solid transparent; border-bottom:8px solid transparent;border-right:8px solid #fff;}
        .chat_wrap .item .box3{display:inline-block; max-width: 400px; position:relative}
        .chat_wrap .item .box3::before{content:""; position:absolute; left:-8px; top:9px; border-top:0px solid ffb6c1; border-bottom:8px solid transparent;border-right:8px solid #ffb6c1;}
        .chat_wrap .item .box3 .msg {background:#ffb6c1; border-radius:10px; padding:8px; text-align:left; word-break: break-word;}
        .chat_wrap .item .box3 .time {font-size:11px; color:#999; position:absolute; right: -75px; bottom:5px; width:70px}
        .chat_wrap .item .box3{transition:all .3s ease-out; margin:0 0 0 20px;opacity:1;}
        
        .chat_wrap .item .box1 .icon {position: absolute; right: -73px; bottom: 6px; opacity: 0.6;}
		.chat_wrap .item.mymsg .box1 .icon1 {position: absolute; left: -71px; bottom: 6px; opacity: 0.6;}
        
        .chat_wrap .item.mymsg .box .time{right:auto; left:-75px}
        .chat_wrap .item .box{transition:all .3s ease-out; margin:0 0 0 20px;opacity:1;} /* 초기 메시지의 투명도를 1로 설정하여 표시 */
        .chat_wrap .item.mymsg .box{transition:all .3s ease-out; margin:0 20px 0 0; }
        .chat_wrap .item.on .box{margin:0; opacity: 1;}
        
        .chat_wrap .item .box .icon {position: absolute; right: -73px; bottom: 6px; opacity: 0.6;}
		.chat_wrap .item.mymsg .box .icon2 {position: absolute; left: -71px; bottom: 6px; opacity: 0.6;}
        
        .loginplz {border: 0; width: 99%; background: #ddd; border-radius: 5px; height: 60px; padding-left: 5px; box-sizing: border-box; margin-top: 5px; text-align: center; line-height: 60px;}

		.chat_wrap .inner .header{z-index: 1; position: sticky; top: 0; border: 0; width: 79%; background: #F8F8FF; border-radius: 3px; height: 40px; box-sizing: border-box; text-align: center; padding-top: 10px; display: inline-block; vertical-align: middle;}
		select#sort_loc{z-index: 1; position: sticky; top: 0; border:0; width:20%;background:#ddd; border-radius:5px; height:40px; padding-left:5px; box-sizing:border-box; display: inline-block; vertical-align: middle;}
		.chat_wrap .inner .header h2{margin: 0; font-size: 20px; }		
		
        input[type="text"]{border:0; width:74%;background:#FFFFFF; border-radius:5px; height:40px; padding-left:5px; box-sizing:border-box; margin-top:5px; }
		input[type="submit"]{border:0; width:12%; background:#ffc400; border-radius:5px; height:40px; padding-left:5px; box-sizing:border-box; margin-top:5px;}	
		select#loc{border:0; width:12%;background:#ddd; border-radius:5px; height:40px; padding-left:5px; box-sizing:border-box; margin-top:5px;}
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

<script type="text/javascript">
function confirm_one_Ban(one_num, id) {
    if (confirm('채팅을 신고하시겠습니까?')) {
        // AJAX를 사용하여 서버에 요청을 보내고, 성공적으로 처리되면 알림창을 표시합니다.
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'one_ban?one_num=' + one_num + '&id=' + id, true);
        xhr.onload = function() {
            if (xhr.status === 200) {
                alert('신고가 완료되었습니다.');
                // 신고가 성공적으로 완료되었으므로 원하는 추가 작업을 수행할 수 있습니다.
            } else if (xhr.status === 409) {
                var response = xhr.responseText; // 서버에서 반환한 응답 데이터
                if (response === 'duplicate_report') {
                    alert('중복 신고는 불가능합니다.');
                    // 중복 신고일 때의 처리를 여기에 추가할 수 있습니다.
                } else {
                    alert('신고 처리 중 오류가 발생했습니다.');
                    // 다른 오류 상황에 대한 처리를 여기에 추가할 수 있습니다.
                }
            }
        };
        xhr.onerror = function() {
            alert('신고 처리 중 오류가 발생했습니다.');
            // 통신 오류가 발생했을 때의 처리를 여기에 추가할 수 있습니다.
        };
        xhr.send();
    }
}
</script>

<script type="text/javascript">
function confirm_one_Delete(one_num) {
    if(confirm('채팅을 정말 삭제하시겠습니까?')) {
        location.href = 'one_delete?one_num=' + one_num;
    }
}
</script>

<script type="text/javascript">
$(document).ready(function() {
    // 채팅창이 로드될 때마다 스크롤을 가장 아래로 이동합니다.
    $('.inner').scrollTop($('.inner')[0].scrollHeight);
});
</script>

<script type="text/javascript">
$(document).ready(function() {
    // 새로운 채팅이 추가될 때마다 스크롤을 가장 아래로 이동합니다.
    function scrollToBottom() {
        $('.inner').scrollTop($('.inner')[0].scrollHeight);
    }

    // 페이지가 로드될 때 스크롤을 가장 아래로 이동합니다.
    scrollToBottom();

    // 메시지를 전송한 후에도 스크롤을 가장 아래로 이동합니다.
    $('form').submit(function() {
        scrollToBottom();
    });
});
</script>

    
</head>
<body>



<form action="say_one_save" method="post">

	<c:choose>
	<c:when test="${position=='admin'}">
	
	<div class="chat_wrap">
    <div class="inner">
    
    <div class="header">
    <h2>실시간 나도 한마디 채팅창♡</h2>
    </div>
    
    <select name="sort_loc" id="sort_loc">
		<option value="전국">전국 한마디</option>
		<option value="경기인천">경기·인천 한마디</option>
		<option value="강원">강원 한마디</option>
		<option value="충남">충남 한마디</option>
		<option value="경북">경북 한마디</option>
		<option value="전북">전북 한마디</option>
		<option value="전남">전남 한마디</option>
		<option value="경남">경남 한마디</option>
		<option value="부산울산">부산·울산 한마디</option>
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
                
                <span class="icon">
                <a href="#" onclick="confirm_one_Delete('${l.one_num}')">
			            <img src="./resources/image/delete_icon.png" width="17px"></a>
			    </span> <!-- icon의 끝 -->
			    
            </div><!-- box 끝 -->
        </div><!-- item 끝 -->
        
        </c:when>
        
        <c:otherwise>
        
        <div class="item mymsg">
            <div class="box1">
                <p class="msg">
					[${l.loc}/관리자]: ${l.content}
                </p> <!-- msg 끝 -->
                <span class="time">${fn:substring(l.one_date, 2, 19)}</span>
                
                <span class="icon1">
                 <a href="#" onclick="confirm_one_Delete('${l.one_num}')">
			            <img src="./resources/image/delete_icon.png" width="17px"></a>
			    </span> <!-- icon1 끝 -->
			    
            </div><!-- box 끝 -->
             </div> <!-- item mymsg 끝 -->
            
        </c:otherwise>
        
	</c:choose>
	
	</c:forEach>
	
    </div><!-- inner 끝 -->
	
	<select name="loc" id="loc" required="required">
		<option value="전국">전국</option>
		<option value="경기인천">경기·인천</option>
		<option value="강원">강원</option>
		<option value="충남">충남</option>
		<option value="경북">경북</option>
		<option value="전북">전북</option>
		<option value="전남">전남</option>
		<option value="경남">경남</option>
		<option value="부산울산">부산·울산</option>
		<option value="제주">제주</option>
	</select>
	
	<input type="hidden" name="id" value="${dto.id}">
	<input type="hidden" name="name" value="${dto.name}">
    <input type="text" class="mymsg" name="content" placeholder="지금, ${dto.name} 님도 한마디!">
    <input type="submit" class="msgbutton" value="전송">
    
    </div> <!-- chatwrap 끝 -->

	</c:when>
	
	
	
	
	
	<c:otherwise>


<c:choose>
<c:when test="${loginstate==true}">



    <div class="chat_wrap">
    <div class="inner">
    
    <div class="header">
    <h2>실시간 나도 한마디 채팅창♡</h2>
    </div><!-- header의 끝 -->
    
    <select name="sort_loc" id="sort_loc">
		<option value="전국">전국 한마디</option>
		<option value="경기인천">경기·인천 한마디</option>
		<option value="강원">강원 한마디</option>
		<option value="충남">충남 한마디</option>
		<option value="경북">경북 한마디</option>
		<option value="전북">전북 한마디</option>
		<option value="전남">전남 한마디</option>
		<option value="경남">경남 한마디</option>
		<option value="부산울산">부산·울산 한마디</option>
		<option value="제주">제주 한마디</option>
	</select>
	
	
	<c:forEach items="${list}" var="l">
    
    
    
   <c:choose>
    <c:when test="${dto.id != l.id}">
    
    
    <c:choose>
    <c:when test="${l.id=='admin'}">

        <div class="item">
            <div class="box3">
                <p class="msg">
                	[${l.loc}/관리자]: ${l.content}
                </p>
                <span class="time">${fn:substring(l.one_date, 2, 19)}</span> 
            </div><!-- box3 끝 -->
        </div><!-- item 끝 -->
        
      </c:when>
      
      
      <c:otherwise>
        <div class="item">
            <div class="box">
                <p class="msg">
                	[${l.loc}/${l.name}]: ${l.content}
                </p>
                <span class="time">${fn:substring(l.one_date, 2, 19)}</span> <!-- time 끝 -->
                <span class="icon">
                <a href="#" onclick="confirm_one_Ban('${l.one_num}','${dto.id}')">
			            <img src="./resources/image/report_icon.png" width="15px"></a>
			    </span> <!-- icon 끝 -->
            </div><!-- box 끝 -->
        </div><!-- item 끝 -->
        
       </c:otherwise>
       </c:choose>
        
        
        </c:when>
        
        <c:otherwise>
        
        <div class="item mymsg">
            <div class="box">
                <p class="msg">
					[${l.loc}/나]: ${l.content}
                </p> <!-- msg의 끝 -->
                <span class="time">${fn:substring(l.one_date, 2, 19)}</span> <!-- time 끝 -->
                <span class="icon2">
                 <a href="#" onclick="confirm_one_Delete('${l.one_num}')">
			            <img src="./resources/image/delete_icon.png" width="17px"></a>
			    </span> <!-- icon2 끝 -->
            </div><!-- box 끝 -->
             </div> <!-- item mymsg 끝 -->
            
        </c:otherwise>
        
	</c:choose>
	</c:forEach>
	
    </div><!-- inner 끝 -->
	
	<select name="loc" id="loc" required="required">
		<option value="전국">전국</option>
		<option value="경기인천">경기·인천</option>
		<option value="강원">강원</option>
		<option value="충남">충남</option>
		<option value="경북">경북</option>
		<option value="전북">전북</option>
		<option value="전남">전남</option>
		<option value="경남">경남</option>
		<option value="부산울산">부산·울산</option>
		<option value="제주">제주</option>
	</select>
	
	<input type="hidden" name="id" value="${dto.id}">
	<input type="hidden" name="name" value="${dto.name}">
    <input type="text" class="mymsg" name="content" placeholder="지금, ${dto.name} 님도 한마디!">
    <input type="submit" class="msgbutton" value="전송">
    
    </div> <!-- chat wrap 끝 -->
    
     </c:when>
     
     
     
     
     
	
	<c:otherwise>
	
	<div class="chat_wrap">
    <div class="inner">
    
    <div class="header">
    <h2>실시간 나도 한마디 채팅창♡</h2>
    </div><!-- header의 끝 -->
    
    <select name="sort_loc" id="sort_loc">
		<option value="전국">전국 한마디</option>
		<option value="경기인천">경기·인천 한마디</option>
		<option value="강원">강원 한마디</option>
		<option value="충남">충남 한마디</option>
		<option value="경북">경북 한마디</option>
		<option value="전북">전북 한마디</option>
		<option value="전남">전남 한마디</option>
		<option value="경남">경남 한마디</option>
		<option value="부산울산">부산·울산 한마디</option>
		<option value="제주">제주 한마디</option>
	</select>
	
	<c:forEach items="${list}" var="l">
	
	
	<c:choose>
    <c:when test="${l.id=='admin'}">

        <div class="item">
            <div class="box3">
                <p class="msg">
                	[${l.loc}/관리자]: ${l.content}
                </p>
                <span class="time">${fn:substring(l.one_date, 2, 19)}</span> 
			    
            </div><!-- box 끝 -->
        </div><!-- item 끝 -->
      </c:when>
      
      <c:otherwise>
        <div class="item">
            <div class="box">
                <p class="msg">
                	[${l.loc}/${l.name}]: ${l.content}
                </p>
                <span class="time">${fn:substring(l.one_date, 2, 19)}</span>
			    
            </div><!-- box 끝 -->
        </div><!-- item 끝 -->
       </c:otherwise>
       
       </c:choose> 
       
       </c:forEach>
       
       </div><!-- inner 끝 -->
       
       
	<div class="loginplz">
	<h3><a href="login">로그인</a> 한 회원은 '나도 한마디'에 참여할 수 있어요.</h3>
	</div>
	</div>
	
	</c:otherwise>
	
	</c:choose>
 
 
 </c:otherwise>
 
</c:choose>
 

</form>
    
</body>
</html>
