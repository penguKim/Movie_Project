<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
$(function() {

	Kakao.init("7f2cbaab42a6ec66232f961c71c7350f");

	// 카카오 로그인 버튼을 생성
	Kakao.Auth.createLoginButton({
		container: '#kakao-login-btn',
		success: function(authObj) {
		// 로그인 성공시, API를 호출합니다.
	Kakao.API.request({// 로그인한 사용자 정보 가져오기
		url: '/v2/user/me',
		success: function(res) {
			console.log("사용자 정보 요청 실패", res);
		},
		fail: function(error) {
			console.log("로그인 실패", error);
			}
	});
		},
		fail: function(err) {
			console.log(err);
		}
	});
	
	document.addEventListener("DOMContentLoaded", function () { //웹 페이지의 HTML이 모두 로드되었을 때(DOMContentLoaded) 실행될 함수
		document.getElementById("kakao-login-btn").addEventListener("click", function (a) { //카카오로그인 버튼클릭 시 실행되는 함수
			a.preventDefault(); // 기본 동작인 페이지 이동을 막음
		loginWithKakao();
		});
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
						<a href="${pageContext.request.contextPath}/join/join_certification.jsp">회원가입</a> |
						<a href="idFind">아이디찾기</a> |
						<a href="pwFind">비밀번호찾기</a>
					</div><br>
					<!-- 간편로그인 기능 API 참고  -->
					<section id="api">
						<a href="#" id="kakao-login-btn"><img src="${pageContext.request.contextPath}/resources/img/카카오버튼.png" value="${sessionScope.sId} width="150px" height="40px"></a>					
						<a href="popup.jsp"><img src="${pageContext.request.contextPath}/resources/img/네이버버튼.png" width="222px" height="49px"></a>
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