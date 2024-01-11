<%-- admin_movie_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		// ======== 개봉일과 상영상태를 비교하는 변수 목록 ========
		let nowTime = new Date().getTime(); // 계산의 기준이 될 날짜를 밀리초 단위로 리턴
		let movieReleaseTime = ''; // 계산의 대상이 될 날짜를 밀리초 단위로 리턴
		let differenceTime = ''; // 기준 날짜와 대상 날짜의 차이
		// ===== submit 수행 시 값의 판별에 사용할 변수 목록 =====
		let isDuplicateMovie = false;
		// ===============================================
		$("#movie_close_date").attr("min", $("#movie_release_date").val());
		
		// 개봉일을 변경할 경우 종영일의 최소값을 변경한다.
		$("#movie_release_date").on("change", function() {
			$("#movie_close_date").attr("min", $("#movie_release_date").val());
			movieReleaseTime = new Date($("#movie_release_date").val()).getTime();
			differenceTime = Math.round((nowTime - movieReleaseTime) / 1000 / 60 / 60 / 24);
			if(differenceTime > 0) { // 오늘보다 개봉일이 이전인 경우
				$("#release").prop("selected", true);
			} else { // 오늘보다 개봉일이 이후인 경우
				$("#comming").prop("selected", true);
			}
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
		
		// 종영 처리 시 수행할 동작
		$("#ending").on("click", function() {
			
		});
		
		// submit 시 수행할 동작
		$("#movieMod").on("click", function() {
			if($("#movie_title").val() == '') {
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
			
			if($("#movie_status").val() == '2') {
				return confirm("영화를 종영처리하시겠습니까?");
			} else {
				return confirm("영화를 수정하시겠습니까?");
			}
		});
		
		$("#movieDlt").on("click", function() {
			return confirm("영화를 삭제하시겠습니까?");
		});
		
	});
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
		<h1 id="h01">영화수정</h1>
		<hr>
			<div id="admin_main">
				<form action="" method="post">
					<table id="movieTable">
			            <colgroup> 
			                <col style="width: 20%;">
			                <col style="width: 20%;">   
			                <col style="width: 20%;"> 
			                <col style="width: 40%;">   
			            </colgroup> 
						<tr>
							<td rowspan="5" colspan="2" id="posterArea">
								<img src="${movie.movie_poster }" id="posterThumnail"><br>
							</td>
							<th width="100px">영화코드</th>
							<td><input type="text" name="movie_id" value="${movie.movie_id }" id="movie_id" class="shortInput" readonly></td>
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
							<td >
								<input type="text" name="movie_prdtYear" value="${movie.movie_prdtYear }" id="movie_prdtYear" class="shortInput" maxlength="4">
								<div id="checkMovie_prdtYearResult"></div>
							</td>
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
							<td>
								<input type="text" name="movie_audience" value="${movie.movie_audience }" id="movie_audience" class="shortInput">
								<div id="checkMovie_audienceResult"></div>
							</td>
							<th>상영시간</th>
							<td>
								<input type="text" name="movie_runtime" value="${movie.movie_runtime }" id="movie_runtime" class="shortInput" maxlength="4">
								<div id="checkMovie_runtimeResult"></div>
							</td>
						</tr>
						<tr>
							<th>관람등급</th>
							<td><input type="text" name="movie_rating" value="${movie.movie_rating }" id="movie_rating" class="shortInput"></td>
							<th>상영 상태</th>
							<td>
								<select name="movie_status" id="movie_status">
									<option disabled>상영 상태</option>
									<option value="0" id="comming" <c:if test="${movie.movie_status eq 0 }">selected</c:if>>개봉 예정</option>
									<option value="1" id="release" <c:if test="${movie.movie_status eq 1 }">selected</c:if>>개봉</option>
									<option value="2" id="ending" <c:if test="${movie.movie_status eq 2 }">selected</c:if>>종영</option>
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
							<td colspan="3"><input type="text" name="movie_poster" value="${movie.movie_poster }" id="movie_poster" class="longInput"></td>
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
					<input type="submit" value="수정" id="movieMod" formaction="movieMod">
					<input type="submit" value="삭제" id="movieDlt" formaction="adminMovieDlt">
					<input type="button" value="돌아가기" onclick="history.back();">
				</form>
			</div>
		</section>
	</div>
</body>
</html>