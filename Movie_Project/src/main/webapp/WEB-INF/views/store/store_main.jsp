<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/store.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		
	});
	
	function pageMove(move_num, pro_id) {
		
		<%-- 페이지 이동용 번호 --%>
		let move = move_num;
		<%-- 상품 아이디 지정 --%>
		let pro = pro_id;
		<%-- 스토어 메인 페이지의 경우 1이 아닌 경우가 없으므로 1 지정 --%>
		let product_count = 1;
		
		<%-- 상세페이지로 이동--%>
		if(move == 1 ) {
			move_detail(pro_id, product_count);
			
		<%-- 장바구니 페이지로 이동--%>
		} else if(move == 2) {
			move_cart(pro_id);

		<%-- 결제 페이지로 이동--%>
		} else if(move == 3) {
			move_pay(pro_id, product_count);
		}
	}	
	
	function move_cart(pro_id) {
		location.href="storeCart?product_id=" + pro_id;
	}
	
	function move_detail(pro_id, product_count) {
		location.href="storeDetail?product_id=" + pro_id;
	}
	
	function move_pay(pro_id, product_count) {
		location.href="storePay?product_id=" + pro_id + "&product_count=" + product_count;
	}
	
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		
		<div id="content">
			<div id="div_store_01">
				<h1 id="h01">스토어</h1>
				<hr>
				<!-- 버튼 클릭시 해당 섹션으로 이동  -->
				<!-- body부분 페이지 변환없이 한페이지에서 모두 보이도록 구성 -->
				<nav class="menubtn">
					<ul>
						<li><a href="#div01"><input type="button" value="패키지"></a></li>
						<li><a href="#div02"><input type="button" value="영화관람권"></a></li>
						<li><a href="#div03"><input type="button" value="스낵/음료"></a></li>
						<li><a href="storeCart2"><input type="button" value="장바구니"></a></li>
					</ul>
				</nav>
				<!-- 클릭시 상세페이지로 전환 -->
				<div id="div01">
					<h2>패키지</h2>
					<c:forEach var="i" begin="0" end="2">
						<div class="snack_menu">
							<a id="storeDetail" href="javascript:void(0)" onclick="pageMove(1, 'P00${i+1}')">
								<img alt="" src="${pageContext.request.contextPath }/resources/upload/${productList[i].product_img}" width="310" height="250"><br>
								<span>${productList[i].product_name}</span><br>
								<span class="snack_detail">${productList[i].product_txt}</span><br><br>
								<span>
									<fmt:formatNumber value="${productList[i].product_price}" pattern="###,###" /><span id="won">원&nbsp;&nbsp;</span>
								</span>
								<span style="text-decoration: line-through;" class="snack_detail">
									<fmt:formatNumber value="${productList[i].product_price * 1.025}" pattern="###,###" /><span id="won">원</span>
								</span>
							</a>
							<!-- 장바구니에 담고 버튼 클릭 시 모달창 확인 -->
							<a href="javascript:void(0)" onclick="pageMove(2, 'P00${i+1}')"><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
							<!-- 결제 바로가기 -->
							<a href="javascript:void(0)" onclick="pageMove(3, 'P00${i+1}')"><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
						</div>
					</c:forEach>
				</div>
				<br>
				<div id="div02">
					<hr>
					<h2>영화관람권</h2>
					<c:forEach var="i" begin="3" end="4">
						<div class="snack_menu">
							<a href="javascript:void(0)" onclick="pageMove(1, 'P00${i+1}')">
								<img alt="" src="${pageContext.request.contextPath }/resources/upload/${productList[i].product_img}" width="310" height="250"><br>
								<span>${productList[i].product_name}</span><br>
								<span class="snack_detail">${productList[i].product_txt }</span><br><br>
								<span>
									<fmt:formatNumber value="${productList[i].product_price}" pattern="###,###" /><span id="won">원</span>
								</span></a>
							<a href="javascript:void(0)" onclick="pageMove(2, 'P0${i < 9 ? '0' : ''}${i+1}')"><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
							<a href="javascript:void(0)" onclick="pageMove(3, 'P0${i < 9 ? '0' : ''}${i+1}')"><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
						</div>
					</c:forEach>
				</div>
				<br>
				<div id="div03">
					<hr>
					<h2>스낵/음료</h2>
					<c:forEach var="i" begin="5" end="16">
						<div class="snack_menu">
							 <a href="javascript:void(0)" onclick="pageMove(1, 'P0${i < 9 ? '0' : ''}${i+1}')">
								<img alt="" src="${pageContext.request.contextPath }/resources/upload/${productList[i].product_img}" width="310" height="250"><br>
								<span>${productList[i].product_name}</span><br>
								<span class="snack_detail">${productList[i].product_txt }</span><br><br>
								<span><fmt:formatNumber value="${productList[i].product_price}" pattern="###,###" /><span id="won">원</span></span>
							</a>
							<a href="javascript:void(0)" onclick="pageMove(2, 'P0${i < 9 ? '0' : ''}${i+1}')"><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
							<a href="javascript:void(0)" onclick="pageMove(3, 'P0${i < 9 ? '0' : ''}${i+1}')"><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
						</div>
					</c:forEach>
				</div>
				<%-- 폰트사이즈 조절 및 위지 조절 --%>
				<div id="store_notice">
					<hr>
					iTicket 고객센터 ☎1544-0000 |
					상담가능 시간 : 월 ~ 금 10:00~12:00 |
					* 이 외 시간은 자동 응답 안내 가능 
					<hr>
				</div>
			</div>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
		</div>
	</div>
</body>
</html>