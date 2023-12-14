<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/css/login.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.7.1.js"></script>
<script type="text/javascript">

	
	$(function() {
		
		/* 새 비밀번호 입력 시  */
		/* 비밀번호에 값이 없을 경우 메세지 출력 X  */
		/* 비밀번호에 값이 8이상~16이하 일 경우 "사용 가능한 패스워드"  */
		/* 비밀번호에 값이 8미만~16초과 일 경우 "사용 불가능한 패스워드" */
		/* passwd 가 없는 경우 "" 표시 */
		$("#passwd").on("keyup", function() {
		let passwd = $("#passwd").val();
			
			if(passwd != "") {
				if(passwd.length >= 8 && passwd.length <= 16 ) {
					$("#passwdResult").text("사용 가능한 패스워드");
					$("#passwdResult").css("color", "blue");
				} else {
					$("#passwdResult").text("사용 불가능한 패스워드");
					$("#passwdResult").css("color", "red");
				}
			} else {
				$("#passwdResult").text("");
			}
		});
		
		/* 새 비밀번호와 재입력 비밀번호 비교 시 */
		$("#passwd, #passwd2").on("input", function() {
			let passwd = $("#passwd").val();
			let passwd2 = $("#passwd2").val();	
			
			/* 새비밀번호와 재입력비밀번호가 맞는 경우 "패스워드 일치"
				맞지 않는 경우 "패스워드 불일치" */
			/* passwd값이 없는 경우 "" 표시 */
			if(passwd2 != "") {
				if(passwd == passwd2) {
					$("#passwdResult2").text("패스워드 일치");
					$("#passwdResult2").css("color", "blue");
				} else {
					$("#passwdResult2").text("패스워드 불일치");
					$("#passwdResult2").css("color", "red");
				}
			} else {
				$("#passwdResult2").text("");
			}	
		});
		
		/* 새 비밀번호만 입력 했을경우 */
		$("form").on("submit", function() {
			
			if($("#passwd").val() != "") {
				alert("비밀번호를 재입력 하세요!");
				return false;
			}
			
		});
		
	});
	
	
	function Back() {
				history.back();
			 }
	
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<form action="join_result.html" method="post" name="joinForm">
				<h1 id="h01">회원 수정</h1>
				<hr>
				<h2 id="login_top">회원정보입력</h2>
				
				<div class="login_center">
					<!-- 이름 변경 불가능 아이디 데이터에 있는 이름값 받아서 적용 -->
					<!-- readonly 에서 disabled 로 변경 -->
					<input type="text" name="name" id="name" placeholder="이름을 입력하세요" disabled="disabled"><br>
					<!-- 아이디 변경 불가능 session 값에서 받아와 입력란에 적용 시킬예정 -->
					<input type="text" name="id" id="id" placeholder="아이디를 입력하세요" disabled="disabled"><br>
	<!-- 						<span id="checkIdResult"></span> -->
					<!-- 기존 비밀번호 입력 창 추가 -->
	<!-- 				<input type="password" name="passwd" id="passwd" placeholder="기존 비밀번호를 입력하세요"><br> -->
					<!-- ajax 이용해서 db에서 비밀번호 비교  -->
					<!-- 비밀번호 입력 방식 db에서 비교해서 맞으면 수정할수 있도록 설정 -->
					<!-- 기존 비밀번호랑 새 비밀번호랑 다르도록 비교 처리   -->
					<input type="password" name="passwd" id="passwd" placeholder="새 비밀번호를 입력하세요">
						<span id="passwdResult"></span> <br>
				
					<!-- 새 비밀번호와 같도록 비교 처리 (추가적으로 문장 등장하도록) -->
					<!-- 비밀번호만 입력됬을 경우 "비밀번호 재입력하세요!" 알람 출력 -->
					<input type="password" name="passwd2" id="passwd2" placeholder="새 비밀번호를 재입력하세요">
					<span id="passwdResult2"></span><br>
					<!-- readonly 에서 disabled 로 변경 -->
					<!-- 생년월일 변경 불가능 아이디 데이터에 있는 생년월일값 받아서 적용 -->
					<!-- 변경 불가 에서 생년월일로 변경 -->
					<input type="text" name="member_birth" id="member_birth" placeholder="생년월일" disabled="disabled"><br>
					<!-- 이메일 변경을 위한 인증 버튼 추가 -->
					<!-- 이메일 변경은 인증은 API 작업, 회원가입 시 작업과 동일 할 예정 -->
					<input type="text" name="email" size="8" id="email" placeholder="이메일주소를 입력하세요"><br>
		
					<div id="login_button">
						<input type="button" value="회원탈퇴" onclick="confirm('탈퇴하시겠습니까?')">
						<input type="button" value="돌아가기" onclick="Back()">
						<input type="submit" value="정보수정">
					</div>	
				</div>
				<hr>
			</form>
		</section>
				
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>