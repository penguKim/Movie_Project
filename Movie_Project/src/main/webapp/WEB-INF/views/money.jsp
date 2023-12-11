<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 완료</title>
</head>
<body>
<%request.setCharacterEncoding("UTF-8"); %> 
	<h1>결제가 완료되었습니다.</h1>
	<table>
		<tr>
			<td>영화 : ${param.movie}</td>
		</tr>
		<tr>
			<td>극장 : ${param.Theater}</td>
		</tr>
		<tr>
			<td>날짜 : ${param.Date}</td>
		</tr>
		<tr>
			<td>시간 : ${param.Time}</td>
		</tr>
		<tr>
			<td>좌석 : ${param.select_seat}</td>
		</tr>
	</table>
</body>
</html>
