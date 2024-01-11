<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script>
$(function() {
    $("#agreeAll").on("change", function() {
        if ($("#agreeAll").prop("checked")) {
            $(":checkbox[name=agree]").prop("checked", true);
            $(":checkbox[name=agree2]").prop("checked", true);
        } else {
        	$(":checkbox[name=agree]").prop("checked", false);
            $(":checkbox[name=agree2]").prop("checked", false);
        }
    });
    
    $(":checkbox[name=agree]").on("change", function() {
        var allChecked = true;
        $(":checkbox[name=agree]").each(function() {
            if (!$(this).prop("checked")) {
                allChecked = false;
                return false;
            }
        });
        $("#agreeAll").prop("checked", allChecked);
    });
    
    $("#agree").on("change", function() {
        if ($("#agree").prop("checked")) {
            $(":checkbox[name=agree2]").prop("checked", true);
        } else {
            $(":checkbox[name=agree2]").prop("checked", false);
            $("#agreeAll").prop("checked", false);
        }
    });

    $(":checkbox[name=agree2]").on("change", function() {
        var allChecked = true;
        $(":checkbox[name=agree2]").each(function() {
            if (!$(this).prop("checked")) {
                allChecked = false;
                return false;
            }
        });
        $("#agree").prop("checked", allChecked);
        $("#agreeAll").prop("checked", allChecked);
    });
});
</script>
<%-- 결제 API 포트원 SDK 코드 --%>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
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
	  var index = ('000' + (++count)).slice(-6);
	  var merchantUid = "ORD" + year + month + date + hours + minutes + seconds + milliseconds + "-" + randomString + index;
	  return merchantUid;
	}
	// ****************************************************
	var merchantUid =  generateMerchantUid();
	<%-- var product_id = "${storeList[0].product_id}"; --%>
	var product_name = "";
	var quantity = [];
	var product_total_price = 0;
	var member_id = "${members.member_id}";
	var member_email = "${members.member_email}";
	var member_name = "${members.member_name}";
	var member_phone = "${members.member_phone}";
	var product_id = [];
	
	$(function() {
		<%-- 상품 아이디 배열에 저장 --%>
		$(".product_id").each(function() {
		    product_id.push($(this).val()); 
		});
		<%-- 상품 수량 배열에 저장 --%>
		$(".product_count").each(function() {
			quantity.push($(this).val());
		});
		<%-- 상품명 결제시 문자열 결합 --%>
		$(".product_name").each(function() {
			product_name += $(this).val() + ",";
		});
		product_name = product_name.slice(0, -1);
		<%-- 상품 수량 결제시 총 수량 --%> 
		<%-- 총 금액 계산 --%>
		$(".product_price").each(function(index) {
			var price = parseInt($(this).val());
		    var quantity = parseInt($(".product_count").eq(index).val());
		    product_total_price += (price * quantity);
		});
	// 	alert("총금액 !!!: " + quantity);
	});	
	// 결제 수단 변수
	var selectedPgValue;
	//*****************************************************
	function check(pg) {
		selectedPgValue = pg.value;
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
	
	console.log(merchantUid);
	// API 초기화 : 포트원 API를 사용하기 위해 초기화
	var IMP = window.IMP;
	IMP.init("imp65336711");
	var selectedValue = $('input[type="radio"]:checked').val();
	
	function requestPay() {
		
		IMP.request_pay({
	      pg: selectedPgValue,
	      pay_method: "card",
	      merchant_uid: merchantUid,   // 주문번호
	      name: product_name,   // 결제 대상 제품명
	      amount: product_total_price,  // 숫자 타입
	      buyer_email: member_email, // 결제 email MemberVO
	      buyer_name: member_name,  // 주문자 명 MemberVO 
	      buyer_tel: member_phone // 연락처 MemberVO
	    }, function (rsp) { // callback
	      //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
	      if (rsp.success) {
		      // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
		      // jQuery로 HTTP 요청
		      $.ajax({
		    	<%--결제 정보--%>
		        url: "PaymentEndpoint", 
		        type: "POST",
		        headers: { "Content-Type": "application/json" },
		        data: JSON.stringify({
		          imp_uid: rsp.imp_uid,            // 결제 고유번호
		          payment_name: rsp.merchant_uid,   // 주문번호
		          payment_card_name: "kakaopay",
		          product_id: product_id,
		          payment_total_price: product_total_price,
		          product_name: product_name,
		          quantity: quantity,
		          member_id: member_id,
		          type: $(".type").val()
		        })
		      }).done(function (data) {
                 location.href="PaymentSuccess?payment_name="+ merchantUid;
		        
		      })
		    } else {
		    	alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
		    	location.href="PaymentFail";
		    }
	    }); // AJAX 끝
	 }  // function requestPay() 끝
	 
	 $(function() {
		<%-- 뒤로가기 방지 --%>
		if (performance.navigation.type === 2) { <%-- 0 : 처음 로딩/새로고침, 1 : 페이지가 앞/뒤로 이동, 2 : 페이지가 뒤로 이동  --%>
			alert('비정상적인 접근입니다.\n스토어 페이지로 이동합니다.');
			location.href = 'store'; //다른 페이지로 이동
		}	
	});
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
							<th colspan="2" class="store_table_box_td">상품명</th>
							<th>판매금액</th>
							<th>수량</th>
							<th>구매금액</th>
						</tr>
						<c:set var="store_total_price" value="0"></c:set>
						<c:forEach var="store" items="${storeList }" varStatus="status">
							<input type="hidden" name="product_id" class="product_id" value="${store.product_id }">
							<input type="hidden" name="product_name" class="product_name" value="${store.product_name }">
		<%-- 						<input type="hidden" name="product_count" class="product_count" value="${store.product_count }"> --%>
							<input type="hidden" name="product_price" class="product_price" value="${store.product_price }">
							<input type="hidden" name="product_txt" class="product_txt" value="${store.product_txt  }">
							<input type="hidden" name="porudct_count" class="product_count" value="${paramValues.product_count[status.index]}">
							<input type="hidden" name="type" class="type" value="${param.type}">
							
							<c:set var="store_total_price" value="${store_total_price + (store.product_price * paramValues.product_count[status.index])}"></c:set>
							<c:set var="store_pay_price" value="${store.product_price * param.product_count}"/>
							<tr class="store_table_box02">
								<td><img src="${pageContext.request.contextPath}/resources/upload/${store.product_img }"></td>
								<td>
									<span >${store.product_name }</span><br> 
									<span id="">${store.product_txt }</span>
								</td>
							    <td><fmt:formatNumber value="${store.product_price}" pattern="###,###"/>원</td>
							    <td>${paramValues.product_count[status.index]}개</td>
							    <td><fmt:formatNumber value="${store.product_price * paramValues.product_count[status.index]}" pattern="###,###"/>원</td>
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
						    <td><fmt:formatNumber value="${store_total_price}" pattern="###,###"/>원 </td>
							<td><img src="${pageContext.request.contextPath}/resources/img/-.png" width="35px" height="35px"></img> </td>
							<td>0원</td>
							<td><img src="${pageContext.request.contextPath}/resources/img/=.png" width="35px" height="35px"></img></td>
							<td class="table_box_red"><fmt:formatNumber value="${store_total_price}" pattern="###,###"/>원</td>
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
							<span><input type="radio" value="html5_inicis"  name=radiocheck onclick="check(this)"><b>신용카드</b></span>
							<span><input type="radio" value="kakaopay" name=radiocheck onclick="check(this)">kakao<b>Pay</b></span>
						</section>
					</div>	
				</div>
				<div class="store_pay_info">
					<div class="store_pay_info_check">
						<input type="checkbox" id="agreeAll" >주문정보/결제 대행 서비스 약관 모두 동의
					</div>
					<div class="store_pay_info_group">
						<div class="info01"><input type="checkbox" name="agree">기프트콘 구매 동의
							<br> <span class="info01_01">&nbsp;&nbsp;&nbsp;기프트콘 발송 및 CS 처리 등을 이해 수신자로부터 영화관에 수신자의 전화번호를 제공하는 것에 대한 적합한 동의를 받습니다.</span>
						</div>
						<div class="info02"><input type="checkbox" id="agree" name="agree"> 결제 대행 서비스 약관 모두 동의 
							<br>&nbsp;&nbsp;<input type="checkbox" id="terms1" name="agree2">전자금융거래 이용약관
							<br>&nbsp;&nbsp;<input type="checkbox" id="terms2" name="agree2">개인정보 수집 이용약관
							<br>&nbsp;&nbsp;<input type="checkbox" id="terms3" name="agree2">개인정보 제공 및 위탁안내
						</div>
					</div>
				</div>
				<div class="paybtn">
						<a href="javascript:history.back()"><input type="button" value="이전화면"></a>
						<input type="button" value="결제하기" onclick="subBtnClick()">
				</div>
			</div>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>