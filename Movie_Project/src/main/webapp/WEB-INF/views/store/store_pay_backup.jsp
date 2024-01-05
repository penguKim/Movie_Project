<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
/* 새로 갱신된 파일 */	
	// 선택된 라디오 버튼 이외의 다른 라디오 버튼을 선택 해제
	function check(checkedRadio) {
	// name이 'radiocheck'인 모든 라디오 버튼을 가져옴
	  var radio = document.getElementsByName('radiocheck');
	// 반복문으로 라디오 버튼들 반복하면서 선택된 버튼 이외의 버튼을 선택 해제
	  for (var i = 0; i < radio.length; i++) {
	    if (radio[i] !== checkedRadio) {
	      radio[i].checked = false;
    }
  }
}
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
<%-- 결제 API 포트원 SDK 코드 --%>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
$(function() {
	
});

	<%-- 주문번호 생성을 위한 작업 --%>
	var count = 0;
	
	function generateMerchantUid() {
	  var now = new Date();
	  var year = now.getFullYear().toString().substr(2, 2);
	  var month = ('0' + (now.getMonth() + 1)).slice(-2);
	  var date = ('0' + now.getDate()).slice(-2);
	  var hours = ('0' + now.getHours()).slice(-2);
	  var minutes = ('0' + now.getMinutes()).slice(-2);
	  var seconds = ('0' + now.getSeconds()).slice(-2);
	  var milliseconds = now.getMilliseconds().toString().padStart(3, '0');
	  var randomString = Math.random().toString(36).substr(2, 3);
	  var index = ('00000' + (++count)).slice(-6);
	
	  var merchantUid = "ORD" + year + month + date + hours + minutes + seconds + milliseconds + "-" + randomString + index;
	  return merchantUid;
	}
	// ****************************************************
	var merchantUid =  generateMerchantUid();
	<%-- var product_id = "${storeList[0].product_id}"; --%>
	var product_name = "";
	var quantity = 0;
	var product_total_price = 0;
	var member_id = "${members.member_id}";
	var member_email = "${members.member_email}";
	var member_name = "${members.member_name}";
	var member_phone = "${members.member_phone}";
$(function() {
	<%-- 상품명 결제시 문자열 결합 --%>
	$(".product_name").each(function() {
		product_name += $(this).val() + ",";
	});
	product_name = product_name.slice(0, -1);
	<%-- 상품 수량 결제시 총 수량 --%> 
	$(".product_count").each(function() {
		quantity += $(this).val() + ",";
	});
	quantity = quantity.slice(0, -1);
	<%-- 총 금액 계산 --%>
	$(".product_price").each(function(index) {
		var price = parseInt($(this).val());
	    var quantity = parseInt($(".product_count").eq(index).val());
	    product_total_price += (price * quantity);
	});
// 	alert("총금액 !!!: " + quantity);
});	
	
	//*****************************************************
	
	console.log(merchantUid);
	// API 초기화 : 포트원 API를 사용하기 위해 초기화
	var IMP = window.IMP;
	IMP.init("imp65336711");
	
	function requestPay() {
		
		$.ajax({
			<%--결제 정보 --%>
	        url: "PaymentEndpoint", 
	        type: "POST",
	        headers: { "Content-Type": "application/json" },
	        data: JSON.stringify({
// 	          imp_uid: imp_uid,            // 결제 고유번호
// 	          payment_name: rsp.merchant_uid,   // 주문번호
	          payment_card_name: "kakaopay",
	          payment_total_price: product_total_price,
	          product_name: product_name,
	          quantity: quantity,
	          member_id: member_id
	        }),
	        success: function(data) {
				console.log("성공!");
			},
			error: function() {
				console.log("실패")
			}
	        
        });
		
		
// 		IMP.request_pay({
// 	      pg: "kakaopay",
// 	      pay_method: "card",
// 	      merchant_uid: merchantUid,   // 주문번호
// 	      name: product_name,   // 결제 대상 제품명
// 	      amount: product_total_price,  // 숫자 타입
// 	      buyer_email: member_email, // 결제 email MemberVO
// 	      buyer_name: member_name,  // 주문자 명 MemberVO 
// 	      buyer_tel: member_phone // 연락처 MemberVO
// 	    }, function (rsp) { // callback
// 	      //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
// 	      if (rsp.success) {
// 		      // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
// 		      // jQuery로 HTTP 요청
// 		      $.ajax({
<%-- 		    	결제 정보 --%>
// 		        url: "PaymentEndpoint", 
// 		        type: "POST",
// 		        headers: { "Content-Type": "application/json" },
// 		        data: JSON.stringify({
// 		          imp_uid: rsp.imp_uid,            // 결제 고유번호
// 		          payment_name: rsp.merchant_uid,   // 주문번호
// 		          payment_card_name: "kakaopay",
// 		          payment_total_price: product_total_price,
// 		          product_name: product_name,
// 		          quantity: quantity,
// 		          member_id: member_id
// 		        })
// 		      }).done(function (data) {
// 		        // 가맹점 서버 결제 API 성공시 로직
// 		        alert("결제 성공");
// 		        location.href="CartListDel"
// 		      })
// 		    } else {
// 		    	alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
// 		    	location.href="payment_fail";
// 		    }
	      
// 	    });
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
			<h1 id="h01">결제하기</h1>
			<hr>
			<div class="store_progress">
				<div id="prog_img"><img src="${pageContext.request.contextPath}/resources/img/cart1.png"></div><div><span class="step">STEP 01</span><br>장바구니</div>
				<div> <span class="bracket"> > </span></div>
				<div id="prog_img"><img src="${pageContext.request.contextPath}/resources/img/pay2.png"></div><div id="progress_red"><span class="step">STEP 02</span><br>결제하기</div>
				<div> <span class="bracket"> > </span> </div>
				<div id="prog_img"><img src="${pageContext.request.contextPath}/resources/img/finish1.png"></div><div><span class="step">STEP 03</span><br>결제완료</div>
			</div>
			
			<!-- 구매 상품 정보 테이블 -->
			<div class="store_pay">
				<div class="store_pay_box">
					<div class="store_subject">구매상품 정보</div>
					<table class="store_pay_table">
						<tr class="store_table_box01">
							<!-- 이미지와 상품정보 두칸 합치기 위해 상품명 colspan2 사용 -->
							<th colspan="2" class="store_table_box_td">상품명</th>
							<th>판매금액</th>
							<th>수량</th>
							<th>구매금액</th>
						</tr>
						<!-- 이미지 가격표 없는 이미지로 편집 -->
						<!-- 단일 구매 인 경우 바로 결제 페이지에 데이터 입력 -->
						<!-- 장바구니에서 넘어오는 경우 랑 단일인 경우 판별 -->
						<!-- 장바구니에서 넘어오는 데이터 테이블화 시켜서 보여줄것 -->
						<c:set var="store_pay_price" value="0"></c:set>
						<c:forEach var="store" items="${storeList }" varStatus="status">
						
						<input type="hidden" name="product_id" class="product_id" value="${store.product_id }">
						<input type="hidden" name="product_name" class="product_name" value="${store.product_name }">
						<input type="hidden" name="product_count" class="product_count" value="${store.product_count }">
						<input type="hidden" name="product_price" class="product_price" value="${store.product_price }">
						<input type="hidden" name="product_txt" class="product_txt" value="${store.product_txt  }">
						
						<c:set var="store_total_price" value="${store_pay_price + (store.product_price * store.product_count)}"></c:set>
						<c:set var="store_pay_count" value="${store.product_price * param.product_count}"></c:set>
							<tr class="store_table_box02">
								<td><img src="${store.product_img }"></td>
								<td><span >${store.product_name }</span> 
									<br> 
									<span id="">${store.product_txt }</span></td>
<%-- 								<td>${param.product_count }개</td> --%>
<%-- 								<td>${store.product_price * param.product_count }원</td> --%>
								<c:choose>
								  <c:when test="${param.product_count != null}">
								    <td><fmt:formatNumber value="${store.product_price}" pattern="###,###"/>원</td>
								    <td>${param.product_count}개</td>
								    <td><fmt:formatNumber value="${store.product_price * param.product_count}" pattern="###,###"/>원</td>
								    <c:set var="store_pay1" value="${store.product_price * param.product_count}"></c:set>
								  </c:when>
								  <c:otherwise>
								    <td><fmt:formatNumber value="${store.product_price}" pattern="###,###"/>원</td>
								    <td>${store.product_count}개</td>
								    <td><fmt:formatNumber value="${store.product_price * store.product_count}" pattern="###,###"/>원</td>
								  </c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</table>
					<table class="store_pay_table">
						<tr class="store_table_box03">
							<th>총 상품 금액</th>
							<th></th>
							<th>할인금액</th>
							<th></th>
							<th>총 결제 예정금액</th>
						</tr>
						<tr class="store_table_box04">
							<c:choose>
								  <c:when test="${param.product_count != null}">
								    <td><fmt:formatNumber value="${store_pay_count}" pattern="###,###"/>원 </td>
									<td><img src="${pageContext.request.contextPath}/resources/img/-.png" width="35px" height="35px"></img> </td>
									<td>0원</td>
									<td><img src="${pageContext.request.contextPath}/resources/img/=.png" width="35px" height="35px"></img></td>
									<td class="table_box_red"><fmt:formatNumber value="${store_pay_count}" pattern="###,###"/>원</td>
								    <c:set var="store_pay1" value="${store.product_price * param.product_count}"></c:set>
								  </c:when>
								  <c:otherwise>
								    <td><fmt:formatNumber value="${store_total_price}" pattern="###,###"/>원 </td>
									<td><img src="${pageContext.request.contextPath}/resources/img/-.png" width="35px" height="35px"></img> </td>
									<td>0원</td>
									<td><img src="${pageContext.request.contextPath}/resources/img/=.png" width="35px" height="35px"></img></td>
									<td class="table_box_red"><fmt:formatNumber value="${store_total_price}" pattern="###,###"/>원</td>
								  </c:otherwise>
							</c:choose>
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
							<span><input type="radio" value="신용카드"  name=radiocheck onclick="check(this)"><b>신용카드</b></span>
							<span><input type="radio" value="kakaoPay" name=radiocheck onclick="check(this)">kakao<b>Pay</b></span>
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
							<br>&nbsp;&nbsp;<input type="checkbox">전자금융거래 이용약관
							<br>&nbsp;&nbsp;<input type="checkbox">개인정보 수집 이용약관
							<br>&nbsp;&nbsp;<input type="checkbox">개인정보 제공 및 위탁안내
						</div>
					</div>
				</div>
				<div class="paybtn">
					<a href="store_main.jsp"><input type="button" value="이전화면"></a>
					<a href="javascript:requestPay()" ><input type="button" value="결제하기"></a>
				</div>
			</div>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>