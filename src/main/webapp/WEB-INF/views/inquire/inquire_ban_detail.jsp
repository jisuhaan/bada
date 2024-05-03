<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html>

<head>

	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>바라는 바다! :: 문의 신고 상세 내역</title>

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
			<td colspan="4" style="text-align: left; background-color: #B3B3B3">
			<a href="to_inquire_detail?inquire_num=${dto.ban_inquire_num}">신고된 원본 글로 이동</a>
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
		<td colspan="4" style="text-align: left; padding-left:20px;">
		<div class="btnlists" onclick="confirmDeleteBan('${dto.i_banned_num}')" style="display:flex; justify-content:space-between; gap:500px; align-items:center; text-align: center;">
			<div class="deletebtn" style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
			<img src="./resources/image/delete_icon.png" width="20px" class="">
			<span>신고삭제</span>
			</div>
			<div class="listbtn" onclick="window.location.href='inquire_ban_listout'" style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
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
		<c:forEach items="${dto2}" var="d">
		<tr>
		<td colspan="4">
		 신고글 제목: <a href="inquire_ban_detail?i_banned_num=${d.i_banned_num}&ban_id=${d.ban_id}">${d.title}</a>
		<span style="float: right;">
		신고 대상: <a href="member_detail?user_number=${d.ban_user_number}"> ${d.ban_name}(${fn:substring(d.ban_id, 0, 4)}****) </a>님
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
function confirmDeleteBan(i_banned_num) {
    if(confirm('해당 신고 내역을 정말 삭제하시겠습니까?')) {
        location.href = 'inquire_ban_delete?i_banned_num=' + i_banned_num;
    }
}
</script>
	
	
</body>
</html>