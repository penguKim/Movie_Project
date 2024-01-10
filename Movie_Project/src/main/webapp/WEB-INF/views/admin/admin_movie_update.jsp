<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 최신 영화 등록</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/dailyBoxOffice.js"></script> --%>
<script>
	$(function() {
		// ============= api 조회에 쓸 변수 목록 =============
		let key = "811a25b246549ad749b278bba8257502"; // kobis 발급 키
		var today = new Date(); // 오늘 날짜
		today.setDate(today.getDate() - 1); // 어제 날짜로 변환
		// 어제 날짜의 객체 생성
		let yesterday = {
			year: today.getFullYear(),
			month: ('0' + (today.getMonth() + 1)).slice(-2),
			day: ('0' + today.getDate()).slice(-2)
		};
		// yyyy-MM-dd 형식으로 어제날짜 변환
		let yesterdayFmt = yesterday.year + "-" + yesterday.month + "-" + yesterday.day;
		// 조회할 날짜의 기본값으로 어제 날짜를 선택
		$("#dateSelect").val(yesterdayFmt);
		// 일일 박스오피스는 오늘 날짜는 조회가 안되므로 어제 날짜까지 조회하게한다.
		$("#dateSelect").attr("max", yesterdayFmt);
		// ======== 개봉일과 상영상태를 비교하는 변수 목록 ========
		let nowTime = new Date().getTime(); // 계산의 기준이 될 날짜를 밀리초 단위로 리턴
		let movieReleaseTime = ''; // 계산의 대상이 될 날짜를 밀리초 단위로 리턴
		let differenceTime = ''; // 기준 날짜와 대상 날짜의 차이
		// ===== submit 수행 시 값의 판별에 사용할 변수 목록 =====
		let isDuplicateMovie = false;
		// ===============================================
		
		// 박스오피스 조회 버튼을 눌러서 셀렉트박스에 영화 목록 뿌리기
		$("#boxofficeSearch").on("click", function() {
			if($("#dateSelect").val() == "") { // 날짜를 고르지 않았을 경우
				alert("조회할 날짜를 선택하세요!");
			} else {
				// 조회할 날짜
				let targetDt = $("#dateSelect").val().replace(/[\-\s]/g, '');
				$.ajax({
					// 일일 박스오피스
					url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
					data: {
						key: key,
						targetDt: targetDt
					},
					dataType: "json",
					success: function(result) { // 영화코드, 제목, 개봉일, 누적관객수
						// 조회 버튼을 누를때 마다 추가되므로 다시 누를 경우엔 기존의 목록을 삭제한다.
						$("#dailyBox").empty();
						let boxOfficeResult = result.boxOfficeResult;
						let dailyBoxOfficeList = boxOfficeResult.dailyBoxOfficeList;
						// 기본으로 표시된 안내 멘트 출력
						$("#dailyBox").append("<option value='movieValue' selected disabled class='defaultValue'>영화를 선택하세요.</option>");
						// 박스오피스의 목록의 영화 수만큼 감독정보를 검색한다.
						for(let movie of dailyBoxOfficeList) {
							$.ajax({
								// 영화 상세정보
								url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
								data: {
									key: key,
									movieCd: movie.movieCd
								},
								dataType: "json",
								success: function(result) { // 감독만 가져오기
									let movieInfoResult = result.movieInfoResult;
									let movieInfo = movieInfoResult.movieInfo;
									// 감독은 배열로 전달되므로 문자열 결합을 한다.
									let arrDirectors = movieInfo.directors;
// 			 						console.log(arrDirectors);
									let directors = "";
									for(let as of arrDirectors) {
										directors += as.peopleNm + "/" 
									}
								// 가져온 관객수, 영화코드, 감독명, 개봉일은 data 속성으로 각각 넣어주고 제목을 출력한다.
								$("#dailyBox").append(
									"<option data-audiacc='" + movie.audiAcc 
									+ "'data-moviecd='" + movie.movieCd 
									+ "' data-director='" + directors.substring(0, directors.length - 1) 
									+ "' data-opendt='" + movie.openDt + "'>" 
									+ movie.movieNm 
									+ "</option>"
								);
								},
								error: function(xhr, textStatus, errorThrown) {
									alert("박스오피스 로딩중입니다.");
								}
							});
						}
					},
					error: function(xhr, textStatus, errorThrown) {
						alert("박스오피스 로딩중입니다.");
					}
				});
			}
		});
		
		// 영화 상세정보는 kobis에서 관리하는 영화코드로 검색한다.
		$("#boxofficeSelect").on("click", function() {
			if($("#dailyBox option:selected").val() == "dateValue") { // 날짜를 고르지 않았을 경우
				alert("조회할 날짜를 선택하세요!");
			} else if($("#dailyBox option:selected").val() == "movieValue") { // 영화를 고르지 않았을 경우
				alert("영화를 선택하세요!");
			} else {
				let ServiceKey = "08P2788CP12T24B2US8F"; // kmdb 발급 키
				let movieCd = $("#dailyBox option:selected").data("moviecd"); //영화 코드
				let title = $("#dailyBox option:selected").val(); // 영화 제목
				let director = $("#dailyBox option:selected").data("director"); // 감독명
				let releaseDts = $("#dailyBox option:selected").data("opendt").replace(/[-]/g, ''); // 개봉일
				// 상세정보 검색을 위한 ajax 처리
				$.ajax({
					type: "GET",
					url: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2",
					data: {
						ServiceKey: ServiceKey,
						title: title,
						// kobis와 kmdb에서 감독명이 미세하게 다를 수 있으므로 공백 기준 처음 문자열로 검색한다.
						director: director.split(" ")[0],
// 						director: director,
						detail: "Y", // 상세검색을 위한 파라미터
						releaseDts: releaseDts
					},
					dataType: "json",
					success: function(kmdb) {
						if(kmdb.Data[0].TotalCount == 0) { // 조회 결과가 0인 경우
							alert("해당 영화의 정보가 없습니다! \n직접 입력해주세요!");
							return;
						}

						// 테이블의 input 태그에 출력하기
						// 영화 코드
						$("#movie_id").val(movieCd);
						// 영화 제목
						$("#movie_title").val(title);
						// 감독 정보
						$("#movie_director").val(director);
						// 배우 배열
						// 배우가 3명보다 작을 경우 그대로 가져오고 3명보다 많을 경우 3명으로 제한한다.
						let actors = kmdb.Data[0].Result[0].actors.actor.length < 3 
									? kmdb.Data[0].Result[0].actors.actor 
									: kmdb.Data[0].Result[0].actors.actor.slice(0,3);
						let actor = '';
						// 배우를 구분자로 구별하여 하나의 문자열로 결합
						for(let el of actors) {
							actor += el.actorNm + '/';
						}
						// 마지막 구분자 제거
						$("#movie_actor").val(actor.substring(0, actor.length - 1));
						// 제작년도
						let prodYear = kmdb.Data[0].Result[0].prodYear;
						$("#movie_prdtYear").val(prodYear);
						// 제작국가
					  	let nation = kmdb.Data[0].Result[0].nation;
						$("#movie_nation").val(nation);
						// 누적 관람객
						$("#movie_audience").val($("#dailyBox option:selected").data("audiacc"));
						// 상영시간
						let runtime = kmdb.Data[0].Result[0].runtime;
						$("#movie_runtime").val(runtime);
						// 관람등급
						let rating = kmdb.Data[0].Result[0].rating;
						$("#movie_rating").val(rating);
						// 장르
					  	let genre = kmdb.Data[0].Result[0].genre;
						$("#movie_genre").val(genre);
						// 상영일
					  	let repRlsDate = kmdb.Data[0].Result[0].repRlsDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
						$("#movie_release_date").val(repRlsDate);
						// 영화의 상영 종료일은 영화의 상영일보다 이후여야한다.
						$("#movie_close_date").attr("min", repRlsDate);
						// 줄거리
					  	let plot = kmdb.Data[0].Result[0].plots.plot[0].plotText;
						$("#movie_plot").val(plot);
						// 포스터 문자열
					  	let posters = kmdb.Data[0].Result[0].posters.split("|");
						// 첫번째 포스터
					  	let poster = posters[0];
						$("#posterThumnail").attr("src", poster);
						$("#movie_poster").val(poster);
						// 스틸샷 문자열
						let stills = kmdb.Data[0].Result[0].stlls.split("|").slice(0, $('.still').length);
						$(".still").each(function(index) {
							$(this).val(stills[index]);
						});
						// 트레일러
						// 가져오는 주소는 embed 태그의 src로 넣을시 작동되지 않으면 아래처럼 변환하자.
						let vod = kmdb.Data[0].Result[0].vods.vod[0].vodUrl == null ? '' : kmdb.Data[0].Result[0].vods.vod[0].vodUrl.replace('trailerPlayPop?pFileNm=', 'play/');
						$("#movie_trailer").val(vod);
						
						// 영화 조회시 상영 상태를 날짜 기준으로 기본값 정하기
						movieReleaseTime = new Date(repRlsDate).getTime(); // 계산의 대상이 될 날짜를 밀리초 단위로 리턴
						// 두 날짜의 차이를 초 -> 분 -> 시 -> 일 비교값으로 나타내기
						differenceTime = Math.round((nowTime - movieReleaseTime) / 1000 / 60 / 60 / 24);
						// 개봉상태 지정
						if(differenceTime> 0) { // 오늘보다 개봉일이 이전인 경우
// 							$("#default_status").prop("selected", false);
							$("#release").prop("selected", true);
						} else { // 오늘보다 개봉일이 이후인 경우
// 							$("#default_status").prop("selected", false);
							$("#comming").prop("selected", true);
						}
					},
					error: function(xhr, textStatus, errorThrown) {
						alert("박스오피스 로딩중입니다.");
					}
				});
			}
		});
		
		// 영화를 선택했을 경우 DB에서 중복 판별 작업을 수행한다.
		$("#dailyBox").on("change", function() {
			$.ajax({
				type:"GET",
				url:"movieDupl",
				data: {
					movie_id: $("#dailyBox option:selected").data("moviecd")
				},
				success: function(result) {
					// 중복 결과를 "true", "false" 문자열로 반환
					if(result == 'true') {
						alert("이미 등록된 영화입니다!");
						isDuplicateMovie = true;
						$("#dailyBox").focus();
						$("#dailyBox").eq(0).prop("selected", true);
						$("#regist").hide();
						
					} else {
						isDuplicateMovie = false;
						$("#regist").show();
					}
				}
			});
			// 다른 영화를 선택하면 입력된 input 항목과 포스터 제거
			$("form").find("input[type=text]").val("");
			$("form").find("input[type=date]").val("");
			$("#posterArea").find("img").attr("src", "");
		});
		
		// 제작년도는 4자리 숫자로 제한한다.
		$("#movie_prdtYear").on("blur", function() {
			let movie_prdtYear = $("#movie_prdtYear").val();
			let regex = /^(19[0-9][0-9]|20[0-2][0-9])/;
			
			if(!regex.test(movie_prdtYear)) {
				$("#checkMovie_prdtYearResult").text("올바른 년도를 입력해주세요").css("color", "red")
			} else {
				$("#checkMovie_prdtYearResult").text("");
			}
			
		});
		
		// 관람객수는 숫자로 입력한다.
		$("#movie_audience").on("blur", function() {
			let movie_audience = $("#movie_audience").val();
			let regex = /^[0-9]$/;
			
			if(!regex.test(movie_audience)) {
				$("#checkMovie_audienceResult").text("숫자로 입력해주세요").css("color", "red");
			} else {
				$("#checkMovie_audienceResult").text("");
			}
		});
			
		// 상영시간은 숫자로 입력한다.
		$("#movie_runtime").on("blur", function() {
			let movie_runtime = $("#movie_runtime").val();
			let regex = /^[0-9]{3}$/;
			
			if(!regex.test(movie_runtime)) {
				$("#checkMovie_runtimeResult").text("분단위 숫자로 입력해주세요").css("color", "red");
			} else {
				$("#checkMovie_runtimeResult").text("");
			}
		});
		
		// 자동 선택 이후 개봉일을 변경할 경우 종영일의 최소값을 변경한다.
		$("#movie_release_date").on("change", function() {
			$("#movie_close_date").attr("min", $("#movie_release_date").val());
			movieReleaseTime = new Date($("#movie_release_date").val()).getTime();
			differenceTime = Math.round((nowTime - movieReleaseTime) / 1000 / 60 / 60 / 24);
			if(differenceTime> 0) { // 오늘보다 개봉일이 이전인 경우
				$("#release").prop("selected", true);
			} else { // 오늘보다 개봉일이 이후인 경우
				$("#comming").prop("selected", true);
			}
		});

		// submit 시 수행할 동작
		$("form").on("submit", function() {
			if(isDuplicateMovie) { // 등록된 영화인지 판별
				alert("이미 등록된 영화입니다!");
				return false;
			} else if($("#movie_id").val() == '') {
				alert("영화코드를 입력하세요!");
				return false;
			} else if($("#movie_title").val() == '') {
				alert("영화 제목을 입력하세요!");
				return false;
			} else if($("#movie_director").val() == '') {
				alert("감독을 입력하세요!");
				return false;
			} else if($("#movie_actor").val() == '') {
				alert("배우를 입력하세요!");
				return false;
			} else if($("#movie_prdtYear").val() == '') {
				alert("제작년도를 입력하세요!");
				return false;
			} else if($("#movie_nation").val() == '') {
				alert("제작국가를 입력하세요!");
				return false;
			} else if($("#movie_audience").val() == '') {
				alert("관객수를 입력하세요!");
				return false;
			} else if($("#movie_runtime").val() == '') {
				alert("상영시간을 입력하세요!");
				return false;
			} else if($("#movie_rating").val() == '') {
				alert("관람등급을 입력하세요!");
				return false;
			} else if($("#movie_genre").val() == '') {
				alert("장르를 입력하세요!");
				return false;
			} else if($("#movie_release_date").val() == '') {
				alert("개봉일을 입력하세요!");
				return false;
			} else if($("#movie_close_date").val() == '') {
				alert("종영일을 입력하세요!");
				return false;
			} else if($("#movie_poster").val() == '') {
				alert("포스터 주소를 입력하세요!");
				return false;
			} else if($("#movie_plot").val() == '') {
				alert("줄거리를 입력하세요!");
				return false;
			} else if($("#movie_status").val() == '') {
				alert("상영상태를 선택하세요!");
				return false;
			}
			
			return confirm("영화를 등록하시겠습니까?");
		});
		

		
	}); // $(document).ready() 끝
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
		<h1 id="h01">영화등록</h1>
		<hr>
			<div id="admin_main">
				<div id="searchArea">
					<input type="date" value="" id="dateSelect">
					<input type="button" value="박스오피스 조회" id="boxofficeSearch">
					<select id="dailyBox">
						<option value="dateValue" selected disabled class="dateValue">날짜를 조회하세요.</option>
						<%-- 일일 박스오피스 조회한 영화 제목 정보 표시 --%>
					</select>
					<input type="button" value="선택" id="boxofficeSelect"><br><br>
				</div>
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
					<input type="button" value="돌아가기" onclick="history.back();">
				</form>
			</div>
		</section>
	</div>
</body>
</html>