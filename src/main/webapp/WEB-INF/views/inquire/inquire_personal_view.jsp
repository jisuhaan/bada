<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/inquire_input.css" rel="stylesheet" type="text/css">
    <title>바라는 바다! :: 1:1 문의 작성</title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#InquirePersonalForm").submit(function(event) {
                if (!validateForm()) {
                    event.preventDefault();
                }
            });
        });

        function validateForm() {
            var isValid = true;
            var email = $("#email").val();
            var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            var content = $("#content").val();
            var title = $("#title").val();
            var name = $("#name").val();

            if (!emailPattern.test(email)) {
                alert("올바른 이메일 형식이 아닙니다.");
                isValid = false;
            }

            if (content.length > 1500) {
                alert("문의 내용은 최대 1500자까지 입력 가능합니다.");
                isValid = false;
            }

            if (!title.trim()) {
                alert("제목을 입력하세요.");
                isValid = false;
            }

            if (!name.trim()) {
                alert("문의 작성자를 입력하세요.");
                isValid = false;
            }

            if (!content.trim()) {
                alert("문의 내용을 입력하세요.");
                isValid = false;
            }

            return isValid;
        }

        function submitForm() {
            if (validateForm()) {
                showLoadingPage();
                document.getElementById("InquirePersonalForm").submit();
            }
        }
    </script>

    <script type="text/javascript">
        function showLoadingPage() {
            document.getElementById("loading").style.display = "block";
        }

        var PicCount = 1;
        function addPicField() {
            if (PicCount >= 5) {
                alert("사진은 최대 5장까지만 첨부할 수 있습니다.");
                return;
            }

            PicCount++;

            var newField = document.createElement('div');
            newField.innerHTML = '<input type="file" name="pic' + PicCount + '" id="pic' + PicCount + '" class="btn">';

            document.getElementById('pic_pack').appendChild(newField);
        }
    </script>
</head>
<body>
    <form id="InquirePersonalForm" action="inquire_personal_save" method="post" enctype="multipart/form-data">
        <div class="container">
            <div class="inquire_container">
                <div id="inquire_title">1 : 1 문의함</div>
                <div class="listbox titles">
                    <div id="list_title">제목</div>
                    <div id="list_contents"><input type="text" name="title" id="title" required="required" placeholder="제목을 입력하세요."></div>
                </div>
                <hr>
                <div class="listboxout line2">
                    <div class="listbox categories">
                        <div id="list_title">카테고리</div>
                        <select name="category" id="category" required="required">
                            <option value="계정 정보 문의">계정 정보 문의</option>
                            <option value="바다 정보 문의">바다 정보 문의</option>
                            <option value="홈페이지 기능 문의">홈페이지 기능 문의</option>
                            <option value="기타 문의">기타 문의</option>
                        </select>
                    </div>
                    <div class="listbox writer">
                        <div id="list_title">문의 작성자</div>
                        <div id="list_contents">
                            <c:choose>
                                <c:when test="${loginstate==true}">
                                    <input type="text" name="name" id="name" value="${dto.name}" readonly="readonly">
                                    <input type="hidden" name="id" id="id" value="${dto.id}">
                                </c:when>
                                <c:otherwise>
                                    <input type="text" name="name" id="name" placeholder="임시 닉네임을 입력해주세요." required="required">
                                    <input type="hidden" name="id" id="id" value="nope">
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="listbox emails">
                    <div id="list_title">이메일 주소</div>
                    <c:choose>
                        <c:when test="${loginstate==true}">
                            <div id="list_contents">
                                <input type="text" name="email" id="email" value="${dto.email}" required="required">
                            </div>
                            <div class="list_infomation">
                                <h6>답을 수신 받고자 하는 이메일 주소를 입력해주세요. <br>해당 이메일로 1:1 문의에 대한 답이 전송됩니다.</h6>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div id="list_contents">
                                <input type="text" name="email" id="email" placeholder="이메일을 입력해주세요." required="required">
                            </div>
                            <div class="list_infomation">
                                <h6>답을 수신 받고자 하는 이메일 주소를 입력해주세요. <br>해당 이메일로 1:1 문의에 대한 답이 전송됩니다.</h6>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <hr>
                <div class="listbox contents">
                    <div id="list_title">문의 내용</div>
                    <textarea cols="50" rows="7" name="content" id="content" placeholder="문의 내용은 1500자 이하로 입력하세요." required></textarea>
                </div>
                <hr>
                <div class="listbox addphoto">
                    <div id="list_title">사진 첨부(최대 5장)</div>
                    <div class="pic_add">
                        <input type="file" name="pic1" id="pic1" class="btn">
                        <button type="button" onclick="addPicField()"> + </button>
                    </div>
                    <div id="pic_pack"></div>
                </div>
            </div>
            <div class="list_buttons">
                <input type="button" value="전송하기" class="btn2" onclick="submitForm()">
                <input type="button" value="돌아가기" class="btn2" onclick="window.location.href='main'">
            </div>
        </div>
    </form>

    <!-- 로딩 페이지 -->
    <div id="loading" style="display: none;">
        <jsp:include page="../loading.jsp"/>
    </div>
</body>
</html>