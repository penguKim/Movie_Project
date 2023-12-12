<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">자주 묻는 질문 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<nav id="fqa_button">
					<ul>
						<li><a href="#div01"><input type="button" value="전체"></a></li> <%-- 전체 질문 보기 --%>
						<li><a href="#div02"><input type="button" value="예매"></a></li> <%-- 예매 관련 질문 모아보기 --%>
						<li><a href="#div03"><input type="button" value="관람권"></a></li> <%-- 관람권 관련 질문 모아보기 --%>
						<li><a href="#div03"><input type="button" value="할인혜택"></a></li> <%-- 할인 관련 질문 모아보기 --%>
						<li><a href="#div03"><input type="button" value="영화관이용"></a></li> <%-- 영화관 관련 질문 모아보기 --%>
					</ul>
				</nav>
				<form action="" class ="admin_board_notice">
					<table border="1" id="admin_notice">
						<tr>
							<th width="30">번호</th>
							<th width="100">유형</th>
							<th width="370">제목</th>
							<th width="100">작성자</th>
							<th width="120">등록일</th>
						</tr>
						<tr>
							<td>100</td>
							<td>영화관이용</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>admin</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
						<tr>
							<td>1</td>
							<td>관람권</td>
							<td class="post_name"><a href="admin_board_faq_modify.jsp">클릭시 자주묻는질문 상세 조회/수정페이지로 이동</a></td>
							<td>관리자</td>
							<td>2023-11-16</td>
						</tr>
					</table>
					<div id="admin_writer">
						<input type="button" value="글쓰기" 
						onclick = "location.href='admin_board_faq_write.jsp'">
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
				</form>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>