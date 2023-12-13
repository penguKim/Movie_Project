<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/join.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	window.onload = function() {
		<%-- 인증번호를 확인한 후 다음 페이지로 넘어가기 --%>
		document.joinCertification.onsubmit = function() {
			if(document.joinCertification.cNum.value == "") {
				alert("인증번호를 입력해주세요!");
				document.joinCertification.cNum.focus();
				return false; // submit 동작 취소
			} 
		};
		
	}; // window.onload 이벤트 끝
</script>
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
				<span id="this">본인인증</span>
				<span>약관동의</span>
				<span>정보입력</span>
				<span>가입완료</span>		
			</section>
			
			<form action="memberJoinAgree" method="post" name="joinCertification">
				<hr>		
				<h3 id="join_top">회원가입을 위해 본인 인증을 해주세요.</h3>
				<section id="api">
					<a href=""><img src="${pageContext.request.contextPath}/resources/img/카카오버튼.png" width="160px" height="40px"></a>
					<a href=""><img src="${pageContext.request.contextPath}/resources/img/네이버버튼.png" width="160px" height="40px"></a>
				</section>
				<hr>
					
				<section id="email1">
					<span id="email2">
						<img src="${pageContext.request.contextPath}/resources/img/mail.png" width="80px" height="70px;"> <br>
						이메일인증</span>
					<span id="email3">
						<input type="text" placeholder="이메일주소">
						<input type="button" value="인증번호발송"> <br>
						<input type="text" placeholder="인증번호" name="cNum">
						<input type="submit" value="인증번호확인">
					</span>
				 </section>
				
				<hr>
				<p id="notice">14세 미만 어린이는 보호자 인증을 추가로 완료한 후 가입이 가능합니다. <br>
				본인인증 시 제공되는 정보는 해당 인증기관에서 직접 수집하며, 인증 이외의 용도로 <br>
				이용 또는 저장되지 않습니다.</p>
			</form>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>