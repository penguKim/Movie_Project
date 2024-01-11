<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- 네이버 api를 위한 script -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script>

	$(function() {
		$("#kakao_id_login").click(function() {
			alert("서비스 준비중입니다");
		});
	});
	
	$(function() {
		$("#google_id_login").click(function() {
			alert("서비스 준비중입니다");
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
			<form action="MemberLoginPro" method="Post">
		
	<%-- 		<div align="right"> login.css 사용해서 정렬 --%>
	<%-- 			<a href="">비회원로그인</a> href 링크, 비회원로그인 부기능 --%>
	<%-- 		</div> --%>
				<div class="login_center">
					<c:choose>
						<c:when test="${not empty param.member_id }">
							<input type="text" placeholder="아이디입력" name="member_id" id="id" value="${param.member_id }" required="required"><br>
						</c:when>
						<c:otherwise>
							<input type="text" placeholder="아이디입력" name="member_id" id="id" value="${cookie.cookieId.value }" required="required"><br>
						</c:otherwise>
					</c:choose>
					<input type="password" placeholder="패스워드입력" name="member_passwd" id="passwd" required="required"><br>
					
					<input type="submit" value="로그인" id="login_button1">
					<br>
					<!-- 
					1) 아이디 저장 체크박스 선택시 아이디(세션) 유지되게 하기[부기능]
					자바스크립트에서 세션아이디를 저장할 필요가 없음. 스프링에서 기술 구현 예정 -->
					<!-- 체크박스 체크시 아이디 저장 기능 - 쿠키 작업 처리 -->
					<div id="remember_id"><input type="checkbox" name="rememberId" <c:if test="${not empty cookie.cookieId.value }">checked</c:if>>아이디 저장</div>
					
					<div id="move_menu"><br>
						
						<!-- 회원 가입, 아이디 찾기, 비밀번호 찾기 주소 연결 -->
						<a href="memberJoin">회원가입</a> |
						<a href="idFind">아이디찾기</a> |
						<a href="pwFind">비밀번호찾기</a>
					</div><br>
					
					<hr>
					<!-- 간편로그인 기능 API 참고  -->
					<section id="api">
						<h3>소셜계정으로 인증하기</h3>
						<!-- 카카오 로그인 버튼 노출 영역 -->
						<div id="kakao_id_login" style="text-align:center">
						  <img src="${pageContext.request.contextPath}/resources/img/kakao.png" width="60px"/>
						</div>
						<div id="naver_id_login" style="text-align:center"><a href="${url}"><img src="${pageContext.request.contextPath}/resources/img/naver.png" width="60px"/></a></div>
						<!-- 구글 로그인 화면으로 이동 시키는 URL -->
						<!-- 구글 로그인 화면에서 ID, PW를 올바르게 입력하면 oauth2callback 메소드 실행 요청-->
						<div id="google_id_login" style="text-align:center">
							<img src="${pageContext.request.contextPath}/resources/img/google.png" width="60px"/>
						</div>
					</section>
					<hr>
				</div>
			</form>
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>