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
<script src="../js/jquery-3.7.1.js"></script>
<script type="text/javascript">

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
			
			<form action="Reserv_board" method="get" name="checkform">
				<div id="my_list">
					<h2>영화 예매내역</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>영화제목</th>
							<th>영화극장 정보</th>
							<th>상태</th>
							<th>예매 내역 정보</th>
						</tr>
						
						<tr>
							<td>[예매순번]</td>
							<td>[영화제목]</td>
							<td>[영화관 / 좌석번호]</td>
							<td>[예매완료]</td>
							<td><input type="button" value="예매상세정보"></td>
						</tr>
						
						<tr>
							<td>[예매순번]</td>
							<td>[영화제목]</td>
							<td>[영화관 / 좌석번호]</td>
							<td>[예매완료]</td>
							<td><input type="button" value="예매상세정보"></td>
						</tr>
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