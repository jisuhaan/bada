<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html>

<head>

	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>바라는 바다! :: 1:1 문의 상세 내역</title>

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
            height: 500px;
        }
        th, td {
            text-align: left;
            padding: 8px;
            white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */
            overflow: hidden; /* 텍스트가 넘칠 경우 숨김 처리 */
            text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 부호로 처리 */
        }
        th {
            border-bottom: 1px solid #ddd;
            width: 10%;
            white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */
            overflow: hidden; /* 텍스트가 넘칠 경우 숨김 처리 */
            text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 부호로 처리 */
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


<form action="inquire_personal_reply" method="post">
        <table>
            <caption>1:1문의 자세히 보기</caption>
            <tr>
                <th>제목</th>
                <td style="text-align: left;">${dto.title}
                <span style="float: right;">
                <c:choose>
                <c:when test="${dto.id == 'nope'}">${dto.name}(비회원) 님</c:when>
                 <c:otherwise>${dto.name}(${fn:substring(dto.id, 0, 4)}****) 님</c:otherwise>
                 </c:choose> </span></td>
            </tr>
            <tr>
                <th>문의 카테고리</th>
                <td style="text-align: left;">[${dto.category}] <span style="float: right;">${fn:substring(dto.ip_date, 0, 19)}</span></td>
            </tr>
            <tr>
                <th>이메일 주소</th>
                <td style="text-align: left;">${dto.email}
                <span style="float: right;">${dto.tf}</span>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border: 2px solid #000; padding: 8px; height: 80%; padding-left: 50px;">
    				<div style="width: 90%; height: 90%;">
				        ${dto.content}
				        <br><br><br><br><br>
				        <c:choose>
						    <c:when test="${not dto.pic1.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic1}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
						<c:choose>
						    <c:when test="${not dto.pic2.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic2}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
						<c:choose>
						    <c:when test="${not dto.pic3.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic3}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
						<c:choose>
						    <c:when test="${not dto.pic4.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic4}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
						<c:choose>
						    <c:when test="${not dto.pic5.equals('nope')}">
						        <img src="./resources/image_user/${dto.pic5}" width="200px">
						    </c:when>
						    <c:otherwise> </c:otherwise>
						</c:choose>
				    </div>
				</td>
            </tr>
            
            <tr>
                <td colspan="2" style="text-align: left;">
                		<a href="#" onclick="confirmDeleteip('${dto.ip_num}')">
    						&nbsp; &nbsp; &nbsp;<img src="./resources/image/delete_icon.png" width="20px" class=""></a>
		        		<br> 문의 삭제
			        <span style="float: right;">
			        	<a href="inquire_personal_out"><input type="button" value="목록으로 돌아가기"></a>
			        </span>
			    </td>
            </tr>
            
            <tr>
            <c:choose>
            
                <c:when test="${dto.tf == '답변 완료'}">
                <th>문의에 답 하나 더 보내기</th>
                	<td>
                	<br><br><br>
                	<h3>이미 답변을 완료한 문의입니다. <br>
                	ezen.bada@gmail.com의 보낸 메일함에서 보낸 답변을 확인할 수 있습니다.<br><br><br> </h3>
                	<br><br>
                	<input type="hidden" name="ip_num" id="ip_num" value="${dto.ip_num}">
                	<input type="hidden" name="title" id="title" value="${dto.title}">
                	<input type="hidden" name="name" id="name" value="${dto.name}">
                	<input type="hidden" name="email" id="email" value="${dto.email}">
                	<input type="hidden" name="category" id="category" value="${dto.category}">
                	<input type="hidden" name="content" id="content" value="${dto.content}">
                	<input type="hidden" name="tf" id="tf" value="${dto.tf}">
                	<textarea cols="90" rows="5" name="reply" id="reply" placeholder="${dto.email}(으)로 답을 한 번 더 전송합니다." required></textarea>
                	<br>
                	<span style="float: right;">
                		<input type="submit" value="답 또 보내기">
                	</span>
                </td>
                </c:when>
                
                 <c:otherwise>
                 <th>문의에 답 보내기</th>
                	<td>
                	<br><br><br><br><br>
                	<input type="hidden" name="ip_num" id="ip_num" value="${dto.ip_num}">
                	<input type="hidden" name="title" id="title" value="${dto.title}">
                	<input type="hidden" name="name" id="name" value="${dto.name}">
                	<input type="hidden" name="email" id="email" value="${dto.email}">
                	<input type="hidden" name="category" id="category" value="${dto.category}">
                	<input type="hidden" name="content" id="content" value="${dto.content}">
                	<input type="hidden" name="tf" id="tf" value="${dto.tf}">
                	<textarea cols="90" rows="5" name="reply" id="reply" placeholder="${dto.email}(으)로 답을 전송합니다." required></textarea>
                	<br>
                	<span style="float: right;">
                		<input type="submit" value="답 작성하기">
                	</span>
                </td>
                 </c:otherwise>
                 
                 </c:choose>
            </tr>
            
            <c:forEach items="${list}" var="l">
            <tr>
            	<td colspan="2" style="text-align: left;">관리자
                	<span style="float: right;">${fn:substring(l.ip_r_date, 0, 19)}</span>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="border: 2px solid #000; padding: 8px; height: 80%; padding-left: 50px;">
    				<div style="width: 90%; height: 90%;">
    				${l.reply}
				    </div>
				</td>
            </tr>
            </c:forEach>
            
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
function confirmDeleteip(ip_num ) {
    if(confirm('해당 문의 내역을 정말 삭제하시겠습니까?')) {
        location.href = 'inquire_personal_delete?ip_num='+ip_num;
    }
}
</script>
	
	
</body>
</html>