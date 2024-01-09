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
// input text에서 검색해서 버튼클릭했을때 selectBox로 입력받은 검색어에 관한 영화목록들을 조회(ajax)
// selectBox 목록에서 영화제목을 클릭했을때 상세정보가 inputText에 출력되게 할거임.(ajax)

$(document).ready(function(){
	// ======== 개봉일과 상영상태를 비교하는 변수 목록 ========
	let nowTime = new Date().getTime(); // 계산의 기준이 될 날짜를 밀리초 단위로 리턴
	let movieReleaseTime = ''; // 계산의 대상이 될 날짜를 밀리초 단위로 리턴
	let differenceTime = ''; // 기준 날짜와 대상 날짜의 차이
	$("#adminMovieSearch").on("click", function(){
// 		data.preventDefault(); //기본 이벤트 작동 못하게 하는 함수 (submit 함수쓸때 기본동작 = 페이지 다시 불러오기 안함)
		let title = $("#movieTitle").val();
		let key = "e9ac77cb0a9e1fa7c1fe08d1ee002e3b";
			
		$.ajax({
			type: "GET",
			url: "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json",
			data: {
				movieNm : title, //title 값을 movieNm에 넣음
				key : key
			},
			success: function(data){
				let movies = data.movieListResult.movieList;
				$("#selectBox").empty().append("<option selected disabled>영화를 선택해주세요</option>");
				//영화제목을 검색했을때 감독,상영일이 있으면 반복문 통해서 출력
				for(let movie of movies) { // movies배열에 값들을 movie변수에 저장
					if(movie.openDt !== "" && movie.directors.length > 0) {//개봉일값이 ""가 아니고 감독명 길이가 0보다 클때
// 						console.log(movie.directors[0].peopleNm);
// 						console.log(movie.movieCd);
// 					$("#movie_id").val(movie.movieCd);
// 					$("#movie_director").val(movie.directors[0].peopleNm);
// 					$("#movie_audience").val('0');
                        $("#selectBox").append('<option data-moviecd="' + movie.movieCd + '"data-director="' + movie.directors[0].peopleNm +'">' + movie.movieNm + '</option>');// selectBox에 영화 제목 넣기
					}
				
			    $("#selectBox").show(); // 클릭시 체크박스 보이기
				}; //for문 끝
			}, //success 끝
			error: function(){
				alert("박스오피스 API영화 정보를 가져오는데 실패했습니다");
			} //error 끝
		}); //ajax 끝
	}); // button 끝
	
	
//--------------------------------------------------------------------------------------------------------------------------------------------------------
			
		$("#selectBox").on("change", function(){
			let kmdbKey = "C7643LD2JV0X8LAV20YO";
			let title = $("#selectBox option:selected").text(); // 선택된 영화의 제목을 가져옵니다.
			let movieCd = $("#selectBox option:selected").data("moviecd");
			let director = $("#selectBox option:selected").data("director");
			$.ajax({
				type: "get",
				dataType: "json",
				url: "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=" + kmdbKey +"&title="+ title,
				data:{
					detail: "Y",
					movieCd : movieCd,
					director : director
					
				},
				success: function(kmdb){
					  
					//영화 감독
					$("#movie_director").val(director);
					//영화 코드
					$("#movie_id").val(movieCd);
					// 영화 제목
					$("#movie_title").val(title);
					//관람객수
					$("#movie_audience").val("0");
					// 제작국가
				  	let nation = kmdb.Data[0].Result[0].nation;
					$("#movie_nation").val(nation);
					// 장르
				  	let genre = kmdb.Data[0].Result[0].genre;
					$("#movie_genre").val(genre);
					
					// 제작년도
					let prodYear = kmdb.Data[0].Result[0].prodYear;
					$("#movie_prdtYear").val(prodYear);
					// 상영시간
					let runtime = kmdb.Data[0].Result[0].runtime;
					$("#movie_runtime").val(runtime);
					// 관람등급
					let rating = kmdb.Data[0].Result[0].rating;
					$("#movie_rating").val(rating);
					// 상영일
				  	let repRlsDate = kmdb.Data[0].Result[0].repRlsDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
					$("#movie_release_date").val(repRlsDate);
					
					//배우 순서대로 3명
					let actors = "";
					for(let i = 0; i < 3; i++) {
						if(kmdb.Data[0].Result[0].actors.actor[i]) {
// 							console.log(kmdb.Data[0].Result[0].actors.actor[i].actorNm); //배우 순서대로 3명 출력
							let actor = kmdb.Data[0].Result[0].actors.actor[i].actorNm;
							actors += actor;
							if (i < 2){
								actors += ", ";
							}
						$("#movie_actor").val(actors);
						};
					};
						//포스터
						let posters = kmdb.Data[0].Result[0].posters.split("|"); 
						let poster = posters[0];
						$("#posterThumnail").attr("src", poster);
						$("#movie_poster").val(poster);
						
						//스틸컷
						let stills = kmdb.Data[0].Result[0].stlls.split("|").slice(0, $('.still').length);
						$(".still").each(function(index) {
							$(this).val(stills[index]);
						});
						
						// 자동 선택 이후 개봉일을 변경할 경우 종영일의 최소값을 변경한다.
						// 영화 조회시 상영 상태를 날짜 기준으로 기본값 정하기
						movieReleaseTime = new Date(repRlsDate).getTime(); // 계산의 대상이 될 날짜를 밀리초 단위로 리턴
						// 두 날짜의 차이를 초 -> 분 -> 시 -> 일 비교값으로 나타내기
						differenceTime = Math.round((nowTime - movieReleaseTime) / 1000 / 60 / 60 / 24);
						// 개봉상태 지정
						if(differenceTime> 0) { // 오늘보다 개봉일이 이전인 경우
							$("#release").prop("selected", true);
						} else { // 오늘보다 개봉일이 이후인 경우
							$("#comming").prop("selected", true);
						}
						
						//트레일러
						let vod = kmdb.Data[0].Result[0].vods.vod[0].vodUrl;
						$("#movie_trailer").val(vod);
						
						// 줄거리
					  	let plot = kmdb.Data[0].Result[0].plots.plot[0].plotText;
						$("#movie_plot").val(plot);
						
				}, //success 끝
				error: function(){
					alert("kmdbAPI영화 정보를 가져오는데 실패했습니다");
				} //error 끝
			}); //ajax 끝
	
		});
	
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
<!-- 				<form id="searchForm" > -->
					<input type="text" id="movieTitle" placeholder="제목을 입력하세요"><input type="button" id="adminMovieSearch" value="검색">
<!-- 				</form> -->
		<div>
			<select name="selectBox" id="selectBox" style="display: none;">
			</select>
		</div>
		
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
				<input type="button" value="창닫기" onclick="history.back();">
			</form>
		</div>
		
	</section>
	</div>
</body>
</html>