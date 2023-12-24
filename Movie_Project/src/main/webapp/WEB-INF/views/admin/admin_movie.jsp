<%-- admin_movie.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		<section id="content">
			<h1 id="h01">영화관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<div id="movie_update">
					<input type="button" value="최신영화 등록" onclick = "location.href='adminMovieUdt'">
					<input type="button" value="영화 검색" onclick = "location.href='adminMovieSearch'">
				</div>
				<div id="movie_Search">
					<%-- 검색 기능을 위한 폼 생성 --%>
					<form action="adminMovie">
						<input type="text" name="searchKeyword" placeholder="제목을 입력하세요">
						<input type="submit" value="검색">
					</form>
				</div>
				<table id="movieList">
					<tr>
						<th>영화코드</th>
						<th>영화제목</th>
						<th>상영상태</th>
						<th>제작년도</th>
						<th>상영시간</th>
						<th>상영일</th>
						<th>종영일</th>
						<th>수정/삭제</th>
					</tr>
					<c:forEach var="movie" items="${movieList }">
						<tr>
							<td>${movie.movie_id }</td>
							<td id="movieTitle">${movie.movie_title }</td>
							<td class="movie_status">
								<c:choose>
									<c:when test="${movie.movie_status eq 1 }">
									<span id="admin_member">상영중</span>
									</c:when>
									<c:when test="${movie.movie_status eq 0 }">
									<span id="admin_Bmember">상영예정</span>
									</c:when>
								</c:choose>
								</td>
<%-- 							<td>${movie.movie_status }</td> --%>
							<td>${movie.movie_prdtYear }년</td>
							<td>${movie.movie_runtime }분</td>
							<td>${movie.movie_release_date }</td>
							<td>${movie.movie_close_date }</td>
							<td><input type="button" value="MORE" onclick = "location.href='adminMovieMod?movie_id=${movie.movie_id }&pageNum=${pageNum }'"></td>
						</tr>
					</c:forEach>
				</table>
			</div>
				<section class="pagination">
				<input type="button" value="이전" 
					onclick="location.href='adminMovie?pageNum=${pageNum - 1}'"
					<c:if test="${pageNum <= 1 }">disabled</c:if>
				>
				<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
					<c:choose>
						<c:when test="${pageNum eq i }">
							<b>${i }</b>
						</c:when>
						<c:otherwise>
							<a href="adminMovie?pageNum=${i }">${i }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<input type="button" value="다음" 
					onclick="location.href='adminMovie?pageNum=${pageNum + 1}'"
					<c:if test="${pageNum >= pageInfo.maxPage }">disabled</c:if>
				>
				</section>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>