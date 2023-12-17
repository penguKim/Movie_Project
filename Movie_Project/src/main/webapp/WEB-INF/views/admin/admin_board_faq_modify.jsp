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
				<form action="boardMod" method="post">
				<%-- 판별식을 이용해 action 속성값 변경할 예정 --%>
<!-- 				<form action="boardDlt" method="post"> -->
				<!-- 서블릿 매핑 미완(수정 : boardMod, 삭제 : boardDlt) -->
				<!-- 폼태그 하나에 복수개의 submit 처리가 필요(수정, 삭제) -->
				<!-- 임시로 action 속성은 boardMod 로 지정(매핑 확인 용) -->
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
						<input type="hidden" name="fileName" value="admin_board_faq_modify">	
						<input type="submit" value="수정">
						<input type="button" value="돌아가기" onclick="history.back()">
						<input type="submit" value="삭제">
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