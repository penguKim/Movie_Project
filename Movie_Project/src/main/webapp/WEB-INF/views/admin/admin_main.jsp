<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
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
			<h1 id="h01">관리자페이지 메인</h1>
			<hr>
			<div id="admin_main">
				<div id="admin_search">
					<%-- 검색 기능을 위한 폼 생성 --%>
					<form>
						<input type="text" name="searchValue" placeholder="유형, 제목으로 검색">
						<input type="submit" value="검색">
					</form>
				</div>
				
				<table border="1">
					<thead>
						<tr>
							<th width="50">번호</th>
							<th width="100">유형</th>
							<th>제목</th>
							<th width="120">등록일</th>
						</tr>
					</thead>					
					<tbody>	
						
					</tbody>
				</table>
				<div id="admin_writer">
					<a href="adminFaqWriteForm"><input type="button" value="글쓰기"></a>
				</div>
				<div class="pagination">
					
				</div>
			</div>
		</section>
	</div>
</body>
</html>