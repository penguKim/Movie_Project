<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1 : 1 문의 관리</title>
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
			<h1 id="h01">1 : 1 문의 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<form action="">
					<table border="1">
						<tr>
							<th width="60">번호</th>
							<th width="120">유형</th>
							<th>제목</th>
							<th width="100">작성자</th>
							<th width="120">등록일</th>
							<th width="95">답변상태</th>
						</tr>
						<tr>
							<td>번호</td>
							<td>칭찬/불만/제안</td>
							<td class="post_name">버튼 클릭시 1대1 문의 상세 페이지</td>
							<td>작성자</td>
							<td>등록일</td>
							<td><a href="adminOneOnOneResp"><input type="button" value="답변완료" id="ok"></a></td>
						</tr>
						<tr>
							<td>번호</td>
							<td>유형</td>
							<td class="post_name">버튼 클릭시 1대1 문의 상세 페이지</td>
							<td>작성자</td>
							<td>등록일</td>
							<td><a href="adminOneOnOneResp"><input type="button" value="답변완료" id="ok"></a></td>
						</tr>
						<tr>
							<td>번호</td>
							<td>유형</td>
							<td class="post_name">버튼 클릭시 1대1 문의 상세 페이지></td>							<td>작성자</td>
							<td>등록일</td>
							<td><a href="adminOneOnOneResp"><input type="button" value="답변완료" id="ok"></a></td>
						</tr>
						<tr>
							<td>번호</td>
							<td>유형</td>
							<td class="post_name">버튼 클릭시 1대1 문의 상세 페이지</td>
							<td>작성자</td>
							<td>등록일</td>
							<td><a href="adminOneOnOneResp"><input type="button" value="답변완료" id="ok"></a></td>
						</tr>
						<tr>
							<td>번호</td>
							<td>유형</td>
							<td class="post_name">버튼 클릭시 1대1 문의 상세 페이지</td>
							<td>작성자</td>
							<td>등록일</td>
							<td><a href="adminOneOnOneResp"><input type="button" value="답변완료" id="ok"></a></td>
						</tr>
						<tr>
							<td>번호</td>
							<td>유형</td>
							<td class="post_name">버튼 클릭시 1대1 문의 상세 페이지</td>
							<td>작성자</td>
							<td>등록일</td>
							<td><a href="adminOneOnOneResp"><input type="button" value="답변완료" id="ok"></a></td>
						</tr>
						<tr>
							<td>번호</td>
							<td>유형</td>
							<td class="post_name">버튼 클릭시 1대1 문의 상세 페이지</td>
							<td>작성자</td>
							<td>등록일</td>
							<td><a href="adminOneOnOneResp"><input type="button" value="답변완료" id="ok"></a></td>
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
				</form>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>