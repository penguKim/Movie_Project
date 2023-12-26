<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영 일정 등록</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources//js/jquery-3.7.1.js"></script>
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
	
	// 상영관 불러오기
	$(function() {
		$("#theater_id").blur(function() {
			let theater_id = $("#theater_id").val();
			$.ajax({
				type: "GET",
				url: "getRoom",
				data: {
					theater_id : theater_id
				},
				success: function(result) {
					$("#room_id").empty();
					$("#room_id").append("<option value=''>상영관 선택</option>");
					for(let room of result) {
						$("#room_id").append("<option value='" + room.room_id + "'>" + room.room_name + "</option>");
					}
				},
				error: function(xhr, textStatus, errorThrown) {
					alert("상영관 로딩 오류입니다.");
				}
				
			});
		});
	});
	
	// 상영중인 영화 불러오기
	$(function() {
		$.ajax({
			type: "GET",
			url: "nowPlaying",
			success: function(result) {
				for(let movie of result) {
				$("#movie_id").append("<option value='" + movie.movie_id + "'>" + movie.movie_title + "</option>");
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("상영중인 영화 로딩 오류입니다.");
			}
			
		});
	});
	
	// 선택 가능한 날짜 불러오기
	$(function() {
		$("#movie_id").blur(function() {
			let movie_id = $("#movie_id").val();
			$.ajax({
				type: "GET",
				url: "getMovieInfo",
				data: {
					movie_id : movie_id
				},
				success: function(result) {
					if(movie_id != '') {						
						let release_date = new Date(result.movie_release_date + 86400000); // 밀리초단위를 날짜로 변환
						let f_release_date = release_date.toISOString().split('T')[0]; // 날짜의 형태를 0000-00-00으로 변환
						let close_date = new Date(result.movie_close_date + 86400000); // 밀리초단위를 날짜로 변환
						let f_close_date = close_date.toISOString().split('T')[0]; // 날짜의 형태를 0000-00-00으로 변환
						
						$("#date").html("<input type='date' min='" + f_release_date + "' max='" + f_close_date + "' id='play_date' name='play_date'>");
					}
				},
				error: function(xhr, textStatus, errorThrown) {
					alert("상영관 로딩 오류입니다.");
				}
			});
		});
	});
	
	// 영화 종료 시간 자동으로 계산
	$(function() {
		$("#play_start_time").blur(function() {
			let movie_id = $("#movie_id").val();
			let start_time = $("#play_start_time").val().split(":")[0];
// 			console.log(start_time); // 09
			
			$.ajax({
				type: "GET",
				url: "getMovieInfo",
				data: {
					movie_id : movie_id
				},
				success: function(result) {
					if(start_time == '') {
						$("#play_end_time").val('');
					} else {
						let end_time = (start_time * 60) + parseInt(result.movie_runtime)
						
						let hours = Math.floor(end_time / 60); // 시간 계산
						let minutes = end_time % 60; // 분 계산
						
						// 시간과 분이 한 자리 수인 경우 0으로 채우기
						let formatted_hours = hours < 10 ? "0" + hours : hours;
						let formatted_minutes = minutes < 10 ? "0" + minutes : minutes;
						
						let formatted_end_time = formatted_hours + ":" + formatted_minutes; // "00:00" 형식으로 변환된 종료 시간
						
						$("#play_end_time").val(formatted_end_time);						
					}
				},
				error: function(xhr, textStatus, errorThrown) {
					alert("종료 시간 출력 오류입니다.");
				}
			});
		});
	});

	// 선행되어야 할 선택값이 필요한 경우 다음 선택을 하지 못하도록 막음
	$(function() {
		$("#room_id").click(function() {
			if($("#theater_id").val() == '') {
				alert("지점을 선택해주세요");
				$("#theater_id").focus();
			}
		});
		$("#date").click(function() {
			if($("#movie_id").val() == '') {
				alert("영화를 선택해주세요");
				$("#movie_id").focus();
			}
		});
		$("#play_start_time").click(function() {
			if($("#play_date").val() == '') {
				alert("날짜를 선택해주세요");
				$("#play_date").focus();
			} else if($("#movie_id").val() == '') {
				alert("영화를 선택해주세요");
				$("#movie_id").focus();
			}
		});
	});
	
	
	// 등록하기
	$(function() {
		$("form").submit(function() {
			if($("#theater_id").val() == '') {
				alert("지점을 선택해주세요");
				$("#theater_id").focus();
				return false;
			} else if($("#room_id").val() == '') {
				alert("상영관을 선택해주세요");
				$("#room_id").focus();
				return false;
			} else if($("#movie_id").val() == '') {
				alert("영화를 선택해주세요");
				$("#movie_id").focus();
				return false;
			} else if($("#date>input").val() == '') {
				alert("상영날짜를 선택해주세요");
				$("#date>input").focus();
				return false;
			} else if($("#play_start_time").val() == '') {
				alert("상영시작시간을 선택해주세요");
				$("#play_start_time").focus();
				return false;
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
			<h1 id="h01">상영 일정 등록</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<a href="adminMovieSchedule"><input type="button" value="상영일정조회"></a>
				<br><br>
				<form action="registPlay" method="post">
					<table border="1">
						<tr>
							<th width="160px">지점명</th>
							<th width="160px">상영관명</th>
							<th colspan="3">영화제목</th>
						</tr>
						<tr>
							<td>
								<select id="theater_id" name="theater_id">
									<option value="">지점 선택</option>
								</select>
							</td>
							<td>
								<select id="room_id" name="room_id">
									<option value="">상영관 선택</option>
								</select>
							</td>
							<td colspan="3">
								<select id="movie_id" name="movie_id">
									<option value="">영화 선택</option>
								</select>
							</td>
						<tr>
							<th width="160px">상영날짜</th>
							<th width="160px">상영시작시간</th>
							<th width="160px">상영종료시간</th>
							<th>등록</th>
							<th>초기화</th>
						</tr>
							<td id="date">
								<input type="date" name="play_date">
							</td>
							<td>
								<select id="play_start_time" name="play_start_time">
									<option value="">시작 시간 선택</option>
									<option value="09:00">09:00</option>
									<option value="10:00">10:00</option>
									<option value="11:00">11:00</option>
									<option value="12:00">12:00</option>
									<option value="13:00">13:00</option>
									<option value="14:00">14:00</option>
									<option value="15:00">15:00</option>
									<option value="16:00">16:00</option>
									<option value="17:00">17:00</option>
									<option value="18:00">18:00</option>
									<option value="19:00">19:00</option>
									<option value="20:00">20:00</option>
									<option value="21:00">21:00</option>
								</select>
							</td>
							<td>
								<input type="text" width="120px" id="play_end_time" name="play_end_time" readonly>
							</td>
							<td>
								<input type="submit" value="등록" id="regist">
							</td>
							<td>
								<input type="reset" value="초기화">
							</td>
						</tr>
					</table>
				</form>
						
				<br>
				<table border="1">
					<tr>
						<th>지점명</th>
						<th>상영관명</th>
						<th>영화제목</th>
						<th>상영날짜</th>
						<th>시작</th>
						<th>종료</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
					<c:forEach var="play" items="${playRegistList}">
						<tr>
							<td>${play.theater_name}</td>
							<td>${play.room_name}</td>
							<td>${play.movie_title}</td>
							<td>${play.play_date}</td>
							<td>${fn:substring(play.play_start_time, 0, 5)}</td>
							<td>${fn:substring(play.play_end_time, 0, 5)}</td>
							<td>
								<input type="button" value="수정">
							</td>
							<td>
								<input type="button" value="삭제">
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>