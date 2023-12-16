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
		let openDt = "";
		
		$.ajax({
			// 일일 박스오피스
			url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
			data: {
				key: key,
				targetDt: targetDt
			},
			dataType: "json",
// 			async: false,
			success: function(result) { // 영화코드, 제목, 개봉일, 누적관객수
				let boxOfficeResult = result.boxOfficeResult;
				let dailyBoxOfficeList = boxOfficeResult.dailyBoxOfficeList;
				
				// 셀렉트 박스에 영화코드와 제목을 합쳐서 출력
				for(let movie of dailyBoxOfficeList) {
					// data 속성 알아보기
					$("#dailyBox").append("<option data-audiacc='" + movie.audiAcc + "' data-moviecd='" + movie.movieCd + "' data-opendt='" + movie.openDt + "'>" + movie.movieNm + "</option>");
// 					$("#dailyBox").append("<option>" + movie.movieCd + ":" + movie.movieNm + "</option>");
				}
				
				// 셀렉트 박스의 영화 제목 클릭 시 상세정보 조회
				$("#dailyBox").on("change", function() {
					let movieCd = $("#dailyBox option:selected").data("moviecd");
					console.log(movieCd);
					let movieNm = $("#dailyBox option:selected").val();
					console.log(movieNm);
					let audiAcc = $("#dailyBox option:selected").data("audiacc");
										
					let ServiceKey = "08P2788CP12T24B2US8F";
					
					let releaseDts = $("#dailyBox option:selected").data("opendt").replace(/[-]/g, '');
					console.log(releaseDts);
					$.ajax({
						type: "GET",
						url: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2",
						data: {
							ServiceKey: ServiceKey,
							title: movieNm,
							detail: "Y",
							releaseDts: releaseDts
						},
						dataType: "json",
						success: function(kmdb) {
// 							let movieList = kmdb.Data[0].Result;
// 							console.log(movieList.length);
// 							for(let movie of movieList) {
// 								console.log(movie.nation);
// 							}
							
							// 타이틀
							let title = kmdb.Data[0].Result[0].title;
							// 타이틀 특문 수정
						  	let titleForamt = title.replace(/!HS/g, "")
												    .replace(/!HE/g, "")
												    .replace(/^\s+|\s+$/g, "")
												    .replace(/ +/g, " ");
							// 장르
						  	let genre = kmdb.Data[0].Result[0].genre;
							// 국가
						  	let nation = kmdb.Data[0].Result[0].nation;
							// 줄거리
						  	let plot = kmdb.Data[0].Result[0].plots.plot[0].plotText;
							$("#plot").val(plot);
							// 포스터 문자열
						  	let posters = kmdb.Data[0].Result[0].posters.split("|");
							// 첫번째 포스터
						  	let poster = posters[0];
							$("#poster").attr("src", poster);
							// 제작년도
							let prodYear = kmdb.Data[0].Result[0].prodYear;
							// 관람등급
							let rating = kmdb.Data[0].Result[0].rating;
							// 개봉일
						  	let repRlsDate = kmdb.Data[0].Result[0].repRlsDate;
							// 상영시간
							let runtime = kmdb.Data[0].Result[0].runtime;
							// 스틸샷 문자열
							let stills = kmdb.Data[0].Result[0].stlls.split("|").slice(0, $('.still').length);
							for(let still of stills) {
								console.log(still);
							}
							
							$(".still").each(function(index) {
								$("this").val(stills[index]);
							});
// 							alert(titleForamt);
							
							
						}
					});
				}); // onchange() 메서드 끝
				
			} // 일일 박스오피스 success 끝
		}); // 일일 박스오피스 ajax 요청 끝
	}); // document.ready 끝
	function btnLookup() {
		location.reload();
	}
</script>
</head>
<body>
	<div id="grayDiv">
		<select id="dailyBox">
			<option value="">영화를 선택하세요.</option>
			<%-- 일일 박스오피스 조회한 영화 제목 정보 표시 --%>
		</select>
		<input type="button" value="조회" onclick="btnLookup()"><br><br>
		<img src="" id="poster"><br>
<!-- 		<img src="" width="250" height="400"><br> -->
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
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람객수</sup><br>
				&nbsp;&nbsp;<input type="text" id="audiAcc">
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
				&nbsp;&nbsp;<input type="text" class="still">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷2</sup><br>
				&nbsp;&nbsp;<input type="text" class="still">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷3</sup><br>
				&nbsp;&nbsp;<input type="text" class="still">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예고영상</sup><br>
				&nbsp;&nbsp;<input type="file">
			</div>
			<br><br>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>줄거리</sup><br>
				&nbsp;&nbsp;<input type="text" id="plot">
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