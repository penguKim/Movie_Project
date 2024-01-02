<%-- admin_board_faq_write.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 관리</title>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
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
				<form action="adminFaqWritePro" method="post">
					<table border="1">
						<tr>
							<th width="90px">유형</th>
							<td>
								<select id="select" name="cs_type_detail">
									<option value="">유형선택</option>
									<option value="예매">예매</option>
									<option value="관람권">관람권</option>
									<option value="할인혜택">할인혜택</option>
									<option value="영화관이용">영화관이용</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><input type="text" id="id" name="member_id" value="${sessionScope.sId}" readonly></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" id="subject" name="cs_subject"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea id="textarea" name="cs_content"></textarea></td>
							<input type="hidden" name="cs_type" value="자주묻는질문">
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="submit" value="등록">
						<input type="button" value="돌아가기" onclick="history.back()">
					</div>
				</form>
			</div>
		</section>
	</div>
</body>
</html>