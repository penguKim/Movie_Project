<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
	<form action="" id="popup1_form">
		<div id="popup1_wrapper">
			<h1>상품 상세 페이지</h1>
			<table border="1" id="popup1_table">
				<tr>
					<th width="150">예매 번호</th>
					<td></td>
				</tr>
				<tr>
					<th>영화제목</th>
					<td>주문자명입니다</td>
				</tr>
				<tr>
					<th>영화극장 정보</th>
					<td></td>
				</tr>
				<tr>
					<th>상태</th>
					<td></td>
				</tr>
				<tr>
					<th>좌석 번호</th>
					<td></td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>