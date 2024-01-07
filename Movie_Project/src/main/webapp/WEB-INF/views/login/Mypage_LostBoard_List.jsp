<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분실물 문의 게시판</title>
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
			<h1 id="h01">분실물 문의 게시판</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form action="Mypage_LostBoard_List" method="get" name="checkform">
				<div id="my_list">
					<h2>분실물 문의</h2>
					<table id="my_table1">
						<tr>
							<th>No</th>
							<th>제목</th>
							<th>지점명</th>
							<th>등록일</th>
						</tr>
						
					<c:forEach var="myLost" items="${myLost}" varStatus="status">
						<tr>
							<td>${myLost.cs_id}</td>
							<td><a href="Mypage_LostBoardDetail?cs_id=${myLost.cs_id }">${myLost.cs_subject }</a></td>
							<td>${myLost.theater_name }</td>
							<td>${myLost.cs_date }</td>
						</tr>
					</c:forEach>						
					</table><br>
				</div>
							
							
			</form>
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
	
</body>
</html>