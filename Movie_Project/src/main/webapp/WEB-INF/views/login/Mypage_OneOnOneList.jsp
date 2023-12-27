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
			<h1 id="h01">나의 게시글</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form action="Mypage_OneOnOneDetail" method="post" name="checkform">
				<div id="my_list">
					<h2>1대1문의 내역 조회</h2>
					<table id="my_table1">
						<tr>
<!-- 							<th>No.</th> -->
							<th>제목</th>
							<th width="200">문의 내용</th>
							<th width="85">등록일</th>
<!-- 							<th width="80">더보기</th> -->
						</tr>
						
						<c:forEach var="ooo" items="${myOneOnOneList }">
							<tr id="move_menu">
<%-- 								<td>${ooo.cs_type_list_num }</td> --%>
								<td><a href="Mypage_OneOnOneDetail?cs_id=${ooo.cs_id }">${ooo.cs_subject }</a></td>
								<c:set var="cs_content" value="${ooo.cs_content }"/>
								<c:choose>
									<c:when test="${fn:length(cs_content) > 13 }">
										<td><a href="Mypage_OneOnOneDetail?cs_id=${ooo.cs_id }">${fn:substring(cs_content, 0, 11) }...</a></td>
									</c:when>
									<c:otherwise>
										<td><a href="Mypage_OneOnOneDetail?cs_id=${ooo.cs_id }">${ooo.cs_content }</a></td>
									</c:otherwise>
								</c:choose>
								<td>${ooo.cs_date }</td>
<!-- 								<td> -->
<!-- 									<input type="submit" value="상세정보"> -->
									<%-- cs_id 오류 해결 미완 --%>
<!-- 								</td> -->
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