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
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
function openPopup(index){
	var payment_id = document.getElementById("payment_id_" + index).value;
// 	var payment_id = $(".payment_id").val();
	var width = 700; // 팝업 창의 가로 크기
    var height = 500; // 팝업 창의 세로 크기
    var left = Math.ceil((window.screen.width - width) / 2); // 화면가로중앙에 위치
    var top =  Math.ceil((window.screen.height - height) / 2); // 화면세로중앙에 위치

    var options = "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top;
       window.open("refundInfoDetailPro?payment_id="+payment_id, "취소상세정보", options);
       
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
			<h1 id="h01">환불내역</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
						

			<!-- 바디부분 상단 -->
			<form onsubmit="openPopup()">
				<div id="refund_list">
					<h2>예매 취소내역</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>영화 제목</th>
							<th>예매취소일</th>
							<th>결제금액</th>
							<th>상태</th>
							<th>비고</th>
						</tr>
<%-- 					<c:if test="${not empty reserveList}"> --%>
<%-- 					<c:set var="maxCount" value="${fn:length(reserveList)}" /> --%>
<%-- 						<c:forEach var="i" begin="0" end="${fn:length(reserveList)}"> --%>
					<c:if test="${not empty reserveList}">
						<c:forEach varStatus="status" var="reserveList" items="${reserveList }" begin="0" end="${fn:length(reserveList)}">
							<tr>					
								<td>${reserveList.payment_id}</td>
								<td><a href="detail?movie_id=${reserveList.movie_id }">${reserveList.movie_title}</a></td>
								<td>${fn:replace(reserveList.payment_datetime, 'T', ' ')}</td>
<%-- 								<td>${reserveList.payment_total_price}</td> --%>
								<td><fmt:formatNumber value="${reserveList.payment_total_price}" pattern="###,###"/></td>
									<!-- 이게 0 이면 환불 완료 처리할 예정 -->
<%-- 								<td>${reserveList.payment_status }</td> --%>
								<td>[취소완료]</td>
								<td>
								<input type="hidden" class="payment_id" id="payment_id_${status.index}" value="${reserveList.payment_id}">
								<input type="submit" value="상세정보" class="resInfoDetail" onclick="openPopup(${status.index})">
								</td>
							</tr>
						</c:forEach>	
					</c:if>
					<c:if test="${empty reserveList}">
						<td colspan="4">취소 내역이 없습니다.</td>
					</c:if>
					</table><br>
				</div>
				<div id="refund_info">
					<h2>환불 안내서</h2>
					<table id="my_table1">
						<tr>
							<td>인터넷 예매시에는 예매매수의 전체환불 및 교환만 가능합니다. 
								인터넷 예매분에 대해 교환환불 및 취소하고자 하실 경우,
								예매하신 내역 전체에 대해 취소 후
								새로 예매를 하시거나 해당 영화관을 방문하셔서 처리하셔야 합니다. 
								
								1) 인터넷상 취소 가능시간 (상영시간 20분전까지만 가능) 
								 - 전체 취소가능하며, 부분 취소 불가
								 EX) 인원수, 관람자, 시간변경은 모두 취소 후 재예매 해주셔야합니다.
								
								2) 현장 취소 가능시간(상영시간 전까지만 가능) 
								  - 전체환불 및 교환가능 단, 부분환불 및 교환은 사용하신 카드로 전체 취소 후 재결제하셔야 합니다.
							</td>
						</tr>
					</table>
				</div>
			</form>
		</section>
	</div>
		
	<footer>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</footer>
	
<!-- 바디부분 상단 끝 -->
</body>
</html>