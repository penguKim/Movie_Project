<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 선물가게 - 이것좀 보고가 </title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/store.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
/* 새로 갱신된 파일 */
	$(function() {
		
		let price = ${store[0].product_price};
		let product_count = parseInt($("#product_count").val());
		
		/* - 클릭 시 상품 수량 감소 */
		/* 1 이하로 수량 감소 불가 */
		$("#minus").on("click", function() {
			
			if(product_count > 1) {
				product_count -= 1;
				$("#product_count").val(product_count);
				/* 수량 감소시 함수 호출 */
				updateTotalPrice();
			} else {
// 				alert("수량이 1보다 커야합니다");
			}
		});
		
		/* + 클릭 시 상품 수량 증가 */
		/* 100 이상으로 증가 불가 */
		$("#plus").on("click", function() {
			
			if(product_count < 99) {
				product_count += 1;
				$("#product_count").val(product_count);
				/* 수량 증가시 함수 호출 */
				updateTotalPrice();
			} else {
				alert("최대 수량입니다");
			}
		});
		
		/* 수량 변경시 totalPrice 액수 변경 */
		function updateTotalPrice() {
			let totalPrice = price * product_count;
			$("#sum").html("총 금액 : <b>" + totalPrice + "원</b>");
		} 
		
		<%-- 토탈 금액 및 금액에서 , 찍어야함 --%>
		/* 수량 변경 없을 경우 현재 total 값 */
		updateTotalPrice();
		
	});
	
	
	function redirectToStorePay() {
	    var productCount = document.getElementById("product_count").value; // 수량 입력 필드의 값 가져오기
// 	    var productID = "${product_id}"; // 상품 ID 가져오기
	    var productID = "${param.product_id}"; // 상품 ID 가져오기
	    
	    var url = "storePay?product_id=" + productID + "&product_count=" + productCount; // URL 생성
	    location.href = url; // 다른 페이지로 이동
	}
	
	
</script>
</head>
<body>
	<div id="wrapper">
		<!-- 상단 고정 메뉴 자리 -->
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>	
		
		<!-- 전체  -->
		<section id="content">
			<h1 id="h01">상품정보</h1>
			<hr>
			<!-- 상품정보 -->
			<!-- 상품명 -->
			<form action="storePay" method="GET">
				<div id="item_name"><strong>${store[0].product_name }</strong></div> 
				
				<!-- 상품상세 이미지  -->
				<div id="box_store_view">
					<div class="left">
							<%-- 상품 이미지 DB에서 직접 꺼내오는 방법 고민 --%>
							<%-- 이미지 절대경로 설정하는 법 익히기 --%>
						<p><img src="${store[0].product_img}" alt="우리패키지"></p>
					</div>
					<div class="right">
						<div class="goods_info">
							<div class="line">
								<b>상품구성</b> ${store[0].product_txt }
							</div>
							<br>
							<div class="line">
								<b>상품제한</b> 제한없음
							</div>	
							<br>
							<div class="line">
								<b>유효기간</b> 구매일로부터 365일 이내 취소 가능하며,<br> 부분취소는 불가능합니다.
							</div>	
							<br>
						</div>
						<hr>
						<!-- 상품/결제 -->
						<div class="pay_quantity">
							<div class="receipt">
								<p class="title">수량/금액</p>
								<div class="contents">
									<button type="button" id="minus" class="btn_minus" title="수량감소">-</button>
									<%-- readonly 하거나 숫자 입력 시 100 이상일 경우 경고메세지 처리 중 어떤게 나을까 --%>
									<input type="text" title="수량입력" id="product_count" name="product_count" value="1" min="1" max="99" class="input-text" readonly>
									<button type="button" id="plus" class="btn_minus" title="수량증가">+</button>
									<div class="money">${store[0].product_price}원</div>
								</div>
							</div>
						</div>	
						<hr>
						<%-- 총 상품 결제 금액 출력(상품 가격 + 상품 갯수) --%>
						<div id="sum"> </div>
						<br>
						<div id="btn_buy">
						<%-- 장바구니 이미지로 교체할지 말지 부기능으로 --%>
						<%-- 구매 버튼 submit으로 교체 예정 --%>
		                	<a  href="#none" onclick="move_cart(2, 'P002')"><button type="button">장바구니</button></a>
		                <button type="button" onclick="redirectToStorePay()">구매</button>
		               	</div>
					</div>	
				</div>
			</form>
			<!-- 사용 방법 및 이용안내 -->
			<div id="store_exap">
				<div id="store_expl01"><strong>사용방법</strong> <br></div>
				<div id="store_expl02">
				- 스토어 상품은 회원만 구매할 수 있습니다.<br>
				- 일반관람권의 경우 2D 일반영화에  사용 가능합니다. (스페셜관 및 특수좌석 사용 불가)<br>
				- 영화관람권은 L.POINT 적립이 불가합니다.<br>
				- 유효기간은 24개월로 관람일 기준입니다.<br>
				- 구매한 영화관람권은 마이시네마 > 나의 쿠폰함에서 확인 후 롯데시네마 홈페이지, 모바일 웹/앱에서 사용 가능합니다.<br>
				- 선물한 영화관람권은 문자쿠폰(MMS)으로 발송되며 롯데시네마 홈페이지, 모바일 웹/앱에서 사용 가능합니다.<br>
				- 선물한 상품은 마이시네마 > 예매/구매내역 > 선물내역 메뉴에서 30일 내 1회 재발송 가능합니다. 단, 받는 사람 번호는 변경 불가합니다.<br>
				- 관람권 구매금액보다 낮은 금액의 티켓 구매 시 구매금액이 아닌 티켓 금액으로 VIP 승급금액이 반영됩니다. (예; 조조, 심야, 문화의 날 등)<br>
				</div>
			</div>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>