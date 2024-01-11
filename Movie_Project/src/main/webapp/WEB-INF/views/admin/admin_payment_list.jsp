<%-- admin_payment.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	
	//무한스크롤 기능에 활용될 페이지번호 변수 선언(초기값 1)
	let pageNum = "1";
	let maxPage = "";
	$(function() {
		
		load_list();
		$(window).scroll(function() {
			// 1. window 객체와 document 객체를 활용하여 스크롤 관련 값 가져오기
			let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
			let windowHeight = $(window).height(); // 브라우저 창높이
			let documentHeight = $(document).height(); // 문서 높이
			// 2. 스크롤 바 위치값  + 창 높이 + X 값이 문서 전체 높이 이상일 경우
			//    다음 페이지 게시물 목록 로딩하여 화면에 추가
			if(scrollTop + windowHeight + 30 >= documentHeight) {
				pageNum++;
				if(maxPage != "" && pageNum <= maxPage) {
					load_list();
				}
			}
		});
	});
	
	function load_list() {
		let searchType = $("#searchType").val();
		let searchKeyword = $("#searchKeyword").val();
		
		$.ajax({
			type: "GET",
			url: "adminPaymentList",
			data: {
				searchType: searchType,
				searchKeyword: searchKeyword,
				pageNum: pageNum
			},
			dataType: "json",
			success: function(data) {
				for(let payment of data.paymentList) {
					
					var products = payment.product_name.split(",");
					var firstProduct = products[0];
					var endNumber = Number(products.length - 1);
					var product_name = "";
					if (endNumber > 0) {
						product_name = products[0] + " 외 " + endNumber + "개";
					} else {
						product_name = products[0];
					}
					
					$("table").append(function() {
						var html = '<tr>'
						+ '<td>' + payment.payment_name + '</td>'
						+ '<td>' + product_name + '</td>'
						+ '<td>' + payment.member_id + '</td>'
						+ '<td>' + payment.payment_datetime.substring(0, 10) + '</td>'
						+ '<td class="payment_status">';
						
						if (payment.payment_status === 0) {
						  html += '<span id="payment_Cstatus">결제취소</span>';
						} else if (payment.payment_status === 1) {
						  html += '<span id="payment_Bstatus">결제완료</span>';
						} 
						
						html += '</td>'
						  + '<td>'
						  + '<a href="adminPaymentDtl?payment_name=' + payment.payment_name + '" id="ok">'
						  + '<input type="button" value="상세보기" id="ok">'
						  + '</a>'
						  + '</td>'
						  + '</tr>';
						  
						return html;
					});
				}
				// 끝페이지 번호(maxPage) 값을 변수에 저장
				maxPage = data.maxPage;
			},
			error: function() {
				alert("게시물 요청 실패!");
			}
		}); // ajax 끝
	} // load_list() 함수 끝
	
</script>
</head>
<body>
	<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1 로 저장) --%>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	<div id="wrapper">
		<nav id="navbar">
            <jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
        </nav>
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
		<section id="content">
			<h1 id="h01">스토어 결제 관리</h1>
			<hr>
			<div id="admin_main">
				<div id="pay_Search">
					<form action="" >
						<select name="searchType" id="searchType">
							<option value="id" <c:if test="${param.searchType eq 'id'}">selected</c:if>>회원아이디</option>
							<option value="name" <c:if test="${param.searchType eq 'name'}">selected</c:if>>상품이름</option> 
						</select>
						<input type="text" name="searchKeyword" id="searchKeyword" placeholder="조회할 내용 입력" value="${param.searchKeyword }">
						<input type="submit" value="조회">
					</form>
				</div>
				<table border="1" width="1000">
					<tr>
						<th>주문번호</th>
						<th>상품이름</th>
						<th width="250">회원ID</th>
						<th>결제일시</th>
						<th>결제상태</th>
						<th>결제내역 상세보기</th>
					</tr>
				</table>
			</div>
		</section>
	</div>
</body>
</html>
