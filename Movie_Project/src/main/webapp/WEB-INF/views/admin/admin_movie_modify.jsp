<%-- admin_movie_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 수정</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/dailyBoxOffice.js"></script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
	<section id="content">
	<h1 id="h01">영화수정</h1>
	<hr>
	<div id="admin_nav">
		<jsp:include page="admin_menubar.jsp"></jsp:include>
	</div>
	<div id="admin_main">
<!-- 	<div id="grayDiv"> -->
		<img src="${movie.movie_poster }" class="poster"><br>
<!-- 		<img src="" width="250" height="400"><br> -->
		<input type="file"><br><br>
			<form action="movieRgst" method="post">
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화코드</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_id" value="${movie.movie_id }" id="movieCd">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화제목</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_title" value="${movie.movie_title }" id="movieNm">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>감독</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_director" value="${movie.movie_director }" id="directors">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>배우</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_actor" value="${movie.movie_actor }" id="actors">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>제작년도</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_prdtYear" value="${movie.movie_prdtYear }" id="prdtYear">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>제작국가</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_nation" value="${movie.movie_nation }" id="nation">
			</div>
			<br><br>	
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람객수</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_audience" value="${movie.movie_audience }" id="audiAcc">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영시간</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_runtime" value="${movie.movie_runtime }" id="showTm">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람등급</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_rating" value="${movie.movie_rating }" id="watchGradeNm">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>장르</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_genre" value="${movie.movie_genre }" id="genre">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영일</sup><br>
				&nbsp;&nbsp;<input type="date" name="movie_release_date" value="${movie.movie_release_date }" id="openDt">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>종영일</sup><br>
				&nbsp;&nbsp;<input type="date" name="movie_close_date" value="${movie.movie_close_date}">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>포스터</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_poster" value="${movie.movie_poster }" class="poster">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷1</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_still1" value="${movie.movie_still1 }" class="still">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷2</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_still2" value="${movie.movie_still2 }" class="still">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷3</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_still3" value="${movie.movie_still3 }" class="still">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예고영상</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_trailer" value="${movie.movie_trailer }" id="vod">
			</div>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>줄거리</sup><br>
				&nbsp;&nbsp;<input type="text" name="movie_plot" value="${movie.movie_plot }" id="plot">
			</div>
				<br><br>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>상영상태</sup><br>
				<select name="movie_status" id="movie_status">
					<option>상영 상태</option>
					<option value="0"<c:if test="${movie.movie_status eq 0 }">selected</c:if>>미개봉</option>
					<option value="1" <c:if test="${movie.movie_status eq 1 }">selected</c:if>>개봉</option>
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
			<input type="submit" value="수정">
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