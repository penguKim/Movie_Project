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
	<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1 로 저장) --%>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	
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
			
			<form name="checkform">
				<div id="my_list">
					<h2>1대1문의 내역 조회</h2>
					<table id="my_table1">
						<tr>
							<th>제목</th>
							<th width="150">문의 유형</th>
							<th width="100">등록일</th>
						</tr>
						
						<c:forEach var="ooo" items="${myOneOnOneList }">
							<tr id="move_menu">
								<c:set var="cs_subject" value="${ooo.cs_subject }"/>
								<c:choose>
									<c:when test="${fn:length(cs_subject) > 30 }">
										<td><a href="Mypage_OneOnOneDetail?cs_id=${ooo.cs_id }">${fn:substring(cs_subject, 0, 28) }...</a></td>
									</c:when>
									<c:otherwise>
										<td><a href="Mypage_OneOnOneDetail?cs_id=${ooo.cs_id }">${ooo.cs_subject }</a></td>
									</c:otherwise>
								</c:choose>
								<td>${ooo.cs_type_detail }</td>
								<td>${ooo.cs_date }</td>
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