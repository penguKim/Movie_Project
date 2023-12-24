<%-- admin_payment.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영일정 조회 페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script type="text/javascript">
	// 지점명 불러오기
	$(function() {
		$.ajax({
			type: "GET",
			url: "getTheater",
			success: function(result) {
				for(let theater of result) {
					$("#theater_id").append("<option value='" + theater.theater_id + "'>" + theater.theater_name + "</option>");
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("지점명 로딩 오류입니다.");
			}
			
		});
	});
	
	// 조회 버튼 클릭 시 이벤트 처리
	$(function() {
		$("#selectSchedule").on("click", function() {
// 			console.log($("#searchDate").val());
			if($("#theater_id").val() == "none" && $("#searchDate").val() == "") {
				alert("지점과 날짜를 선택해주세요!");
				$("#theater_id").focus();
				$("#theater_id").on("change", function() {
					if($("#theater_id").val() != "none" && $("#searchDate").val() == "") {
						$("#searchDate").focus();
					}
				});
				return;
			} else {
				if($("#theater_id").val() == "none") {
					alert("지점을 선택해주세요!");
					$("#theater_id").focus();
					return;
				} else if($("#searchDate").val() == "") {
					alert("날짜를 선택해주세요!");
					$("#searchDate").focus();
					return;
				} else {
					$.ajax({
						type: "get",
						url: "ScheduleSearch",
						data: $("form").serialize(),
// 						data: {
// 							"room_id":
// 							"play_date":
// 						},
						success: function(result) {
							console.log(result);
							for(let schedule of result) {
								$("#scheduleTableTr").after("<tr><td>" + schedule.room_name + "</td><td>" + schedule.movie_title + "</td><td>" + schedule.play_start_time + "</td></tr>");
							}
						},
						error: function(e) {
							alert("상영 일정 조회 요청 실패!");
							location.reload();
							return;
						}
						
						/*
						INFO : jdbc.sqltiming - SELECT r.room_name, m.movie_title, p.play_start_time FROM plays p JOIN rooms r ON p.room_id 
						= r.room_id JOIN theaters t ON r.theater_id = t.theater_id JOIN movies m ON p.movie_id = m.movie_id 
						WHERE t.theater_id = NULL AND p.play_date = NULL 
						 {executed in 24 msec}
						INFO : jdbc.resultsettable - 
						|----------|------------|----------------|
						|room_name |movie_title |play_start_time |
						|----------|------------|----------------|
						|----------|------------|----------------|

						theater_id, play_date가 null 값으로 넘어옴.. xml 쿼리 문제?
						*/
						
						
					});	
				}
			}
			
		}); 
		
	});
	


		
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">상영 일정 조회</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<a href="movieScheduleMod"><input type="button" value="상영일정관리"></a>
				<div id="schedule_search">
					<form action="">
						<select name="theater_id" id="theater_id">
							<option value="none">지점을 선택하세요.</option>
						</select>
						<input type="date" id="searchDate" name="play_date">
						<input type="button" value="조회" id="selectSchedule">
					</form>
				</div>
				<table border="1" width="1100">
					<tr id="scheduleTableTr">
						<th>상영관</th>
						<th>영화명</th>
						<th>상영시간</th>
					</tr>
					<c:forEach items="${playList }" var="play">
						<tr>
							<td>${play.room_name }</td>
							<td>${play.movie_title }</td>
							<td>${play.play_start_time }</td>
						</tr>
					
					</c:forEach>
				</table>
				<div class="pagination">
					<a href="#">&laquo;</a>
					<a href="#">1</a>
					<a class="active" href="#">2</a>
					<a href="#">3</a>
					<a href="#">4</a>
					<a href="#">5</a>
					<a href="#">&raquo;</a>
				</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>
