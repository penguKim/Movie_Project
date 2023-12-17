<%-- admin_board_lostnfound.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분실물 문의 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
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
			<h1 id="h01">분실물 문의 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			<div id="admin_main">
				<table border="1">
					<tr>
						<th width="70">번호</th>
						<th width="120">분실장소</th>
						<th>제목</th>
						<th width="100">작성자</th>
						<th width="120">등록일</th>
						<th width="95">답변상태</th>
					</tr>
					<tr>
						<td>번호</td>
						<td>지점명A</td>
						<td class="post_name">버튼클릭시 분실물문의상세로이동</td>
						<td>작성자</td>
						<td>등록일</td>
						<td><a href="adminLostNFoundResp"><input type="button" value="답변하기" id="ok"></a></td>
					</tr>
					<tr>
						<td>번호</td>
						<td>유형</td>
						<td class="post_name">버튼클릭시 분실물문의상세로이동</td>
						<td>작성자</td>
						<td>등록일</td>
						<td><a href="adminLostNFoundResp"><input type="button" value="답변하기" id="ok"></a></td>
					</tr>
					<tr>
						<td>번호</td>
						<td>유형</td>
						<td class="post_name">버튼클릭시 분실물문의상세로이동</td>
						<td>작성자</td>
						<td>등록일</td>
						<td><a href="adminLostNFoundResp"><input type="button" value="답변하기" id="ok"></a></td>
					</tr>
					<tr>
						<td>번호</td>
						<td>유형</td>
						<td class="post_name">버튼클릭시 분실물문의상세로이동</td>
						<td>작성자</td>
						<td>등록일</td>
						<td><a href="adminLostNFoundResp"><input type="button" value="답변하기" id="ok"></a></td>
					</tr>
					<tr>
						<td>번호</td>
						<td>유형</td>
						<td class="post_name">버튼클릭시 분실물문의상세로이동</td>
						<td>작성자</td>
						<td>등록일</td>
						<td><a href="adminLostNFoundResp"><input type="button" value="답변하기" id="ok"></a></td>
					</tr>
					<tr>
						<td>번호</td>
						<td>유형</td>
						<td class="post_name">버튼클릭시 분실물문의상세로이동</td>
						<td>작성자</td>
						<td>등록일</td>
						<td><a href="adminLostNFoundResp"><input type="button" value="ㅌ" id="ok"></a></td>
					</tr>
				</table>
				<div class="pagination">
					<a href="#">&laquo;</a>
					<a href="#">1</a>
					<a class="active" href="#">2</a>
					<a href="#">3</a>
					<a href="#">4</a>
					<a href="#">5</a>
					<a href="#">&raquo;</a>
				</div>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>