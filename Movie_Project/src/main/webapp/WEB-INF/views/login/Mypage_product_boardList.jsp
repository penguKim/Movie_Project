<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<style>
	.CancleReservation{
		background-color: #F4E4E4!important;
	}

</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
function openPopup(payment_name){
	var width = 700; // 팝업 창의 가로 크기
    var height = 500; // 팝업 창의 세로 크기
    var left = Math.ceil((window.screen.width - width) / 2); // 화면가로중앙에 위치
    var top =  Math.ceil((window.screen.height - height) / 2); // 화면세로중앙에 위치

    var options = "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top;

    window.open("MypageProductListDtail?payment_name="+payment_name, "상품구매상세정보", options);
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
			<h1 id="h01">상품구매 내역 게시판</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			<form action="MypageProductListDtail" method="POST" name="checkform">
				<div id="buy_list">
					<h2>상품 구매내역</h2>
					<table id="my_table1">
						<tr>
							<th width="250">No.</th>
							<th>상품명</th>
							<th>구매일</th>
							<th>상태</th>
							<th>상품 구매 정보</th>
						</tr>
						<c:forEach varStatus="status" var="myStore" items="${myStoreList }" >
							<tr>
								<c:choose>
									<c:when test="${myStore.payment_status eq 0}"><tr class="CancleReservation"></c:when>
									<c:otherwise><tr></c:otherwise>
								</c:choose>
								<td>${myStore.payment_name }</td>
								<td>
								<c:set var="productNames" value="${fn:split(myStore.product_name, ',')}" />
								<c:choose>
								    <c:when test="${fn:length(productNames) eq 1}">
								        <p>${myStore.product_name}</p>
								    </c:when>
								    <c:otherwise>
								        <p>${productNames[0]} 외 ${fn:length(productNames) - 1}개</p>
								    </c:otherwise>
								</c:choose>
								</td>
								<td>${fn:substring(myStore.payment_datetime, 0, 10)}</td>
								<td>
									<c:if test="${myStore.payment_status eq 1}">결제완료</c:if>
									<c:if test="${myStore.payment_status eq 0}">취소완료</c:if>
								</td>
								<td>
									<input type="button" id="stupidButton" value="상세정보" onclick="openPopup('${myStore.payment_name}')">
									<input type="hidden" name="payment_name" value="${myStore.payment_name }">
								</td>
							</tr>
						</c:forEach> 
					</table><br>
					
					<c:set var="pageNum" value="1" />
					<c:if test="${not empty param.pageNum }">
						<c:set var="pageNum" value="${param.pageNum }" />
					</c:if>
					<div class="pagination">
						<c:choose>
							<c:when test="${pageNum eq 1}">
								<a href="" >&laquo;</a>					
							</c:when>
							<c:otherwise>
								<a href="MypageProductboardList?pageNum=${pageNum-1}" >&laquo;</a>
							</c:otherwise>				
						</c:choose>
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<c:choose>
								<c:when test="${pageNum eq i}">
									<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
								</c:when>
								<c:otherwise>
									<a href="MypageProductboardList?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${pageNum eq pageInfo.maxPage}">
								<a href="" >&raquo;</a>					
							</c:when>
							<c:otherwise>
								<a href="MypageProductboardList?pageNum=${pageNum+1}" >&raquo;</a>
							</c:otherwise>				
						</c:choose>
					</div>
				</div>
			</form>	
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>