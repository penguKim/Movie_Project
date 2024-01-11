<%-- admin_movie_booking.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	function resDetail(payment_id) {
		location.href="adminMovieBookingMod?payment_id="+payment_id;
	}
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
			<h1 id="h01">영화 예매 관리</h1>
			<hr>
			<div id="admin_sub">
				<form action="">
					<table border="1">
						<tr>
							<form action="cancleBooking">
								<td colspan="9" style="text-align: right;">
									<input type="text" name="searchKeyword" placeholder="회원ID를 입력하세요">
									<input type="submit" value="검색">
									<a href="adminMovieBooking"><input type="button" value="예매내역조회"></a>
								</td>
							</form>
						</tr>
						<tr>
							<th>결제번호</th>
							<th>결제일</th>
							<th>영화명</th>
							<th>회원ID</th>
							<th>위치</th>
							<th>상영일</th>
							<th>좌석</th>
							<th>상태</th>
							<th>비고</th>
						</tr>
						<c:forEach var="resList" items="${resList}">
							<c:if test="${resList.payment_status eq 0}">
								<tr>
								<td>${resList.payment_id}</td>
								<fmt:parseDate var="parsedDate" value="${resList.payment_datetime}" pattern="yyyy-MM-dd'T'HH:mm" type="both" />
								<td><fmt:formatDate value="${parsedDate}" pattern="MM-dd HH:mm"/> </td>
								<td>${resList.movie_title}</td>
								<td>${resList.member_id}</td>
								<td>${resList.theater_name}<br>${resList.room_name}</td>
								<td>${resList.play_date}</td>
								<td>${resList.seat_name}</td>
								<td>
									<c:if test="${resList.payment_status eq 0}"><span id="payment_Cstatus">결제취소</span></c:if>
									<c:if test="${resList.payment_status eq 1}"><span id="payment_Bstatus">결제완료</span></c:if>
								</td>
								<td><input type="button" value="상세보기" onclick = "resDetail(${resList.payment_id})"></td>
								</tr>
							</c:if>
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
								<a href="cancleBooking?pageNum=${pageNum-1}" >&laquo;</a>
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
									<a href="cancleBooking?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
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
								<a href="cancleBooking?pageNum=${pageNum+1}" >&raquo;</a>
							</c:otherwise>				
						</c:choose>
				</div>
				</form>
			</div>
		</section>
	</div>
</body>
</html>
