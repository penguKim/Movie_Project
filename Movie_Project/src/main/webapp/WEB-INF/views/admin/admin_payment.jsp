<%-- admin_payment.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 결제 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function btnLookup() {
		location.reload();
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
			<h1 id="h01">스토어 결제 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<div id="pay_Search">
					<input type="text" placeholder="조회할 아이디 입력">
					<input type="button" value="조회" onclick="btnLookup()">
				</div>
				<table border="1" width="1100">
					<tr>
						<th>결제번호</th>
						<th>아이디</th>
						<th>결제일시</th>
						<th>결제상태</th>
						<th>결제내역 상세보기</th>
					</tr>
<%-- 					<c:forEach var="" items=""> --%>
						
<%-- 					</c:forEach> --%>
					<tr>
						<td>13251245</td>
						<td>member_id</td>
						<td>payment_datetime</td>
						<td>payment_status</td>
						<td><a href="adminPaymentDtl"><input type="button" value="상세보기"></a></td>
					</tr>
					<tr>
						<td>13251245</td>
						<td>member_id</td>
						<td>payment_datetime</td>
						<td>payment_status</td>
						<td><a href="adminPaymentDtl"><input type="button" value="상세보기"></a></td>
					</tr>
					<tr>
						<td>13251245</td>
						<td>member_id</td>
						<td>payment_datetime</td>
						<td>payment_status</td>
						<td><a href="adminPaymentDtl"><input type="button" value="상세보기"></a></td>
					</tr>
					<tr>
						<td>13251245</td>
						<td>member_id</td>
						<td>payment_datetime</td>
						<td>payment_status</td>
						<td><a href="adminPaymentDtl"><input type="button" value="상세보기"></a></td>
					</tr>
					<tr>
						<td>13251245</td>
						<td>member_id</td>
						<td>payment_datetime</td>
						<td>payment_status</td>
						<td><a href="adminPaymentDtl"><input type="button" value="상세보기"></a></td>
					</tr>
					<tr>
						<td>13251245</td>
						<td>member_id</td>
						<td>payment_datetime</td>
						<td>payment_status</td>
						<td><a href="adminPaymentDtl"><input type="button" value="상세보기"></a></td>
					</tr>
					<tr>
						<td>13251245</td>
						<td>A영화</td>
						<td>coming</td>
						<td>payment_status</td>
						<td><a href="adminPaymentDtl"><input type="button" value="상세보기"></a></td>
					</tr>
				</table>
				<div class="pagination">
					<a href="#">&laquo;</a>
					<a href="#">1</a>
					<a class="active" href="#">2</a>
					<a href="#">3</a>
					<a href="#">4</a>
					<a href="#">5</a>
					<a href="#">&raquo;</a>
				</div>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>
