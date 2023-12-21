<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>현재상영작</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/movie.css" rel="stylesheet">
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">현재상영작</h1>
			<hr>
			<nav class="movie-menu">
				<ul>
					<li class="active"><a href="release">
						<input type="button" value="현재상영작"></a></li>
					<li><a href="comming">
						<input type="button" value="상영예정작"></a></li>
				</ul>
			</nav>
			<section class="movie-section">
				<div class="container">
					<div class="movie-grid">
					<c:forEach var="movie" items="${movieList}">
						<div class="movie">
							<a href="detail?movie_id=${movie.movie_id}">
							<c:choose>
								<c:when test="${movie.movie_rating eq '12세' }">
									<b class="movie-rating age12">12</b>
								</c:when>
								<c:when test="${movie.movie_rating eq '15세' }">
									<b class="movie-rating age15">15</b>
								</c:when>
								<c:when test="${movie.movie_rating eq '18세' }">
									<b class="movie-rating age18">18</b>
								</c:when>
								<c:when test="${movie.movie_rating eq '전체' }">
									<b class="movie-rating ageAll">ALL</b>
								</c:when>
							</c:choose>
							<div class="movie-poster">
								<div class="poster">
									<img alt="" src="${movie.movie_poster }">
								</div>
								<div>
									<p class="title">${movie.movie_title }</p>
								</div>
							</div>
								<p class="date">${movie.movie_release_date } <span class="release-type">개봉</span></p>
							</a>
							<div class="reserve_area">
								<a href="movie_select" class="rel_reservBtn">
									<input type="button" value="예매하기"></a>
							</div>
						</div>
					</c:forEach>
					</div>
				</div>
			</section>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>