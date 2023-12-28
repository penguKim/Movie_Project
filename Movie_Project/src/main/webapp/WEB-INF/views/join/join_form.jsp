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
<script>
	$(function() {	
		let isDuplicateId = false; <%-- 아이디 중복 여부를 저장할 변수 선언 --%>
		let isDuplicateEmail = false; <%-- 이메일 중복 여부를 저장할 변수 선언 --%>
		let isDuplicatePhone = false; <%-- 휴대폰번호 중복 여부를 저장할 변수 선언 --%>
		
		let isSamePasswd = false; <%-- 패스워드 일치 여부를 저장할 변수 선언 --%>
		let isSafePasswd = false; <%-- 패스워드 안전도를 저장하는 변수 --%>
		
		let iscorrectId = false; <%-- 아이디가 정규표현식에 적합한지를 저장할 변수 선언 --%>
		let iscorrectPasswd = false; <%-- 비밀번호가 정규표현식에 적합한지를 저장할 변수 선언 --%>
		let iscorrectName = false; <%-- 이름이 정규표현식에 적합한지를 저장할 변수 선언 --%>
		let iscorrectPhone = false; <%-- 휴대폰번호가 정규표현식에 적합한지를 저장할 변수 선언 --%>
		let iscorrectEmail = false; <%-- 이메일이 정규표현식에 적합한지를 저장할 변수 선언 --%>
		let iscorrectBirth = false; <%-- 생일이 정규표현식에 적합한지를 저장할 변수 선언 --%>
		
		
		$("#id").blur(function() {
			let member_id = $("#id").val();
			<%-- 아이디 길이, 문자 종류 확인 --%>
			let regId = /^[A-Za-z0-9]{5,20}$/; <%-- 5~20자의 영문(대소문자), 숫자 --%>
			if(!regId.exec(member_id)) {
				$("#checkIdResult").text("5~20자의 영문 대/소문자, 숫자를 입력해주세요").css("color", "red");
				iscorrectId = false;
			} else {
				<%-- AJAX를 통해 아이디 중복값 확인 --%>
				$.ajax({
					url: "checkDup",
					data: {
						member_id : member_id
					},
					dataType: "json",
					success: function(checkDupId) {
						console.log("결과 : " + checkDupId)
						if(checkDupId) { // 중복
 							$("#checkIdResult").text("이미 사용중인 아이디입니다").css("color", "red");
 							iscorrectId = false;
 							isDuplicateId = true;
						} else { // 사용가능
							$("#checkIdResult").text("사용 가능한 아이디입니다").css("color", "blue");
							iscorrectId = true;
 							isDuplicateId = false;
						}
							
					}
				});
			}
		});	
		
		
		<%-- 패스워드 확인 --%>
		$("#passwd").blur(function() {	
			let member_passwd = $("#passwd").val();
			
			<%-- 비밀번호 길이, 문자종류 검증 --%>
			let regPw = /^[A-Za-z0-9!@#%^&*]{8,16}$/; <%-- 8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*) --%>
			if(!regPw.exec(member_passwd)) { <%-- 비밀번호 길이, 문자종류 위반 --%>
				$("#checkPasswdResult").text("8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*)만 사용 가능합니다").css("color", "red");
				iscorrectPasswd = false;
			} else { <%-- 통과했을 때 복잡도 검증 실행 --%>
				let count = 0; <%-- 복잡도 점수를 저장할 변수 선언 --%>
				
				let regEngUpper = /[A-Z]/; <%-- 대문자 --%>
				let regEngLower = /[a-z]/; <%-- 소문자 --%>
				let regNum = /[0-9]/; <%-- 숫자 --%>
				let regSpec = /[!@#%^&*]/; <%-- 특수문자(!@#%^&*) --%>
			
				if(regEngUpper.exec(member_passwd)) count++; <%-- 대문자가 있으면 +1점 --%>
				if(regEngLower.exec(member_passwd)) count++; <%-- 소문자가 있으면 +1점 --%>
				if(regNum.exec(member_passwd)) count++; <%-- 숫자가 있으면 +1점 --%>
				if(regSpec.exec(member_passwd)) count++; <%-- 특수문자가 있으면 +1점 --%>
				
				switch (count) {
					case 4: 
						$("#checkPasswdResult").text("안전").css("color", "green");
						isSafePasswd = true;
						iscorrectPasswd = true;
						break;
					case 3: 
						$("#checkPasswdResult").text("보통").css("color", "blue");
						isSafePasswd = true;
						iscorrectPasswd = true;
						break;
					case 2: 
						$("#checkPasswdResult").text("주의").css("color", "orange");
						isSafePasswd = false;
						iscorrectPasswd = false;
						break;
					case 1: 
					case 0: 
						$("#checkPasswdResult").text("위험").css("color", "red");
						isSafePasswd = false;
						iscorrectPasswd = false;
						break;
				}
			
			}
			
		});

		<%-- 비밀번호와 비밀번호 확인이 같은지 체크하기 --%>
		$("#passwd").on("keyup", function() {	
		    if($("#passwd").val() == $("#passwd2").val()) { // 일치
		    	$("#checkPasswd2Result").text("비밀번호가 일치합니다").css("color", "blue");
		    	isSamePasswd = true;
		    } else { // 불일치
		    	$("#checkPasswd2Result").text("비밀번호가 일치하지 않습니다").css("color", "red");		     	
		    	isSamePasswd = false;
		    }
			
		});
		
		$("#passwd2").on("keyup", function() {	
		    if($("#passwd").val() == $("#passwd2").val()) { // 일치
		    	$("#checkPasswd2Result").text("비밀번호가 일치합니다").css("color", "blue");
		    	isSamePasswd = true;
		    } else { // 불일치
		    	$("#checkPasswd2Result").text("비밀번호가 일치하지 않습니다").css("color", "red");		     	
		    	isSamePasswd = false;
		    }
			
		});
		
		
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
		
		
		<%-- 이메일주소 확인 --%>
		$("#email").blur(function() {			
			let member_email = $("#email").val();
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
						console.log("결과 : " + checkDupEmail)
						if(checkDupEmail) { // 중복
 							$("#checkEmailResult").text("이미 사용중인 이메일입니다").css("color", "red");
 							iscorrectEmail = false;
 							isDuplicateEmail = true;
						} else { // 사용가능
							$("#checkEmailResult").text("사용 가능한 이메일입니다").css("color", "blue");
							isDuplicateEmail = false;
							iscorrectEmail = true;
						}
							
					}
				});
	        }
		});	
		
		<%-- 휴대폰번호 확인 --%>
		$("#phone").on("blur", function() {	
			let member_phone = $("#phone").val();
			let regPhone = /^010-\d{4}-\d{4}$/; <%-- 010으로 시작하는 11자리 숫자 --%>
			if(!regPhone.test(member_phone)){
				$("#checkPhoneResult").text("휴대폰번호를 확인해주세요").css("color", "red");
				iscorrectPhone = false;
			} else {
				<%-- AJAX를 통해 휴대폰번호 중복값 확인 --%>
				$.ajax({
					url: "checkDup",
					data: {
						member_phone : member_phone
					},
					dataType: "json",
					success: function(checkDupPhone) {
						console.log("결과 : " + checkDupPhone)
						if(checkDupPhone) { // 중복
 							$("#checkPhoneResult").text("이미 사용중인 휴대폰번호입니다").css("color", "red");
 							iscorrectPhone = false;
 							isDuplicatePhone = true;
						} else { // 사용가능
							$("#checkPhoneResult").text("사용 가능한 휴대폰번호입니다").css("color", "blue");
							iscorrectPhone = true;
							isDuplicatePhone = false;
						}
							
					}
				});
	        }
		});			
		
		<%-- 전화번호에 자동 "-" 입력 --%>
		$("#phone").keyup(function(){
			var val = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 입력 가능
			if(val.length > 3 && val.length < 6) {
				$(this).val(val.substring(0,3) + "-" + val.substring(3));
			} else if (val.length > 7) {
				$(this).val(val.substring(0,3) + "-" + val.substring(3, 7) + "-" + val.substring(7));
					
			}
		});
		
		
		<%-- 생년월일 확인 --%>
		let regBirth = /^(19[0-9][0-9]|20[0-2][0-9]).(0[0-9]|1[0-2]).(0[1-9]|[1-2][0-9]|3[0-1])$/; <%-- 1920년~2029년까지/01월~12월까지/01일~31일까지의 8자리 숫자 --%>
		$("#birth").on("blur", function() {				
			if(!regBirth.test($("#birth").val())) {
				$("#checkBirthResult").text("생년월일을 확인해주세요").css("color", "red");
				iscorrectBirth = false;
			} else if(regBirth.test($("#birth").val())) {
				$("#checkBirthResult").text("사용 가능한 생년월일입니다").css("color", "blue");
				iscorrectBirth = true;
	        }
		});	
		
		<%-- 생년월일에 자동 "." 입력 --%>
		$("#birth").keyup(function() {
			var val = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 입력 가능
			if(val.length > 4 && val.length < 6) {
				$(this).val(val.substring(0,4) + "." + val.substring(4));
			}else if (val.length > 7) {
				$(this).val(val.substring(0,4) + "." + val.substring(4, 6) + "." + val.substring(6));
			}
		});

	
		<%-- submit 동작을 수행할 때 값을 올바르게 입력했는지 확인 --%>
		$("form").on("submit", function() {
			if(!iscorrectId) { <%-- 아이디가 정규표현식에 적합하지 않을 경우(미입력 포함) --%>
				$("#checkIdResult").text("5~20자의 영문 대/소문자, 숫자를 입력해주세요").css("color", "red");
				$("#id").focus();
				return false; // submit 동작 취소
			} else if(isDuplicateId) {  <%-- 아이디가 중복일 때 --%>
				$("#id").focus();
				return false; // submit 동작 취소
			} else if(!iscorrectPasswd) { <%-- 비밀번호 미입력 시 --%>
				$("#checkPasswdResult").text("8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*)만 사용 가능합니다").css("color", "red");
				$("#passwd").focus();
				return false; // submit 동작 취소
			} else if(!isSafePasswd) { <%-- 비밀번호가 안전하지 않을 때 --%>
				$("#passwd").focus();
				return false; // submit 동작 취소
			} else if(!isSamePasswd) { <%-- 비밀번호 불일치 시 --%>
				$("#passwd2").focus();
				return false; // submit 동작 취소
			} else if(!iscorrectName) { <%-- 이름 미입력 시 --%>
				$("#checkNameResult").text("2~5글자의 한글만 사용 가능합니다").css("color", "red");
				$("#name").focus();
				return false; // submit 동작 취소
			} else if(!iscorrectPhone) {  <%-- 휴대폰번호 미입력 시 --%>
				$("#checkPhoneResult").text("휴대폰번호를 확인해주세요").css("color", "red");
				$("#phone").focus();
				return false; // submit 동작 취소
			} else if(isDuplicatePhone) {  <%-- 휴대폰번호 중복 시 --%>
				$("#phone").focus();
				return false; // submit 동작 취소
			} else if(!iscorrectEmail) {  <%-- 이메일 주소 미입력 시 --%>
				$("#checkEmailResult").text("이메일 주소를 확인해주세요").css("color", "red");
				$("#email").focus();
				return false; // submit 동작 취소
			} else if(isDuplicateEmail) {  <%-- 이메일 주소 중복 시 --%>
				$("#email").focus();
				return false; // submit 동작 취소
			} else if(!iscorrectBirth) {  <%-- 생년월일 미입력 시 --%>
				$("#checkBirthResult").text("생년월일을 확인해주세요").css("color", "red");
				$("#birth").focus();
				return false; // submit 동작 취소
			}
			return true; // submit 동작 수행(생략 가능)
	
		});
		
	});
	
</script>			
</head>
<body>
	<%-- div 태그로 전체를 감싼 후 가운데에 정렬하기 --%>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
				
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>

		<section id="content">	
			<h1 id="h01">회원가입</h1> <%-- 제목영역 --%>
			<section id="join_top"> <%-- 회원가입 진행상황 --%>
				<span>본인인증</span>
				<span>약관동의</span>
				<span id="this">정보입력</span>
				<span>가입완료</span>		
			</section>
			
			<form action="memberJoinPro" method="post" name="joinForm">
				<hr>
				<h3 id="join_top">회원정보입력</h3> <%-- 소제목 --%>
				<section id="join_center">
					<input type="text" id="id" name="member_id" placeholder="아이디">
					<div id="checkIdResult"></div> <br>
					<input type="password" id="passwd" name="member_passwd" placeholder="비밀번호">
					<div id="checkPasswdResult"></div> <br>
					<input type="password" id="passwd2" name="passwd2" placeholder="비밀번호확인">
					<div id="checkPasswd2Result"></div> <br>
					<input type="text" id="name" name="member_name" placeholder="이름">
					<div id="checkNameResult"></div> <br>
					<input type="tel" id="phone" name="member_phone" placeholder="휴대폰번호"  maxlength="13">
					<div id="checkPhoneResult"></div> <br>
					<input type="text" id="email" name="member_email" placeholder="이메일주소">
					<div id="checkEmailResult"></div> <br>
					<input type="text" id="birth" name="member_birth" placeholder="생년월일" maxlength="10">
					<div id="checkBirthResult"></div> <br>
					<div class="joinbtn">
						<a href=""><input type="button" value="이전"></a>
						<input type="submit" value="가입완료">
					</div>
				</section>
			</form>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>