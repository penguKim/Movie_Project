<%-- admin_board_notice_write.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function btnWrt() {
		var result = confirm("공지사항을 등록하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">공지사항 글 등록</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>

			<div id="admin_sub">
				<table border="1">
					<tr>
						<th>번호</th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea></textarea></td>
					</tr>
					<tr>
						<th>사진첨부</th>
						<td><input type="file"></td>
					</tr>
				</table>
				<div id="admin_writer"> 
					<input type="button" value="등록" onclick="btnWrt()">
					<input type="button" value="돌아가기" onclick="history.back()">
				</div>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>		
</body>
</html>