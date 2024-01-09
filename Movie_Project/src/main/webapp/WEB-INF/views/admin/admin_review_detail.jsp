<%-- admin_payment_detail.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 리뷰 상세 게시판</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
$(function() {
	$("#adminReviewDelete").on("click", function() {
		if(confirm("글을 삭제하시겠습니까?")) {
			return true;
		} else {
			return false;
		}
	}); //on click 끝
}); //function 끝
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">리뷰 상세 페이지</h1>
			<hr>		
			<div id="admin_main">
				<table border="1">
				<c:forEach var="adminReviewDlt" items="${adminReviewDlt }">
					<tr>
						<th width="100">번호</th>
						<td>${adminReviewDlt.review_id }</td>
					</tr>
					<tr>
						<th>영화제목</th>
						<td>${adminReviewDlt.movie_title }</td>
					</tr>
					<tr>
						<th>평점</th>
						<td>${adminReviewDlt.review_rating }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${adminReviewDlt.member_id }</td>
					<tr>
						<th>작성일</th>
						<td>${adminReviewDlt.review_date }</td>
					</tr>
					<tr>
						<th>작성내용</th>
						<td>${adminReviewDlt.review_content }</td>
					</tr>
				</c:forEach>
				</table>
				
			<form action="adminReviewDelete" method="get">
				<div id="admin_writer">
					<input type="submit" id="adminReviewDelete" value="삭제" >
					<input type="button" value="뒤로가기"  onclick="history.back()">
					<input type="hidden" id="adminReviewDelete" name="review_id" value="${param.review_id}">
				</div>
			</form>
			</div>
		</section>
	</div>			
</body>
</html>