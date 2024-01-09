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
			<div id="mypage_nav"> <%-- 사이드 메뉴바 처리 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form action="Mypage_LostBoard_List" method="get" name="checkform">
				<div id="my_list">
					<h2>분실물 문의</h2>
					<table id="MyOneOnOneTable">
						<tr>
							<th>제목</th>
							<th width="150">지점명</th>
							<th width="100">등록일</th>
						</tr>
							<c:choose>
								<c:when test="${empty myOneOnOneList }">
									<tr>
										<td colspan="3">분실물문의 내역이 존재하지 않습니다.</td>
									</tr>								
								</c:when>
								<c:otherwise>
									<c:forEach var="myLostBoardList" items="${myLostBoardList}" varStatus="status">
										<tr>
											<td id="myLostBoardList"><a href="Mypage_LostBoardDetail?cs_id=${myLostBoardList.cs_id }">${myLostBoardList.cs_subject }</a></td>
											<td>${myLostBoardList.theater_name }</td>
											<td>${myLostBoardList.cs_date }</td>
										</tr>
									</c:forEach>				
								</c:otherwise>
							</c:choose>
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
							<a href="Mypage_LostBoard_List?pageNum=${pageNum-1}" >&laquo;</a>
						</c:otherwise>				
					</c:choose>
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<c:choose>
							<c:when test="${pageNum eq i}">
								<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
							</c:when>
							<c:otherwise>
								<a href="Mypage_LostBoard_List?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${pageNum eq pageInfo.maxPage}">
							<a href="" >&raquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="Mypage_LostBoard_List?pageNum=${pageNum+1}" >&raquo;</a>
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