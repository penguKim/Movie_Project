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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<!-- 네이버 api를 위한 script -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript">
	$(function() {
		// 인증여부를 저장할 변수 선언
		var isChecked = false;
		
		<%-- 이메일주소 중복 확인 --%>
		// 인증번호 발송 버튼을 클릭했을 때
		$("#sendMail").click(function() {		
			var member_email = $("#email").val();
			let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			
			if(!regEmail.exec(member_email)){
				$("#checkEmailResult").text("이메일 주소를 확인해주세요").css("color", "red");
				iscorrectEmail = false;
			} else {
				<%-- AJAX를 통해 이메일 중복값 확인 --%>
				$.ajax({
					url: "checkDup",
					data: {
						member_email : member_email
					},
					dataType: "json",
					success: function(checkDupEmail) {
						if(checkDupEmail) { // 중복
 							$("#checkResult").text("이미 사용중인 이메일입니다").css("color", "red");
						} else { // 사용가능
							$("#checkResult").text("사용 가능한 이메일입니다").css("color", "blue");
							alert("인증번호를 발송했습니다. \n인증번호를 확인하고 인증번호확인란에 입력해주세요.");
							// 인증여부를 저장하는 변수 값을 true로 변경
							isChecked = true;
							
							// 인증번호 발송 요청
							$.ajax({
								url: "authEmail",
								data: {
									member_email : member_email
								},
								success: function(data) {
									checkCNum(data);
								},
								error: function(xhr, status, error) {
								      // 요청이 실패한 경우 처리할 로직
								      console.log("AJAX 요청 실패:", error); // 예시: 에러 메시지 출력
								}
							});
						
						}
							
					},
					error: function(xhr, status, error) {
					      // 요청이 실패한 경우 처리할 로직
					      console.log("AJAX 요청 실패:", error); // 예시: 에러 메시지 출력
					}
				});
	        }
		});	

		// 인증번호발송을 누르지 않으면 submit 동작 취소
		$("form").on("submit", function() {
			if(!isChecked) {
				alert("인증번호를 발송해주세요");
				$("#email").focus();
				return false; // submit 동작 취소
			} else if($("#cNum").val() == '') {
				alert("인증번호를 입력해주세요");
				$("#cNum").focus();
				return false; // submit 동작 취소
			}
		});
		
		// 인증번호 대조
		function checkCNum(data) {
			$("form").on("submit", function() {
				if($("#cNum").val() != data) {
					alert("인증번호가 일치하지 않습니다.");
					return false; // submit 동작 취소
				}
				return true; // submit 동작 수행(생략 가능)
			});		
		};
		
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
						<input type="text" id="email" name="email" placeholder="이메일주소">
						<input type="button" id="sendMail" value="인증번호발송"><br>
						<div id="checkResult"></div>
						<input type="text" placeholder="인증번호" id="cNum">
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