<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/css/join.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	window.onload = function() {
		
		<%-- 키를 누를때마다 비밀번호 길이 체크하기 --%>
		document.joinForm.passwd.onkeyup = function() {
			let passwd = document.joinForm.passwd.value; <%-- 입력받은 비밀번호 저장 --%>
			
		    if(passwd.length >= 8 && passwd.length <= 16) {
		     	document.querySelector("#checkPasswdResult").innerText = "사용 가능한 패스워드";
		     	document.querySelector("#checkPasswdResult").style.color = "blue";
		    } else {
		     	document.querySelector("#checkPasswdResult").innerText = "8 ~ 16글자만 사용 가능합니다";
		     	document.querySelector("#checkPasswdResult").style.color = "red";
		    }
			
		};
		
		<%-- 비밀번호와 같은지 체크하기 --%>
		document.joinForm.passwd2.onkeyup = function() {
			let passwd = document.joinForm.passwd.value;
			let passwd2 = document.joinForm.passwd2.value;
			
		    if(passwd == passwd2) { <%-- 일치 --%>
		     	document.querySelector("#checkPasswd2Result").innerText = "비밀번호가 일치합니다";
		     	document.querySelector("#checkPasswd2Result").style.color = "blue";
		     	isSamePasswd = true;
		    } else { <%-- 불일치 --%>
		     	document.querySelector("#checkPasswd2Result").innerText = "비밀번호가 일치하지 않습니다";
		     	document.querySelector("#checkPasswd2Result").style.color = "red";
		     	isSamePasswd = false;
		    }
			
		};
		
		<%-- 비밀번호와 같은지 체크하기2 --%>
		document.joinForm.passwd.onkeyup = function() {
			let passwd = document.joinForm.passwd.value;
			let passwd2 = document.joinForm.passwd2.value;
			
		    if(passwd2 == passwd) { <%-- 일치 --%>
		     	document.querySelector("#checkPasswd2Result").innerText = "비밀번호가 일치합니다";
		     	document.querySelector("#checkPasswd2Result").style.color = "blue";
		     	isSamePasswd = true;
		    } else { <%-- 불일치 --%>
		     	document.querySelector("#checkPasswd2Result").innerText = "비밀번호가 일치하지 않습니다";
		     	document.querySelector("#checkPasswd2Result").style.color = "red";
		     	isSamePasswd = false;
		    }
			
		};
		
		<%-- "가입완료" 클릭 시
	    	모든 필수 항목이 입력되었을 경우에만 submit 동작이 수행되도록 처리 --%>
		document.joinForm.onsubmit = function() {
			if(document.joinForm.id.value == "") {
				alert("아이디 입력은 필수입니다");
				document.joinForm.id.focus();
				return false; // submit 동작 취소
			} else if(!(document.joinForm.id.value.length >= 5 
					&& document.joinForm.id.value.length <= 20)) {
				alert("아이디를 올바르게 입력해주세요");
				document.joinForm.id.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.passwd.value == "") {
				alert("비밀번호 입력은 필수입니다");
				document.joinForm.passwd.focus();
				return false; // submit 동작 취소
			} else if(!(document.joinForm.passwd.value.length >= 8 
					&& document.joinForm.passwd.value.length <= 16)) {
				alert("비밀번호를 올바르게 입력해주세요");
				document.joinForm.passwd.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.passwd2.value == "") {
				alert("비밀번호 일치 여부를 확인해주세요");
				document.joinForm.passwd2.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.passwd2.value
					!= document.joinForm.passwd.value) {
				alert("비밀번호가 일치하지 않습니다");
				document.joinForm.passwd2.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.name.value == "") {
				alert("이름 입력은 필수입니다");
				document.joinForm.name.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.phone.value == "") {
				alert("휴대폰번호 입력은 필수입니다");
				document.joinForm.phone.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.email.value == "") {
				alert("이메일주소 입력은 필수입니다");
				document.joinForm.email.focus();
				return false; // submit 동작 취소
			} else if(document.joinForm.birth.value == "") {
				alert("생년월일 입력은 필수입니다");
				document.joinForm.birth.focus();
				return false; // submit 동작 취소
			}
			
			return true; // submit 동작 수행(생략 가능)
		};
			
		
	}; // window.onload 이벤트 끝
</script>
<script type="text/javascript">
	$(function() {
		<%-- 아이디 입력란에서 포커스가 해제될 때(커서가 빠져나갈 때)의 이벤트 처리 = blur --%>
		$("#id").on("blur", function() {
			<%-- 입력받은 아이디 가져오기 --%>
			let id = $("#id").val();
			
			if(id == "") { <%-- 입력된 아이디가 없을 경우 --%>
				$("#checkIdResult").text("아이디를 입력해주세요").css("color", "red");
				return;				
			} else if(id.length < 5 || id.length > 20) { <%-- 아이디가 5글자 이상 20글자 이하가 아닐 경우 --%>
				$("#checkIdResult").text("5~20글자만 사용 가능합니다").css("color", "red");
				return;				
		    }
			
		});
		
		$("#id_check").on("click", function() {
			// AJAX 를 활용하여 "test2_check_id2.jsp" 페이지 요청을 통해
			// 아이디 중복 검사 작업 수행 후 결과값을 리턴받아 처리
			// => 아이디 파라미터 전달
			$.ajax({
				// type 속성 생략 시 기본값 "get"
				url: "check_id.jsp",
				data: {
					id: $("#id").val()
				},
				success: function(result) {
// 					// 처리 페이지에서 아이디 중복 검사 비즈니스 로직 처리 성공 후
// 					// "true" 또는 "false" 값 리턴 
// 					// => 자바에서 출력된 데이터지만, 웹 페이지에서는 단순 문자로 취급(boolean 타입 아님!)
// 					// 리턴받은 결과값에 대해 판별 수행
// 					// => "true" 일 경우 checkIdResult 영역에 "이미 사용중인 아이디" 출력(빨간색) 
// 					// => "false" 일 경우 checkIdResult 영역에 "사용 가능한 아이디" 출력(파란색) 
// 					// => 주의! 리턴받은 값을 문자열로만 판별해야할 경우
// 					//    문자열 앞 뒤의 공백 제거를 위해 trim()메서드 사용 권장
// 					if(result.trim() == "true") { // 문자열 비교 필수!
// 						// trim()을 써서 문자열 공백을 제거하고 비교해야 함
// 						$("#checkIdResult").text("이미 사용중인 아이디").css("color", "red");
// 					} else if(result.trim() == "false") {
// 						$("#checkIdResult").text("사용 가능한 아이디").css("color", "blue");
// 					}
					if($("#id").val().length >= 5 && $("#id").val().length <= 20) {
						if(result.trim() == "true") { // 문자열 비교 필수!
							// trim()을 써서 문자열 공백을 제거하고 비교해야 함
							$("#checkIdResult").text("이미 사용중인 아이디입니다").css("color", "red");
						} else if(result.trim() == "false") {
							$("#checkIdResult").text("사용 가능한 아이디입니다").css("color", "blue");
						}
						
					}
				}
			});

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
			
			<form action="join_completion.jsp" method="post" name="joinForm">
				<hr>
				<h3 id="join_top">회원정보입력</h3> <%-- 소제목 --%>
				<b id="warning">*은 필수</b> <br>
				<section id="join_center">
					<input type="text" id="id" name="id" placeholder="*아이디">
					<input type="button" id="id_check" value="중복확인"> <br>
					<span id="checkIdResult"></span> <br>
					<input type="text" id="passwd" name="passwd" placeholder="*비밀번호"> <br>
					<span id="checkPasswdResult"></span> <br>
					<input type="text" id="passwd2" name="passwd2" placeholder="*비밀번호확인"> <br>
					<span id="checkPasswd2Result"></span> <br>
					<input type="text" id="name" name="name" placeholder="*이름"> <br>
					<input type="phone" id="phone" name="phone" placeholder="*휴대폰번호"  maxlength="11"> <br>
					<input type="text" id="email" name="email" placeholder="*이메일주소"> <br>
					<input type="text" id="birth" name="birth" placeholder="*생년월일" maxlength="8"> <br>
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