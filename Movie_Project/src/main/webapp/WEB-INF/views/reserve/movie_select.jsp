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
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		$(".btnMovie").click(function(){
			$('.btnMovie').removeClass('selected');
			$(this).addClass('selected');
			param();
		});
		
		$(".btnTheater").click(function(){
			$('.btnTheater').removeClass('selected');
			$(this).addClass('selected');
			param();
		});
		$(".btnDate").click(function(){
			$('.btnDate').removeClass('selected');
			$(this).addClass('selected');
			param();
		});
		$(".btnTime").click(function(){
			$('.btnTime').removeClass('selected');
			$(this).addClass('selected');
			param();
		});
		function param() {
			let selectMovieValue = $('.btnMovie.selected').val();
			let selectTheaterValue = $('.btnTheater.selected').val();
			let selectDateValue = $('.btnDate.selected').val();
			let selectTimeValue = $('.btnTime.selected').val();
			
		    // 선택된 데이터를 표시
		    var tableCells = $('#end_param td');
		    tableCells[0].textContent = selectMovieValue;
		    tableCells[1].textContent = selectTheaterValue;
		    tableCells[2].textContent = selectDateValue;
		    tableCells[3].textContent = selectTimeValue;
		    
			// selectedValues의 각 속성을 각각의 hidden input 태그에 설정
			$("#movie_title").val(selectMovieValue); 
			$("#theater_name").val(selectTheaterValue);
			$("#play_date").val(selectDateValue);
			$("#play_start_time").val(selectTimeValue);
		}
	});


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
								<input type ="button" value="${movieList.movie_title}" class="btnMovie"><br>
							</c:forEach>
						</div> 
						<div class="overflow theater"><b>극장</b>
							<c:forEach var="theaterList" items="${theaterList}">
								<input type ="button" value="${theaterList.theater_name}" class="btnTheater"><br>
							</c:forEach>
						</div>
						<div class="overflow date"><b>날짜</b>
							<c:forEach var="playList" items="${playList}">
								<input type ="button" value="${playList.play_date}" class="btnDate"><br>
							</c:forEach>
						</div> 
						<div class="overflow time"><b>시간</b> 
							1관 11층<br>
							<c:forEach var="playList" items="${playList}">
								<input type ="button" value="${playList.play_start_time}" class="btnTime">
							</c:forEach>
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
							    <input type="hidden" name="movie_title" id="movie_title" value="">
							    <input type="hidden" name="theater_name" id="theater_name" value="">
							    <input type="hidden" name="play_date" id="play_date" value="">
							    <input type="hidden" name="play_start_time" id="play_start_time" value="">
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