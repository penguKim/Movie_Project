<%-- admin_review.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 리뷰 관리</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<style type="text/css">
</style>
<script src="../js/jquery-3.7.1.js"></script>
<script type="text/javascript">


$(document).ready(function(){
	var member_id = "<%= session.getAttribute("sId") %>";
    	
	$("#submitReview").click(function(){
			var review_content = $("#review_content").val(); // 'review_content'라는 id를 가진 요소의 값을 가져옴
			var movie_id = ${param.movie_id};
			var formattedTime = year + '-' + // 현재 연도
				month + '-' + // 현재 월
				date + ' ' + // 현재 일
				hours + ':' + // 현재 시간
				minutes; // 현재 분
    
//				alert(movie_id);
				console.log(member_id);
		$.ajax({
			url: "reviewPro", // 요청을 보낼 URL
			type: "POST",
			data: {
				review_content : review_content,
				member_id : member_id,
				movie_id : movie_id
			},
			
			datatype: "json",
			success: function(data) { // 요청 성공
				$("#review_no").append(
					"<tr>"	
					+ "<td>" + member_id + "</td>"	
					+ "<td>" + review_content + "</td>"	
					+ "<td>" + formattedTime  + "</td>"	
					+ "</tr>"	
				);
				console.log("성공");
			},
			error: function(request, status, error) { // 요청 실패
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});//ajax끝
	}); //click 이벤트 끝
}); //ready 끝
</script>
</head>
<body>
	<div id="wrapper">
		<nav id="navbar">
            <jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
        </nav>
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
<%-- 		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include> --%>
		
		<section id="content">
			<h1 id="h01">리뷰 관리</h1>
			<hr>
<!-- 			<div id="admin_nav"> -->
<%-- 				<jsp:include page="admin_menubar.jsp"></jsp:include> --%>
<!-- 			</div> -->
			
			<div id="admin_main">
<!-- 				<div id="review_Search"> -->
<!-- 					<input type="text" id="searchInput" placeholder="아이디 또는 영화명 입력"> -->
<!-- 					<input type="button" id="searchButton" value="조회"> -->
<!-- 				</div> -->
<!-- 				<form action="reviewDlt" method="get"> -->
					<table border="1">
						<tr>
							<th width="60">번호</th>
							<th width="250">영화명</th>
							<th width="450">내용</th>
							<th width="100">아이디</th>
							<th width="100">작성일</th>
							<th width="100">리뷰 상세정보</th>
						</tr>
						<c:forEach var="adminReviewList" items="${adminReviewList}">
							<tr>
								<td>${adminReviewList.review_id}</td>
								<td>${adminReviewList.movie_title}</td>
								<td>${adminReviewList.review_content}</td>
								<td>${adminReviewList.member_id}</td>
								<td>${adminReviewList.review_date}</td>
<!-- 								<td><input type="submit" id="reviewDlt" value="상세정보"></td> -->
								<td><form action="reviewDlt" method="get" id="reviewDlt">
									<input type="hidden" name="review_id" value="${adminReviewList.review_id}">
									<input type="submit" id="adminDlt" value="상세정보">
									</form>
								</td>
							</tr>
						</c:forEach>
						</table>
					<c:set var="pageNum" value="1" />
				<c:if test="${not empty param.pageNum }">
					<c:set var="pageNum" value="${param.pageNum }" />
				</c:if>
				<div class="pagination">
					<c:choose>
						<c:when test="${pageNum eq 1}">
							<a href="" >&laquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminReview?pageNum=${pageNum-1}" >&laquo;</a>
						</c:otherwise>				
					</c:choose>
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<c:choose>
							<c:when test="${pageNum eq i}">
								<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
							</c:when>
							<c:otherwise>
								<a href="adminReview?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${pageNum eq pageInfo.maxPage}">
							<a href="" >&raquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminReview?pageNum=${pageNum+1}" >&raquo;</a>
						</c:otherwise>				
					</c:choose>
				</div>

			</div>
		</section>
	</div>
</body>
</html>
