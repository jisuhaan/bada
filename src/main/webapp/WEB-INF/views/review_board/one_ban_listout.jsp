<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    

<!DOCTYPE html>
<html>
<head>

	<style>
        table {
            margin: 0 auto;
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            text-align: center;
            font-size: 13px; /* 텍스트 크기를 작게 설정 */
            padding: 4px; /* 셀 안의 여백 설정 */
        }
        th:nth-child(1) {
            width: 14%;
        }
        th:nth-child(2){
        width: 14%;
        }
        th:nth-child(3){
        width: 50%;
        }
        th:nth-child(4){
        width: 14%;
        }
        .lock-icon {
            display: inline-block; /* 이미지를 인라인 블록 요소로 설정하여 텍스트와 같이 정렬 */
            vertical-align: middle; /* 아이콘을 수직 가운데 정렬 */
        }
    </style>
    
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

	<br> <br> <br>
	
	<div style="margin-bottom: 20px;">
    <select id="report_type">
        <option value="post_report" >신고된 게시글</option>
        <option value="reply_report">신고된 댓글</option>
        <option value="chat_report" selected>신고된 한마디</option>
    </select>
	</div>
	
	<!-- option 값에 따라 변동될 부분 -->	
	<br>
		<table id="one_table" border="1">
	
			      <tr>
			      	 <th>신고자</th>
			         <th>신고당한 회원</th>
			         <th>신고된 한마디</th>
			         <th>신고 날짜</th>
			         <th>신고 삭제</th>
			      </tr>
		         
<c:choose>

<c:when test="${loginstate==true && position=='admin'}">

<c:forEach items="${list}" var="l">
			      <tr>
			        <td>${l.name}(${fn:substring(l.id, 0, 4)}****) 님</td>
			      	<td> <a href="member_detail?user_number=${l.ban_user_number}">
			      	${l.ban_name}(${fn:substring(l.ban_id, 0, 4)}****) 님</a></td>
			      	
			      	<td>${l.ban_content}</td>
			      	<td>${fn:substring(l.ban_date, 0, 19)}</td>
			      	<td><a href="#" onclick="confirmDeleteBan('${l.one_ban_num}')">
			            <img src="./resources/image/delete_icon.png" width="17px"></a></td>
			      </tr>
			      </c:forEach>
			      
		<!--  페이징 처리 6단계 -->
		<!-- 페이징처리 -->
		<tr style="border-left: none; border-right: none; border-bottom: none;">
		   <td colspan="7" style="text-align: center;">
		   <c:if test="${paging.startPage!=1 }">
		   	 <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
		      <a href="one_ban_listoutt?nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
		      
		   </c:if>   
		   
		      <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
		         <c:choose>
		            <c:when test="${p == paging.nowPage }">
		            <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
		               <b><span style="color: red;">${p}</span></b>
		            </c:when>   
		            <c:when test="${p != paging.nowPage }">
		            <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
		               <a href="one_ban_listout?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
		            </c:when>   
		         </c:choose>
		      </c:forEach>
		     
		      <c:if test="${paging.endPage != paging.lastPage}">
		      <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
		      <a href="one_ban_listout?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
		   </c:if>
		   
		   </td>
		</tr>
		<!-- 페이징처리 -->
	<!-- 페이징 처리 6단계 끝 -->
			      
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
	        
	    </table>
	    
	<br> <br> <br> <br> <br>
	
	<script type="text/javascript">
	function confirmDeleteBan(review_reply_ban_num) {
	    if(confirm('해당 신고 내역을 정말 삭제하시겠습니까?')) {
	        location.href = 'one_ban_delete?one_ban_num='+one_ban_num;
	    }
	}
	</script>


</body>
</html>