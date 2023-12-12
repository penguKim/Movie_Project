<%-- admin_board_one_on_one_response.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1 : 1 문의 상세</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">1 : 1 문의 상세페이지</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>

			<div id="admin_sub">
				<form action="">
					<table border="1">
						<tr>
							<th>번호</th>
							<td></td>
						</tr>
						<tr>
							<th>문의 제목</th>
							<td>문의 제목입니다</td>
						</tr>
						<tr>
							<th>문의 작성자</th>
							<td></td>
						</tr>
						<tr>
							<th height="300">문의 내용</th>
							<td></td>
						</tr>
						<tr>
							<th>사진 첨부</th>
							<td><input type="file"></td>
						</tr>
						<tr>
							<th>답변 제목</th>
							<td></td>
						</tr>
						<tr>
							<th>답변 작성자</th>
							<td></td>
						</tr>
						<tr>
							<th height="300">답변 내용</th>
							<td></td>
						</tr>
					</table>
					<div id="admin_writer"> 
<!-- 						<input type="submit" value="답변 수정" onclick="confirm('수정 내용을 등록하시겠습니까?')")> -->
						<input type="submit" value="답변 등록" onclick="confirm('답변을 등록하시겠습니까?')")>
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