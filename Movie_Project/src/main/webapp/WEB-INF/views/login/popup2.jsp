<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 상품 상세 페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
	<form action="" id="popup1_form">
		<div id="popup1_wrapper">
			<h1>상품 상세 페이지</h1>
			<table border="1" id="popup1_table">
				<tr>
					<th width="150">상품 번호</th>
					<td></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td>상품명입니다</td>
				</tr>
				<tr>
					<th>총 결제금액</th>
					<td></td>
				</tr>
				<tr>
					<th>구매일</th>
					<td></td>
				</tr>
				<tr>
					<th>상태</th>
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