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
					<input type="button" value="영화 등록" onclick = "location.href='adminMovieRgst'">
					<input type="button" value="인기 영화 등록" onclick = "location.href='adminMovieUdt'">
					<input type="button" value="영화 검색" onclick = "location.href='adminMovieSearch'">
				</div>
				<div id="status_select">
					<form action="adminMovie" id="status_submit">
						<select name="sortMovie" id="sortMovie">
							<option value="allMovie" <c:if test="${param.sortMovie eq 'allMovie' }">selected</c:if>>모든 영화</option>
							<option value="release" <c:if test="${param.sortMovie eq 'release' }">selected</c:if>>상영작</option>
							<option value="comming" <c:if test="${param.sortMovie eq 'comming' }">selected</c:if>>상영예정작</option>
							<option value="ending" <c:if test="${param.sortMovie eq 'ending' }">selected</c:if>>종영작</option>
						</select>
					</form>
				</div>
				<div id="movie_Search">
					<%-- 검색 기능을 위한 폼 생성 --%>
					<form action="adminMovie" id="search_submit">
						<input type="text" name="searchKeyword" placeholder="영화코드/제목으로 입력" value="${param.searchKeyword }">
						<input type="hidden" name="sortMovie" value="">
						<input type="submit" value="조회">
					</form>
				</div>
				<table id="movieList">
					<tr>
						<th>영화코드</th>
						<th>영화제목</th>
						<th>상영상태</th>
						<th>제작년도</th>
						<th>상영시간</th>
						<th>상영일</th>
						<th>종영일</th>
						<th>수정/삭제</th>
					</tr>
					<c:forEach var="movie" items="${movieList }">
						<tr>
							<td>${movie.movie_id }</td>
							<td id="movieTitle">${movie.movie_title }</td>
							<td class="movie_status">
								<c:choose>
									<c:when test="${movie.movie_status eq 2 }">
									<span id="admin_Cmember">종영작</span>
									</c:when>
									<c:when test="${movie.movie_status eq 1 }">
									<span id="admin_member">상영작</span>
									</c:when>
									<c:when test="${movie.movie_status eq 0 }">
									<span id="admin_Bmember">상영예정작</span>
									</c:when>
								</c:choose>
								</td>
<%-- 							<td>${movie.movie_status }</td> --%>
							<td>${movie.movie_prdtYear }년</td>
							<td>${movie.movie_runtime }분</td>
							<td>${movie.movie_release_date }</td>
							<td>${movie.movie_close_date }</td>
							<td><input type="button" value="MORE" onclick = "location.href='adminMovieMod?movie_id=${movie.movie_id }&pageNum=${pageNum }'"></td>
						</tr>
					</c:forEach>
				</table>
				<div class="pagination">
					<%-- '<<' 버튼 클릭 시 현체 페이지보다 한 페이지 앞선 페이지 요청 --%>
					<%-- 다만, 페이지 번호가 1일 경우 비활성화 --%>		
					<c:choose>
						<c:when test="${pageNum eq 1}">
							<a href="" >&laquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminMovie?searchKeyword=${param.searchKeyword }&sortMovie=${param.sortMovie }&pageNum=${pageNum-1}" >&laquo;</a>
						</c:otherwise>				
					</c:choose>
					<%-- 현재 페이지가 저장된 pageInfo 객체를 통해 페이지 번호 출력 --%>
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<%-- 각 페이지마다 하이퍼링크 설정(페이지번호를 pageNum 파라미터로 전달) --%>
						<%-- 단, 현재 페이지는 하이퍼링크 제거하고 굵게 표시 --%>
						<c:choose>
							<%-- 현재 페이지번호와 표시될 페이지번호가 같을 경우 판별 --%>
							<c:when test="${pageNum eq i}">
								<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
							</c:when>
							<c:otherwise>
								<a href="adminMovie?searchKeyword=${param.searchKeyword }&sortMovie=${param.sortMovie }&pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<%-- '>>' 버튼 클릭 시 현체 페이지보다 한 페이지 다음 페이지 요청 --%>
					<%-- 다만, 페이지 번호가 마지막 경우 비활성화 --%>		
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