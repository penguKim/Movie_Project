<%-- admin_board_notice_write.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리</title>
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
			<h1 id="h01">공지사항 관리</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			<div id="admin_sub">
				<form action="adminNoticeModifyPro" method="post" enctype="multipart/form-data">
					<table border="1">
						<tr>
							<th>지점</th>
							<td>${noticeDetail.theater_name}</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><input type="text" name="member_id" value="${sessionScope.sId}" readonly> </td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" name="cs_subject" value="${noticeDetail.cs_subject}"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea rows="15" cols="90" name="cs_content">${noticeDetail.cs_content}</textarea></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td><input type="file" name="mFile"></td>
							<input type="hidden" name="cs_type" value="공지사항">
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