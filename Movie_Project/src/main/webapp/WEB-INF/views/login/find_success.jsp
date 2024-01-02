<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾은 회원 정보</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		// 변수 선언
		var iscorrectName = false;
		var iscorrectEmail = false;
		var isSended = false;
		var isChecked = false;
		
		<%-- 이름 확인 --%>
		$("#name").on("blur", function() {		
			let regName = /^[가-힣]{2,5}$/; <%-- 한글 2~5글자 --%>
			if(!regName.test($("#name").val())){
				$("#checkNameResult").text("2~5글자의 한글만 사용 가능합니다").css("color", "red");
				iscorrectName = false;
			} else if(regName.test($("#name").val())){
				$("#checkNameResult").text("사용 가능한 이름입니다").css("color", "blue");
				iscorrectName = true;
		    }
		});	
		
		$("#email").on("blur", function() {
			let member_email = $("#email").val();
			let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			
			if(!regEmail.exec(member_email)){
				$("#checkEmailResult").text("이메일 주소를 확인해주세요").css("color", "red");
				iscorrectEmail = false;
			} else {
				$("#checkEmailResult").text("사용 가능한 이메일입니다").css("color", "blue");
				iscorrectEmail = true;
			}
		});
		
		<%-- 생년월일 확인 --%>
<%-- 		let regBirth = /^(19[0-9][0-9]|20[0-2][0-9]).(0[0-9]|1[0-2]).(0[1-9]|[1-2][0-9]|3[0-1])$/; 1920년~2029년까지/01월~12월까지/01일~31일까지의 8자리 숫자 --%>
// 		$("#member_birth").on("blur", function() {				
// 			if(!regBirth.test($("#member_birth").val())) {
// 				$("#checkBirthResult").text("생년월일을 확인해주세요").css("color", "red");
// 				iscorrectBirth = false;
// 			} else if(regBirth.test($("#member_birth").val())) {
// 				$("#checkBirthResult").text("사용 가능한 생년월일입니다").css("color", "blue");
// 				iscorrectBirth = true;
// 	        }
// 		});	
		
		<%-- 생년월일에 자동 "." 입력 --%>
// 		$("#member_birth").keyup(function() {
// 			var val = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 입력 가능
// 			if(val.length > 4 && val.length < 6) {
// 				$(this).val(val.substring(0,4) + "." + val.substring(4));
// 			}else if (val.length > 7) {
// 				$(this).val(val.substring(0,4) + "." + val.substring(4, 6) + "." + val.substring(6));
// 			}
// 		});
		
		
		// 인증번호 발송 버튼을 클릭했을 때
		$("#sendMail").click(function() {		
			let member_email = $("#email").val();
			let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			
			if(!regEmail.exec(member_email)){
				$("#checkEmailResult").text("이메일 주소를 확인해주세요").css("color", "red");
			} else {
				$("#checkEmailResult").text("사용 가능한 이메일입니다").css("color", "blue");
// 				alert("인증번호를 발송했습니다. \n인증번호를 확인하고 인증번호확인란에 입력해주세요.");
				// 인증여부를 저장하는 변수 값을 true로 변경
				isSended = true;
				$("#sendMail").val("인증번호재발송");
				
				// 인증번호 발송 요청
				$.ajax({
					url: "authEmail",
					data: {
						member_email : member_email
					},
					success: function(data) {
// 						checkCNum(data);
						$("#authCode").val(data);
					
					},
					error: function(xhr, status, error) {
					      // 요청이 실패한 경우 처리할 로직
					      console.log("AJAX 요청 실패:", error); // 예시: 에러 메시지 출력
					}
				});
			}
		});
		
		$("#checkCode").on("click", function() {
			if(!isSended) {
				$("#checkResult").text("인증번호를 발송해주세요.").css("color", "red");
				$("#email").focus();
				isChecked = false;
			} else if($("#cNum").val() == '') {
// 				alert("인증번호를 입력해주세요");
				$("#checkResult").text("인증번호를 입력해주세요.").css("color", "red");
				$("#cNum").focus();
				isChecked = false;
			} else if($("#cNum").val() != $("#authCode").val()) {
// 				alert("인증번호가 일치하지 않습니다.");
				$("#checkResult").text("인증번호가 일치하지 않습니다.").css("color", "red");
				isChecked = false;
			} else {
				$("#checkResult").text("인증번호가 일치합니다.").css("color", "blue");
				isChecked = true;
			}
		});
		
		// 인증번호발송을 누르지 않으면 submit 동작 취소
		$("form").on("submit", function() {
			if(!iscorrectName) {
				$("#checkNameResult").text("2~5글자의 한글만 사용 가능합니다").css("color", "red");
				$("#name").focus();
				return false;
			} else if(!iscorrectEmail) {
				$("#checkEmailResult").text("이메일 주소를 확인해주세요").css("color", "red");
				$("#email").focus();
				return false; // submit 동작 취소
			} else if(!isSended) {
				$("#checkResult").text("인증번호를 발송해주세요.").css("color", "red");
				$("#email").focus();
				return false; // submit 동작 취소
			} else if($("#cNum").val() == '') {
				$("#checkResult").text("인증번호를 입력해주세요.").css("color", "red");
				$("#cNum").focus();
				return false; // submit 동작 취소
			} else if(!isChecked) {
				$("#checkResult").text("인증번호를 확인해주세요.").css("color", "red");
				$("#cNum").focus();
				return false; // submit 동작 취소
			}
			return true;
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
		<h1 id="h01">찾은 회원 정보</h1>
		<hr>
			<div class="login_center">
<!-- 					<h4>회원가입시 등록한 정보를 입력하세요</h4> -->
<!-- 					<input type="text" placeholder="이름을 입력하세요" id="name" name="member_name"> -->
<!-- 					<div id="checkNameResult" class="resultArea"></div> -->
<!-- 					<input type="text" placeholder="이메일을 입력하세요" name="member_email" id="email"> -->
<!-- 					<div id="checkEmailResult" class="resultArea"></div> -->
<!-- 					<input type="button" id="sendMail" value="인증번호발송"> -->
<!-- 					<div id="sendResult"></div> -->
<!-- 					<input type="text" placeholder="인증번호를 입력하세요" id="cNum" name="cNum"> -->
<!-- 					<input type="hidden" id="authCode"> -->
<!-- 					<input type="button" id="checkCode" value="인증번호 확인"> -->
<!-- 					<div id="checkResult"></div> -->
<%-- 					<input type="button" value="돌아가기" onclick='history.back();'>로그인 페이지로 돌아가기 --%>
<!-- 					<input type="submit" value="아이디찾기" id="findId"> -->
				<h3>회원님의 ID는</h3>
				<div><h3>${member.member_id } 입니다.</h3></div>
				<a href="memberLogin?member_id=${member.member_id }"><input type="button" value="로그인하기"></a>
				<a href="./"><input type="button" value="메인으로 이동"></a>
			</div>
		</section>
		
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>