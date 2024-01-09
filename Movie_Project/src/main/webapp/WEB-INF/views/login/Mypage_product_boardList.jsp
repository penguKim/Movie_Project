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
	#resCancleBtn{
		background-color: gray;
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
								<c:choose>
									<c:when test="${myStore.payment_status eq 1}">
									
			<%-- 									<input type="button" id="stupidButton" onclick="storeX(${myStore.payment_id})" value="구매취소"> --%>
										<input type="button" id="stupidButton" value="상세정보" onclick="openPopup('${myStore.payment_name}')">
										<input type="hidden" name="payment_name" value="${myStore.payment_name }">
									
									</c:when>
									<c:otherwise>
										<input type="button" id="resCancleBtn" value="취소완료" onclick="openPopup('${myStore.payment_name}')">
									</c:otherwise>
									</c:choose>
			<!-- 							<td><input type="button" value="구매취소"></td> -->
								</td>
							</tr>
						</c:forEach> 
					</table><br>
					
					<c:set var="pageNum" value="1" />
					<c:if test="${not empty param.pageNum }">
						<c:set var="pageNum" value="${param.pageNum }" />
					</c:if>
					
					<div class="pagination">
						<%-- '<<' 버튼 클릭 시 현체 페이지보다 한 페이지 앞선 페이지 요청 --%>
						<%-- 다만, 페이지 번호가 1일 경우 비활성화 --%>		
						<c:choose>
							<c:when test="${pageNum eq 1}">
								<a href="" >&laquo;</a>					
							</c:when>
							<c:otherwise>
								<a href="MypageProductboardList?pageNum=${pageNum-1}" >&laquo;</a>
							</c:otherwise>				
						</c:choose>
						<%-- 현재 페이지가 저장된 pageInfo 객체를 통해 페이지 번호 출력 --%>
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<%-- 각 페이지마다 하이퍼링크 설정(페이지번호를 pageNum 파라미터로 전달) --%>
							<%-- 단, 현재 페이지는 하이퍼링크 제거하고 굵게 표시 --%>
							<c:choose>
								<%-- 현재 페이지번호와 표시될 페이지번호가 같을 경우 판별 --%>
								<c:when test="${pageNum eq i}">
									<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
								</c:when>
								<c:otherwise>
									<a href="MypageProductboardList?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<%-- '>>' 버튼 클릭 시 현체 페이지보다 한 페이지 다음 페이지 요청 --%>
						<%-- 다만, 페이지 번호가 마지막 경우 비활성화 --%>		
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