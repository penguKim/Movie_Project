<%-- admin_payment.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
</script>
</head>
<body>
	<div id="wrapper">
		<nav id="navbar">
            <jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
        </nav>
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
		<section id="content">
			<h1 id="h01">스토어 상품 관리</h1>
			<hr>
			
			<div id="admin_main">
				<form action="">
					<div id="pay_Search">
						<input type="text" name="searchKeyword" placeholder="상품명을 입력하세요" value="${param.searchKeyword }">
						<input type="submit" value="조회">
						<input type="button" value="상품 등록" onclick = "location.href='adminProductWrite'">
					</div>
				</form>
				<table border="1" width="1100">
					<tr>
						<th>상품번호</th>
						<th width="250">상품명</th>
						<th width="500">상품설명</th>
						<th>상품가격</th>
						<th>상품 상세보기</th>
					</tr>
					<c:forEach var="store" items="${storeList}">
						<tr>
							<td>${store.product_id}</td>
							<td>${store.product_name}</td>
							<td>${store.product_txt}</td>
							<td><fmt:formatNumber value="${store.product_price}" pattern="#,##0" />원</td>
							<td><a href="adminProductDtl?product_id=${store.product_id}"><input type="button" value="상세보기"></a></td>
						</tr>
					</c:forEach>
				</table>
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
							<a href="adminProduct?pageNum=${pageNum-1}" >&laquo;</a>
						</c:otherwise>				
					</c:choose>
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<c:choose>
							<c:when test="${pageNum eq i}">
								<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
							</c:when>
							<c:otherwise>
								<a href="adminProduct?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${pageNum eq pageInfo.maxPage}">
							<a href="" >&raquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminProduct?pageNum=${pageNum+1}" >&raquo;</a>
						</c:otherwise>				
					</c:choose>
				</div>
			</div>
		</section>
	</div>
</body>
</html>
