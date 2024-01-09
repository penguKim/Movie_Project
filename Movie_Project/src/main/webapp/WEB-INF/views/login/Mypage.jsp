<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<h1 id="h01">마이페이지</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
<!-- 			<form action="Mypage" method="get" name="checkform"> -->
			<div class="mapage_table">
				<div id="my_list">
					<h2>최근 예매내역</h2>
					<table id="my_table1">
						<tr>
							<th style="width: 80px;">No.</th>
							<th>영화제목</th>
							<th>영화극장 정보</th>
							<th>상태</th>
						</tr>
						<c:choose>
							<c:when test="${not empty resMap}">
								<c:forEach var="res" items="${resMap}">
									<tr>
										<td>${res.payment_id}</td>
										<td>${res.movie_title}</td>
										<td>${res.theater_name}${res.room_name} / ${res.seat_name}</td>
										<c:choose>
											<c:when test="${payment_status eq 0}"><td>취소완료</td></c:when>
											<c:otherwise><td>결제완료</td></c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr >
									<td colspan="4" height="70">
										<b class="recentHis">최근 예매 내역이 없습니다</b>
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
						
					</table><br>
				</div>
				
				<div id="buy_list">
					<h2>최근 상품 구매내역</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>상품명</th>
							<th>구매일</th>
							<th>상태</th>
						</tr>
						
							<c:choose>
								<c:when test="${not empty productList}">
									<c:forEach var="product" items="${productList}">
										<tr>
											<td>${product.payment_name}</td>
											<c:set var="productNames" value="${fn:split(product.product_name, ',')}" />
											<td>
												<c:choose>
												    <c:when test="${fn:length(productNames) eq 1}">
												        <p>${product.product_name}</p>
												    </c:when>
												    <c:otherwise>
												        <p>${productNames[0]} 외 ${fn:length(productNames) - 1}개</p>
												    </c:otherwise>
												</c:choose>
											</td>
											<td>${fn:substring(product.payment_datetime, 0, 10)}</td>
											<c:choose>
												<c:when test="${payment_status eq 0}">
													<td>취소완료</td>
												</c:when>
												<c:otherwise>
													<td>결제완료</td>
												</c:otherwise>
											</c:choose>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" height="70" >
											최근 구매 내역이 없습니다
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
					</table><br>
				</div>
			</div>
<!-- 			</form> -->
			
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
	
</body>
</html>