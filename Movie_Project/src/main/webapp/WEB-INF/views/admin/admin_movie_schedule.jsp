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
					$.ajax({ // 조회 버튼 클릭시 ajax 요청
						type: "get",
						url: "ScheduleSearch",
						data: $("form").serialize(),
// 						data: {
// 							theater_id: $("#theater_id").val(),
// 							play_date: $("#searchDate").val()
// 						},
						success: function(result) {
							console.log(result);
							
							if(result == null) {
								$("#scheduleTableTr").after("<tr><td colspan='3'>" + 상영일정이 존재하지 않습니다! + "</td></tr>");
							} else {
								for(let schedule of result) {
									$("#searchResult").remove();
									$("#scheduleTableTr").after("<tr><td>" + schedule.room_name + "</td><td>" + schedule.movie_title + "</td><td>" + schedule.play_start_time + "</td></tr>");
								}
								
							}
						},
						error: function(e) {
							alert("상영 일정 조회 요청 실패!");
							location.reload();
							return;
						}
						
						
						
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
					<%-- 
					일단 메인페이지가 로딩되면 1관의 오늘일자 상영정보가 뜨도록하고 
					지점과 날짜 선택 후 조회 버튼 클릭 시
					기존 조회된 상영정보가 날아가고 조건에 맞는 상영정보가 떠야함
					판별을 어떻게 할거야???
					=> 1관의 오늘 상영일자가 선택 되었을 경우나 아무것도 선택되지 않았을 경우(메인페이지 로딩 시)
					   기존 로딩 되는 정보(1관의 )
					--%>
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${ }"> --%>
						
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
						
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
					
					<c:forEach items="${playList }" var="play">
						<tr id="searchResult">
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
