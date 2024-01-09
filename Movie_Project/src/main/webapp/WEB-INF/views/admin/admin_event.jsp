<%-- admin_movie.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 영화 관리</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		$("#sortMovie").on("change", function() {
			 $("#status_submit").submit();
		});
		
		$("#search_submit").on("submit", function() {
		    var sortMovie = $("#sortMovie").val();
		    console.log(sortMovie);
		    $(this).find("input[name='sortMovie']").val(sortMovie);
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
		<h1 id="h01">영화관리</h1>
		<hr>
			<div id="admin_main">
				<div id="movie_update">
					<input type="button" value="이벤트 등록" onclick = "location.href='adminEventRgst'">
				</div>
				<div id="movie_Search">
					<%-- 검색 기능을 위한 폼 생성 --%>
					<form action="adminEvent" id="search_submit">
						<input type="text" name="searchKeyword" placeholder="영화코드/제목으로 입력" value="${param.searchKeyword }">
						<input type="submit" value="조회">
					</form>
				</div>
				<table id="movieList">
					<tr>
						<th width="100">이벤트 번호</th>
						<th>이벤트 제목</th>
						<th>시작 기간</th>
						<th>종료 기간</th>
						<th width="100">수정/삭제</th>
					</tr>
					<c:forEach var="event" items="${eventList }">
						<tr>
							<td>${event.event_id }</td>
							<td id="movieTitle">${event.event_title }</td>
							<td>${event.event_release_date }</td>
							<td>${event.event_close_date }</td>
							<td><input type="button" value="MORE" onclick = "location.href='adminEventMod?event_id=${event.event_id }&pageNum=${pageNum }'"></td>
						</tr>
					</c:forEach>
				</table>
				<div class="pagination">
					<c:choose>
						<c:when test="${pageNum eq 1}">
							<a href="" >&laquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminMovie?searchKeyword=${param.searchKeyword }&sortMovie=${param.sortMovie }&pageNum=${pageNum-1}" >&laquo;</a>
						</c:otherwise>				
					</c:choose>
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<c:choose>
							<c:when test="${pageNum eq i}">
								<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
							</c:when>
							<c:otherwise>
								<a href="adminMovie?searchKeyword=${param.searchKeyword }&sortMovie=${param.sortMovie }&pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${pageNum eq pageInfo.maxPage}">
							<a href="" >&raquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminMovie?searchKeyword=${param.searchKeyword }&sortMovie=${param.sortMovie }&pageNum=${pageNum+1}" >&raquo;</a>
						</c:otherwise>				
					</c:choose>
				</div>
			</div>
		</section>
	</div>
</body>
</html>