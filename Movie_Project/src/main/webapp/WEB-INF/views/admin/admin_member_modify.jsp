<%-- admin_member_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 상세</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		let name = $("#member_name").val();
		let passwd = $("#passwd").val();
		console.log(passwd);
		let member_birth = $("#member_birth").val();
		let member_phone = $("#member_phone").val();
		let member_email = $("#member_email").val();
		
		
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

		<%-- 이름 확인 --%>
		$("#mamber_name").on("blur", function() {	
			if(name == $("#member_name").val()) {
				$("#checkNameResult").text("기존과 동일한 이름입니다").css("color", "blue");
				iscorrectName = true;
			} else {
				let regName = /^[가-힣]{2,5}$/; <%-- 한글 2~5글자 --%>
				if(!regName.test($("#mamber_name").val())){
					$("#checkNameResult").text("2~5글자의 한글만 사용 가능합니다").css("color", "red");
					iscorrectName = false;
				} else if(regName.test($("#mamber_name").val())){
					$("#checkNameResult").text("사용 가능한 이름입니다").css("color", "blue");
					iscorrectName = true;
		        }
			}
			
		});	
		
		<%-- 패스워드 확인 --%>
		$("#newPasswd").blur(function() {	
			let newPasswd = $("#newPasswd").val();
			if(passwd == newPasswd) {
				$("#checkNewPasswdResult").text("기존과 동일한 이름입니다").css("color", "blue");
				isSafePasswd = true;
				iscorrectPasswd = true;
			} else {
				<%-- 비밀번호 길이, 문자종류 검증 --%>
				let regPw = /^[A-Za-z0-9!@#%^&*]{8,16}$/; <%-- 8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*) --%>
				if(!regPw.exec(newPasswd)) { <%-- 비밀번호 길이, 문자종류 위반 --%>
					$("#checkNewPasswdResult").text("8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*)만 사용 가능합니다").css("color", "red");
					iscorrectPasswd = false;
				} else { <%-- 통과했을 때 복잡도 검증 실행 --%>
					let count = 0; <%-- 복잡도 점수를 저장할 변수 선언 --%>
					
					let regEngUpper = /[A-Z]/; <%-- 대문자 --%>
					let regEngLower = /[a-z]/; <%-- 소문자 --%>
					let regNum = /[0-9]/; <%-- 숫자 --%>
					let regSpec = /[!@#%^&*]/; <%-- 특수문자(!@#%^&*) --%>
				
					if(regEngUpper.exec(newPasswd)) count++; <%-- 대문자가 있으면 +1점 --%>
					if(regEngLower.exec(newPasswd)) count++; <%-- 소문자가 있으면 +1점 --%>
					if(regNum.exec(newPasswd)) count++; <%-- 숫자가 있으면 +1점 --%>
					if(regSpec.exec(newPasswd)) count++; <%-- 특수문자가 있으면 +1점 --%>
					
					switch (count) {
						case 4: 
							$("#checkNewPasswdResult").text("안전").css("color", "blue");
							isSafePasswd = true;
							iscorrectPasswd = true;
							break;
						case 3: 
							$("#checkNewPasswdResult").text("보통").css("color", "yello");
							isSafePasswd = true;
							iscorrectPasswd = true;
							break;
						case 2: 
							$("#checkNewPasswdResult").text("주의").css("color", "orange");
							isSafePasswd = false;
							iscorrectPasswd = false;
							break;
						case 1: 
						case 0: 
							$("#checkNewPasswdResult").text("위험").css("color", "red");
							isSafePasswd = false;
							iscorrectPasswd = false;
							break;
					}
				}
			}
		});
		
// 		$("newPasswd").on("blur", function() {
// 			$.ajax({
// 				url: "passwdCheck",
// 				data: {
// 					member_id: $("#mamber_id").val(),
// 					newPasswd: $("#newPasswd").val()
// 				},
// 				success: function(passwdCheck) {
// 					console.log(passwdCheck);
// 				}
// 			});
// 			if($("#newPasswd").val() == $("#passwd").val()) {
// 		    	$("#checkPasswd2Result").text("기존 비밀번호와 동일합니다").css("color", "blue");
// 			}
// 		});
// 		$("#newPasswd").on("keyup", function() {	
// 		    if($("#newPasswd").val() == $("#newPasswd2").val()) { // 일치
// 		    	$("#checkPasswd2Result").text("비밀번호가 일치합니다").css("color", "blue");
// 		    	isSamePasswd = true;
// 		    } else { // 불일치
// 		    	$("#checkPasswd2Result").text("비밀번호가 일치하지 않습니다").css("color", "red");		     	
// 		    	isSamePasswd = false;
// 		    }
			
// 		});
		
		<%-- 비밀번호와 비밀번호 확인이 같은지 체크하기 --%>
		$("#newPasswd2").on("keyup", function() {	
		    if($("#newPasswd").val() == $("#newPasswd2").val()) { // 일치
		    	$("#checkNewPasswd2Result").text("비밀번호가 일치합니다").css("color", "blue");
		    	isSamePasswd = true;
		    } else { // 불일치
		    	$("#checkNewPasswd2Result").text("비밀번호가 일치하지 않습니다").css("color", "red");		     	
		    	isSamePasswd = false;
		    }
		});
		
		
		<%-- 이메일주소 확인 --%>
		$("#member_email").blur(function() {			
			let member_email = $("#member_email").val();
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

		
	});
</script>
</head>
<body>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">${member.member_name }의 회원정보</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>

			<div id="admin_sub">
				<form action="memberModOrDlt" method="post">
					<table border="1">
						<tr>
							<th>이름</th>	
							<td colspan="2">
								<input type="text" name="member_name" value="${member.member_name }" id="mamber_name" required>
								<div id="checkNameResult"></div>
							</td>
						</tr>
						<tr>
							<th>계정</th>
							<td colspan="2">
								<input type="text" name="member_id" value="${member.member_id }" id="mamber_id" readonly>
							</td>
						</tr>
						<tr>
							<th>새 비밀번호</th>
							<td>
								<input type="password" name="newPasswd" id="newPasswd" placeholder="8~16글자(변경시 입력)">
								<div id="checkNewPasswdResult"></div>
							</td>
						</tr>
						<tr>
							<th>새 비밀번호확인</th>
							<td>
								<input type="password" name="newPasswd2" id="newPasswd2" placeholder="(변경시 입력)">
								<div id="checkNewPasswd2Result"></dic>
							</td>
						</tr>
						<!-- 멤버십(회원등급)은 부기능이므로 제외시켜놓음 -->
	<!-- 						<tr> -->
	<!-- 							<th>멤버십</th> -->
	<!-- 							<td> -->
	<!-- 								<select> -->
	<!-- 									<option selected>BRONZE</option> -->
	<!-- 									<option>SILVER</option> -->
	<!-- 									<option>GOLD</option> -->
	<!-- 									<option>PLATINUM</option> -->
	<!-- 								</select> -->
	<!-- 							</td> -->
	<!-- 						</tr> -->

						<tr>
							<th>생년월일</th>
							<td colspan="2">
								<input type="text" id="member_birth" name="member_birth" value="${member.member_birth }" placeholder="생년월일" maxlength="10">
								<div id="checkBirthResult"></div>
							</td>
						</tr>
						<tr>
							<th>휴대폰번호</th>
							<td colspan="2">
								<input type="tel" id="member_phone" name="member_phone" value="${member.member_phone }" placeholder="휴대폰번호"  maxlength="13">
								<div id="checkPhoneResult"></div>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td colspan="2">
								<input type="text" name="member_email" value="${member.member_email }" id="member_email">
								<div id="checkEmailResult"></div>
							</td>
						</tr>
						<tr>
							<th>활동상태</th>
							<td>
								<select name="member_status" id="member_status">
									<option value="1" id="active" <c:if test="${member.member_status eq 1 }">selected</c:if>>활동</option>
									<option value="2" id="withdraw" <c:if test="${member.member_status eq 2 }">selected</c:if>>탈퇴</option>
								</select>
							</td>
						</tr>
					</table>
					<input type="hidden" name="passwd" id="passwd" value="${member.member_passwd }">	
					<input type="hidden" name="pageNum" value="${pageNum }">	
					<div id="admin_writer"> 
						<input type="submit" value="정보 수정">
						<input type="button" value="돌아가기" onclick="history.back();">
					</div>
				</form>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>			
</body>
</html>