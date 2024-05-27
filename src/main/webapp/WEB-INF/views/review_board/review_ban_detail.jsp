<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>

 <style>
	.container {
		margin: 0 auto;
		margin-top:100px;
		display: flex;
		justify-content: center;
		align-items: center;
		width:700px;
	}
	form {
		margin: 0 auto;
		display: flex;
		justify-content: center;
		align-items: center;
		width:100%;		
	}
	table {
	    width: 100%;
	    margin: 0 auto;
	    font-size: 14px;
	    border-collapse: collapse;
		border-spacing: 0;
		background-color: rgba(247,247,247,0.9);
    }
      
	table a {
		color: #1c1c1c;
		display: inline-block;
		line-height: 1.4;
		word-break: break-all;
		vertical-align: middle;
		cursor: pointer;
}
	th, td {
		text-align: left;
		padding: 8px;
	}
	th {
		color: #1c1c1c;
		width:150px !important;
		background-color: #B3B3B3;
	}
	td {
		border-bottom: 1px solid #ddd;
		vertical-align: middle;
	}
	.right-align {
		text-align: right;
	}
</style>
  
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:choose>
<c:when test="${loginstate==true && position=='admin'}">

<div class="container">
<form action="#" method="post">
        <table>
            <tr>
                <th>제목</th>
                <td style="text-align: left;">${dto.title}</td>
                <th>신고자</th>
				<td><span style="float: right;">${dto.name}(${dto.id})</span></td>
            </tr>
			<tr>
				<th>신고사유</th>
				<td style="text-align: left;">[${dto.category}]</td>
				<th>신고일자</th>
				<td><span style="float: right;">${fn:substring(dto.ban_date, 0, 19)}</span></td>
			</tr>
            <tr>
				 <td colspan="4" style="text-align: left; background-color: #B3B3B3;">
        			<a href="review_detail?review_num=${dto.ban_review_num}">신고된 원본 글로 이동</a>
					<span style="float: right;">
					신고된 회원:
					<a href="member_detail?user_number=${dto.ban_user_number}">
					${dto.ban_name}(${dto.ban_id}) 
					</a>님
					</span>
			    </td>
			</tr>
            <tr>
                <td colspan="4" style="border: 2px solid #000; padding: 20px; height: 100px; vertical-align: middle;">
					${dto.content}
				</td>
            </tr>
            <tr>
			    <td colspan="4">    
		       		<div class="btnlists" style="display:flex; justify-content:space-between; gap:500px; align-items:center; text-align: center;">
						<div class="deletebtn" onclick="confirmDeleteBan('${dto.review_report_num}')"  style="width:150px; display: flex; flex-direction: column; justify-content: center; align-items: center;">
						<img src="./resources/image/delete_icon.png" width="20px" class="">
						<span>신고삭제</span>
						</div>
						<div class="listbtn" onclick="window.location.href='review_ban_listout'" style="width:150px; display: flex; flex-direction: column; justify-content: center; align-items: center;">
							<img src="./resources/image/icon_tolist.png" width="20px" class="">
						<span>목록으로</span>
						</div>
					</div>
			    </td>
            </tr>
            
            <tr>
                <td colspan="4" style="text-align: center;">
                동일한 회원이 신고를 받은 횟수: ${ban_count}개 
			    </td>
			    <c:forEach items="${list}" var="list">
			    <tr>
			    <td colspan="4">
				    신고글 제목: <a href="review_ban_detail?ban_review_num=${list.ban_review_num}&ban_id=${list.ban_id}">${list.title}</a>
				    <span style="float: right;">
				    신고자: <a href="member_detail?user_number=${list.user_number}"> ${list.name}(${list.id})</a>님
			      	</span>
			    </td>
			    <tr>
			    </c:forEach>
            </tr>
            
        </table>
    </form>
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
	    
	<br> <br> <br> <br> <br>
	
	
<script type="text/javascript">
function confirmDeleteBan(review_report_num) {
    if(confirm('해당 신고 내역을 정말 삭제하시겠습니까?')) {
        location.href = 'review_ban_delete?review_report_num=' + review_report_num;
    }
}
</script>


</body>
</html>