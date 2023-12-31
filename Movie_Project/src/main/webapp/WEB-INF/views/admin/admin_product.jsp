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
<title>스토어 상품 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">스토어 상품 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<form action="">
					<div id="pay_Search">
						<select name="searchType">
							<option value="pro_id" <c:if test="${param.searchType eq 'pro_id'}">selected</c:if>>상품번호</option> 
							<option value="pro_name" <c:if test="${param.searchType eq 'pro_name'}">selected</c:if>>상품명</option>
						</select>
						<input type="text" name="searchKeyword" placeholder="조회할 내용 입력">
						<input type="submit" value="조회">
						<input type="button" value="상품 등록" onclick = "location.href='adminProductWrite'">
					</div>
				</form>
				<table border="1" width="1100">
					<tr>
						<th>상품번호</th>
						<th>상품명</th>
						<th>상품설명</th>
						<th>상품가격</th>
						<th>상품 상세보기</th>
					</tr>
					<c:forEach var="store" items="${storeList}">
						<tr>
							<td>${store.product_id}</td>
							<td>${store.product_name}</td>
							<td>${store.product_txt}</td>
							<td>${store.product_price}원</td>
							<td><a href="adminProductDtl?product_id=${store.product_id}"><input type="button" value="상세보기"></a></td>
						</tr>
					</c:forEach>
				</table>
				<input type="button" value="이전"
					onclick="location.href = 'adminProduct?pageNum=${pageNum - 1}'"
					<c:if test="${pageNum <= 1 }">disabled</c:if>>
				<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
					<%-- 각 페이지마다 하이퍼링크 설정(페이지번호를 pageNum 파라미터로 전달) --%>
					<%-- 단, 현재 페이지는 하이퍼링크 제거하고 굵게 표시 --%>
					<c:choose>
						<%-- 현재 페이지번호와 표시될 페이지번호가 같을 경우 판별 --%>
						<c:when test="${pageNum eq i }">
							<b>${i }</b> <%-- 현재 페이지 번호 --%>
						</c:when>
						<c:otherwise>
							<a href="adminProduct?pageNum=${i }">${i }</a> <%-- 다른 페이지 번호 --%>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<input type="button" value="다음" 
					onclick="location.href = 'adminProduct?pageNum=${pageNum + 1}'"
					<c:if test="${pageNum >= pageInfo.maxPage }">disabled</c:if>>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>
