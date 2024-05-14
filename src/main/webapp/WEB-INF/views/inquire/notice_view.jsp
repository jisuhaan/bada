<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>바라는 바다! :: 문의 공지</title>
<link href="${pageContext.request.contextPath}/resources/css/notice_view.css" rel="stylesheet" type="text/css">	
	
</head>
<body>
    <div class="container">
        <table class="board-table">
            <thead>
                <tr>
                    <th>공지 사항</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${notice_num == 1}">
                    <!-- 1번 공지사항 내용 -->
                    <tr>
                        <td class="notice-box">
                        <img src="./resources/image/manual.png">
			    
			      	<div class="contact-info">
					Contact us <br>
					경기 수원시 팔달구 향교로 2(매산로1가 60-3) [16455] <br>
					031-253-6776 <br>
					ezen.bada@gmail.com <br>
					</div>
                        </td>
                    </tr>
                </c:if>

                <c:if test="${notice_num == 2}">
                    <!-- 2번 공지사항 내용 -->
                    <tr>
                        <td class="notice-box">
						<img src="./resources/image/bada_rule.jpg">
					<div class="contact-info">
					Contact us <br>
					경기 수원시 팔달구 향교로 2(매산로1가 60-3) [16455] <br>
					031-253-6776 <br>
					ezen.bada@gmail.com <br>
					</div>
                        </td>
                    </tr>
                </c:if>

                <c:if test="${notice_num == 3}">
                    <!-- 3번 공지사항 내용 -->
                    <tr>
                        <td class="notice-box">
					<img src="./resources/image/notice_report.jpg">
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
