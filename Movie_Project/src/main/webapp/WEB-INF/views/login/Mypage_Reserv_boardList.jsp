<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function(){
		$("#resCancleBtn").click(function(){
			if(confirm("선택하신 예매내역을 취소하시겠습니까?")){
				return true;
			}else{
				return false;
			}
		});
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
			<h1 id="h01">나의 예매내역 게시판</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form action="resCancle" method="post" name="checkform">
				<div id="my_list">
					<h2>영화 예매내역</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>영화제목</th>
							<th>극장정보</th>
							<th>상영일정</th>
							<th>좌석</th>
							<th>상태</th>
							<th>비고</th>
						</tr>
						<c:forEach var="reslist" items="${resList}">
						<tr>
							<td>${reslist.payment_id}<input type="hidden" name="payment_id" value="${reslist.payment_id}"></td>
							<td>${reslist.movie_title}</td>
							<td>${reslist.theater_name}<br>${reslist.room_name}</td>
							<td>${reslist.play_start_time}</td>
							<td>${reslist.seat_name}<input type="hidden" name="seat_id" value="${reslist.seat_id}"></td>
							<td>
								<c:if test="${reslist.payment_status eq 1}">결제완료</c:if>
								<c:if test="${reslist.payment_status eq 0}">취소완료</c:if>
							</td>
							<td>
								<c:choose>
									<c:when test="${reslist.payment_status eq 0}"><input type="button" id="stupidButton" value="예매취소"></c:when>
									<c:otherwise><input type="submit" id="resCancleBtn" value="예매취소"></c:otherwise>
								</c:choose>
							</td>
						</tr>
						</c:forEach>
					</table><br>
								
					<div class="pagination">
						<a href="#">&laquo;</a>
						<a href="#">1</a>
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