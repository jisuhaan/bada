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
	
    <style>
        .container {
            max-width: 1000px;
            margin: auto;
            padding: 20px;
        }
        .board-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th {
            padding-bottom: 40px;
        }        
        .notice-box {
        	margin-top: 20px;
            background-color: white;
            border-radius: 10px;
            border: 1px solid #ccc;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: left;
            word-wrap: break-word; /* 자동 줄바꿈을 위해 추가 */
        	overflow-wrap: break-word; /* 긴 단어도 줄바꿈 처리 */
        }
        
        .contact-info {
       		
            text-align: center; /* 중앙 정렬 */
            padding: 20px;
            font-size: 0.9em;
            border-top: 1px solid #ccc; /* 상단에 일직선의 줄 추가 */
        	margin-top: 30px; /* 위의 내용과의 여백 추가 *
        }        
    </style>	
	
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
                <c:if test="${notice_num == 3}">
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

                <c:if test="${notice_num == 4}">
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

                <c:if test="${notice_num == 5}">
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
