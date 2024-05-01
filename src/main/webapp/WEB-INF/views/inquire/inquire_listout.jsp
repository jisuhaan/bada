<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="inquire_search.jsp" %>
<%@ include file="inquire_notice_list.jsp" %>

<!DOCTYPE html>

<html>

<head>

   <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="${pageContext.request.contextPath}/resources/css/review_page.css" rel="stylesheet" type="text/css">
   <title>바라는 바다! :: 문의 목록</title>

   
<title>바라는 바다! :: 문의 목록</title>
</head>

<body>

      <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
               <tr>
                   <th colspan="2">문의글 제목</th>
                  <th>문의 카테고리</th>
                  <th>문의 작성자</th>
                  <th>문의 날짜</th>
                  <th>답변</th>
                  <th>추천수</th>
                  <th>조회수</th>
               </tr>
                  </thead>
                  
<tbody>


<c:choose>
<c:when test="${sort=='latest'}">




<c:choose>
<c:when test="${loginstate==true && position=='admin'}">



<c:forEach items="${list2}" var="l2">
         <tr class="notice_line">
            <td colspan="2">
            [추천순 top3]
            <a href="to_inquire_detail?inquire_num=${l2.inquire_num}">
                   <c:choose>
                       <c:when test="${l2.secret == 'y'}">
                           <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                           ${l2.title}
                       </c:when>
                       <c:otherwise>
                           ${l2.title}
                       </c:otherwise>
                   </c:choose>
               </a>
               </td>
            <td>${l2.category}</td>
            <td>
            ${l2.name}(${fn:substring(l2.id, 0, 4)}****) 님
            </td>
            <td>
               ${fn:substring(l2.i_date, 0, 19)}
            </td>
            <td>
               <c:choose>
                <c:when test="${l2.reply == 0}">미응답</c:when>
                <c:otherwise>완료</c:otherwise>
            </c:choose>
            </td>
            <td>${l2.rec}</td>
            <td>${l2.cnt}</td>
         </tr>
         </c:forEach>



<c:forEach items="${list}" var="l">
               <tr>
                  <td colspan="2">
                  <a href="to_inquire_detail?inquire_num=${l.inquire_num}">
                       <c:choose>
                           <c:when test="${l.secret == 'y'}">
                               <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                               ${l.title}
                           </c:when>
                           <c:otherwise>
                               ${l.title}
                           </c:otherwise>
                       </c:choose>
                   </a>
                   </td>
                  <td>${l.category}</td>
                  <td>
                  ${l.name}(${fn:substring(l.id, 0, 4)}****) 님
                  </td>
                  <td>
                     ${fn:substring(l.i_date, 0, 19)}
                  </td>
                  <td>
                     <c:choose>
                      <c:when test="${l.reply == 0}">미응답</c:when>
                      <c:otherwise>완료</c:otherwise>
                  </c:choose>
                  </td>
                  <td>${l.rec}</td>
                  <td>${l.cnt}</td>
               </tr>
               </c:forEach>
            
    <!--  페이징 처리 6단계 -->
      <!-- 페이징처리 -->
      <tr style="border-left: none; border-right: none; border-bottom: none;">
         <td colspan="10" style="text-align: center;">
         <c:if test="${paging.startPage!=1 }">
             <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=latest&nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
            
         </c:if>   
         
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
               <c:choose>
                  <c:when test="${p == paging.nowPage }">
                  <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
                     <b><span style="color: red;">${p}</span></b>
                  </c:when>   
                  <c:when test="${p != paging.nowPage }">
                  <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
                     <a href="inquire_listout?sort=latest&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
                  </c:when>   
               </c:choose>
            </c:forEach>
           
            <c:if test="${paging.endPage != paging.lastPage}">
            <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=latest&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
         </c:if>
         
         </td>
      </tr>
      <!-- 페이징처리 -->
   <!-- 페이징 처리 6단계 끝 -->
</c:when>







<c:otherwise>

<c:forEach items="${list2}" var="l2">
         <tr class="notice_line">
            <td colspan="2">
            [추천순 top3]
            <a href="to_inquire_detail?inquire_num=${l2.inquire_num}">
                   <c:choose>
                       <c:when test="${l2.secret == 'y'}">
                           <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                           ${l2.title}
                       </c:when>
                       <c:otherwise>
                           ${l2.title}
                       </c:otherwise>
                   </c:choose>
               </a>
               </td>
            <td>${l2.category}</td>
            <td>
            ${l2.name}(${fn:substring(l2.id, 0, 4)}****) 님
            </td>
            <td>
               ${fn:substring(l2.i_date, 0, 19)}
            </td>
            <td>
               <c:choose>
                <c:when test="${l2.reply == 0}">미응답</c:when>
                <c:otherwise>완료</c:otherwise>
            </c:choose>
            </td>
            <td>${l2.rec}</td>
            <td>${l2.cnt}</td>
         </tr>
         </c:forEach>



               <c:forEach items="${list}" var="l">
               <tr>
                  <td colspan="2">
                  <a href="inquire_secret_yn?inquire_num=${l.inquire_num}&secret=${l.secret}">
                       <c:choose>
                           <c:when test="${l.secret == 'y'}">
                               <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                               비밀글입니다.
                           </c:when>
                           <c:otherwise>
                               ${l.title}
                           </c:otherwise>
                       </c:choose>
                   </a>
                   </td>
                  <td>${l.category}</td>
                  <td>
                  ${l.name}(${fn:substring(l.id, 0, 4)}****) 님
                  </td>
                  <td>
                     ${fn:substring(l.i_date, 0, 19)}
                  </td>
                  <td>
                     <c:choose>
                      <c:when test="${l.reply == 0}">미응답</c:when>
                      <c:otherwise>완료</c:otherwise>
                  </c:choose>
                  </td>
                  <td>${l.rec}</td>
                  <td>${l.cnt}</td>
               </tr>
               </c:forEach>
            
    <!--  페이징 처리 6단계 -->
      <!-- 페이징처리 -->
      <tr style="border-left: none; border-right: none; border-bottom: none;">
         <td colspan="10" style="text-align: center;">
         <c:if test="${paging.startPage!=1 }">
             <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=latest&nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
            
         </c:if>   
         
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
               <c:choose>
                  <c:when test="${p == paging.nowPage }">
                  <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
                     <b><span style="color: red;">${p}</span></b>
                  </c:when>   
                  <c:when test="${p != paging.nowPage }">
                  <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
                     <a href="inquire_listout?sort=latest&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
                  </c:when>   
               </c:choose>
            </c:forEach>
           
            <c:if test="${paging.endPage != paging.lastPage}">
            <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=latest&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
         </c:if>
         
         </td>
      </tr>
      <!-- 페이징처리 -->
   <!-- 페이징 처리 6단계 끝 -->   
       
       </c:otherwise>    

       </c:choose>
       
      </c:when>
      
      
      
      <c:otherwise>
      
      <c:choose>
      
<c:when test="${loginstate==true && position=='admin'}">


<c:forEach items="${list2}" var="l2">
         <tr class="notice_line">
            <td colspan="2">
            [추천순 top3]
            <a href="to_inquire_detail?inquire_num=${l2.inquire_num}">
                   <c:choose>
                       <c:when test="${l2.secret == 'y'}">
                           <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                           ${l2.title}
                       </c:when>
                       <c:otherwise>
                           ${l2.title}
                       </c:otherwise>
                   </c:choose>
               </a>
               </td>
            <td>${l2.category}</td>
            <td>
            ${l2.name}(${fn:substring(l2.id, 0, 4)}****) 님
            </td>
            <td>
               ${fn:substring(l2.i_date, 0, 19)}
            </td>
            <td>
               <c:choose>
                <c:when test="${l2.reply == 0}">미응답</c:when>
                <c:otherwise>완료</c:otherwise>
            </c:choose>
            </td>
            <td>${l2.rec}</td>
            <td>${l2.cnt}</td>
         </tr>
         </c:forEach>



<c:forEach items="${list}" var="l">
               <tr>
                  <td colspan="2">
                  <a href="to_inquire_detail?inquire_num=${l.inquire_num}">
                       <c:choose>
                           <c:when test="${l.secret == 'y'}">
                               <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                               ${l.title}
                           </c:when>
                           <c:otherwise>
                               ${l.title}
                           </c:otherwise>
                       </c:choose>
                   </a>
                   </td>
                  <td>${l.category}</td>
                  <td>
                  ${l.name}(${fn:substring(l.id, 0, 4)}****) 님
                  </td>
                  <td>
                     ${fn:substring(l.i_date, 0, 19)}
                  </td>
                  <td>
                     <c:choose>
                      <c:when test="${l.reply == 0}">미응답</c:when>
                      <c:otherwise>완료</c:otherwise>
                  </c:choose>
                  </td>
                  <td>${l.rec}</td>
                  <td>${l.cnt}</td>
               </tr>
               </c:forEach>
            
    <!--  페이징 처리 6단계 -->
      <!-- 페이징처리 -->
      <tr style="border-left: none; border-right: none; border-bottom: none;">
         <td colspan="10" style="text-align: center;">
         <c:if test="${paging.startPage!=1 }">
             <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=popular&nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
            
         </c:if>   
         
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
               <c:choose>
                  <c:when test="${p == paging.nowPage }">
                  <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
                     <b><span style="color: red;">${p}</span></b>
                  </c:when>   
                  <c:when test="${p != paging.nowPage }">
                  <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
                     <a href="inquire_listout?sort=popular&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
                  </c:when>   
               </c:choose>
            </c:forEach>
           
            <c:if test="${paging.endPage != paging.lastPage}">
            <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=popular&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
         </c:if>
         
         </td>
      </tr>
      <!-- 페이징처리 -->
   <!-- 페이징 처리 6단계 끝 -->
</c:when>
<c:otherwise>

<c:forEach items="${list2}" var="l2">
         <tr class="notice_line">
            <td colspan="2">
            [추천순 top3]
            <a href="to_inquire_detail?inquire_num=${l2.inquire_num}">
                   <c:choose>
                       <c:when test="${l2.secret == 'y'}">
                           <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                           ${l2.title}
                       </c:when>
                       <c:otherwise>
                           ${l2.title}
                       </c:otherwise>
                   </c:choose>
               </a>
               </td>
            <td>${l2.category}</td>
            <td>
            ${l2.name}(${fn:substring(l2.id, 0, 4)}****) 님
            </td>
            <td>
               ${fn:substring(l2.i_date, 0, 19)}
            </td>
            <td>
               <c:choose>
                <c:when test="${l2.reply == 0}">미응답</c:when>
                <c:otherwise>완료</c:otherwise>
            </c:choose>
            </td>
            <td>${l2.rec}</td>
            <td>${l2.cnt}</td>
         </tr>
         </c:forEach>

               <c:forEach items="${list}" var="l">
               <tr>
                  <td colspan="2">
                  <a href="inquire_secret_yn?inquire_num=${l.inquire_num}&secret=${l.secret}">
                       <c:choose>
                           <c:when test="${l.secret == 'y'}">
                               <img src="./resources/image/lock_icon.png" width="20px" class="lock-icon">
                               비밀글입니다.
                           </c:when>
                           <c:otherwise>
                               ${l.title}
                           </c:otherwise>
                       </c:choose>
                   </a>
                   </td>
                  <td>${l.category}</td>
                  <td>
                  ${l.name}(${fn:substring(l.id, 0, 4)}****) 님
                  </td>
                  <td>
                     ${fn:substring(l.i_date, 0, 19)}
                  </td>
                  <td>
                     <c:choose>
                      <c:when test="${l.reply == 0}">미응답</c:when>
                      <c:otherwise>완료</c:otherwise>
                  </c:choose>
                  </td>
                  <td>${l.rec}</td>
                  <td>${l.cnt}</td>
               </tr>
               </c:forEach>
            
    <!--  페이징 처리 6단계 -->
      <!-- 페이징처리 -->
      <tr style="border-left: none; border-right: none; border-bottom: none;">
         <td colspan="10" style="text-align: center;">
         <c:if test="${paging.startPage!=1 }">
             <!-- ◀ 을 누르면 이전 페이지(-1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=popular&nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">◀</a>
            
         </c:if>   
         
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"> 
               <c:choose>
                  <c:when test="${p == paging.nowPage }">
                  <!-- 현재 보고 있는 페이지는 빨간색으로 표시 -->
                     <b><span style="color: red;">${p}</span></b>
                  </c:when>   
                  <c:when test="${p != paging.nowPage }">
                  <!-- 현재 페이지는 아니지만, 화면 내에 표시되어 있는 다른 페이지로 넘어가고 싶은 경우 -->
                     <a href="inquire_listout?sort=popular&nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
                  </c:when>   
               </c:choose>
            </c:forEach>
           
            <c:if test="${paging.endPage != paging.lastPage}">
            <!-- ▶ 을 누르면 다음 페이지(+1 페이지)로 넘어갈 수 있도록  -->
            <a href="inquire_listout?sort=popular&nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">▶</a>
         </c:if>
         
         </td>
      </tr>
      <!-- 페이징처리 -->
   <!-- 페이징 처리 6단계 끝 -->
          
       </c:otherwise>
       
       
       </c:choose>
      
      
      
      </c:otherwise>
      
       
           
   </c:choose>        
           
       </tbody>
            </table>
        </div>
    </div>
    
    
    
       <div class="sort-options">
    <label>정렬 방식:</label>&nbsp;&nbsp;
    <a href="inquire_listout?sort=latest">최신순</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="inquire_listout?sort=popular">추천순</a>
</div>


   <br> <br> <br> <br> <br>
   
</body>
</html>