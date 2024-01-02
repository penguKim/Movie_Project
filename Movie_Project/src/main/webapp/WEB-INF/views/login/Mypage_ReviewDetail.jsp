<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세정보 게시판</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
$(function() {
	$("#reviewDelete").on("click", function() {
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
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<h1 id="h01">리뷰 상세정보 게시판</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form action="reviewDelete" method="get" name="checkform">
				<div id="my_list">
					<h2>리뷰 상세정보 게시판</h2>
					<table id="my_table1">
						<c:forEach var="reviewBoardDetail" items="${reviewBoardDetail}" varStatus="status">
						<tr>
							<th>번호</th>
							<td>${reviewBoardDetail.review_id}</td>
						</tr>
						<tr>
							<th>영화제목</th>
							<td>${reviewBoardDetail.movie_title }</td>
						</tr>
						<tr>
							<th>평점</th>
							<td>${reviewBoardDetail.review_rating }</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${reviewBoardDetail.member_id }</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td>${reviewBoardDetail.review_date }</td>
						</tr>
						<tr>
							<th height="200">영화 리뷰 내용</th>
							<td>${reviewBoardDetail.review_content }</td>
						</tr>
						</c:forEach>
					</table><br>
								
				</div>
					<input type="submit" id="reviewDelete" value="삭제">
			</form>
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
	
</body>
</html>