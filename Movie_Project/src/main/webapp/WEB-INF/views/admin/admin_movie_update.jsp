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
// 	$(function() {
// 		let key = "811a25b246549ad749b278bba8257502"; // 발급 키
// 		// 어제 날짜 호출
// 		let targetDt = new Date().toLocaleDateString().replace(/[\.\s]/g, '') - 1;
// 		// kobis 일일 박스오피스
// 		$("#boxofficeSearch").on("click", function() {
// 			$.ajax({
// 				type: "GET",
// 				url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
// 				data: {
// 					key: key,
// 					targetDt: targetDt
// 				},
// 				dataType: "json",
// // 					async: false,
// 				success: function(result) { // 영화코드, 제목, 개봉일, 누적관객수
// 					let boxOfficeResult = result.boxOfficeResult;
// 					let dailyBoxOfficeList = boxOfficeResult.dailyBoxOfficeList;
					
// 					// 셀렉트 박스에 관객수, 영화코드, 개봉일을 data 속성으로 넣어주고 반복
// 					for(let movie of dailyBoxOfficeList) {
// 						$("#dailyBox").append("<option data-audiacc='" + movie.audiAcc + "' data-moviecd='" + movie.movieCd + "' data-opendt='" + movie.openDt + "'>" + movie.movieNm + "</option>");
// 		//					$("#dailyBox").append("<option>" + movie.movieCd + ":" + movie.movieNm + "</option>");
// 					}
// 				}, // 일일 박스오피스 success 끝
// 				error: function(xhr, textStatus, errorThrown) {
// 					alert("박스오피스 로딩중입니다.");
// 				}
// 			}); // 일일 박스오피스 ajax 요청 끝
// 		});
// 		// 셀렉트박스 선택 시
// 		$("#dailyBox").on("change", function() {
// 			// kobis 영화 상세정보
// 			$.ajax({
// 				type: "GET",
// 				url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
// 				data: {
// 					key: key,
// 					movieCd: $("#dailyBox option:selected").data("moviecd"),
// 				},
// 				dataType: "json",
// // 				async: false,
// 				success: function(kobis) {
// 					let directors = movieInfo.directors[0].peopleNm == null ? '' : movieInfo.directors[0].peopleNm;
// 					$("#directors").val(directors);
// 					// ----------------- kmdb api 접근 ------------------
// 					let ServiceKey = "08P2788CP12T24B2US8F";
// 			// 		let releaseDts = $("#dailyBox option:selected").data("opendt").replace(/[-]/g, '');
// 					$.ajax({
// 						type: "GET",
// 						url: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2",
// 						data: {
// 							ServiceKey: ServiceKey,
// 							title: movieNm,
// 							director: directors,
// 							detail: "Y",
// 			//					releaseDts: releaseDts
// 						},
// 						dataType: "json",
// 						success: function(kmdb) {
// 							console.log("성공");
							
// 						},
// 						error: function(xhr, textStatus, errorThrown) {
// 							alert("박스오피스 로딩중입니다.");
// 						}
// 					});
// 				},
// 				error: function(xhr, textStatus, errorThrown) {
// 					alert("박스오피스 로딩중입니다.");
// 				}
// 			});
// 		});
// 	});
</script>


</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
	<section id="content">
	<h1 id="h01">영화등록</h1>
	<hr>
	<div id="admin_nav">
		<jsp:include page="admin_menubar.jsp"></jsp:include>
	</div>
	<div id="admin_main">
<!-- 	<div id="grayDiv"> -->
		<select id="dailyBox">
			<option value="">영화를 선택하세요.</option>
			<%-- 일일 박스오피스 조회한 영화 제목 정보 표시 --%>
		</select>
		<input type="button" value="조회" id="boxofficeSearch"><br><br>
		<img src="" class="poster"><br>
<!-- 		<img src="" width="250" height="400"><br> -->
		<input type="file"><br><br>
			<form action="movieRgst" method="post">
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화코드</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_id" id="movieCd">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화제목</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_title" id="movieNm">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>감독</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_director" id="directors">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>배우</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_actor" id="actors">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>제작년도</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_prdtYear" id="prdtYear">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>제작국가</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_nation" id="nation">
			</div>
			<br><br>	
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람객수</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_audience" id="audiAcc">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영시간</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_runtime" id="showTm">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람등급</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_rating" id="watchGradeNm">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>장르</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_genre" id="genre">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영일</sup><br>
				&nbsp;&nbsp;<input type="date" name="movie_release_date" id="openDt">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>종영일</sup><br>
				&nbsp;&nbsp;<input type="date" name="movie_close_date" value="2024-01-31">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>포스터</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_poster" class="poster">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷1</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_still1" class="still">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷2</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_still2" class="still">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷3</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_still3" class="still">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예고영상</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_trailer" id="vod">
			</div>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>줄거리</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_plot" id="plot">
			</div>
				<br><br>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>상영상태</sup><br>
				<select name="movie_status" id="movie_status">
					<option>상영 상태</option>
					<option value="0">미개봉</option>
					<option value="1">개봉</option>
				</select>
			</div>
			<br><br>
<!-- 			<div id="grayBlock"> -->
<!-- 				&nbsp;&nbsp;<sup>검색할 영화 제목</sup><br> -->
<!-- 				&nbsp;&nbsp;<input type="text" placeholder="검색할영화"> -->
<!-- 			</div> -->
<!-- 			<div id="grayBlock"> -->
<!-- 				&nbsp;&nbsp;<sup>조회 연도</sup><br> -->
<!-- 				&nbsp;&nbsp;<input type="text" value="2002"> -->
<!-- 			</div> -->
			<input type="submit" value="등록">
			<input type="button" value="창닫기" onclick="history.back();">
		</form>
	</div>
	</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>