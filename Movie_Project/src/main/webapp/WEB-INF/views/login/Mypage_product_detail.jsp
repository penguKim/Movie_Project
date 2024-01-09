<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 상품 구매 상세 페이지</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
function resCancle(payment_name){
	if(confirm("결제취소하시겠습니까?")){
		$.ajax({
			type: "POST",
			url: "MypageBuyCancel",
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
}//resCancle function 끝
</script>
</head>
<body>
	<form action="" id="popup1_form">
		<div id="popup1_wrapper">
			<h1>상품 구매 상세 페이지</h1>
			<table border="1" id="popup1_table">
				<tr>
					<th width="150">주문 번호</th>
					<td>${refund.payment_name }</td>
				</tr>
				<tr>
					<th>상품 명</th>
					<td>${refund.product_name }</td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td><fmt:formatNumber value="${refund.payment_total_price}" pattern="#,##0" />원</td>
				</tr>
				<tr>
					<th>결제 일시</th>
					<td>${fn:replace(refund.payment_datetime,'T',' ')}</td>
				</tr>
				<tr>
					<th>결제 상태</th>
					<td id="payment_status_result">
						<c:choose>
							<c:when test="${refund.payment_status eq 0}">
								결제취소
							</c:when>
							<c:otherwise>
								결제완료
							</c:otherwise>
						</c:choose>					
					</td>
				</tr>
			</table>
			<br>
			<section id="payX">
				<c:choose>
					<c:when test="${refund.payment_status eq 0}">
						<input type="button" value="확인" onclick="window.close()">
					</c:when>
					<c:otherwise>
						<input type="button" id="resCanBtn" value="결제취소" onclick="resCancle('${refund.payment_name}')">
						<input type="button" value="확인" onclick="window.close();">
					</c:otherwise>
				</c:choose>
			</section>
		</div>
	</form>
</body>
</html>