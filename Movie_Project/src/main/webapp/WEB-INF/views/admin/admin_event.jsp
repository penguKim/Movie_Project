<%-- admin_movie.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 이벤트 관리</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	// 데이터 조회해 상영 일시를 판별해 음영처리
	$(function(){
		// 현재 시간을 밀리초로 가져오기
		let currentTime = new Date().getTime();
		
		// 각 tr 태그 반복해 이벤트 종료 시간을 지정
		$("tr").each(function() {
			let closeDate = $(this).find(".close_date").text(); // 종료시간
			
			if(closeDate != "") { // 종료시간이 있는 tr일 경우
				let endTime = new Date(closeDate).getTime(); // 종료시간을 밀리초로 변환
				// 두 날짜의 차이를 일로 변환
				differenceTime = Math.round((currentTime - endTime) / 1000 / 60 / 60 / 24);
				if (differenceTime > 0) { // 시간 비교해 현재 이전인 경우 
					$(this).css("background-color", "lightgray"); // 배경색 지정해 음영처리
				}
			}
		});
		
	});
</script>
</head>
<body>
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
		<h1 id="h01">이벤트 관리</h1>
		<hr>
			<div id="admin_main">
				<div id="event_update">
					<input type="button" value="이벤트 등록" onclick = "location.href='adminMovieEventRgst'">
				</div>
				<div id="event_Search">
					<%-- 검색 기능을 위한 폼 생성 --%>
					<form action="adminMovieEvent" id="search_submit">
						<input type="text" name="searchKeyword" placeholder="제목으로 입력" value="${param.searchKeyword }">
						<input type="submit" value="조회">
					</form>
				</div>
				<table id="eventList">
					<tr>
						<th width="100">이벤트 번호</th>
						<th>이벤트 제목</th>
						<th>시작 기간</th>
						<th>종료 기간</th>
						<th width="100">수정/삭제</th>
					</tr>
					<c:forEach var="event" items="${eventList }" varStatus="status">
						<tr>
							<td>${event.event_id }</td>
							<td id="eventTitle">${event.event_title }</td>
							<td>${event.event_release_date }</td>
							<td class="close_date">${event.event_close_date }</td>
							<td><input type="button" value="MORE" onclick = "location.href='adminMovieEventMod?event_id=${event.event_id }&pageNum=${pageNum }'"></td>
						</tr>
					</c:forEach>
				</table>
				<div class="pagination">
					<c:choose>
						<c:when test="${pageNum eq 1}">
							<a href="" >&laquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminMovieEvent?searchKeyword=${param.searchKeyword }&pageNum=${pageNum-1}" >&laquo;</a>
						</c:otherwise>				
					</c:choose>
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<c:choose>
							<c:when test="${pageNum eq i}">
								<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
							</c:when>
							<c:otherwise>
								<a href="adminMovieEvent?searchKeyword=${param.searchKeyword }&pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${pageNum eq pageInfo.maxPage}">
							<a href="" >&raquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminMovieEvent?searchKeyword=${param.searchKeyword }&pageNum=${pageNum+1}" >&raquo;</a>
						</c:otherwise>				
					</c:choose>
				</div>
			</div>
		</section>
	</div>
</body>
</html>