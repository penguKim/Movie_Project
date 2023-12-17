<%-- admin_payment_detail.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 결제 상세</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function btnCcl() {
		var result = confirm("결제를 취소하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">스토어 결제 상세 페이지</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>

			<div id="admin_main">
				<table border="1">
					<tr>
						<th width="100">결제 번호</th>
						<td></td>
					</tr>
					<tr>
						<th>주문자명</th>
						<td>주문자명입니다</td>
					</tr>
					<tr>
						<th>결제일</th>
						<td></td>
					</tr>
					<tr>
						<th>영화 명</th>
						<td></td>
					</tr>
					<tr>
						<th>극장 명</th>
						<td></td>
					</tr>
					<tr>
						<th>인원 수</th>
						<td></td>
					</tr>
					<tr>
						<th>좌석 번호</th>
						<td></td>
					</tr>
					<tr>
						<th>주문한 상품</th>
						<td></td>
					</tr>
					<tr>
						<th>결제 방법</th>
						<td></td>
					</tr>
					<tr>
						<th>총 결제 금액</th>
						<td></td>
					</tr>
				</table>
				<div id="admin_writer">
					<input type="submit" value="결제취소" onclick="btnCcl()">
					<input type="button" value="뒤로가기" onclick="history.back()">
				</div>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>			
</body>
</html>