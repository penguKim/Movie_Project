<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		// 변수 선언
		let iscorrectName = false;
		let iscorrectEmail = false;
		let iscorrectBirth = false;
// 		var isSended = false;
// 		var isChecked = false;
		
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
		
		<%-- 생년월일 확인 --%>
		let regBirth = /^(19[0-9][0-9]|20[0-2][0-9]).(0[0-9]|1[0-2]).(0[1-9]|[1-2][0-9]|3[0-1])$/; <%-- 1920년~2029년까지/01월~12월까지/01일~31일까지의 8자리 숫자 --%>
		$("#member_birth").on("blur", function() {				
			if(!regBirth.test($("#member_birth").val())) {
				$("#checkBirthResult").text("생년월일을 확인해주세요").css("color", "red");
				iscorrectBirth = false;
			} else if(regBirth.test($("#member_birth").val())) {
				$("#checkBirthResult").text("사용 가능한 생년월일입니다").css("color", "blue");
				iscorrectBirth = true;
	        }
		});	
		
		<%-- 생년월일에 자동 "." 입력 --%>
		$("#member_birth").keyup(function() {
			var val = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 입력 가능
			if(val.length > 4 && val.length < 6) {
				$(this).val(val.substring(0,4) + "." + val.substring(4));
			}else if (val.length > 7) {
				$(this).val(val.substring(0,4) + "." + val.substring(4, 6) + "." + val.substring(6));
			}
		});
		
		<%-- 이메일 확인 --%>
		$("#member_email").on("blur", function() {
			let member_email = $("#member_email").val();
			let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			
			if(!regEmail.exec(member_email)){
				$("#checkEmailResult").text("이메일 주소를 확인해주세요").css("color", "red");
				iscorrectEmail = false;
			} else {
				$("#checkEmailResult").text("사용 가능한 이메일입니다").css("color", "blue");
				iscorrectEmail = true;
			}
		});
		
		
		// 인증번호 발송 버튼을 클릭했을 때
// 		$("#sendMail").click(function() {		
// 			let member_email = $("#member_email").val();
// 			let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			
// 			if(!regEmail.exec(member_email)){
// 				$("#checkEmailResult").text("이메일 주소를 확인해주세요").css("color", "red");
// 			} else {
// 				$("#checkEmailResult").text("사용 가능한 이메일입니다").css("color", "blue");
// // 				alert("인증번호를 발송했습니다. \n인증번호를 확인하고 인증번호확인란에 입력해주세요.");
// 				// 인증여부를 저장하는 변수 값을 true로 변경
// 				isSended = true;
// 				$("#sendMail").val("인증번호재발송");
				
// 				// 인증번호 발송 요청
// 				$.ajax({
// 					url: "authEmail",
// 					data: {
// 						member_email : member_email
// 					},
// 					success: function(data) {
// 						$("#authCode").val(data);
					
// 					},
// 					error: function(xhr, status, error) {
// 					      // 요청이 실패한 경우 처리할 로직
// 					      console.log("AJAX 요청 실패:", error); // 예시: 에러 메시지 출력
// 					}
// 				});
// 			}
// 		});
		
// 		$("#checkCode").on("click", function() {
// 			if(!isSended) {
// 				$("#checkResult").text("인증번호를 발송해주세요.").css("color", "red");
// 				$("#member_email").focus();
// 				isChecked = false;
// 			} else if($("#cNum").val() == '') {
// 				$("#checkResult").text("인증번호를 입력해주세요.").css("color", "red");
// 				$("#cNum").focus();
// 				isChecked = false;
// 			} else if($("#cNum").val() != $("#authCode").val()) {
// 				$("#checkResult").text("인증번호가 일치하지 않습니다.").css("color", "red");
// 				isChecked = false;
// 			} else if($("#cNum").val() == $("#authCode").val()) {
// 				$("#checkResult").text("인증번호가 일치합니다.").css("color", "blue");
// 				isChecked = true;
// 				$("#authCode").val("");
// 			}
// 		});

		
		$("#findId").on("click", function() {
			let name = $("#name").val();
			let birth = $("#member_birth").val();
			let email = $("#member_email").val();
			if(!iscorrectName) {
				$("#checkNameResult").text("2~5글자의 한글만 사용 가능합니다").css("color", "red");
				$("#name").focus();
			} else if(!iscorrectBirth) {
				$("#checkBirthResult").text("생년월일을 확인해주세요").css("color", "red");
				$("#member_birth").focus();
			} else if(!iscorrectEmail) {
				$("#checkEmailResult").text("이메일 주소를 확인해주세요").css("color", "red");
				$("#member_email").focus();
			} else {
				$.ajax({
					type: "GET",
					url: "idFindPro",
					data: {
						member_name: name,
						member_birth: birth,
						member_email: email
					},
					success: function(result) {
						console.log(result);
						if(result == '') {
							alert("일치하는 회원이 없습니다!");
						} else {
							$("#modal-subject").html("<h3>회원님의 ID는</h3>"
									+ "<div><h3>" + result.member_id + " 입니다.</h3></div>"
									+ "<a href='memberLogin?member_id=" + result.member_id + "'><input type='button' value='로그인하기'></a>"
									+ "&nbsp;<a href='./'><input type='button' value='메인으로 이동'></a>"
								);
							$("#myModal").show();
						}
					},
					error: function(xhr, textStatus, errorThrown) {
						alert("아이디 조회를 실패했습니다.");
					}
				});
			}
		});
		
		// 모달 열기 버튼 클릭 이벤트
		function eventModal(name, birth, email) {
	<%-- 		$("body").addClass("not_scroll"); body 영역 스크롤바 삭제 --%>

		}
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
		<h1 id="h01">아이디찾기</h1>
		<hr>
		<nav class="login_find">
			<ul>
				<li>
					<a href="idFind">
					<input type="button" value="아이디찾기">
					</a>
				</li>
				<li>
					<a href="pwFind">
					<input type="button" value="비밀번호찾기">
					</a>
				</li>
			</ul>
		</nav>
<!-- 			<form action="idFindPro" method="post"> -->
				<div class="login_center">
					<h4>회원가입시 등록한 정보를 입력하세요</h4>
					<div id="findArea">
						<input type="text" placeholder="이름을 입력하세요" id="name" name="member_name" class="Certification">
						<div id="checkNameResult" class="resultArea"></div>
						<input type="text" placeholder="생년월일 8자리를 입력하세요" id="member_birth" name="member_birth" class="Certification" maxlength="10">
						<div id="checkBirthResult" class="resultArea"></div>
						<input type="text" placeholder="이메일을 입력하세요" name="member_email" id="member_email" class="Certification">
						<div id="checkEmailResult" class="resultArea"></div>
<!-- 						<input type="button" id="sendMail" value="인증번호발송"> -->
<!-- 						<input type="text" placeholder="인증번호를 입력하세요" id="cNum" name="cNum" class="Certification"> -->
<!-- 						<input type="hidden" id="authCode"> -->
<!-- 						<input type="button" id="checkCode" value="인증번호 확인"> -->
<!-- 						<div id="checkResult"></div> -->
						<input type="button" value="돌아가기" onclick='history.back();'><%--로그인 페이지로 돌아가기 --%>
						<input type="button" value="아이디찾기" id="findId">
					</div>
				</div>
				<!-- 모달 배경 -->
				<div id="myModal" class="modal">
					<!-- 모달 컨텐츠 -->
					<div class="modal-content">
						<div id="modal-subject"></div>
					</div>
				</div>
<!-- 			</form> -->
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>