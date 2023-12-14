<%-- admin_member_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 상세</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function btnMod() {
		var result = confirm("회원정보를 수정하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	
	function btnDlt() {
		var result = confirm("회원정보를 삭제하시겠습니까?");
		if(result) {
			location.href = "adminMember";
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
			<h1 id="h01">XXX의 회원정보</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>

			<div id="admin_sub">
				<table border="1">
					<tr>
						<th>이름</th>	
						<td colspan="2"></td>
					</tr>
					<tr>
						<th>계정</th>
						<td colspan="2"></td>
					</tr>
					<tr>
						<th>활동상태</th>
						<td>
							<select>
								<option selected>활동</option>
								<option>탈퇴</option>
							</select>
						</td>
					</tr>
					<!-- 멤버십(회원등급)은 부기능이므로 제외시켜놓음 -->
<!-- 						<tr> -->
<!-- 							<th>멤버십</th> -->
<!-- 							<td> -->
<!-- 								<select> -->
<!-- 									<option selected>BRONZE</option> -->
<!-- 									<option>SILVER</option> -->
<!-- 									<option>GOLD</option> -->
<!-- 									<option>PLATINUM</option> -->
<!-- 								</select> -->
<!-- 							</td> -->
<!-- 						</tr> -->
					<tr>
						<th>아이디</th>
						<td colspan="2"></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td colspan="2"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td colspan="2"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="2"></td>
					</tr>
				</table>
				<div id="admin_writer"> 
					<input type="button" value="수정" onclick="btnMod()">
					<input type="button" value="돌아가기" onclick="history.back()">
					<input type="button" value="삭제" onclick="btnDlt()">
				</div>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>			
</body>
</html>