<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>

<html>

<head>
	
<meta charset="UTF-8">
<title>바라는 바다! :: 신고창</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#inquire_ban_check").click(function () {
            var id = $("#id").val();
            var ban_inquire_num = $("#ban_inquire_num").val();
            var category = $("#category").val();
            var content = $("#content").val();

            $.ajax({
                type: "post",
                async: true,
                dataType: "text",
                url: "inquire_ban_check",
                data: {"id": id, "ban_inquire_num": ban_inquire_num, "category": category, "content": content},
                
                success: function (result) {
                    if (result == "nope") { // 중복 신고인 경우
                        alert("동일한 사유, 동일한 내용의 중복 신고는 불가합니다.");
                    } else if (result == "ok") { // 중복 신고가 아닌 경우
                        // 중복이 아니면 신고 저장을 위해 폼 제출
                        $("form").submit();
                        alert("신고가 접수되었습니다.");
                    }
                },
                error: function () {
                    alert("오류가 발생했습니다.");
                }
            });
        });
    });
</script>

    
</head>



<body>
	
	<c:choose>
	<c:when test="${loginstate==true}">
	
	<form action="inquire_ban_save" method="post">
		<table align="center">
		
		<caption>신고창</caption>
		
			<tr>
				<th>제목 &nbsp;&nbsp;</th>
				<td><input type="text" name="title" id="title" value="게시글 [${idto.title}] 신고" required="required"></td>
			</tr>
			<tr>
				<th>신고자</th>
				<td>
					<input type="text" name="name" id="name" value="${mdto.name}" readonly="readonly">
					<input type="hidden" name="id" id="id" value="${mdto.id}">
				</td>
			</tr>
			<tr>
				<th>신고 대상</th>
				<td>
					<input type="text" name="ban_name" id="ban_name" value="${idto.name}" readonly="readonly">
					<input type="hidden" name="ban_id" id="ban_id" value="${idto.id}">
					<input type="hidden" name="ban_inquire_num" id="ban_inquire_num" value="${idto.inquire_num}">
				</td>
			</tr>
			<tr>
				<th>신고 사유</th>
				<td>
					<select name="category" id="category" required="required">
							<option value="정보통신망법에 의거한 청소년 유해 컨텐츠">정보통신망법에 의거한 청소년 유해 컨텐츠</option>
							<option value="정보통신망법에 의거한 명예훼손, 모욕, 비방">정보통신망법에 의거한 명예훼손, 모욕, 비방</option>
							<option value="정보통신망법에 의거한 불법촬영물">정보통신망법에 의거한 불법촬영물</option>
							<option value="정보통신망법에 의거한 광고성 게시글(스팸, 바이럴)">정보통신망법에 의거한 광고성 게시글(스팸, 바이럴)</option>
							<option value="그 외(아래 '문의 내용'에 게재)">그 외(아래 '문의 내용'에 게재)</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>신고 내용</th>
				<td>
					<textarea cols="50" rows="7" name="content" id="content" placeholder="문의 내용은 1500자 이하로 입력하세요." required></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="신고하기" id="inquire_ban_check">
					<a href="inquire_listout">
						<input type="button" value="입력 취소">
					</a>
				</td>
			</tr>
		</table>
	</form>

	
	</c:when>
	<c:otherwise>
	
		<script>
			window.onload = function() {
			    alert("로그인한 회원만 신고 기능을 이용할 수 있습니다.");
			    window.location.href = "${pageContext.request.contextPath}/login";
			};
	    </script>
	    
	</c:otherwise>
</c:choose>
	
	
	
</body>



</html>