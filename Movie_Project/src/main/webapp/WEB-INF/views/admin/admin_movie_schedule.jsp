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


	$(function() {
		$("#selectSchedule").("click", function(){
			$.ajax({
				
				
			});
			
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
					<select name="theater_id" id="theater_id">
						<option value="">지점을 선택하세요.</option>
					</select>
					<input type="date">
					<input type="button" value="조회" id="selectSchedule">
				</div>
				<table border="1" width="1100">
					<tr>
						<th>상영관</th>
						<th>영화명</th>
						<th>상영시간</th>
					</tr>
					<c:forEach items="${playList }" var="play">
						<tr>
							<td>${play.room_id }</td>
							<td>${play.movie_id }</td>
							<td>${play.play_start_time }</td>
						</tr>
					
					</c:forEach>
<!-- 					<tr> -->
<!-- 						<td>영화2</td> -->
<!-- 						<td>상영시간</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td rowspan="3">2관</td> -->
<!-- 						<td>영화1</td> -->
<!-- 						<td>상영시간</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>영화2</td> -->
<!-- 						<td>상영시간</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>영화3</td> -->
<!-- 						<td>상영시간</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>3관</td> -->
<!-- 						<td>영화1</td> -->
<!-- 						<td>상영시간</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td rowspan="4">4관</td> -->
<!-- 						<td>영화1</td> -->
<!-- 						<td>상영시간</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>영화2</td> -->
<!-- 						<td>상영시간</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>영화3</td> -->
<!-- 						<td>상영시간</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>영화4</td> -->
<!-- 						<td>상영시간</td> -->
<!-- 					</tr> -->
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
