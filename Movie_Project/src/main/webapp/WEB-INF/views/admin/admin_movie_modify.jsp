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
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
	<section id="content">
	<h1 id="h01">영화수정</h1>
	<hr>
	<div id="admin_nav">
		<jsp:include page="admin_menubar.jsp"></jsp:include>
	</div>
	<div id="admin_main">
<!-- 		<div id="grayDiv"> -->
<!-- 			<div id="posterArea"> -->
<%-- 				<img src="${movie.movie_poster }" class="poster"><br> --%>
<!-- 				<input type="file"><br><br> -->
<!-- 			</div> -->
			<form action="movieMod" method="post">
				<table id="movieTable">
		            <colgroup> 
		                <col style="width: 20%;">
		                <col style="width: 20%;">   
		                <col style="width: 20%;"> 
		                <col style="width: 40%;">   
		            </colgroup> 
					<tr>
						<td rowspan="5" colspan="2" id="posterArea">
							<img src="${movie.movie_poster }"" class="poster"><br>
						</td>
						<th width="100px">영화코드</th>
						<td><input type="text" name="movie_id" value="${movie.movie_id }" id="movie_id" class="shortInput"></td>
					</tr>
					<tr>
						<th width="100px">영화제목</th>
						<td><input type="text" name="movie_title" value="${movie.movie_title }" id="movie_title" class="shortInput"></td>
					</tr>
					<tr>
						<th width="100px">감독</th>
						<td><input type="text" name="movie_director" value="${movie.movie_director }" id="movie_director" class="shortInput"></td>
					</tr>
					<tr>
						<th>제작년도</th>
						<td ><input type="text" name="movie_prdtYear" value="${movie.movie_prdtYear }" id="movie_prdtYear" class="shortInput"></td>
					</tr>
					<tr>
						<th>제작국가</th>
						<td ><input type="text" name="movie_nation" value="${movie.movie_nation }" id="movie_nation" class="shortInput"></td>
					</tr>
					<tr>
						<th>배우</th>
						<td><input type="text" name="movie_actor" value="${movie.movie_actor }" id="movie_actor" class="shortInput"></td>
						<th>장르</th>
						<td><input type="text" name="movie_genre" value="${movie.movie_genre }" id="movie_genre" class="shortInput"></td>
					</tr>
					<tr>
						<th>관람객수</th>
						<td><input type="text" name="movie_audience" value="${movie.movie_audience }" id="movie_audience" class="shortInput"></td>
						<th>상영시간</th>
						<td><input type="text" name="movie_runtime" value="${movie.movie_runtime }" id="movie_runtime" class="shortInput"></td>
					</tr>
					<tr>
						<th>관람등급</th>
						<td><input type="text" name="movie_rating" value="${movie.movie_rating }" id="movie_rating" class="shortInput"></td>
						<th>상영 상태</th>
						<td>
							<select name="movie_status" id="movie_status">
								<option disabled>상영 상태</option>
								<option value="0"<c:if test="${movie.movie_status eq 0 }">selected</c:if>>미개봉</option>
								<option value="1" <c:if test="${movie.movie_status eq 1 }">selected</c:if>>개봉</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>상영일</th>
						<td><input type="date" name="movie_release_date" value="${movie.movie_release_date }" id="movie_release_date" class="shortInput"></td>
						<th>종영일</th>
						<td><input type="date" name="movie_close_date" value="${movie.movie_close_date}" id="movie_close_date" class="shortInput"></td>
					</tr>
					<tr>
						<th>포스터</th>
						<td colspan="3"><input type="text" name="movie_poster" value="${movie.movie_poster }" class="poster longInput" ></td>
					</tr>
					<tr>
						<th>스틸컷1</th>
						<td colspan="3"><input type="text" name="movie_still1" value="${movie.movie_still1 }" class="still longInput"></td>
					</tr>
					<tr>
						<th>스틸컷2</th>
						<td colspan="3"><input type="text" name="movie_still2" value="${movie.movie_still2 }" class="still longInput"></td>
					</tr>
					<tr>
						<th>스틸컷3</th>
						<td colspan="3"><input type="text" name="movie_still3" value="${movie.movie_still3 }" class="still longInput"></td>
					</tr>
					<tr>
						<th>트레일러</th>
						<td colspan="3"><input type="text" name="movie_trailer" value="${movie.movie_trailer }" id="movie_trailer" class="longInput"></td>
					</tr>
					<tr>
						<th>줄거리</th>
						<td colspan="3"><input type="text" name="movie_plot" value="${movie.movie_plot }" id="movie_plot" class="longInput"></td>
					</tr>
				</table>
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>영화코드</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_id" value="${movie.movie_id }" id="movieCd"> --%>
<!-- 				</div> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>영화제목</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_title" value="${movie.movie_title }" id="movieNm"> --%>
<!-- 				</div> -->
<!-- 				<br><br> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>감독</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_director" value="${movie.movie_director }" id="directors"> --%>
<!-- 				</div> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>배우</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_actor" value="${movie.movie_actor }" id="actors"> --%>
<!-- 				</div> -->
<!-- 				<br><br> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>제작년도</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_prdtYear" value="${movie.movie_prdtYear }" id="prdtYear"> --%>
<!-- 				</div> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>제작국가</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_nation" value="${movie.movie_nation }" id="nation"> --%>
<!-- 				</div> -->
<!-- 				<br><br>	 -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>관람객수</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_audience" value="${movie.movie_audience }" id="audiAcc"> --%>
<!-- 				</div> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>상영시간</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_runtime" value="${movie.movie_runtime }" id="showTm"> --%>
<!-- 				</div> -->
<!-- 				<br><br> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>관람등급</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_rating" value="${movie.movie_rating }" id="watchGradeNm"> --%>
<!-- 				</div> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>장르</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_genre" value="${movie.movie_genre }" id="genre"> --%>
<!-- 				</div> -->
<!-- 				<br><br> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>상영일</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="date" name="movie_release_date" value="${movie.movie_release_date }" id="openDt"> --%>
<!-- 				</div> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>종영일</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="date" name="movie_close_date" value="${movie.movie_close_date}" id="movie_close_date"> --%>
<!-- 				</div> -->
<!-- 				<br><br> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>예고영상</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_trailer" value="${movie.movie_trailer }" id="vod"> --%>
<!-- 				</div> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>스틸컷1</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_still1" value="${movie.movie_still1 }" class="still"> --%>
<!-- 				</div> -->
<!-- 				<br><br> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>스틸컷2</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_still2" value="${movie.movie_still2 }" class="still"> --%>
<!-- 				</div> -->
<!-- 				<div id="grayBlock"> -->
<!-- 					&nbsp;&nbsp;<sup>스틸컷3</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_still3" value="${movie.movie_still3 }" class="still"> --%>
<!-- 				</div> -->
<!-- 				<br><br> -->
<!-- 				<div id="grayBlockWide"> -->
<!-- 					&nbsp;&nbsp;<sup>포스터</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_poster" value="${movie.movie_poster }" class="poster"> --%>
<!-- 				</div> -->
<!-- 				<div id="grayBlockWide"> -->
<!-- 					&nbsp;&nbsp;<sup>줄거리</sup><br> -->
<%-- 					&nbsp;&nbsp;<input type="text" name="movie_plot" value="${movie.movie_plot }" id="plot"> --%>
<!-- 				</div> -->
<!-- 					<br><br> -->
<!-- 				<div id="grayBlockWide"> -->
<!-- 					&nbsp;&nbsp;<sup>상영상태</sup><br> -->
<!-- 					<select name="movie_status" id="movie_status"> -->
<!-- 						<option disabled>상영 상태</option> -->
<%-- 						<option value="0"<c:if test="${movie.movie_status eq 0 }">selected</c:if>>미개봉</option> --%>
<%-- 						<option value="1" <c:if test="${movie.movie_status eq 1 }">selected</c:if>>개봉</option> --%>
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 				<br><br> -->
				<input type="submit" value="수정">
				<input type="submit" value="삭제" formaction="adminMovieDlt">
				<input type="button" value="창닫기" onclick="history.back();">
			</form>
<!-- 		</div> -->
	</div>
	</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>