<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 등록</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/dailyBoxOffice.js"></script>
<script type="text/javascript">
// 여기 페이지에서 해야할것.
// input 텍스트창에 영화제목을 입력하고 검색버튼을 눌렀을때 영화정보를 보여주기


$(document).ready(function(){
	$("#searchForm").on("submit", function(data){
		data.preventDefault(); //기본 이벤트 작동 못하게 하는 함수
		let title = $("#movieTitle").val();

		$.ajax({
			type: "GET",
			url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=e9ac77cb0a9e1fa7c1fe08d1ee002e3b&movieNm=" + title,
			success: function(data){
				let movies = data.movieListResult.movieList;
				$("#movieInfo").empty();
				for(let movie of movies) {
						$("#movieInfo").append("<hr>제목: " + movie.movieNm + "</br>");
					if(movie.directors.length > 0){
						$("#movieInfo").append("감독: " + movie.directors[0].peopleNm + "</br>");
					}
					if(movie.openDt !== "") {
						$("#movieInfo").append("개봉일: " + movie.openDt + "</br>");
					}
						$("#movieInfo").append("<hr>국가: " + movie.nationAlt + "</br>");
				} //for문 끝
			}, //success 끝
			error: function(){
				$("#movieInfo").html("영화 정보를 가져오는데 실패했습니다");
			} //error 끝
		}); //ajax 끝
	}); // submit 끝
}); //ready 끝
</script>


</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
	<section id="content">
	
	<h1 id="h01">영화검색</h1>
	<hr>
	
	<div id="admin_nav">
		<jsp:include page="admin_menubar.jsp"></jsp:include>
	</div>
	
		<form id="searchForm">
			<input type="text" id="movieTitle" placeholder="제목을 입력하세요">
			<input type="submit" value="검색">
		</form>

	<div id="movieInfo"></div>

	</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>