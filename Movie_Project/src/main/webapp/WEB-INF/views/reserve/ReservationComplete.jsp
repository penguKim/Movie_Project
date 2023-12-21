<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매결과</title>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<style type="text/css">
	table td{
		border: 1px solid black;
		text-align: center;
		width: 200px;
		height: 50px;
	}
	table{
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		border: 1px solid black;
		text-align: center;
	}
	#content{
	 cursor:default; 
	}
	
</style>
</head>
<body>
<div id="wrapper"><%--CSS 요청으로 감싼 태그--%>
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
			<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		</header>
		<section id="content"><%--CSS 요청으로 감싼 태그--%>
			<table>
				<tr>
					<td colspan="2">예매성공!</td>
				</tr>
				<tr>
					<td>영화번호</td>
					<td>${map.movie}</td>
				</tr>
				<tr>
					<td>예매좌석</td>
					<td>${map.select_seat}</td>
				</tr>
				<tr>
					<td>극장이름</td>
					<td>${map.Theater}</td>
				</tr>
				<tr>
					<td>상영관</td>
					<td>${map.Room}</td>
				</tr>
				<tr>
					<td>상영일</td>
					<td>${map.Date}</td>
				</tr>
				<tr>
					<td>시작시간</td>
					<td>${map.Time}</td>
				</tr>
			</table>
		</section>
		<footer>
				<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
		
</div>
</body>
</html>