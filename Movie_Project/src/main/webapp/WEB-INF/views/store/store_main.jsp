<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 선물가게 - 한개씩 골라골라</title>
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
		let quantity = 1;
		
		<%-- 상세페이지로 이동--%>
		if(move == 1 ) {
			move_detail(pro_id, quantity);
			
		<%-- 장바구니 페이지로 이동--%>
		} else if(move == 2) {
			move_cart(pro_id, quantity);

		<%-- 결제 페이지로 이동--%>
		} else if(move == 3) {
			move_pay(pro_id, quantity);
		}
	}
	
	function move_detail(pro_id, quantity) {
		location.href="storeDetail?product_id=" + pro_id;
	}
	
	function move_pay(pro_id, quantity) {
		location.href="storePay?product_id=" + pro_id + "&quantity=" + quantity;
		
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
					<div class="snack_menu">
						<!-- 상품 상세 페이지 바로가기 -->
						<a id="storeDetail" href="#none" onclick="pageMove(1, 'P005')">
							<img alt="" src="${pageContext.request.contextPath}/resources/img/snack/우리패키지.jpg" width="310" height="250" ><br>
							<span>우리패키지</span><br>
							<span class="snack_detail">영화관람권 4매+더블콤보 1개</span><br><br>
							<span>61,000<span id="won">원&nbsp;&nbsp;</span></span>
							<span style="text-decoration: line-through;" class="snack_detail">65,000
								<span id="won">원</span>
							</span>
						</a>
						<!-- 장바구니에 담고 버튼 클릭 시 모달창 확인 -->
						<a href="#none" onclick="pageMove(2, 'P005')">
							<img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn">
						</a>
						<!-- 결제 바로가기 -->
						<a href="#none" onclick="pageMove(3, 'P005')">
							<img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn">
						</a>
					</div>
					<div class="snack_menu">
						<a href="#none" onclick="pageMove(1, 'P002')">
						<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/나랑너패키지.jpg" width="310" height="250"><br>
						<span>나랑너패키지</span><br>
						<span class="snack_detail">영화관람권 2매+스위트콤보 1개</span><br><br>
							<span>34,000<span id="won">원&nbsp;&nbsp;</span>
						</span>
						<span style="text-decoration: line-through;" class="snack_detail">36,000
							<span id="won">원</span>
						</span></a>
						<a href="#none" onclick="pageMove(2, 'P002')"><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href="#none" onclick="pageMove(3, 'P002')"><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
					<div class="snack_menu">
						<a href="storeDetail?product_id=P003">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/시네마패키지.jpg" width="310" height="250"><br>
							<span>시네마패키지</span><br>
							<span class="snack_detail">미니 시네마+팝콘L1개+콜라M2개</span><br><br>
							<span>31,000<span id="won">원&nbsp;&nbsp;</span></span><span style="text-decoration: line-through;" class="snack_detail">36,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
				</div>
				<br>
				<div id="div02">
					<hr>
					<h2>영화관람권</h2>
					<!-- 가격까지 이미지로 다 넣어서 해야할듯 이미지 파일 편집 -->
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/일반관람권.jpg" width="310" height="250"><br>
							<span>일반관람권</span><br>
							<span class="snack_detail">일반 관람권 1매</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/vip관람권.jpg" width="310" height="250"><br>
							<span>VIP관람권</span><br>
							<span class="snack_detail">VIP 관람권 1매</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>	
				</div>
				<br>
				<div id="div03">
					<hr>
					<h2>스낵/음료</h2>
					<!-- 가격까지 이미지로 다 넣어서 해야할듯 이미지 파일 편집 -->
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/스위트콤보.jpg" width="310" height="250"><br>
							<span>스위트콤보</span><br>
							<span class="snack_detail">오리지널L + 탄산음료M2</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/더블콤보.jpg" width="310" height="250"> <br>
							<span>더블콤보</span><br>
							<span class="snack_detail">오리지널팝콘M + 탄산음료M2</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/콜라M.jpg" width="310" height="250"> <br>
							<span>콜라M</span><br>
							<span class="snack_detail">콜라M</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
						<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
						<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/콜라L.jpg" width="310" height="250"><br>
							<span>콜라L</span><br>
							<span class="snack_detail">콜라L</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a> 
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/오리지널M.jpg" width="310" height="250"><br>
							<span>오리지날팝콘 M</span><br>
							<span class="snack_detail">오리지날팝콘 M</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/오리지널L.jpg" width="310" height="250"><br>
							<span>오리지날팝콘 L</span><br>
							<span class="snack_detail">오리지널팝콘 L</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/카라멜M.jpg" width="310" height="250"><br>
							<span>캬라멜팝콘 M</span><br>
							<span class="snack_detail">카라멜팝콘 M</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/카라멜L.jpg" width="310" height="250"><br>
							<span>캬라멜팝콘 L</span><br>
							<span class="snack_detail">카라멜팝콘 L</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
					<div class="snack_menu">
						<a href="storeDetail?product_id=P001">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/반반.jpg" width="310" height="250"><br>
							<span>반반팝콘(오리지널/카라멜)L</span><br>
							<span class="snack_detail">반반팝콘(오리지널+카라멜)L</span><br><br>
							<span>10,000<span id="won">원</span></span>
						</a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/cart2.png" width="60px" height="60px" class="cart_btn"></a>
						<a href=""><img src="${pageContext.request.contextPath }/resources/img/pay2.png" width="60px" height="60px" class="pay_btn"></a>
					</div>
				</div>
				
				<%-- 폰트사이즈 조절 및 위지 조절 --%>
				<div id="store_notice">
					<hr>
					영화관 고객센터 ☎1544-0000
					상담가능 시간 : 월 ~ 금 10:00~12:00
					* 이 외 시간은 자동 응답 안내 가능 
					<hr>
				</div>
			</div>
		</div>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>