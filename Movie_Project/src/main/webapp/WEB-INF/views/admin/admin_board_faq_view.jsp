<%-- admin_board_faq_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 관리</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	$(function() {
		$("#deleteBtn").click(function() {
			if(confirm("삭제하시겠습니까?")) {
				location.href="adminFaqDelete?cs_type=${faqDetail.cs_type}&cs_type_list_num=${faqDetail.cs_type_list_num}&pageNum=${param.pageNum}";
			}
		})
	});
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">자주 묻는 질문 관리</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			<div id="admin_sub">
				<form action="adminFaqModifyForm?cs_type=${faqDetail.cs_type}&cs_type_list_num=${faqDetail.cs_type_list_num}&pageNum=${param.pageNum}" method="post">
					<table border="1">
						<tr>
							<th>번호</th>
							<td>${faqDetail.cs_type_list_num}</td>
						</tr>
						<tr>
							<th>유형</th>
							<td>${faqDetail.cs_type_detail}</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>${faqDetail.cs_subject}</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>
								<fmt:parseDate value='${faqDetail.cs_date}' pattern="yyyy-MM-dd" var='cs_date'/>
								<fmt:formatDate value="${cs_date}" pattern="yyyy-MM-dd"/>
							</td>
						</tr>
						<tr>
							<th height="400">내용</th>
							<td>${faqDetail.cs_content}</td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="submit" value="수정">
						<input type="button" value="돌아가기" onclick="history.back()">
						<input type="button" value="삭제" id="deleteBtn">
					</div>
				</form>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>