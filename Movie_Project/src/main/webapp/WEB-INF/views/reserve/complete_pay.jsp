<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 선물가게 - 구매는 언제나 옳다</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/store.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script>

</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>	
		
		<section id="content">
			<h1 id="h01">결제하기</h1>
			<hr>
			<div class="store_progress">
				<div id="prog_img"><img src="${pageContext.request.contextPath}/resources/img/pay1.png"></div><div><span class="step">STEP 01</span><br>결제하기</div>
				<div> <span class="bracket"> > </span> </div>
				<div id="prog_img"><img src="${pageContext.request.contextPath}/resources/img/finish2.png"></div><div id="progress_red"><span class="step">STEP 02</span><br>예매완료</div>
			</div>
			
			<!-- 구매 상품 정보 테이블 -->
			<div class="store_pay">
				<div class="store_pay_box">
					<table class="store_pay_table">
						<tr>
							<th colspan="5"><h1>예매가 완료되었습니다.</h1></th>
						</tr>
						<tr>
							<th colspan="5">Thank You for Your Order</th>
						</tr>
						<tr>
							<th colspan="5"><img src="${pageContext.request.contextPath }/resources/img/결제성공.png"></th>
						</tr>
					</table>
					
				</div>
				<br>
			
				<div class="paybtn">
					<a href="movie_select"><input type="button" value="추가 예매하기"></a>
					<a href="./" ><input type="button" value="홈으로"></a>
				</div>
			</div>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>