<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function btnLookup() {
		location.reload();
	}
	
	function btnDlt() {
		var result = confirm("리뷰를 삭제하시겠습니까?");
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
			<h1 id="h01">리뷰 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<div id="review_Search">
					<input type="text" placeholder="아이디 또는 영화명 입력">
					<input type="button" value="조회" onclick="btnLookup()">
				</div>
				<table border="1" width="1100">
					<tr>
						<th>영화명</th>
						<th>평점</th>
						<th>아이디</th>
						<th>내용</th>
						<th>리뷰 삭제하기</th>
					</tr>
					<tr>
						<td>movie_title</td>
						<td>review_rating</td>
						<td>member_id</td>
						<td>review_content</td>
						<td><input type="button" value="삭제" onclick="btnDlt()"></td>
					</tr>
					<tr>
						<td>movie_title</td>
						<td>review_rating</td>
						<td>member_id</td>
						<td>review_content</td>
						<td><input type="button" value="삭제" onclick="btnDlt()"></td>
					</tr>
					<tr>
						<td>movie_title</td>
						<td>review_rating</td>
						<td>member_id</td>
						<td>review_content</td>
						<td><input type="button" value="삭제" onclick="btnDlt()"></td>
					</tr>
					<tr>
						<td>movie_title</td>
						<td>review_rating</td>
						<td>member_id</td>
						<td>review_content</td>
						<td><input type="button" value="삭제" onclick="btnDlt()"></td>
					</tr>
					<tr>
						<td>movie_title</td>
						<td>review_rating</td>
						<td>member_id</td>
						<td>review_content</td>
						<td><input type="button" value="삭제" onclick="btnDlt()"></td>
					</tr>
					<tr>
						<td>movie_title</td>
						<td>review_rating</td>
						<td>member_id</td>
						<td>review_content</td>
						<td><input type="button" value="삭제" onclick="btnDlt()"></td>
					</tr>
					<tr>
						<td>movie_title</td>
						<td>review_rating</td>
						<td>member_id</td>
						<td>review_content</td>
						<td><input type="button" value="삭제" onclick="btnDlt()"></td>
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
