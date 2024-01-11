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

	function resCancle(payment_id,seat_id){
		if(confirm("결제취소하시겠습니까?")){
			$.ajax({
				url: "resCancle",
				data: {
					payment_id: payment_id
					,seat_id: seat_id
				},
				dataType: "json",
			    success: function(isResCancle) {
			    	if(isResCancle){
				    	$("#payment_status_result").html("결제취소");
				    	$("#resCanBtn").remove();
				    	window.opener.location.reload();
			    	}else{
			    		alert("결제취소 실패!");
			    	}
			    },
			    error:function(isResCancle) {
			    	alert("ajax 실패!");
	            }
			});//ajax끝
		}//confirm true 끝
	}//resCancle function 끝
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
			<h1 id="h01">영화 예매 상세</h1>
			<hr>
			<div id="admin_sub">
				<form action="">
					<table>
						<tr>
							<th>예매이름</th>
							<th>회원ID</th>
							<th>결제금액</th>
							<th>결제일</th>
							<th>영화제목</th>
						</tr>
						<tr>
							<td>${resList.payment_name}</td>
							<td>${resList.member_id}</td>
							<td>${resList.payment_total_price}</td>
							<fmt:parseDate var="parsedDate" value="${resList.payment_datetime}" pattern="yyyy-MM-dd'T'HH:mm" type="both" />
							<td><fmt:formatDate value="${parsedDate}" pattern="MM-dd HH:mm"/> </td>
							<td>${resList.movie_title}</td>
						</tr>
						<tr>
							<th>관람일</th>
							<th>지점</th>
							<th>상영관</th>
							<th>예매좌석</th>
							<th>상태</th>
						</tr>
						<tr>
							<td>${resList.play_date}</td>
							<td>${resList.theater_name}</td>
							<td>${resList.room_name}</td>
							<td>${resList.seat_name}</td>
							<td id="payment_status_result">
								<c:choose>
									<c:when test="${resList.payment_status eq 0}">
										결제취소
									</c:when>
									<c:otherwise>
										결제완료
									</c:otherwise>
								</c:choose>			
							</td>
						</tr>
					
					</table>
					<div style="text-align: right;">
					<input type="button" value="뒤로가기" onclick="location.href='adminMovieBooking'">
					<c:choose>
						<c:when test="${resList.payment_status eq 0}"></c:when>
						<c:otherwise>
							<input type="button" id="resCanBtn" value="결제취소" onclick="resCancle(${resList.payment_id},${resList.seat_id})">
						</c:otherwise>
					</c:choose>	
					</div>
					
				</form>
			</div>
		</section>
	</div>
</body>
</html>
