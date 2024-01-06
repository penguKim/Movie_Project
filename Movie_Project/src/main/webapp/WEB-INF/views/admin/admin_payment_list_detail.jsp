<%-- admin_payment_detail.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 결제 상세</title>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function btnCcl(payment_name) {
		if(confirm("결제취소하시겠습니까?")){
			$.ajax({
				type: "POST",
				url: "adminPaymentCancel",
				data: {
					payment_name: payment_name
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
	}
</script>
</head>
<body>
	<div id="wrapper">
		<nav id="navbar">
            <jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
        </nav>
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
		<section id="content">
			<h1 id="h01">스토어 결제 상세 페이지</h1>
			<hr>		
			<div id="admin_main">
				<table border="1">
					<tr>
						<th width="100">주문 번호</th>
						<td>${payment.payment_name }</td>
					</tr>
					<tr>
						<th>주문자명</th>
						<td>${payment.member_name}</td>
					</tr>
					<tr>
						<th>주문한 상품</th>
						<td>${payment.product_name }</td>
					</tr>
					<tr>
						<th>상품수량</th>
						<td>${payment.quantity }</td>
					<tr>
						<th>결제일</th>
						<td>${fn:replace(payment.payment_datetime, "T", "  ") }</td>
					</tr>
					<tr>
						<th>결제 방법</th>
						<td>${payment.payment_card_name }</td>
					</tr>
					<tr>
						<th>총 결제 금액</th>
						<td><fmt:formatNumber value="${payment.payment_total_price}" pattern="#,##0" />원</td>
					</tr>
					<tr>
					<th>결제 상태</th>
					<td id="payment_status_result">
						<c:choose>
							<c:when test="${payment.payment_status eq 0}">
								결제취소
							</c:when>
							<c:otherwise>
								결제완료
							</c:otherwise>
						</c:choose>					
					</td>
				</tr>
				</table>
				<div id="admin_writer">
					<c:choose>
					<c:when test="${payment.payment_status eq 0}">
						<input type="button" value="뒤로가기" onclick="history.back()">
					</c:when>
					<c:otherwise>	
						<input type="submit" value="결제취소" id="resCanBtn" onclick="btnCcl('${payment.payment_name }')">
						<input type="button" value="뒤로가기" onclick="history.back()">
					</c:otherwise>
				</c:choose>
				</div>
			</div>
		</section>
	</div>			
</body>
</html>