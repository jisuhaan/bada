<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

    <style>
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
        }
        .board-table {
            width: 100%;
            border-collapse: collapse;
        }
        .board-table th {
            padding-bottom: 40px;
        }        
        .event-box {
            background-color: white;
            border-radius: 10px;
            border: 1px solid #ccc;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
    </style>

<title>바라는 바다! :: 이벤트 페이지</title>
</head>
<body>

    <div class="container">
        <table class="board-table">
            <thead>
                <tr>
                    <th>바라는 바다! 이벤트 바다!</th>
                </tr>
            </thead>
            <tbody>
                    <tr>
                        <td class="event-box">
                            <img src="./resources/image/${photo}">
                        </td>
                    </tr>
            </tbody>
        </table>
    </div>



</body>
</html>