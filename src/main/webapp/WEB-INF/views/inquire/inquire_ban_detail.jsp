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
    
    	html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        table {
            width: 80%;
            margin: 0 auto;
            font-size: 14px;
            border-collapse: collapse;
            height: 500px
        }
        th, td {
            text-align: left;
            padding: 8px;
        }
        th {
            border-bottom: 1px solid #ddd;
            width: 10%;
        }
        td {
            border-bottom: 1px solid #ddd;
            vertical-align: top;
        }
        .right-align {
            text-align: right;
        }
    </style>
</head>

<body>

<c:choose>
<c:when test="${loginstate==true && position=='admin'}">


<form action="#" method="post">
        <table>
            <caption>문의 신고 자세히 보기</caption>
            <tr>
                <th>제목</th>
                <td style="text-align: left;">${dto.title} <span style="float: right;">${dto.name}(${fn:substring(dto.id, 0, 4)}****) 님</span></td>
            </tr>
            <tr>
                <th>신고 사유</th>
                <td style="text-align: left;">[${dto.category}] <span style="float: right;">${fn:substring(dto.ban_date, 0, 19)}</span></td>
            </tr>
            <tr>
				 <td colspan="2" style="text-align: left;">
				     <a href="to_inquire_detail?inquire_num=${dto.ban_inquire_num}">신고된 원본 글로 이동</a>
				     <span style="float: right;">
				         신고된 회원:
				         <a href="member_detail?user_number=${dto.ban_user_number}">
				             ${dto.ban_name}(${fn:substring(dto.ban_id, 0, 4)}****) 
			            </a>님
			        </span>
			    </td>
			</tr>
            <tr>
                <td colspan="2" style="border: 2px solid #000; padding: 8px; height: 80%; padding-left: 50px;">
    				<div style="width: 90%; height: 90%;">
				        ${dto.content}
				        <br><br><br><br><br>
				    </div>
				</td>
            </tr>
            
            <tr>
                <td colspan="2" style="text-align: left;">
                		<a href="#" onclick="confirmDeleteBan('${dto.i_banned_num}')">
    						&nbsp; &nbsp; &nbsp;<img src="./resources/image/delete_icon.png" width="20px" class=""></a>
		        		<br> 신고 삭제
			        <span style="float: right;">
			        	<a href="inquire_ban_listout"><input type="button" value="목록으로 돌아가기"></a>
			        </span>
			    </td>
            </tr>
            
            <tr>
                <td colspan="2" style="text-align: center;">
                동일한 회원이 신고를 받은 횟수: ${ban_count}개 <br> <br>
			    </td>
			    <c:forEach items="${dto2}" var="d">
			    <tr>
			    <td colspan="2">
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