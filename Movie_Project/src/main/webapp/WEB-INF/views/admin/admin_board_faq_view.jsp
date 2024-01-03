<%-- admin_board_faq_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 관리</title>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>	
	function confirmDelete() {
		if(confirm("삭제하시겠습니까?")) {
			location.href="adminFaqDelete?cs_type=${faqDetail.cs_type}&cs_type_list_num=${faqDetail.cs_type_list_num}&pageNum=${param.pageNum}";
		}
	}
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
			<h1 id="h01">자주 묻는 질문 관리</h1>
			<hr>		
			<div id="admin_sub">
				<form action="adminFaqModifyForm?cs_type=${faqDetail.cs_type}&cs_type_list_num=${faqDetail.cs_type_list_num}&pageNum=${param.pageNum}" method="post">
					<table border="1">
						<tr>
							<th width="100px">번호</th>
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
							<th>내용</th>
							<td><pre id="content_table">${faqDetail.cs_content}</pre></td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="submit" value="수정">
						<a href="adminFaq?pageNum=${param.pageNum}"><input type="button" value="돌아가기"></a>
						<a href="javascript:confirmDelete()"><input type="button" value="삭제"></a>
					</div>
				</form>
			</div>
		</section>
	</div>
</body>
</html>