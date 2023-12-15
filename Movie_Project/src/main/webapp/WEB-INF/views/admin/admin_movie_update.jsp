<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 등록 팝업</title>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		let key = "811a25b246549ad749b278bba8257502"; // 발급 키
		// 어제 날짜 호출
		let targetDt = new Date().toLocaleDateString().replace(/[\.\s]/g, '') - 1;
// 		console.log(targetDt);

		
		$.ajax({
			// 일일 박스오피스
			url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
			data: {
				key: key,
				targetDt: targetDt
			},
			dataType: "json",
			async: false,
			success: function(result) { // 영화코드, 제목, 개봉일, 누적관객수
				let boxOfficeResult = result.boxOfficeResult;
				let dailyBoxOfficeList = boxOfficeResult.dailyBoxOfficeList;
				
				// 셀렉트 박스에 영화코드와 제목을 합쳐서 출력
				for(let movie of dailyBoxOfficeList) {
					// data 속성 알아보기
// 					$("#dailyBOx").append("<option data-movieCD=" + movie.movieCd + ">" + movie.movieNm + "</option>");
					$("#dailyBOx").append("<option data-movieCD=" + movie.movieCd + ">" + movie.movieCd + ":" + movie.movieNm + "</option>");
				}
				
				// 셀렉트 박스의 영화 제목 클릭 시 상세정보 조회
				$("#dailyBOx").on("change", function() {
					let movieCd = $(this).val().substring(0, $(this).val().indexOf(":"));
		// 			console.log(movieCd);
					let movieNm = $(this).val().substring($(this).val().lastIndexOf(":")+1);
		// 			console.log(movieNm);
					$.ajax({
						url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
// 						url: "movieRegistTest",
						data: {
							key: key,
							movieCd: movieCd
						},
						dataType: "json",
						success: function(result) {
							let movieInfo = result.movieInfoResult.movieInfo;
							// 상영시간
							let showTm = movieInfo.showTm;
							// 제작년도
							let prdtYear = movieInfo.prdtYear;
							// 개봉일
							let openDt = movieInfo.openDt;
							// 제작국가
							let nationNm = "";
							if(movieInfo.nations[0] != null) {
								nationNm = movieInfo.nations[0].nationNm;
							}
							// 장르
							let genres = "";
							for(let genre of movieInfo.genres) {
								genres += genre.genreNm + " ";
							}
							// 감독
							let directors = "";
							if(movieInfo.directors[0] != null) {
								directors = movieInfo.directors[0].peopleNm;
							}
							// 배우
							let actors = "";
							if(movieInfo.actors[0] != null && movieInfo.actors.length == 1) {
								for(let actor of movieInfo.actors) {
									actors += actor.peopleNm + "/"
								}
							} else if(movieInfo.actors[0] != null && movieInfo.actors.length < 3) {
								actors += movieInfo.actors[0].peopleNm
							} else if(movieInfo.actors[0] != null && movieInfo.actors.length >= 3) {
								for(let i = 0; i < 3; i++) {
									actors += movieInfo.actors[i].peopleNm + "/"
								}
							}
							// 관람등급
							let watchGradeNm = movieInfo.audits[0].watchGradeNm;
							
							// input 태그에 집어넣기
							$("#movieCd").val(movieCd);
							$("#movieNm").val(movieNm);
							$("#showTm").val(showTm + '');
							$("#prdtYear").val(prdtYear);
							// 8자리 숫자를 4,2,2 숫자의 정규표현식 활용하여 4-2-2의 형식으로 치환
							$("#openDt").val(openDt.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
							$("#nationNm").val(nationNm);
							$("#genres").val(genres);
							$("#directors").val(directors);
							$("#actors").val(actors.replace(/[/]$/g, ''));
							$("#watchGradeNm").val(watchGradeNm);
							
							console.log($("#movieNm").val());
					if($("#movieNm").val() != "") {
						console.log($("#movieNm").val());
						let ServiceKey = "08P2788CP12T24B2US8F";
						
						$.ajax({
							type: "GET",
							url: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp",
							data: {
								collection: "kmdb_new2",
								detail: "N",
								deirector: $("#directors").val(),
								title: $("#movieNm").val(),
								ServiceKey: ServiceKey
							},
							dataType: "json",
							success: function(result) {
								let title = result.Data[0].Result[0].title;
							  	let titleForamt = title.replace(/!HS/g, "")
													    .replace(/!HE/g, "")
													    .replace(/^\s+|\s+$/g, "")
													    .replace(/ +/g, " ");
								alert(titleForamt);
							}
						});
					}
						}
					});
				}); // onchange() 메서드 끝

			} // 일일 박스오피스 success 끝
		}); // 일일 박스오피스 ajax 요청 끝
		
		
		
				
		
	}); // document.ready 끝

	function btnRgst() {
		var result = confirm("영화 정보를 등록하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	function btnLookup() {
		location.reload();
	}
</script>
</head>
<body>
	<div id="grayDiv">
		<select id="dailyBOx">
			<option value="">영화를 선택하세요.</option>
			<%-- 일일 박스오피스 조회한 영화 제목 정보 표시 --%>
		</select>
		<input type="button" value="조회" onclick="btnLookup()"><br><br>
		<img src="${pageContext.request.contextPath}/resources/img/cobweb.jpg" width="250" height="400"><br>
		<input type="file"><br><br>
		<form action="movieTest" method="post">
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화코드</sup><br>
				&nbsp;&nbsp;<input type="text" id="movieCd">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화제목</sup><br>
				&nbsp;&nbsp;<input type="text" id="movieNm">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화감독</sup><br>
				&nbsp;&nbsp;<input type="text" id="directors">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>출연진</sup><br>
				&nbsp;&nbsp;<input type="text" id="actors">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>장르</sup><br>
				&nbsp;&nbsp;<input type="text" id="genres">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람객수</sup><br>
				&nbsp;&nbsp;<input type="text" id="audiAcc">
			</div>
			<br><br>
	<!-- 		<div id="grayBlock"> -->
	<!-- 			&nbsp;&nbsp;<sup>러닝타임</sup><br> -->
	<!-- 			&nbsp;&nbsp;<input type="text"  value="4시간"> -->
	<!-- 		</div> -->
	<!-- 		<div id="grayBlock"> -->
	<!-- 			&nbsp;&nbsp;<sup>심의등급</sup><br> -->
	<!-- 			&nbsp;&nbsp;<input type="text"  value="15세"> -->
	<!-- 		</div> -->
	<!-- 		<br><br> -->
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>제작년도</sup><br>
				&nbsp;&nbsp;<input type="text" id="prdtYear">
			</div>
			<br><br>		
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영시간</sup><br>
				&nbsp;&nbsp;<input type="text" id="showTm">
			</div>
	<!-- 		<br><br> -->
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람등급</sup><br>
				&nbsp;&nbsp;<input type="text" id="watchGradeNm">
			</div>
			<br><br>		
	<!-- 		<div id="grayBlock"> -->
	<!-- 			&nbsp;&nbsp;<sup>장르</sup><br> -->
	<!-- 			&nbsp;&nbsp;<input type="text" value="스릴러"> -->
	<!-- 		</div> -->
	<!-- 		<br><br> -->
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영일</sup><br>
				&nbsp;&nbsp;<input type="date" id="openDt">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>종영일</sup><br>
				&nbsp;&nbsp;<input type="date">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷1</sup><br>
				&nbsp;&nbsp;<input type="file">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷2</sup><br>
				&nbsp;&nbsp;<input type="file">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷3</sup><br>
				&nbsp;&nbsp;<input type="file">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예고영상</sup><br>
				&nbsp;&nbsp;<input type="file">
			</div>
			<br><br>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>줄거리</sup><br>
				&nbsp;&nbsp;<input type="text" value="아이유짱짱짱짱짱짱">
			</div>
				<br><br>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>상영상태</sup><br>
				&nbsp;&nbsp;<input type="text" value="아이유짱짱짱짱짱짱">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>검색할 영화 제목</sup><br>
				&nbsp;&nbsp;<input type="text" placeholder="검색할영화">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>조회 연도</sup><br>
				&nbsp;&nbsp;<input type="text" value="2002">
			</div>
			<br><br>
			<br>	
	<!-- 		<input type="button" value="등록" onclick="btnRgst()"> -->
			<input type="submit" value="등록">
			<input type="button" value="창닫기" onclick="window.close()">
		</form>
	</div>
</body>
</html>