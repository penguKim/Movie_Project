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
<!-- 결제 API 포트원 SDK 코드 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
	
	// API 초기화 : 포트원 API를 사용하기 위해 초기화
	var IMP = window.IMP;
	IMP.init("imp65336711");
	
	function requestPay() {
	    IMP.request_pay({
	      pg: "kakaopay",
	      pay_method: "card",
	      merchant_uid: "ORD20180131-0000011",   // 주문번호
	      name: "시네마 패키지",   // 결제 대상 제품명
	      amount: 30000,                         // 숫자 타입
	      buyer_email: "gildong@gmail.com", // 결제 email MemberVO
	      buyer_name: "홍길동",  // 주문자 명 MemberVO 
	      buyer_tel: "010-4242-4242", // 연락처 MemberVO
	      buyer_addr: "서울특별시 강남구 신사동", // 주소 MemberVO
	      buyer_postcode: "01181" // 우편번호 
	    }, function (rsp) { // callback
	      //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
	      if (rsp.success) {
		      // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
		      // jQuery로 HTTP 요청
		      $.ajax({
		    	<%-- 결제 정보 --%>
		        url: "PaymentEndpoint", 
		        method: "POST",
		        headers: { "Content-Type": "application/json" },
		        data: {
		          imp_uid: rsp.imp_uid,            // 결제 고유번호
		          merchant_uid: rsp.merchant_uid   // 주문번호
		        }
		        
		      }).done(function (data) {
		        // 가맹점 서버 결제 API 성공시 로직
		        
		        
		      })
		    } else {
		      alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
		    }
	      
	    });
	  }
	
	
</script>
</head>
<body>
	<form action="butPayment">
		<input type="button" value="결제하기" onclick="requestPay()">
	</form>
</body>
</html>






























