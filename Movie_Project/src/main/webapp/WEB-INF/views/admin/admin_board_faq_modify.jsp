<%-- admin_board_faq_write.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 관리</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
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
				<form action="adminFaqModifyPro" method="post">
					<table border="1">
						<tr>
							<th>유형</th>
							<td>
							
								<select name="cs_type_detail">
									<option value="">유형선택</option>
									<option value="예매" <c:if test="${faqDetail.cs_type_detail eq '예매'}">selected</c:if>>예매</option>
									<option value="관람권" <c:if test="${faqDetail.cs_type_detail eq '관람권'}">selected</c:if>>관람권</option>
									<option value="할인혜택" <c:if test="${faqDetail.cs_type_detail eq '할인혜택'}">selected</c:if>>할인혜택</option>
									<option value="영화관이용"  <c:if test="${faqDetail.cs_type_detail eq '영화관이용'}">selected</c:if>>영화관이용</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><input type="text" name="member_id" value="${sessionScope.sId}" readonly></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" name="cs_subject" value="${faqDetail.cs_subject}"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea rows="15" cols="90" name="cs_content">${faqDetail.cs_content}</textarea></td>
							<input type="hidden" name="cs_type" value="자주묻는질문">
							<input type="hidden" name="cs_type_list_num" value="${param.cs_type_list_num}">
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="submit" value="등록">
						<input type="button" value="돌아가기" onclick="history.back()">
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