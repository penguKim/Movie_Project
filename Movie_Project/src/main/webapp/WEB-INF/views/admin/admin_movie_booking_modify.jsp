<%-- admin_movie_booking_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 예매 상세 페이지</title>
<link href="${pageContext.request.contextPath }/resources/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="grayDiv">
			<form action="movieBooking" method="post">
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예매이름</sup><br>
				&nbsp;&nbsp;<input type="text" value="${resList.payment_name}">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>회원ID</sup><br>
				&nbsp;&nbsp;<input type="text" value="${resList.member_id}">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화제목</sup><br>
				&nbsp;&nbsp;<input type="text" value="${resList.room_name}">
			</div>
			<br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람일</sup><br>
				&nbsp;&nbsp;<input type="text" value="${resList.play_date}">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>지점</sup><br>
				&nbsp;&nbsp;<input type="text" value="${resList.theater_name}">
			</div>
			<br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영관</sup><br>
				&nbsp;&nbsp;<input type="text" value="${resList.room_name}">
			</div>
			<br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예매좌석</sup><br>
				&nbsp;&nbsp;<input type="text" value="${resList.seat_name}">
			</div>
			<br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>결제금액</sup><br>
				&nbsp;&nbsp;<input type="text" value="${resList.payment_total_price}">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>결제일</sup><br>
				&nbsp;&nbsp;<input type="text" value="${resList.payment_datetime}">
			</div>
			<br><br>
			<section id="btnCtr">
				<input type="button" value="창닫기" onclick="window.close()">
				<input type="submit" value="수정">
				<input type="submit" value="삭제">
			</section>
		</form>
	</div>
</body>
</html>