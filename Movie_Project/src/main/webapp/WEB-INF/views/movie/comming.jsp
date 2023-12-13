<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영예정작</title>
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
			<h1 id="h01">상영예정작</h1>
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
							<a href="detail?detailNum=${movie.detailNum}">
							<div class="movie-poster">
								<div class="poster">
									<img alt="" src="${movie.poster}">
								</div>
								<div>
									<p class="title">${movie.title }</p>
								</div>
							</div>
								<p class="date">${movie.release }</p>
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