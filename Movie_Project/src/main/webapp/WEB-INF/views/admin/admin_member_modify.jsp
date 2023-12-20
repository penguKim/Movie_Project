<%-- admin_member_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 상세</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		
		
	});
</script>
</head>
<body>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">${member.member_name }의 회원정보</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>

			<div id="admin_sub">
				<form action="memberModOrDlt" method="post">
					<table border="1">
						<tr>
							<th>이름</th>	
							<td colspan="2">
								<input type="text" name="member_name" value="${member.member_name }" id="mamber_name" required>
							</td>
						</tr>
						<tr>
							<th>계정</th>
							<td colspan="2">
								<input type="text" name="member_id" value="${member.member_id }" id="mamber_id" readonly>
							</td>
						</tr>
						<tr>
							<th>새 비밀번호</th>
							<td>
								<input type="password" name="newPasswd" placeholder="8~16글자(변경시 입력)">
								<span id="checkNewPasswdResult"></span>
							</td>
						</tr>
						<tr>
							<th>새 비밀번호확인</th>
							<td>
								<input type="password" name="newPasswd2" placeholder="(변경시 입력)">
								<span id="checkNewPasswd2Result"></span>
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
							<th>생년월일</th>
							<td colspan="2">
								<input type="date" name="member_birth" value="${member.member_birth }" id="member_birth">
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td colspan="2">
								<input type="text" name="member_phone" value="${member.member_phone }" id="member_phone">
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td colspan="2">
								<input type="text" name="member_email" value="${member.member_email }" id="member_email">
							</td>
						</tr>
						<tr>
							<th>활동상태</th>
							<td>
								<select name="member_status" value="" id="member_status">
									<option value="1" id="active" <c:if test="${member.member_status eq 1 }">selected</c:if>>활동</option>
									<option value="2" id="withdraw" <c:if test="${member.member_status eq 2 }">selected</c:if>>탈퇴</option>
								</select>
							</td>
						</tr>
					</table>
					<input type="hidden" name="pageNum" value="${pageNum }">	
					<div id="admin_writer"> 
						<input type="submit" value="정보 수정">
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