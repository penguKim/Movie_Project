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
				//영화제목을 검색했을때 감독,상영일이 있으면 반복문 통해서 출력
				for(let movie of movies) {
					if(movie.openDt !== "" && movie.directors[0].peopleNm !== "") {
						$("#movieInfo").append("<hr>제목: " + movie.movieNm + "</br>");
						$("#movieInfo").append("감독: " + movie.directors[0].peopleNm + "</br>");
						$("#movieInfo").append("개봉일: " + movie.openDt + "</br>");
						$("#movieInfo").append("국가: " + movie.nationAlt + "</br>");
					}
				} //for문 끝
				
			}, //success 끝
			error: function(){
				$("#movieInfo").html("영화 정보를 가져오는데 실패했습니다");
			} //error 끝
		}); //ajax 끝
	}); // submit 끝
	
	
	/*
	박스오피스 API는 줄거리랑 포스터 정보가 없음
	KMDb는 진짜 영화정보만 있음
	해결법
	- 박스오피스 데이터(제목, 개봉일, 감독)를 먼저 받아와서
	- 응답데이터 중 KMDb요청인자로 사용할수 있는것 뽑아내기
	- 뽑아낸 데이터를 KMDb 요청인자로 넣어서 영화 정보를 검색
	
	
	*/
	
	$("#searchFormDetail").on("submit", function(data){
// 		alert("submit버튼확인");
		let title = $("#movieTitle").val();
		let kmdbKey = C7643LD2JV0X8LAV20YO;
		$.ajax({
			type: "GET",
			dataType: "json",
			url: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=" + kmdbKey + "&title=" + title,
			data:{
				
			},
			success: function(data){
				
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
		<nav id="navbar">
            <jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
        </nav>
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
						
	<section id="content">
	
	<h1 id="h01">영화검색</h1>
	<hr>
	<div id="adminSearch">
		<form id="searchForm">
			<input type="text" id="movieTitle" placeholder="제목을 입력하세요"><input type="submit" value="검색">
		</form>
		<form id="searchFormDetail">
			<input type="text" id="movieTitleDetail" placeholder="제목을 입력하세요"><input type="submit" value="검색">
		</form>
	</section>
	</div>
	</div>
</body>
</html>