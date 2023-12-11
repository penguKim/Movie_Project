<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품정보</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/css/store.css" rel="stylesheet" type="text/css">
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
			<div id="item_name"><strong >스위트 콤보</strong></div> 
			
			<!-- 상품상세 이미지  -->
			<div id="box_store_view">
				<div class="left">
					<p><img src="../img/스위트콤보.png" alt="스위트콤보"></p>
				</div>
				<div class="right">
					<div class="goods_info">
						<div class="line">
							<b>상품구성</b> 오리지널L + 탄산음료M2
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
								<button type="button" class="btn_minus" title="수량감소">-</button>
								<input type="text" title="수량입력" value="1" min="1" max="99" class="input-text">
								<button type="button" class="btn_minus" title="수량증가">+</button>
								<div class="money">10000원</div>
							</div>
						</div>
					</div>	
					<hr>
					<div id="sum">총 금액 : <b>10000원</b></div>
					<br>
					<div id="btn_buy">
					<!-- 이미지로 교체 예정 -->
	                	<a href="store_main.jsp"><button type="button">장바구니</button></a>
	                	<a href=""><button type="button">구매</button></a>
	               	</div>
				</div>	
			</div>
			<!-- 사용 방법 및 이용안내 -->
			<div id="store_exap">
				<div id="store_expl01"><strong>사용방법</strong> <br></div>
				<div id="store_expl02">
				- 스토어 상품은 회원만 구매할 수 있습니다.<br>
				- 일반관람권의 경우 2D 일반영화에 사용 가능합니다. (스페셜관 및 특수좌석 사용 불가)<br>
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