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
	<%-- AJAX 를 활용하여 아이디 중복 검사 작업 수행 --%>
	$(function() {	
		$("#id_check").on("click", function() {
			$.ajax({
				url: "resources/join/check_id.jsp",
				data: {
					id: $("#id").val()
				},
				success: function(result) {
					if($("#id").val().length >= 5 && $("#id").val().length <= 20) {
						if(result.trim() == "true") {
// 							trim()을 써서 문자열 공백을 제거하고 비교
 							$("#checkIdResult").text("이미 사용중인 아이디입니다").css("color", "red");
 							$("#id").focus();
						} else if(result.trim() == "false") {
							$("#checkIdResult").text("사용 가능한 아이디입니다").css("color", "blue");
							$("#passwd").focus();
						}
						
					}
				}
			});

		});
	});
	
	$(function() {
		<%-- 비밀번호와 비밀번호 확인이 같은지 체크하기 --%>
		$("#passwd").on("keyup", function() {	
		    if($("#passwd").val() == $("#passwd2").val()) { // 일치
		    	$("#checkPasswd2Result").text("비밀번호가 일치합니다").css("color", "blue");
		    } else { // 불일치
		    	$("#checkPasswd2Result").text("비밀번호가 일치하지 않습니다").css("color", "red");		     	
		    }
			
		});
		
		$("#passwd2").on("keyup", function() {	
		    if($("#passwd").val() == $("#passwd2").val()) { // 일치
		    	$("#checkPasswd2Result").text("비밀번호가 일치합니다").css("color", "blue");
		    } else { // 불일치
		    	$("#checkPasswd2Result").text("비밀번호가 일치하지 않습니다").css("color", "red");		     	
		    }
			
		});
	});
	
	<%-- 입력창에서 커서가 빠져나갈 때 올바른 형식인지 확인 --%>
	$(function() {
		<%-- 정규식 작성 --%>
		let regId = /^[A-Za-z0-9]{5,20}$/; <%-- 5~20자의 영문(대소문자), 숫자 --%>
		let regPw = /^[A-Za-z0-9!@#%^&*]{8,16}$/; <%-- 8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*) --%>
		let regName = /^[가-힣]{2,5}$/; <%-- 한글 2~5글자 --%>
		let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		<%-- 대소문자숫자 @ 대소문자숫자 . 대소문자 형식 --%>
		let regPhone = /^010-\d{4}-\d{4}$/; <%-- 010으로 시작하는 11자리 숫자 --%>
		let regBirth = /^(19[0-9][0-9]|20[0-2][0-9]).(0[0-9]|1[0-2]).(0[1-9]|[1-2][0-9]|3[0-1])$/; <%-- 1920년~2029년까지/01월~12월까지/01일~31일까지의 8자리 숫자 --%>
		
		<%-- 아이디 확인 --%>
		$("#id").on("blur", function() {
			if(!regId.test($("#id").val())){
				$("#checkIdResult").text("5~20자의 영문 대/소문자, 숫자를 입력해주세요").css("color", "red");
			}
		});	
			
		<%-- 패스워드 확인 --%>
		$("#passwd").on("blur", function() {	
			if(!regPw.test($("#passwd").val())){
				$("#checkPasswdResult").text("8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*)만 사용 가능합니다").css("color", "red");
			} else if(regPw.test($("#passwd").val())) {
				$("#checkPasswdResult").text("적합한 비밀번호입니다").css("color", "blue");
	        }
		});		
			
		<%-- 이름 확인 --%>
		$("#name").on("blur", function() {		
			if(!regName.test($("#name").val())){
				$("#checkNameResult").text("2~5글자의 한글만 입력 가능합니다").css("color", "red");
			} else if(regName.test($("#name").val())){
				$("#checkNameResult").text("사용 가능한 이름입니다").css("color", "blue");
	        }
		});		
			
		<%-- 이메일주소 확인 --%>
		$("#email").on("blur", function() {			
			if(!regEmail.test($("#email").val())){
				$("#checkEmailResult").text("올바른 이메일 형식으로 입력해주세요").css("color", "red");
			} else if(regEmail.test($("#email").val())){
				$("#checkEmailResult").text("사용 가능한 이메일주소입니다").css("color", "blue");
	        }
		});			
		
		<%-- 휴대폰번호 확인 --%>
		$("#phone").on("blur", function() {			
			if(!regPhone.test($("#phone").val())){
				$("#checkPhoneResult").text("올바른 휴대폰번호 형식으로 입력해주세요").css("color", "red");
			} else if(regPhone.test($("#phone").val())){
				$("#checkPhoneResult").text("사용 가능한 휴대폰번호입니다").css("color", "blue");
	        }
		});			
			
		<%-- 생년월일 확인 --%>
		$("#birth").on("blur", function() {				
			if(!regBirth.test($("#birth").val())){
				$("#checkBirthResult").text("생년월일을 올바르게 입력해주세요").css("color", "red");
			} else if(regBirth.test($("#birth").val())) {
				$("#checkBirthResult").text("사용 가능한 생년월일입니다").css("color", "blue");
	        }
		});	
			
	});
	
	<%-- 전화번호에 자동 "-" 입력 --%>
	$(function() {
		$("#phone").keyup(function(){
			var val = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 입력 가능
			if(val.length > 3 && val.length < 6) {
				$(this).val(val.substring(0,3) + "-" + val.substring(3));
			}else if (val.length > 7) {
				$(this).val(val.substring(0,3) + "-" + val.substring(3, 7) + "-" + val.substring(7));
					
			}
		});
	});
	
	<%-- 생년월일에 자동 "." 입력 --%>
	$(function() {
		$("#birth").keyup(function(){
			var val = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 입력 가능
			if(val.length > 4 && val.length < 6) {
				$(this).val(val.substring(0,4) + "." + val.substring(4));
			}else if (val.length > 7) {
				$(this).val(val.substring(0,4) + "." + val.substring(4, 6) + "." + val.substring(6));
					
			}
		});
	});
	
	
	<%-- submit 동작을 수행할 때 값을 올바르게 입력했는지 확인 --%>
	$(function() {
		<%-- 정규식 작성 --%>
		let regId = /^[A-Za-z0-9]{5,20}$/; <%-- 5~20자의 영문(대소문자), 숫자 --%>
		let regPw = /^[A-Za-z0-9!@#%^&*]{8,16}$/; <%-- 8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*) --%>
		let regName = /^[가-힣]{2,5}$/; <%-- 한글 2~5글자 --%>
		let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		<%-- 대소문자숫자 @ 대소문자숫자 . 대소문자 형식 --%>
		let regPhone = /^010-\d{4}-\d{4}$/; <%-- 010으로 시작하는 11자리 숫자 --%>
		let regBirth = /^(19[0-9][0-9]|20[0-2][0-9]).(0[0-9]|1[0-2]).(0[1-9]|[1-2][0-9]|3[0-1])$/; <%-- 1920년~2029년까지/01월~12월까지/01일~31일까지의 8자리 숫자 --%>
		
		$("form").on("submit", function() {
			if($("#id").val() == "") {
				$("#checkIdResult").text("아이디 입력은 필수입니다").css("color", "red");
				$("#id").focus();
				return false; // submit 동작 취소
			} else if(!regId.test($("#id").val())){
				$("#checkIdResult").text("5~20자의 영문 대/소문자, 숫자를 입력해주세요").css("color", "red");
				$("#id").focus();
				return false; // submit 동작 취소
// 			} else if($("#checkIdResult").text() != "사용 가능한 아이디입니다"){
// 				$("#checkIdResult").text("아이디 중복확인을 해주세요").css("color", "red");
// 				$("#id_check").focus();
// 				return false; // submit 동작 취소
			} else if($("#passwd").val() == "")  {
				$("#checkPasswdResult").text("비밀번호 입력은 필수입니다").css("color", "red");
				$("#passwd").focus();
				return false; // submit 동작 취소
			} else if(!regPw.test($("#passwd").val())) {
				$("#checkPasswdResult").text("8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*)만 사용 가능합니다").css("color", "red");
				$("#passwd").focus();
				return false; // submit 동작 취소
			} else if($("#passwd2").val() == "") {
				$("#checkPasswd2Result").text("비밀번호 일치 여부를 확인해주세요").css("color", "red");
				$("#passwd2").focus();
				return false; // submit 동작 취소
			} else if($("#passwd").val() != $("#passwd2").val()) {
				$("#checkPasswdResult2").text("비밀번호가 일치하지 않습니다").css("color", "red");
				$("#passwd2").focus();
				return false; // submit 동작 취소
			} else if($("#name").val() == "") {
				$("#checkNameResult").text("이름 입력은 필수입니다").css("color", "red");
				$("#name").focus();
				return false; // submit 동작 취소
			} else if(!regName.test($("#name").val())) {
				$("#checkNameResult").text("2~5글자의 한글만 입력 가능합니다").css("color", "red");
				$("#name").focus();
				return false; // submit 동작 취소
			} else if($("#phone").val() == "") {
				$("#checkPhoneResult").text("휴대폰번호 입력은 필수입니다").css("color", "red");
				$("#phone").focus();
				return false; // submit 동작 취소
			} else if(!regPhone.test($("#phone").val())) {
				$("#checkPhoneResult").text("올바른 휴대폰번호 형식으로 입력해주세요").css("color", "red");
				$("#phone").focus();
				return false; // submit 동작 취소
			} else if($("#email").val() == "") {
				$("#checkEmailResult").text("이메일주소 입력은 필수입니다").css("color", "red");
				$("#email").focus();
				return false; // submit 동작 취소
			} else if(!regEmail.test($("#email").val())) {
				$("#checkEmailResult").text("올바른 이메일 형식으로 입력해주세요").css("color", "red");
				$("#email").focus();
				return false; // submit 동작 취소
			} else if($("#birth").val() == "") {
				$("#checkBirthResult").text("생년월일 입력은 필수입니다").css("color", "red");
				$("#birth").focus();
				return false; // submit 동작 취소
			} else if(!regBirth.test($("#birth").val())) {
				$("#checkBirthResult").text("생년월일을 올바르게 입력해주세요").css("color", "red");
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
				<b id="warning">*은 필수</b> <br>
				<section id="join_center">
					<input type="text" id="id" name="member_id" placeholder="*아이디">
					<input type="button" id="id_check" value="중복확인"> <br>
					<span id="checkIdResult"></span> <br>
					<input type="text" id="passwd" name="member_pass" placeholder="*비밀번호"> <br>
					<span id="checkPasswdResult"></span> <br>
					<input type="text" id="passwd2" name="passwd2" placeholder="*비밀번호확인"> <br>
					<span id="checkPasswd2Result"></span> <br>
					<input type="text" id="name" name="member_name" placeholder="*이름"> <br>
					<span id="checkNameResult"></span> <br>
					<input type="tel" id="phone" name="member_phone" placeholder="*휴대폰번호"  maxlength="13"> <br>
					<span id="checkPhoneResult"></span> <br>
					<input type="text" id="email" name="member_email" placeholder="*이메일주소"> <br>
					<span id="checkEmailResult"></span> <br>
					<input type="text" id="birth" name="member_birth" placeholder="*생년월일" maxlength="10"> <br>
					<span id="checkBirthResult"></span> <br>
					<div class="joinbtn">
						<a href="join_agree.jsp"><input type="button" value="이전"></a>
						<a href="join_completion.jsp" ><input type="submit" value="가입완료"></a>
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