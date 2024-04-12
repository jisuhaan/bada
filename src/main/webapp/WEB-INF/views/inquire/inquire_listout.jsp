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

	<style>
        table {
            margin: 0 auto;
            width: 95%;
            border-collapse: collapse;
        }
        th, td {
            text-align: center;
            font-size: 13px; /* 텍스트 크기를 작게 설정 */
            padding: 4px; /* 셀 안의 여백 설정 */
        }
        th:nth-child(1) {
            width: 45%; /* 첫 번째 열의 너비를 70%로 설정 */
        }
        th:nth-child(2){
        width: 12%;
        }
        th:nth-child(3){
        width: 10%;
        }
        .lock-icon {
            display: inline-block; /* 이미지를 인라인 블록 요소로 설정하여 텍스트와 같이 정렬 */
            vertical-align: middle; /* 아이콘을 수직 가운데 정렬 */
        }
    </style>
<title>바라는 바다! :: 문의 목록</title>
</head>


<!-- 
구성이 엄청나게 길어졌는데, 확인할 때 이해하기 쉬우시라고 먼저 첨언을 드립니다...
웹화면 상에서 화면의 구성은

서치창
인기글 top3 고정
페이징 처리 된 리스트

이렇게 3단계로 이루어져 있으나, 실제 코드는
최신순/추천순의 choose 안에서 -> admin/user로 나눠지는 choose 안에서 -> 인기글 top3 고정과 페이징처리 된 리스트로
내부에서 choose 두 번과 리스트 두 개씩을 사용해
총 8가지의 경우의 수 리스트로 구성되어 있습니다. 때문에 이 jsp 파일의 구성은



1. 최신순 정렬의 choose (sort=latest)
1-1-1(when sort=latest, when role=admin). 최신순 속의 admin 화면 안의 고정 인기글(top3)
1-1-2. 최신순 속의 admin 화면 안의 페이징 처리된 최신순 정렬

1-2-1(when sort=latest, when role otherwise). 최신순 속의 user 화면 안의 고정 인기글(top3)
1-2-2. 최신순 속의 user 화면 안의 페이징 처리된 최신순 정렬

2. 인기순 정렬의 choose (sort=popular)
1-1-1(when sort=popular(otherwise), when role=admin). 추천순 속의 admin 화면 안의 고정 인기글(top3)
1-1-2. 추천순 속의 admin 화면 안의 페이징 처리된 추천순 정렬

1-2-1(when sort=popular(otherwise), when role otherwise). 추천순 속의 user 화면 안의 고정 인기글(top3)
1-2-2. 추천순 속의 user 화면 안의 페이징 처리된 추천순 정렬



이러합니다.
해당 코드를 읽을 때 참고하시기 바랍니다...
-정지수
 -->





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




<!-- 정렬에 대한 choose -->
<c:choose>
<!-- when: 최신순 정렬일 때 -->
<c:when test="${sort=='latest'}">



<!-- 최신순 페이지 속 자격에 대한 choose(관리자에게만 보이는 화면) -->
<c:choose>
<!-- when: 관리자일 때 (최신순이며, 관리자일 때)-->
<c:when test="${loginstate==true && position=='admin'}">



<!-- 최신순 정렬에 관리자 화면에서의 추천순 top3 고정 정렬 -->
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
<!-- 추천순 top3 고정 정렬 끝 -->



<!-- 최신순 정렬 & 페이징 + 관리자 자격의 화면 -->
<c:forEach items="${list}" var="l">
			      <tr class="notice_line">
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
<!-- 최신순 정렬 & 페이징 + 관리자 자격의 화면 끝 -->



<!-- 최신순 정렬 & 페이징 + 사용자 화면 시작 -->
<c:otherwise>

<!-- 최신순 정렬에 사용자 화면에서의 추천순 top3 고정 정렬 -->
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
<!-- 최신순 정렬에 사용자 화면에서의 추천순 top3 고정 정렬 끝-->



<!-- 최신순 정렬 & 페이징 + 사용자의 화면 -->
			      <c:forEach items="${list}" var="l">
			      <tr class="notice_line">
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
<!-- 최신순 정렬 & 페이징 + 사용자 자격의 화면 끝 -->

	    </c:choose>
<!-- 최신순 정렬 내부에서의 자격 확인 choose 끝 -->
	    
	   </c:when>
<!-- 최신순 정렬 끝 -->
	   
	   
	   
	<!-- 추천순 choose 파트 시작(아래는 모두 추천순 정렬) -->
	   <c:otherwise>
	   
	   <!-- 추천순 정렬 내부의 자격 확인(관리자 자격 확인) choose -->
	   <c:choose>
	   
	   <!-- 추천순 정렬 내부에서 관리자 화면인 경우의 when -->
<c:when test="${loginstate==true && position=='admin'}">

<!-- 추천순 내부이며, 관리자 화면이며, 그 안에서의 추천순 고정 파트 -->

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
	      <!-- 추천순 고정 파트 종료 -->



<!-- 추천순 내부이며, 관리자 화면이며, 페이징 처리 정렬 -->
<c:forEach items="${list}" var="l">
			      <tr class="notice_line">
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
<!-- 추천순 내부이며, 관리자 화면이며, 페이징 처리 정렬 끝, 위 when은 추천순 내부의 자격확인 choose에 대한 when의 끝 -->



<!-- 추천순 내부이며, 사용자 화면 시작. 아래 otherwise는 추천순 내부의 자격확인 choose에 대한 otherwise로 사용자라는 뜻 -->
<c:otherwise>

<!-- 추천순 내부이며, 사용자 화면이며, 추천순 top3 고정 정렬 -->
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
<!-- 추천순 내부이며, 사용자 화면이며, 추천순 top3 고정 정렬 끝 -->


<!-- 추천순 내부이며, 사용자 화면이며, 페이징 처리 시작-->
			      <c:forEach items="${list}" var="l">
			      <tr class="notice_line">
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
	    <!-- 추천순 내부이며, 사용자 화면이며, 페이징 처리 끝. 위 otherwise는 자격이 admin이 아닌 otherwise(user)일 때의 끝 -->
	    
	    
	    </c:choose>
	    <!-- 추천순 내부이며, 자격 확인(admin/user 구분 choose)의 끝 -->
	   
	   
	   
	   </c:otherwise>
	   <!-- 추천순의 끝이며, 정렬 방식 구분에서 popular의 끝 -->    
	   
	    
	        
	</c:choose>        
	  <!-- 정렬 방식 구분(latest/popular 구분 choose)의 끝 -->       
	        
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