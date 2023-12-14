<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function btnWdr() {
		var result = confirm("탈퇴 처리하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	
	function btnDlt() {
		var result = confirm("비회원 삭제 처리하시겠습니까?");
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
			<h1 id="h01">회원정보관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<table border="1" width="1000">
					<div id="member_Search">
						<input type="text" placeholder="조회할 회원정보 입력">
						<input type="button" value="조회">
					</div>
					<tr>
						<th>이름</th>
						<th>아이디</th>
						<th>멤버십</th>
						<th>회원상태</th>
						<th>계정종류 및 변경</th>
					</tr>
					<tr>
						<td>번호입니다</td>
						<td>유형입니다</td>
						<td>제목입니다</td>
						<td>작성자입니다</td>
						<td><a href="adminMemberMod"><input type="button" value="회원" id="admin_member"></a></td>
					</tr>
					<tr>
						<td>번호입니다</td>
						<td>유형입니다</td>
						<td>제목입니다</td>
						<td>작성자입니다</td>
						<td><a href="adminMemberMod"><input type="button" value="회원" id="admin_member"></a></td>
					</tr>
					<tr>
						<td>번호입니다</td>
						<td>유형입니다</td>
						<td>제목입니다</td>
						<td>작성자입니다</td>
						<td><input type="button" value="탈퇴" id="admin_Cmember"
						onclick="btnWdr()"></td>
					</tr>
					<tr>
						<td>번호입니다</td>
						<td>유형입니다</td>
						<td>제목입니다</td>
						<td>작성자입니다</td>
						<td><input type="button" value="비회원" id="admin_Bmember"
						onclick="btnDlt()"></td>
					</tr>
					<tr>
						<td>번호입니다</td>
						<td>유형입니다</td>
						<td>제목입니다</td>
						<td>작성자입니다</td>
						<td><a href="adminMemberMod"><input type="button" value="회원" id="admin_member"></a></td>
					</tr>
					<tr>
						<td>번호입니다</td>
						<td>유형입니다</td>
						<td>제목입니다</td>
						<td>작성자입니다</td>
						<td><input type="button" value="비회원" id="admin_Bmember"  onclick="btnDlt()"></td>
					</tr>
					<tr>
						<td>번호입니다</td>
						<td>유형입니다</td>
						<td>제목입니다</td>
						<td>작성자입니다</td>
						<td><a href="adminMemberMod"><input type="button" value="회원" id="admin_member"></a></td>
					</tr>
					<tr>
						<td>번호입니다</td>
						<td>유형입니다</td>
						<td>제목입니다</td>
						<td>작성자입니다</td>
						<td><a href="adminMemberMod"><input type="button" value="회원" id="admin_member"></a></td>
					</tr>
					<tr>
						<td>번호입니다</td>
						<td>유형입니다</td>
						<td>제목입니다</td>
						<td>작성자입니다</td>
						<td><a href="adminMemberMod"><input type="button" value="회원" id="admin_member"></a></td>
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