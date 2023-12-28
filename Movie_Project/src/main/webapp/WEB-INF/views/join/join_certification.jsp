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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>spdl
<!-- 네이버 api를 위한 script -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
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
					<!-- 네이버 로그인 버튼 노출 영역 -->
					<div id="naver_id_login"></div>
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
	
	
	
	<!-- 네이버아디디로로그인 초기화 Script -->
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("nr_LTg68QmTdiTdj7ult", "http://localhost:8081/c5d2308t1");
		var state = naver_id_login.getUniqState();
		naver_id_login.setButton("green", 3,40);
		naver_id_login.setDomain(".service.com");
		naver_id_login.setState(state);
		naver_id_login.setPopup();
		naver_id_login.init_naver_id_login();
	</script>
	<!-- // 네이버 로그인 초기화 Script -->
	
	<!-- 네이버아디디로로그인 Callback페이지 처리 Script -->
	<script type="text/javascript">
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			// naver_id_login.getProfileData('프로필항목명');
			// 프로필 항목은 개발가이드를 참고하시기 바랍니다.
			alert(naver_id_login.getProfileData('id'));
			alert(naver_id_login.getProfileData('name'));
			alert(naver_id_login.getProfileData('email'));
			alert(naver_id_login.getProfileData('gender'));
// 			alert(naver_id_login.getProfileData('age'));
// 			alert(naver_id_login.getProfileData('birthday'));
			alert(naver_id_login.getProfileData('mobile'));
		}
	
	
		// 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
	</script>
	<!-- //네이버아디디로로그인 Callback페이지 처리 Script -->
	
	
	
</body>
</html>