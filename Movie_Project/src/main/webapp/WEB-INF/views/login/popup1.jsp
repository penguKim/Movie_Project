<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 상세 페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
	<form action="" id="popup1_form">
		<div id="popup1_wrapper">
			<h1>예매 상세 페이지</h1>
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
			<br>
			<section id="payX">
				<!-- 자바스크립트 사용해 사이즈 조정 후 팝업으로 만들 창이므로 버튼을 미리 가운데 정렬-->
				<input type="button" value="결제취소" onclick="confirm('결제 취소하시겠습니까?')">
			</section>
		</div>
	</form>
</body>
</html>