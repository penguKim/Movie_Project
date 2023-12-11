<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">

		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">
		<h1 id="h01">비밀번호찾기</h1>
		<hr>
			<form action="../main.jsp" method="post">
			
					<nav class="login_find">
						<ul>
							<li>
								<a href="id_find.jsp">
								<input type="button" value="아이디찾기">
								</a>
							</li>
							<li>
								<a href="pw_find.jsp">
								<input type="button" value="비밀번호찾기">
								</a>
							</li>
						</ul>
					</nav>
				<div class="login_center">
					
						<h4>회원가입시 등록한 정보를 입력하세요</h4>
							<input type="text" placeholder="아이디를 입력하세요" id="id" name="member_id" required><br>
							<input type="text" placeholder="이름을 입력하세요" id="name" name="member_name" required><br>
							<input type="text" placeholder="생년월일 8자리를 입력하세요" id="member_birth" name="member_birth" required><br>
							<input type="text" placeholder="이메일을 입력하세요" name="email" id="email" required><br>
							<input type="text" placeholder="인증번호를 입력하세요" id="Certification" name="Certification" required>
							<input type="button" value="인증번호 받기">
							<input type="button" value="돌아가기"><%--로그인 페이지로 돌아가기 --%>
							<input type="submit" value="비밀번호찾기">
						<%--"아이디를 알림창으로 띄운뒤" 로그인 페이지로 돌아가기 --%>
				</div>
			</form>
		</section>
		
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>