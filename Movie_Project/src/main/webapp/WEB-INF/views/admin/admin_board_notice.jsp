<%-- admin_board_notice.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리</title>
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
			<h1 id="h01">공지사항 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<table border="1">
					<tr>
						<th width="60">번호</th>
						<th>제목</th>
						<th width="100">작성자</th>
						<th width="120">등록일</th>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
					<tr>
						<td>1</td>
						<td class="post_name"><a href="adminNoticeDtl">클릭시 공지사항 상세페이지로 이동</a></td>
						<td>아이유</td>
						<td>2023-11-16</td>
					</tr>
				</table>
				<div id="admin_writer">
					<a href="adminNoticeWrt"><input type="button" value="글쓰기"></a>
				</div>
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