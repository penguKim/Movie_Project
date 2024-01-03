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
		isSafePasswd = false;
		iscorrectPasswd = false;
		isSamePasswd = false;
		
		<%-- 패스워드 확인 --%>
		$("#newPasswd").blur(function() {	
			let member_passwd = $("#newPasswd").val();
			
			<%-- 비밀번호 길이, 문자종류 검증 --%>
			let regPw = /^[A-Za-z0-9!@#%^&*]{8,16}$/; <%-- 8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*) --%>
			if(!regPw.exec(member_passwd)) { <%-- 비밀번호 길이, 문자종류 위반 --%>
				$("#checkNewPasswdResult").text("8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*)만 사용 가능합니다").css("color", "red");
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
						$("#checkNewPasswdResult").text("안전").css("color", "green");
						isSafePasswd = true;
						iscorrectPasswd = true;
						break;
					case 3: 
						$("#checkNewPasswdResult").text("보통").css("color", "blue");
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
			
		});

		<%-- 비밀번호와 비밀번호 확인이 같은지 체크하기 --%>
		$("#newPasswd").on("keyup", function() {	
		    if($("#newPasswd").val() == $("#newPasswd2").val()) { // 일치
		    	$("#checkNewPasswd2Result").text("비밀번호가 일치합니다").css("color", "blue");
		    	isSamePasswd = true;
		    } else { // 불일치
		    	$("#checkNewPasswd2Result").text("비밀번호가 일치하지 않습니다").css("color", "red");		     	
		    	isSamePasswd = false;
		    }
			
		});
		
		$("#newPasswd2").on("keyup", function() {	
		    if($("#newPasswd").val() == $("#newPasswd2").val()) { // 일치
		    	$("#checkNewPasswd2Result").text("비밀번호가 일치합니다").css("color", "blue");
		    	isSamePasswd = true;
		    } else { // 불일치
		    	$("#checkNewPasswd2Result").text("비밀번호가 일치하지 않습니다").css("color", "red");		     	
		    	isSamePasswd = false;
		    }
			
		});
		
		$("#modifyPw").on("click", function() {
			if(!isSafePasswd) {
				$("#checkNewPasswdResult").text("8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*)만 사용 가능합니다").css("color", "red");
				$("#newPasswd").focus;
			} else if(!iscorrectPasswd) {
				$("#checkNewPasswdResult").text("8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*)만 사용 가능합니다").css("color", "red");
				$("#newPasswd").focus;
			} else if(!isSamePasswd) {
				$("#newPasswd2").focus();
			} else {
				let id = $("#showId").val();
				let newPasswd = $("#newPasswd").val();
				$.ajax({
					type: "POST",
					url: "modifyMemberPwPro",
					data: {
						member_id: id,
						newPasswd: newPasswd
					},
					success: function(result) {
						if(!result) {
							alert("비밀번호 수정을 실패했습니다.");
						} else {
							$("#modal-subject").html("<h3>비밀번호를 수정했습니다.</h3><br><br>"
									+ "<a href='memberLogin'><input type='button' value='로그인하기'></a>"
									+ "&nbsp;<a href='./'><input type='button' value='메인으로 이동'></a>"
								);
							$("#myModal").show();
						}
					},
					error: function(xhr, textStatus, errorThrown) {
						alert("비밀번호 수정을 실패했습니다.");
					}
					
				});
			}
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
		<h1 id="h01">비밀번호 재설정</h1>
		<hr>
		<div class="login_center">
		<h4>새로 사용하실 비밀번호를 설정해주세요</h4>
			<div id=findArea>
				<label for="id"><b>아이디</b></label>
				<input type="text" value="${member.member_id }" name="member_id" id="showId" class="Certification" readonly>
				<div id="checkIdResult" class="resultArea"></div>
				<label for="newPasswd"><b>새 비밀번호</b></label>
				<input type="password" placeholder="8~16자의 영문 대/소문자, 숫자, 특수문자(!@#%^&*)" name="newPasswd" id="newPasswd" class="Certification">
				<div id="checkNewPasswdResult" class="resultArea"></div>
				<label for="newPasswd2"><b>새 비밀번호확인</b></label>
				<input type="password" placeholder="비밀번호를 다시 입력해주세요" name="newPasswd2" id="newPasswd2" class="Certification">
				<div id="checkNewPasswd2Result" class="resultArea"></div>
				<input type="button" value="돌아가기" onclick='history.back();'><%--로그인 페이지로 돌아가기 --%>
				<input type="button" value="비밀번호 수정" id="modifyPw">
			<%--"아이디를 알림창으로 띄운뒤" 로그인 페이지로 돌아가기 --%>
			</div>
		</div>
		<!-- 모달 배경 -->
		<div id="myModal" class="modal">
			<!-- 모달 컨텐츠 -->
			<div class="modal-content">
				<div id="modal-subject"></div>
			</div>
		</div>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>