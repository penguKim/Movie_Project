<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/css/join.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper"> 
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">회원가입</h1>
			<section id="join_top">
				<span>본인인증</span>
				<span>약관동의</span>
				<span>정보입력</span>
				<span id="this">가입완료</span>		
			</section>
			
			<form action="" method="" name="" id="completion_msg">
				<hr>
				<h2>회원가입을 축하합니다</h2>
				<p>(아이디) 님의 회원가입을 축하합니다. <br>
				로그인을 하시면 포인트 적립, 쿠폰 등 <br>
				다양한 혜택을 누리실 수 있습니다. </p>
				<section id="join_button">
					<a href="../login/login.jsp"> <input type="button" value="로그인"></a>
					<a href="../main.jsp"><input type="button" value="메인페이지"></a>
				</section>
				<hr>
			</form>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>	
</body>
</html>