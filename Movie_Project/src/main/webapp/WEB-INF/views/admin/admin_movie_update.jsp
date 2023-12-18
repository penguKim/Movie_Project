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
<script src="${pageContext.request.contextPath}/resources/js/dailyBoxOffice.js"></script>
</head>
<body>
	<div id="grayDiv">
		<select id="dailyBox">
			<option value="">영화를 선택하세요.</option>
			<%-- 일일 박스오피스 조회한 영화 제목 정보 표시 --%>
		</select>
		<input type="button" value="조회"><br><br>
		<img src="" class="poster"><br>
<!-- 		<img src="" width="250" height="400"><br> -->
		<input type="file"><br><br>
			<form action="boardRgst" method="post">
<!-- 			<form action="movieTest" method="post"> -->
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
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람객수</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_audience" id="audiAcc">
			</div>
			<br><br>		
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영시간</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_runtime" id="showTm">
			</div>
	<!-- 		<br><br> -->
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람등급</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_rating" id="watchGradeNm">
			</div>
			<br><br>		
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
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷2</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_still2" class="still">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷3</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_still3" class="still">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예고영상</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_trailer" id="vod">
			</div>
			<br><br>
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
					<option value="1" selected>개봉</option>
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
			<br><br>
			<br>	
			<input type="hidden" name="fileName" value="admin_movie_update">	
			<input type="submit" value="등록">
			<input type="button" value="창닫기" onclick="window.close()">
		</form>
	</div>
</body>
</html>