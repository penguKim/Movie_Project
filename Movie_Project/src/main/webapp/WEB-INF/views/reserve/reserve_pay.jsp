<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket STEP01.결제하기</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/store.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<script>
	//결제수단 변수
    var selectedPgValue;
	//랜덤한 8자리 숫자 변수
	var randomCode = generateRandomNumber();
	console.log(randomCode);
	var totalPrice = 0;
	$(function(){
		var typeCount = "${map.typeCount}";
		var types = typeCount.split(",");
		for(var i = 0; i < types.length; i++) {
			var type = types[i].trim();
			var value = parseInt(type.match(/\d+/)[0]);
		    if (type.includes("일반")) {
		    	totalPrice += value * 15000;
		    } else if (type.includes("청소년")) {
		    	totalPrice += value * 11000;
		    } else if (type.includes("경로")) {
		    	totalPrice += value * 7000;
		    } else if (type.includes("우대")) {
		    	totalPrice += value * 5000;
		    }
		  }
		  $("#totalPrice").text(totalPrice);
		  $(".totalPriceResult").val(totalPrice);
		  $(".back").click(function(){
			  history.back();
		  })
	});//document.ready End
	
	
	function radio(pg) {
		selectedPgValue = pg.value;
		console.log(selectedPgValue);
	}
	  
	function subBtnClick(){
		if(selectedPgValue==null){
			alert("결제수단 선택 필수!");
		}
		// 체크박스 상태 확인
	    var terms1Checked = $("#terms1").is(":checked");
	    var terms2Checked = $("#terms2").is(":checked");
	    var terms3Checked = $("#terms3").is(":checked");

	    // 결제연동 준비상태를 표시하는 변
	    var requestReady = null;

	    // 체크 여부 확인 및 포커스 설정
	    if (terms1Checked && terms2Checked && terms3Checked) {
	    	requestReady = true;
	    } else{
	    	alert("결제 대행 서비스 약관 동의 필수!");
	    }
	    
	    if(selectedPgValue != null && requestReady == true){
	    	requestPay();
	    }
	}
	
	function generateRandomNumber() {
		var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789가나다라마바사아자차카타파하';
	    var code = '';
	    for (var i = 0; i < 20; i++) {
	        var randomIndex = Math.floor(Math.random() * characters.length);
	        code += characters.charAt(randomIndex);
	    }
	    return code;
	}

	var IMP = window.IMP;
	IMP.init("imp76837350");
	function requestPay() {
		IMP.request_pay({
			pg: selectedPgValue,
			pay_method: "card",
			merchant_uid: randomCode,   // 주문번호
			name: "예매상품 : ${map.movie}",   // 결제 대상 제품명
			amount: totalPrice,         //totalPrice,  // 숫자 타입
			buyer_email: "${members.member_email}", // 결제 email MemberVO
			buyer_name: "${members.member_name}",  // 주문자 명 MemberVO 
			buyer_tel: "${members.member_phone}" // 연락처 MemberVO
		
		}, function(rsp){ // callback
			if(rsp.success){
				alert("결제성공");
				$("#reservePayForm").submit();
			}else{
				var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		        alert(msg);
			}
		
		});//IMP.request_pay End
		
	}//requestPay function End
	
	// 약관 동의 체크박스 부분 처리
	function checkAll() {
		var Checkbox = document.querySelector('.store_pay_info_check input[type="checkbox"]');
		var Checkboxes = document.querySelectorAll('.store_pay_info_group input[type="checkbox"]');
		for (var i = 0; i < Checkboxes.length; i++) {
			Checkboxes[i].checked = Checkbox.checked;
		}
	}
	// 아래쪽 약관 동의 체크박스 부분 처리
	function checkAll2() {
		var Checkbox2 = document.querySelector('.info02 input[type="checkbox"]');
		var Checkboxes2 = document.querySelectorAll('.info02 input[type="checkbox"]:not(:first-child)');
		for (var i = 0; i < Checkboxes2.length; i++) {
		    Checkboxes2[i].checked = Checkbox2.checked;
		}
	}
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>	
		
		<section id="content">
			<div class="store_progress">
				<div id="prog_img"><img src="${pageContext.request.contextPath}/resources/img/pay2.png"></div><div id="progress_red"><span class="step">STEP 01</span><br>결제하기</div>
				<div> <span class="bracket"> > </span> </div>
				<div id="prog_img"><img src="${pageContext.request.contextPath}/resources/img/finish1.png"></div><div><span class="step">STEP 02</span><br>예매완료</div>
			</div>
			
			<!-- 구매 상품 정보 테이블 -->
			<div class="store_pay">
				<div class="store_pay_box">
					<div class="store_subject">구매상품 정보</div>
					<table class="store_pay_table">
						<tr class="store_table_box01">
							<!-- 이미지와 상품정보 두칸 합치기 위해 상품명 colspan2 사용 -->
							<th>영화정보</th>
							<th>극장정보</th>
							<th>상영일정 </th>
							<th>인원 </th>
							<th>좌석 </th>
							<th>구매금액</th>
						</tr>
						<!-- 이미지 가격표 없는 이미지로 편집 -->
						<!-- 단일 구매 인 경우 바로 결제 페이지에 데이터 입력 -->
						<!-- 장바구니에서 넘어오는 경우 랑 단일인 경우 판별 -->
						<!-- 장바구니에서 넘어오는 데이터 테이블화 시켜서 보여줄것 -->
							<tr class="store_table_box02">
								<td><span>${map.movie}</span></td>
								<td> 
									<span>${map.Theater}</span><br>
									<span>${map.Room}</span><br>
								</td>
								<td><span>${map.Date}<br>${map.StartTime}</span></td>
								<td>${map.typeCount} </td>
								<td>${map.select_seat} </td>
								<td id="totalPrice"> 
									총금액
								</td>
							</tr>
					</table>
					
				</div>
				<br>
				<div class="">
					<div class="store_subject">주문자 정보확인</div>
					<div class="store_member_info">	
						<!-- 이름과 휴대전화 번호는 자동 저장 -->
						<!-- 이름 중간 *, 번호 중간 네자리 * 처리 -->
						<section>
							<span><b>이름</b> <input type="text" value="${members.member_name}" readonly="readonly"></span>
							<span><b>휴대전화 번호</b> <input type="text" value="${members.member_phone}" readonly="readonly"></span>
						</section>
					</div>
					<div class="store_member_info_ex">* 구매하신 기프티콘은 주문자 정보에 입력된 휴대전화 번호로
					MMS로 발송 됩니다. <br> &nbsp; 입력된 휴대전화 번호가 맞는지 꼭 확인하세요</div>
				</div>
				
				<div class="store_payment">
					<div class="store_subject">결제 수단</div>
					<div class="store_payment_line">
						<section>
							<span><input type="radio" value="html5_inicis"  name=radiocheck onclick="radio(this)"><b>신용카드</b></span>
							<span><input type="radio" value="kakaopay" name=radiocheck onclick="radio(this)">kakao<b>Pay</b></span>
						</section>
					</div>	
				</div>
			
				<div class="store_pay_info">
					<div class="store_pay_info_check"><input type="checkbox" onclick="checkAll()">주문정보/결제 대행 서비스 약관 모두 동의</div>
					<div class="store_pay_info_group">
						<div class="info01"><input type="checkbox">기프트콘 구매 동의
							<br> <span class="info01_01">&nbsp;&nbsp;&nbsp;기프트콘 발송 및 CS 처리 등을 이해 수신자로부터 영화관에 수신자의 전화번호를 제공하는 것에 대한 적합한 동의를 받습니다.</span>
						</div>
						<div class="info02"><input type="checkbox" onclick="checkAll2()">결제 대행 서비스 약관 모두 동의 
							<br>&nbsp;&nbsp;<input type="checkbox" id="terms1">전자금융거래 이용약관
							<br>&nbsp;&nbsp;<input type="checkbox" id="terms2">개인정보 수집 이용약관
							<br>&nbsp;&nbsp;<input type="checkbox" id="terms3">개인정보 제공 및 위탁안내
						</div>
					</div>
				</div>
				<div class="paybtn">
					<form action="completePay" method="get" id="reservePayForm">
						<input type="button" value="이전화면" class="back">
						<input type="hidden" name="movie_title" id="movie_title" value="${map.movie}">
						<input type="hidden" name="theater_name" value="${map.Theater}">
						<input type="hidden" name="room_name" value="${map.Room}">
						<input type="hidden" name="play_date" value="${map.Date}">
						<input type="hidden" name="play_start_time" value="${map.StartTime}">
						<input type="hidden" name="typeCount" value="${map.typeCount}">
						<input type="hidden" name="seat_name" value="${map.select_seat}">
						<input type="hidden" class="totalPriceResult" name="payment_total_price" value="">
						<input type="button" value="결제하기" id="subBtn" onclick="subBtnClick()">
					</form>
				</div>
			</div>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>