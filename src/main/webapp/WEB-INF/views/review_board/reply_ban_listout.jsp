<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    

<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/ban_lists.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>바라는 바다! :: 신고 내역</title>

<script>
	document.addEventListener("DOMContentLoaded", function() {
	    var choice_report = document.getElementById("report_type");
	    choice_report.addEventListener("change", function() {
	        var selected_value = this.value;
	        if (selected_value === "reply_report") {
	            window.location.href = "reply_ban_listout";
	        } else if (selected_value === "chat_report") {
	            window.location.href = "one_ban_listout";
	        }
	        else{window.location.href = "review_ban_listout";}
	    });
	});
</script>

</head>
<body>

<c:choose>
<c:when test="${loginstate==true && position=='admin'}">
	
<div class="container">	
	<div class="select_views">
    <select id="report_type">
        <option value="post_report">신고된 게시글</option>
        <option value="reply_report" selected>신고된 댓글</option>
        <option value="chat_report">신고된 한마디</option>
    </select>
	</div>
	
	<div class="list_container">
		<div class="ban_table">
		<table class="board-table">
		<thead>
		<tr>	
			<th scope="col" class="th-r_user">신고자</th>
			<th scope="col" class="th-r_title">댓글내용</th>
			<th scope="col" class="th-r_text">게시물</th>
			<th scope="col" class="th-r_reported">댓글 작성자</th>
			<th scope="col" class="th-r_reason">신고분류</th>
			<th scope="col" class="th-r_reason">신고사유</th>
			<th scope="col" class="th-r_date">신고날짜</th>
		</tr>
		</thead>
        

		<c:forEach items="${list}" var="l">
		<tr>
		
			<td> <a href="member_detail?user_number=${l.user_number}">
			${l.name}(${l.id})</a></td>
			<td>
			<a href="#" onclick="confirmDeleteBan('${l.review_reply_ban_num}')">
			${l.reply_contents}</a></td>     	
			<td>
			<a href="review_detail?review_num=${l.review_num}">원본글 보기</a>
			</td>
			
			<td> <a href="member_detail?user_number=${l.ban_user_number}">
			${l.ban_name}(${l.ban_id})</a></td>
			
			<td>${l.reason}</td>
			<td>${l.detail}</td>
			
			<td>${fn:substring(l.ban_date, 0, 19)}</td>
			
		</tr>
		</c:forEach>
			      
		<!--  페이징 처리 6단계 -->
		<!-- 페이징처리 -->
		<tr style="border-left: none; border-right: none; border-bottom: none;">
		   <td colspan="7" style="text-align: center;">
		   <c:if test="${paging.startPage!=1 }">
		   	 <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
		      <a href="reply_ban_listout?nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
		      
		   </c:if>   
		   
		      <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
		         <c:choose>
		            <c:when test="${p == paging.nowPage }">
		            <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
		               <b><span style="color: red;">${p}</span></b>
		            </c:when>   
		            <c:when test="${p != paging.nowPage }">
		            <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
		               <a href="reply_ban_listout?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
		            </c:when>   
		         </c:choose>
		      </c:forEach>
		     
		      <c:if test="${paging.endPage != paging.lastPage}">
		      <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
		      <a href="reply_ban_listout?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
		   </c:if>
		   
		   </td>
		</tr>
	<!-- 페이징처리 -->
	<!-- 페이징 처리 6단계 끝 -->
	</table>
	</div>
	</div>
</div>   
</c:when>

<c:otherwise>

<script>
	window.onload = function() {
	    alert("관리자 외 접근할 수 없는 페이지 입니다.");
	    window.location.href = "${pageContext.request.contextPath}/main";
	};
</script>
	        
</c:otherwise>
</c:choose>	    

	
	<script type="text/javascript">
	function confirmDeleteBan(review_reply_ban_num) {
	    if(confirm('해당 신고 내역을 정말 삭제하시겠습니까?')) {
	        location.href = 'reply_ban_delete?review_reply_ban_num=' + review_reply_ban_num;
	    }
	}
	</script>


</body>
</html>