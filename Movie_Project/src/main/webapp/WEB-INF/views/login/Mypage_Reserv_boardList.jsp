<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<style type="text/css">
	#stupidButton{
		background-color: gray;
	}
	#textSmall td{
		font-size: 10px;
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	function openPopup(){
		
		var payment_id = $(".payment_id").val();
		
		var width = 700; // 팝업 창의 가로 크기
	    var height = 500; // 팝업 창의 세로 크기
	    var left = Math.ceil((window.screen.width - width) / 2); // 화면가로중앙에 위치
	    var top =  Math.ceil((window.screen.height - height) / 2); // 화면세로중앙에 위치

	    var options = "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top;

        window.open("resInfoDetailPro?payment_id="+payment_id, "예매상세정보", options);
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
			<h1 id="h01">나의 예매내역 게시판</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form onsubmit="openPopup()">
				<div id="my_list">
					<h2>영화 예매내역</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>영화이름</th>
							<th>구매일</th>
							<th>결제금액</th>
							<th>상태</th>
							<th>비고</th>
						</tr>
						<c:forEach var="reslist" items="${resList}">
						<div id="textSmall">
						<tr>
							<td>${reslist.payment_id}</td>
							<td>${reslist.movie_title}</td>
							<td>${fn:replace(reslist.payment_datetime, 'T', '<br>')}</td>
							<td>${reslist.payment_total_price}</td>
							<td>
								<c:if test="${reslist.payment_status eq 1}">결제완료</c:if>
								<c:if test="${reslist.payment_status eq 0}">취소완료</c:if>
							</td>
							<td>
								<input type="hidden" class="payment_id" value="${reslist.payment_id}">
								<input type="submit" value="상세정보" class="resInfoDetail">
							</td>
						</tr>
						</div>
						</c:forEach>
					</table><br>
								
					<div class="pagination">
						<a href="#">&laquo;</a>
						<a href="#">1< /a>
						<a class="active" href="#">2</a>
						<a href="#">3</a>
						<a href="#">4</a>
						<a href="#">5</a>
						<a href="#">&raquo;</a>
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