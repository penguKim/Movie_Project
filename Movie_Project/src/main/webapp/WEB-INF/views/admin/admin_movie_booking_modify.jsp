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
				&nbsp;&nbsp;<sup>회원ID</sup><br>
				&nbsp;&nbsp;<input type="text" value="">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화제목</sup><br>
				&nbsp;&nbsp;<input type="text" value="">
			</div>
			<br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람일</sup><br>
				&nbsp;&nbsp;<input type="text" value="">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>지점/상영관</sup><br>
				&nbsp;&nbsp;<input type="text" value="">
			</div>
			<br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예매좌석</sup><br>
				&nbsp;&nbsp;<input type="text" value="">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예매인원수</sup><br>
				&nbsp;&nbsp;<input type="text" value="">
			</div>
			<br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>결제금액</sup><br>
				&nbsp;&nbsp;<input type="text" value="">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>결제일</sup><br>
				&nbsp;&nbsp;<input type="text" value="">
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