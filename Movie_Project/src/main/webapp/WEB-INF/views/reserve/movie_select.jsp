<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매하기</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/reserve.css" rel="stylesheet" type="text/css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<script type="text/javascript">
    //영화 선택시 1개만 선택 가능하게 하는 기능
	function toggleMovie(button) {
		var buttons = document.querySelectorAll('.overflow.movie input[type="button"]');
		for (var i = 0; i < buttons.length; i++) {
			buttons[i].classList.remove('selected');
		}
		button.classList.add('selected');
		param();
	}

	//극장 선택시 1개만 선택 가능하게 하는 기능
	function toggleTheater(button) {
		var buttons = document.querySelectorAll('.overflow.theater input[type="button"]');
		for (var i = 0; i < buttons.length; i++) {
			buttons[i].classList.remove('selected');
		}
		button.classList.add('selected');
		param();
	}

	//날짜 선택시 1개만 선택 가능하게 하는 기능
	function toggleDate(button) {
		var buttons = document.querySelectorAll('.overflow.date input[type="button"]');
		for (var i = 0; i < buttons.length; i++) {
			buttons[i].classList.remove('selected');
		}
		button.classList.add('selected');
		param();
	}

	//시간 선택시 1개만 선택 가능하게 하는 기능
	function toggleTime(button) {
		var buttons = document.querySelectorAll('.overflow.time input[type="button"]');
		for (var i = 0; i < buttons.length; i++) {
			buttons[i].classList.remove('selected');
		}
		button.classList.add('selected');
		param();
	}


	function param() {
	    var selectedMovie = document.querySelector('.overflow.movie input.selected');
	    var selectedTheater = document.querySelector('.overflow.theater input.selected');
	    var selectedDate = document.querySelector('.overflow.date input.selected');
	    var selectedTime = document.querySelector('.overflow.time input.selected');

	    var selectedValues = {
	        movie: selectedMovie ? selectedMovie.value : null,
	        theater: selectedTheater ? selectedTheater.value : null,
	        date: selectedDate ? selectedDate.value : null,
	        time: selectedTime ? selectedTime.value : null
	    };
	    
	  	

	    // 선택된 데이터를 표시
	    var tableCells = document.querySelectorAll('#end_param td');
	    tableCells[0].textContent = selectedValues.movie || '';
	    tableCells[1].textContent = selectedValues.theater || '';
	    tableCells[2].textContent = selectedValues.date || '';
	    tableCells[3].textContent = selectedValues.time || '';
	    
		// selectedValues의 각 속성을 각각의 hidden input 태그에 설정
	    document.querySelector('input[name="movie"]').value = selectedValues.movie || '';
	    document.querySelector('input[name="theater"]').value = selectedValues.theater || '';
	    document.querySelector('input[name="date"]').value = selectedValues.date || '';
	    document.querySelector('input[name="time"]').value = selectedValues.time || '';
	}
</script>
</head>
<body>
	<div id="wrapper"><%--CSS 요청으로 감싼 태그--%>
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content"><%--CSS 요청으로 감싼 태그--%>
			<h1 id="h01">예매하기</h1>
			<hr>
			<article>
				<div id = "reserve_parameter">
						<div class="overflow movie"><b>영화</b>
							<c:forEach var="movieList" items="${movieList}">
								<input type ="button" value="${movieList.movie_title}" onclick="toggleMovie(this)"><br>
							</c:forEach>
						</div> 
						<div class="overflow theater"><b>극장</b>
							<c:forEach var="theaterList" items="${theaterList}">
								<input type ="button" value="${theaterList.theater_name}" onclick="toggleTheater(this)"><br>
							</c:forEach>
						</div>
						<div class="overflow date"><b>날짜</b>
							<c:forEach var="playList" items="${playList}">
								<input type ="button" value="${playList.play_date}" onclick="toggleDate(this)"><br>
							</c:forEach>
<%-- 							<c:forEach var="play_date" items="${playList}"> --%>
<%-- 								<input type ="button" value="${playList.play_start_time}" onclick="toggleMovie(this)"><br> --%>
<%-- 							</c:forEach> --%>
<!-- 							2023<br>11<br> -->
<!-- 							<input type="button" value="수 29" onclick="toggleDate(this)"><br> -->
<!-- 							<input type="button" value="목 30" onclick="toggleDate(this)"><br> -->
<!-- 							2023<br>12<br> -->
<%-- 							<c:set var="Day_of_the_week" value="${fn:split('월,화,수,목,금,토,일', ',')}" /><!-- 요일을 결정지을 변수 선언 --> --%>
<%-- 							<c:set var="startDay" value="4" /> <!--시작하는 요일은 금요일 --> --%>
<%-- 							<c:forEach var="i" begin="1" end="31"><!-- 1일부터 31일까지 반복 --> --%>
<%-- 								<c:set var="day" value="${(i + startDay - 1) % 7}" /><!-- 요일 판별하는 변수 --> --%>
<%-- 								<c:set var="dayOfWeek" value="" /> --%>
<%-- 								<c:set var="dayOfWeek" value="${Day_of_the_week[day]}" /> --%>
<%-- 								<input type="button" value="${i}일 ${dayOfWeek}요일" onclick="toggleDate(this)"><br> --%>
<%-- 							</c:forEach> --%>
						</div> 
						<div class="overflow time"><b>시간</b> 
							1관 11층<br>
							<c:forEach var="playList" items="${playList}">
								<input type ="button" value="${playList.play_start_time}" onclick="toggleTime(this)">
							</c:forEach>
							<input type="button" value="10:00" onclick="toggleTime(this)">
							<input type="button" value="12:00" onclick="toggleTime(this)">
							<input type="button" value="14:00" onclick="toggleTime(this)"><br>
							<input type="button" value="16:00" onclick="toggleTime(this)">
							<input type="button" value="18:00" onclick="toggleTime(this)">
							<input type="button" value="20:00" onclick="toggleTime(this)"><br>
							2관 11층<br>
							<input type="button" value="10:00" onclick="toggleTime(this)">
							<input type="button" value="12:00" onclick="toggleTime(this)">
							<input type="button" value="14:00" onclick="toggleTime(this)"><br>
							<input type="button" value="16:00" onclick="toggleTime(this)">
							<input type="button" value="18:00" onclick="toggleTime(this)">
							<input type="button" value="20:00" onclick="toggleTime(this)"><br>
							3관 11층<br>
							<input type="button" value="10:00" onclick="toggleTime(this)">
							<input type="button" value="12:00" onclick="toggleTime(this)">
							<input type="button" value="14:00" onclick="toggleTime(this)"><br>
							<input type="button" value="16:00" onclick="toggleTime(this)">
							<input type="button" value="18:00" onclick="toggleTime(this)">
							<input type="button" value="20:00" onclick="toggleTime(this)"><br>
							4관 11층<br>
							<input type="button" value="10:00" onclick="toggleTime(this)">
							<input type="button" value="12:00" onclick="toggleTime(this)">
							<input type="button" value="14:00" onclick="toggleTime(this)"><br>
							<input type="button" value="16:00" onclick="toggleTime(this)">
							<input type="button" value="18:00" onclick="toggleTime(this)">
							<input type="button" value="20:00" onclick="toggleTime(this)"><br>
						</div>
				</div>
			</article>
		</section><%--CSS 요청으로 감싼 태그--%>
		<article id="select_info">
			<div class="print_parameter">
				<table id="end_param">
					<tr>
						<td>영화선택</td>
						<td>극장선택</td>
						<td>날짜선택</td>
						<td>시간선택</td>
						<td>
							<form action="seat_select" method="post">
							    <input type="hidden" name="movie" value="">
							    <input type="hidden" name="theater" value="">
							    <input type="hidden" name="date" value="">
							    <input type="hidden" name="time" value="">
							    <input type="submit" class="btnsubmit" value="좌석선택">
							</form>
						</td>
					</tr>
				</table>
			</div>
		</article>
		<footer>
				<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div><%--CSS 요청으로 감싼 태그--%>
</body>
</html>