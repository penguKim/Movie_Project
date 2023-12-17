<%-- admin_board_lostnfound_response.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분실물 문의 상세</title>
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
			<h1 id="h01">분실물 문의 상세페이지</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			<div id="admin_sub">
				<form action="boardRgst" method="post">
				<%-- 판별식을 이용해 action 속성값 변경할 예정 --%>
<!-- 				<form action="boardMod" method="post"> -->
<!-- 				<form action="boardDlt" method="post"> -->
				<!-- 서블릿 매핑 미완(등록 : boardRgst, 수정 : boardMod, 삭제 : boardDlt) -->
				<!-- 폼태그 하나에 복수개의 submit 처리가 필요(등록, 수정, 삭제) -->
				<!-- 임시로 action 속성은 boardRgst 로 지정(매핑 확인 용) -->
					<table border="1">
						<tr>
							<th>번호</th>
							<td></td>
						</tr>
						<tr>
							<th>분실장소</th>
							<td></td>
						</tr>
						<tr>
							<th>분실일시</th>
							<td></td>
						</tr>
						<tr>
							<th>문의 제목</th>
							<td></td>
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
						<input type="hidden" name="fileName" value="admin_board_lostnfound_response">	
	<!-- 						<input type="submit" value="답변 수정"> -->
	<!-- 						<input type="submit" value="답변 삭제"> -->
						<input type="submit" value="답변 등록">
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