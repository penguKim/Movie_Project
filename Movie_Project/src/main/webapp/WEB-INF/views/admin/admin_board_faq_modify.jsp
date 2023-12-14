<%-- admin_board_faq_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 수정</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function btnMod() {
		var result = confirm("자주 묻는 질문을 수정하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	
	function btnDlt() {
		var result = confirm('자주 묻는 질문을 삭제하시겠습니까?');
		if(result) {
			location.href = "adminFaq";
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
			<h1 id="h01">자주 묻는 질문 글 수정</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			<div id="admin_sub">
				<table border="1" id="">
					<tr>
						<th>번호</th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th>유형</th>
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
						<th height="400">내용</th>
						<td><textarea></textarea></td>
					</tr>
					<tr>
						<th>사진첨부</th>
						<td><input type="file"></td>
					</tr>
				</table>
				<div id="admin_writer"> 
					<input type="button" value="수정" onclick="btnMod()">
					<input type="button" value="돌아가기" onclick="history.back()">
					<input type="button" value="삭제" onclick="btnDlt()">
				</div>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>