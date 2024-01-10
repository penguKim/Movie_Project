<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script src="${pageContext.request.contextPath}/resources//js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources//js/manageMovieSchedule.js"></script>
</head>
<body>
	<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1 로 저장) --%>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	<div id="wrapper">
		<nav id="navbar">
			<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		</nav>
	
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<section id="content">
			<h1 id="h01">상영 일정 등록</h1>
			<hr>
			
			<div id="admin_main">
				<a href="adminMovieSchedule"><input type="button" value="상영일정조회"></a>
				<br><br>
				<form action="registPlay" method="post" id="registForm">
					<table border="1">
						<tr>
							<th width="140px">지점명</th>
							<th width="140px">상영관명</th>
							<th>영화제목</th>
							<th width="140px">상영날짜</th>
							<th width="140px">상영시작시간</th>
							<th width="140px">상영종료시간</th>
							<th width="90px">등록</th>
							<th width="90px">초기화</th>
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
							<td>
								<select id="movie_id" name="movie_id">
									<option value="">영화 선택</option>
								</select>
							</td>
							<td id="date">
								<input type="date" id="play_date" name="play_date">
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
								<input type="text" id="play_end_time" name="play_end_time" readonly>
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
				
				<table border="1" class="modifyForm">
					<tr>
						<th width="140px">지점명</th>
						<th width="140px">상영관명</th>
						<th>영화제목</th>
						<th width="140px">상영날짜</th>
						<th width="140px">상영시작시간</th>
						<th width="140px">상영종료시간</th>
						<th width="90px">수정</th>
						<th width="90px">삭제</th>
					</tr>
<%-- 					<c:forEach var="play" items="${playRegistList}"> --%>
<%-- 						<tr id="${play.play_id}"> --%>
<%-- 							<td id="theater_name_mod" data-theater-name="${play.theater_name}">${play.theater_name}</td> --%>
<%-- 							<td id="room_name_mod" data-room_name="${play.room_name}">${play.room_name}</td> --%>
<%-- 							<input type="hidden" value="${play.room_id}" id="room_id"> --%>
<%-- 							<td id="movie_title_mod" data-movie_title="${play.movie_title}">${play.movie_title}</td> --%>
<%-- 							<input type="hidden" value="${play.movie_id}" id="movie_id"> --%>
<%-- 							<td id="play_date_mod">${play.play_date}</td> --%>
<%-- 							<td id="play_start_time_mod" data-play_start_time="${fn:substring(play.play_start_time, 0, 5)}">${fn:substring(play.play_start_time, 0, 5)}</td> --%>
<%-- 							<td id="play_end_time_mod">${fn:substring(play.play_end_time, 0, 5)}</td> --%>
<!-- 							<td> -->
<!-- <!-- 									<input type="button" value="수정" class="btnModify"> -->
<%-- 								<input type="button" value="수정" class="btnModify_${play.play_id}" onclick="CannotDuplicateModify(${play.play_id}, '${play.play_start_time }', '${play.play_date }')"> --%>
<!-- 							</td> -->
<!-- 							<td> -->
<%-- 								<input type="hidden" value="${play.play_id}" name="play_id" id="play_id"> --%>
<%-- 								<input type="button" value="삭제" id="btnDelete_${play.play_id }" onclick="confirmDelete(${play.play_id}, '${play.play_start_time }', '${play.play_date }')"> --%>
<!-- 							</td> -->
<!-- 						</tr> -->
<%-- 					</c:forEach> --%>
				</table>
			</div>
			<br><br><br><br><br>
		</section>
	</div>
</body>
</html>