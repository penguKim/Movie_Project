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
<%-- <script src="${pageContext.request.contextPath}/resources/js/dailyBoxOffice.js"></script> --%>
<script type="text/javascript">
// 여기 페이지에서 해야할것.
// input 텍스트창에 영화제목을 입력하고 검색버튼을 눌렀을때 영화정보를 보여주기

$(document).ready(function(){
	$("#adminMovieSearch").on("click", function(){
// 		data.preventDefault(); //기본 이벤트 작동 못하게 하는 함수 (submit 함수쓸때 기본동작 = 페이지 다시 불러오기 안함)
		let title = $("#movieTitle").val();
		var key = "e9ac77cb0a9e1fa7c1fe08d1ee002e3b";
		$.ajax({
			type: "GET",
			url: "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=" + key + "&movieNm=" + title,
			success: function(data){
				
				let movies = data.movieListResult.movieList;
				$("#movieInfo").empty();
				//영화제목을 검색했을때 감독,상영일이 있으면 반복문 통해서 출력
				for(let movie of movies) { // movies배열에 값들을 movie변수에 저장
					if(movie.openDt !== "" && movie.directors.length > 0) {//개봉일값이 ""가 아니고 감독명 길이가 0보다 클때
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
	}); // button 끝s
	
	
	/*
	박스오피스 API는 줄거리랑 포스터 정보가 없음
	KMDb는 진짜 영화정보만 있음
	해결법
	- 박스오피스 데이터(제목, 개봉일, 감독)를 먼저 받아와서
	- 응답데이터 중 KMDb요청인자로 사용할수 있는것 뽑아내기
	- 뽑아낸 데이터를 KMDb 요청인자로 넣어서 영화 정보를 검색
	
	
	*/
	
	$("#adminMovieSearchDetail").on("click", function(){
		let kmdbKey = "C7643LD2JV0X8LAV20YO";
		
		let title_name = $("#movieTitlekmdb").val();
		
		$.ajax({
			type: "GET",
			dataType: "json",
			url: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=" + kmdbKey + "&title=" + title_name,
			data:{
				detail: "Y",
			},
			success: function(kmdb){
				
// 				var movieTotal = []; //영화 모든 정보들을 배열에 저장하기
//------------------------------------------------------------------------------------------------------------------------ 영화제목 박스오피스에서 가져오기
// 				let movieTitles = []; //movieTitles변수를 가진 배열에 kmdb.Data[0].Result배열 안에있는 영화제목을 저장
// 				kmdb.Data[0].Result.forEach(function(movie) {
// 					movieTitles.push(movie.title);
// 				});
				
// 				let titleFormat = [];//title을 배열로 저장
// 				movieTitles.forEach(function(title) {
// 					title = title.replace(/!HS/g, "") //"!HS"를 ""으로 바꾸기
// 							.replace(/!HE/g, "")//"!HE"를 ""으로 바꾸기
// 							.replace(/^\s+|\s+$/g, "")//처음과 끝의 공백 제거
// 							.replace(/ +/g, " ");//연속된 공백을 하나의 공백으로 바꾸기
// 					titleFormat.push(title); // 변경된 title을 titleFormat저장
// 				});

//  					console.log(titleFormat); //영화제목 배열로 출력
//------------------------------------------------------------------------------------------------------------------------ 영화코드 박스오피스에서 가져오기
// 				let movieCode = [];
// 					kmdb.Data[0].Result.forEach(function(movie){
// 						movieCode.push(movie.movieSeq);
// 				});
// 					console.log(kmdb.Data[0].Result.forEach); //영화제목 배열로 출력
//------------------------------------------------------------------------------------------------------------------------ 					
// 				let directorNm = [];
// 					kmdb.Data[0].Result[0].directors.director[0].(function(movie) {
// 						directorNm.push(movie.directorNm);
// 					});
					console.log(kmdb.Data[0].Result[0].prodYear); //제작년도
					console.log(kmdb.Data[0].Result[0].nation); //제작국가
					console.log(kmdb.Data[0].Result[0].genre); //장르
					console.log(kmdb.Data[0].Result[0].runtime); //상영시간(분)
					//상영상태(기본값을 0으로둔다?)
					console.log(kmdb.Data[0].Result[0].ratings.rating[0].releaseDate); //상영일
					//종영일
					for(let i = 0; i < 3; i++) {
						if(kmdb.Data[0].Result[0].actors.actor[i]) {
							console.log(kmdb.Data[0].Result[0].actors.actor[i].actorNm); //배우 순서대로 3명 출력
						}
					}
					console.log(kmdb.Data[0].Result[0].rating); //관람등급
// 					console.log(kmdb.Data[0].Result[0].posters); //포스터
					
					let posters = kmdb.Data[0].Result[0].posters.split("|"); //포스터
					let poster = posters[0];
					$("#posterThumnail").attr("src", poster);
					$("#movie_poster").val(poster);
					
					console.log(kmdb.Data[0].Result[0].vods.vod[0].vodUrl); //트레일러
					console.log(kmdb.Data[0].Result[0].keywords); //줄거리
					
					
			}, //success 끝
			error: function(){
				$("#movieInfo").html("영화 정보를 가져오는데 실패했습니다");
			} //error 끝
		}); //ajax 끝


	}); // button 끝
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
		<div id="admin_main">
			<div id="adminSearch">
				<form id="searchForm">
					<input type="text" id="movieTitle" placeholder="제목을 입력하세요"><input type="button" id="adminMovieSearch" value="검색">
				</form>
				<input type="text" id="movieTitlekmdb" placeholder="제목을 입력하세요"><input type="button" id="adminMovieSearchDetail" value="검색">
			</div>
<!-- 		<div id="movieInfo"> -->
			<form action="movieRgst" method="post" id="movieRegist">
				<table id="movieTable">
		            <colgroup> 
		                <col style="width: 20%;">
		                <col style="width: 20%;">   
		                <col style="width: 20%;"> 
		                <col style="width: 40%;">   
		            </colgroup> 
					<tr>
						<td rowspan="5" colspan="2" id="posterArea">
							<img src="" id="posterThumnail"><br>
						</td>
						<th width="100px">영화코드</th>
						<td><input type="text" name="movie_id" id="movie_id" class="shortInput"></td>
					</tr>
					<tr>
						<th width="100px">영화제목</th>
						<td><input type="text" name="movie_title" id="movie_title" class="shortInput"></td>
					</tr>
					<tr>
						<th width="100px">감독</th>
						<td><input type="text" name="movie_director" id="movie_director" class="shortInput"></td>
					</tr>
					<tr>
						<th>제작년도</th>
						<td >
							<input type="text" name="movie_prdtYear" id="movie_prdtYear" class="shortInput" maxlength="4">
							<div id="checkMovie_prdtYearResult"></div>
						</td>
					</tr>
					<tr>
						<th>제작국가</th>
						<td ><input type="text" name="movie_nation" id="movie_nation" class="shortInput"></td>
						
					</tr>
					<tr>
						<th>배우</th>
						<td><input type="text" name="movie_actor" id="movie_actor" class="shortInput"></td>
						<th>장르</th>
						<td><input type="text" name="movie_genre" id="movie_genre" class="shortInput"></td>
					</tr>
					<tr>
						<th>관람객수</th>
						<td>
							<input type="text" name="movie_audience" id="movie_audience" class="shortInput">
							<div id="checkMovie_audienceResult"></div>
						</td>
						<th>상영시간</th>
						<td>
							<input type="text" name="movie_runtime" id="movie_runtime" class="shortInput" maxlength="4">
							<div id="checkMovie_runtimeResult"></div>
						</td>
					</tr>
					<tr>
						<th>관람등급</th>
						<td><input type="text" name="movie_rating" id="movie_rating" class="shortInput"></td>
						<th>상영 상태</th>
						<td>
						<select name="movie_status" id="movie_status">
							<option value="" selected disabled id="default_status">상영 상태</option>
							<option value="0" id="comming">개봉 예정</option>
							<option value="1" id="release">개봉</option>
						</select>
						</td>
					</tr>
					<tr>
						<th>상영일</th>
						<td><input type="date" name="movie_release_date" id="movie_release_date" class="shortInput"></td>
						<th>종영일</th>
						<td><input type="date" name="movie_close_date" id="movie_close_date" class="shortInput"></td>
					</tr>
					<tr>
						<th>포스터</th>
						<td colspan="3"><input type="text" name="movie_poster" id="movie_poster" class="longInput"></td>
					</tr>
					<tr>
						<th>스틸컷1</th>
						<td colspan="3"><input type="text" name="movie_still1" class="still longInput"></td>
					</tr>
					<tr>
						<th>스틸컷2</th>
						<td colspan="3"><input type="text" name="movie_still2" class="still longInput"></td>
					</tr>
					<tr>
						<th>스틸컷3</th>
						<td colspan="3"><input type="text" name="movie_still3" class="still longInput"></td>
					</tr>
					<tr>
						<th>트레일러</th>
						<td colspan="3"><input type="text" name="movie_trailer" id="movie_trailer" class="longInput"></td>
					</tr>
					<tr>
						<th>줄거리</th>
						<td colspan="3"><input type="text" name="movie_plot" id="movie_plot" class="longInput"></td>
					</tr>
				</table>
				<input type="submit" value="등록" id="regist">
				<input type="button" value="창닫기" onclick="history.back();">
			</form>
		</div>
	</section>
	</div>
</body>
</html>