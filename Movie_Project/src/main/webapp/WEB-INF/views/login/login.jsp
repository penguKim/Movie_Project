<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	
	$(function() {
		/* 클릭시 카카오 간편로그인, 네이버 간편로그인 */
// 		$(".login-link").on("click", function() {
// 			alert("간편로그인 할 예정입니다");
// 		});
		
		
		$("form").on("submit", function() {
			/* 아이디 및 비밀번호 둘중에 하나라도 입력하지 않으면 아이디 비밀번호를 입력하세요 출력 */
			if($("#id").val() == "" || $("#passwd").val() == "") {
				alert("아이디와 비밀번호를 입력하세요");
				return false;
			}
			/* 아이디 및 비밀번호 비교해서 로그인, 로그인 저장 버튼 활성화는 쿠키작업 처리 */
			// 스프링에서 처리할 예정
			/* 아이디 및 비밀번호 둘중에 하나라도 맞지 않으면 아이디 비밀번호가 다릅니다 출력 */
		});	
		
	});
</script>
</head>
<body>
	<div id="wrapper">
	
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">
		<h1 id="h01">회원로그인</h1>
		<hr>
			<form action="../main.jsp" method="post">
		
	<%-- 		<div align="right"> login.css 사용해서 정렬 --%>
	<%-- 			<a href="">비회원로그인</a> href 링크, 비회원로그인 부기능 --%>
	<%-- 		</div> --%>
				<div class="login_center">
					<input type="text" placeholder="아이디입력" name="id" id="id" ><br>
					<input type="password" placeholder="패스워드입력" name="passwd" id="passwd" ><br>
					
					<input type="submit" value="로그인" id="login_button1">
					<br>
					<!-- 
					1) 아이디 저장 체크박스 선택시 아이디(세션) 유지되게 하기[부기능]
					자바스크립트에서 세션아이디를 저장할 필요가 없음. 스프링에서 기술 구현 예정 -->
					<!-- 체크박스 체크시 아이디 저장 기능 - 쿠키 작업 처리 -->
					<div id="remember_id"><input type="checkbox">아이디 저장</div>
				
					<div id="move_menu"><br>
						
						<!-- 회원 가입, 아이디 찾기, 비밀번호 찾기 주소 연결 -->
						<a href="${pageContext.request.contextPath}/join/join_certification.jsp">회원가입</a> |
						<a href="${pageContext.request.contextPath}/login/id_find.jsp">아이디찾기</a> |
						<a href="${pageContext.request.contextPath}/login/pw_find.jsp">비밀번호찾기</a>
					</div><br>
					<!-- 간편로그인 기능 API 참고  -->
					<section id="api">
						<a href="popup.jsp"><img src="${pageContext.request.contextPath}/img/카카오버튼.png" width="150px" height="40px"></a>
						<a href="popup.jsp"><img src="${pageContext.request.contextPath}/img/네이버버튼.png" width="150px" height="40px"></a>
					</section>
				</div>
			</form>
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>