<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 게시글</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.7.1.js"></script>

</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<h1 id="h01">나의 게시글</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form action="" method="" name="checkform">
				<div id="my_list">
					<h2>1:1 문의</h2>
					<table id="my_table1">
						<tr>
							<th width="50px"><input type="checkbox" id="checkbox1"></th><th>No.</th>
							<th>문의 제목</th>
							<th>문의 내용</th>
							<th>회원 아이디</th>
							<th>상세 정보</th>
						</tr>
						<tr>
							<td><input type="checkbox" name="checkbox1"></td><td>[게시글 순번]</td>
							<td>[문의 제목]</td>
							<td>[문의 내용...]</td>
							<td>[회원아이디]</td>
							<td><a href="myPageOneOnOneDtl"><input type="button" value="나의글상세정보"></a></td>
						</tr>
						
						<tr>
							<td><input type="checkbox" name="checkbox1"></td><td>[게시글 순번]</td>
							<td>[문의 제목]</td>
							<td>[문의 내용...]</td>
							<td>[회원아이디]</td>
							<td><a href="myPageOneOnOneDtl"><input type="button" value="나의글상세정보"></a></td>
						</tr>
					</table><br>
								
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
				
				<div id="buy_list">
					<h2>분실물 문의</h2>
					<table id="my_table1">
						<tr>
							<th width="50px"><input type="checkbox" id="checkbox2"></th><th>No.</th>
							<th>문의 제목</th>
							<th>문의 내용</th>
							<th>회원 아이디</th>
							<th>상세 정보</th>
						</tr>
						<tr>
							<td><input type="checkbox" name="checkbox2"></td><td>[게시글 순번]</td>
							<td>[문의 제목]</td>
							<td>[문의 내용...]</td>
							<td>[회원아이디]</td>
							<td><a href="mypage_lost.jsp"><input type="button" value="나의글상세정보"></a></td>
							
						</tr>
						<tr>
							<td><input type="checkbox" name="checkbox2"></td><td>[게시글 순번]</td>
							<td>[문의 제목]</td>
							<td>[문의 내용...]</td>
							<td>[회원아이디]</td>
							<td><a href="mypage_lost.jsp"><input type="button" value="나의글상세정보"></a></td>
						</tr>
					</table><br>
								
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

				<div id="buy_list">
					<h2>나의 리뷰</h2>
					<table id="my_table1">
						<tr>
							<th width="50px"><input type="checkbox" id="checkbox2"></th><th>No.</th>
							<th>리뷰 내용</th>
							<th>작성 시간</th>
							<th>회원 아이디</th>
							<th>상세 정보</th>
						</tr>
						<tr>
							<td><input type="checkbox" name="checkbox2"></td><td>[게시글 순번]</td>
							<td>[리뷰 내용]</td>
							<td>[작성 시간]</td>
							<td>[회원아이디]</td>
							<td><input type="button" value="나의리뷰삭제"></td>
							
						</tr>
						<tr>
							<td><input type="checkbox" name="checkbox2"></td><td>[게시글 순번]</td>
							<td>[리뷰 내용]</td>
							<td>[작성 시간]</td>
							<td>[회원아이디]</td>
							<td><input type="button" value="나의리뷰삭제"></td>
						</tr>
					</table><br>
								
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
			</form>
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>