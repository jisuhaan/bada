<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/inquire_detail.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<meta charset="UTF-8">
<title>바라는 바다! :: 문의글</title>

</head>
<body>

<div class="container">

<div class="inquire_container">
       
	<table class="title_table">
	<tr>     
		<th id="list_title" width="10%">제목</th>
		<td id="list_contents" width="65%">${dto.title}</td>
		<th id="category" width="25%">[${dto.category}]</th>
	</tr>
	</table>
	
	<div class="listboxout">
		<div class="listbox replies"> 
			<div id="list_title">답변 상태</div>
			<div id="replystate">${dto.reply == 0 ? '미응답' : '완료'}</div>
		</div>
		<div class="listbox writer">
			<div id="list_title">작성자</div>
			<div id="inquire_writer">${dto.name}(${fn:substring(dto.id, 0, 4)}****) 님</div>
		</div>
	</div>
 
 		<div class="listbox rec_hit">
		<div id="list_title">추천수</div> ${dto.rec}
		<div id="list_title">조회수</div> ${dto.cnt}
		<div id="writeday">${fn:substring(dto.i_date, 0, 19)}</div>
	</div>

	<div class="inquire-images">
		<c:choose>
		<c:when test="${not dto.pic1.equals('nope')}">
			<div><img src="./resources/image_user/${dto.pic1}"></div>
		</c:when>
		<c:otherwise> </c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${not dto.pic2.equals('nope')}">
			<div><img src="./resources/image_user/${dto.pic2}"></div>
		</c:when>
		<c:otherwise> </c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${not dto.pic3.equals('nope')}">
			<div><img src="./resources/image_user/${dto.pic3}"></div>
		</c:when>
		<c:otherwise> </c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${not dto.pic4.equals('nope')}">
			<div><img src="./resources/image_user/${dto.pic4}"></div>
		</c:when>
		<c:otherwise> </c:otherwise>
		</c:choose>
		<c:choose>
		<c:when test="${not dto.pic5.equals('nope')}">
			<div><img src="./resources/image_user/${dto.pic5}"></div>
		</c:when>
		<c:otherwise> </c:otherwise>
		</c:choose>
	</div>
	
	<c:choose>
		<c:when test="${dto.pic1.equals('nope')}">
		
		</c:when>
		<c:otherwise>
		<script type="text/javascript">
			$(document).ready(function(){
				
				 $('.inquire-images').slick({
				 	autoplay:true,
				 	autoplaySpeed: 2000,
					dots: true,
					arrows: true,
					infinite: true,
				 	pauseOnHover: true,
				 	fade:false,
					draggable: true,
					cssEase: 'linear'
				 });
				 
			});	
		</script>
		</c:otherwise>
	</c:choose>

	<div class="listbox content">
	 	<div id="list_title">문의내용</div>
	 	<div class="list_contents">${dto.content}</div>
	</div>

<c:choose>
<c:when test="${loginid eq dto.id || position=='admin'}">
<div class="action_btns">

	<div class="update_btn">
		<img src="./resources/image/modify_icon.png" width="20px" class="like_icon" onclick="window.location.href='inquire_modify?inquire_num=${dto.inquire_num}'">
		수정하기
	</div>
	<div class="delete_btn">
		<img src="./resources/image/delete_icon.png" width="20px" class="report_icon" onclick="confirmDelete('${dto.inquire_num}')">
		삭제하기
	</div>
	<div class="list_btn">
		<input type="button" value="목록으로" onclick="window.location.href='inquire_listout'">
	</div>
</div>
</c:when>  	
<c:otherwise>
<c:choose>

<c:when test="${loginstate==true}">
  
<span style="float: left;">
<a href="inquire_report_view?inquire_num=${dto.inquire_num}&loginid=${loginid}"> <img src="./resources/image/report_icon.png" width="20px" class="report_icon"></a>
<br> 신고하기
</span>
<a href="inquire_listout"><input type="button" value="목록으로 돌아가기"></a>
<span style="float: right;">
<a href="inquire_recommand?inquire_num=${dto.inquire_num}&loginid=${loginid}"> <img src="./resources/image/like_icon.png" width="20px" class="like_icon"> </a>
<br>추천 ${dto.rec}
</span>
  
</c:when>

<c:otherwise>
 
<a href="inquire_listout"><input type="button" value="목록으로 돌아가기"></a>
<br><br><br><br><br>
로그인한 회원만 추천, 신고 기능을 이용할 수 있습니다.
<br><br><br>

  
  </c:otherwise>
  </c:choose>
  
  </c:otherwise>
  
  </c:choose>

</div>   
   
 

<div class="comments_container">  
    <!-- 댓글 영역 -->   
<c:forEach items="${list}" var="l">

<td colspan="2" style="text-align: left;">관리자
<span style="float: right;">${fn:substring(l.inquire_reply_date, 0, 19)}</span>



<td colspan="2" style="border: 2px solid #000; padding: 8px; height: 80%; padding-left: 50px;">
<div style="width: 90%; height: 90%;">
${l.content}
</div>
    
</c:forEach>

<c:choose>
<c:when test="${loginstate==true && position=='admin'}">

<tr id="reply_${l.inquire_reply_num}">
<td colspan="2">
&nbsp;
<a href="#" onclick="confirm_reply_Delete('${l.inquire_reply_num}' , '${dto.inquire_num}')">
<img src="./resources/image/delete_icon.png" width="15px"></a>
&nbsp; &nbsp; &nbsp;
<a href="#" onclick="createEditForm('${l.inquire_reply_num}', '${dto.inquire_num}', '${l.content}')">
<img src="./resources/image/modify_icon.png" width="15px">
</a>
<br> 삭제 &nbsp; &nbsp;수정
			    
            
<div class="reply_input_area">
<textarea name="reply" id="reply" placeholder="문의에 대한 답은 1500자 이하로 입력하세요." required></textarea>
</div>
<div class="button_area">
<input type="hidden" name="inquire_num" value="${dto.inquire_num}">
<input type="submit" id="replybtn" value="답 작성하기">
</div>



</c:when>

</c:choose>
            

</div>    

</div>




</body>
</html>
