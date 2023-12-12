<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/join.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		
		$("#agreeAll").on("change", function() {
			
			if($("#agreeAll").prop("checked")) {
				$(":checkbox").prop("checked", true);
			} else {
				$(":checkbox").prop("checked", false);
			}
		});
		
		$("form").on("submit", function() {
			if(!$("input:checkbox[name=agree]").eq(0).prop("checked") ) {
				alert("서비스 이용 약관에 동의를 해주세요.");
				return false;
			}
		
			if(!$("input:checkbox[name=agree]").eq(1).prop("checked") ) {
				alert("개인정보 수입 및 이용 약관에 동의를 해주세요.");
				return false;
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
			<h1 id="h01">회원가입</h1>
			<section id="join_top">
				<span>본인인증</span>
				<span id="this">약관동의</span>
				<span>정보입력</span>
				<span>가입완료</span>		
			</section>
	
			<form  action="memberJoinForm" method="post" name="joinAgree">
				<hr>
				<h3 id="join_top">약관 및 정보활용 동의</h3>
				<label><input type="checkbox" id="agreeAll">전체동의</label> <br>
				<hr>
				<section id="agree" name="agree">
					<label id="required"><input type="checkbox" name="agree" value="서비스 이용 약관 동의(필수)">
					서비스 이용 약관 동의(필수)</label> <br>
					<%-- 들여쓰기 하시면 안됩니다! --%>
					<textarea readonly>제 1 장 총칙
제 1조 (목적)

본 약관은 서비스(이하 "회사"라 한다)는 홈페이지에서 제공하는 서비스(이하 "서비스"
라 한다)를 제공함에 있어 회사와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로
합니다.

제 2조 (용어의 정의)

1. 본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
   '서비스'란 회사가 이용자에게 서비스를 제공하기 위하여 컴퓨터 등 정보통신설비를 이용
   하여 구성한 가상의 공간을 의미하며, 서비스 자체를 의미하기도 합니다.
   '회원(이하 "회원"이라 한다)'이란 개인정보를 제공하여 회원등록을 한 자로서 홈페이지의 
   정보를 지속적으로 제공받으며 홈페이지가 제공하는 서비스를 계속적으로 이용할 수 있는 
   자를 말합니다.
   '아이디(이하 "ID"라 한다)'란 회원의 식별과 회원의 서비스 이용을 위하여 회원이 선정
   하고 회사가 승인하는 회원 고유의 계정 정보를 의미합니다.
   '비밀번호'란 회원이 부여 받은 ID와 일치된 회원임을 확인하고, 회원의 개인정보를 보호
   하기 위하여 회원이 정한 문자와 숫자의 조합을 의미합니다.
   '회원탈퇴(이하 "탈퇴"라 한다)'란 회원이 이용계약을 해지하는 것을 의미합니다.

2. 본 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령 및 
   서비스 별 안내에서 정하는 바에 의합니다.

제 3조 (이용약관의 효력 및 변경)

1. 회사는 본 약관의 내용을 회원이 쉽게 알 수 있도록 각 서비스 사이트의 초기 서비스
   화면에 게시합니다.
2. 회사는 약관의 규제에 관한 법률, 전자거래기본법, 전자 서명법, 정보통신망 이용촉진 및
   정보보호 등에 관한 법률 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 
   있습니다.
3. 회사는 본 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행 약관과 함께 
   회사가 제공하는 서비스 사이트의 초기 화면에 그 적용일자 7일 이전부터 적용일자 
   전일까지 공지합니다.
   다만, 회원에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예
   기간을 두고 공지합니다. 이 경우 회사는 개정 전 내용과 개정 후 내용을 명확하게 비교
   하여 회원이 알기 쉽도록 표시합니다.
4. 회원은 개정된 약관에 대해 거부할 권리가 있습니다. 회원은 개정된 약관에 동의하지 않을
   경우 서비스 이용을 중단하고 회원등록을 해지할 수 있습니다.
   단, 개정된 약관의 효력 발생일 이후에도 서비스를 계속 이용할 경우에는 약관의 변경
   사항에 동의한 것으로 간주합니다.
5. 변경된 약관에 대한 정보를 알지 못해 발생하는 회원 피해는 회사가 책임지지 않습니다.</textarea> <br> <br>
					<label id="required"><input type="checkbox" name="agree" value="개인정보 수집 및 이용 동의(필수)">
					개인정보 수집 및 이용 동의(필수)</label> <br>
					<textarea readonly>개인정보보호법에 따라 영화관에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 
개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 
불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
영화관은 개인정보를 안전하게 취급하는데 최선을 다합니다.

아래에 동의하시면 영화관이 제공하는 서비스를 편리하게 이용하실 수 있습니다.
이용자 식별 및 본인여부 확인(아이디, 이름, 생년월일, 비밀번호) : 회원 탈퇴 시까지
고객서비스 이용에 관한 통지, CS대응을 위한 이용자 식별(이메일, 휴대폰번호)
 : 회원 탈퇴 시까지

개인정보 수집 및 이용에 대해서는 거부할 수 있으며, 거부 시에는 회원가입이 불가합니다.
서비스 제공을 위해서 반드시 필요한 최소한의 개인정보이므로 동의를 하셔야 서비스 이용이 
가능합니다.
이 외 서비스 이용과정에서 별도 동의를 통해 추가정보 수집이 있을 수 있습니다.
</textarea> <br> <br>
					<label><input type="checkbox" name="agree" value="마케팅 활용을 위한 개인정보 수집 및 이용 안내(선택)">
					마케팅 활용을 위한 개인정보 수집 및 이용 안내(선택)</label> <br>
					<textarea readonly>영화관의 이벤트・혜택 등의 정보 발송을 위해 아이디, 휴대전화번호(문자), 이메일주소를 
수집합니다. 
아이디, 휴대전화번호 및 이메일주소는 서비스 제공을 위한 필수 수집항목으로서 영화관 회원 
가입 기간 동안 보관하나, 이벤트 혜택 정보 수신 동의를 철회하시면 본 목적으로의 개인정보 
처리는 중지됩니다. 
정보주체는 개인정보 수집 및 이용 동의를 거부하실 수 있으며, 미동의 시에도 서비스 이용은
가능합니다.
※ 일부 서비스의 경우, 수신에 대해 별도로 안내 드리며, 동의를 구합니다.</textarea> <br> <br>
				</section>
				<div class="joinbtn">
					<a href="join_certification.jsp"><input type="button" value="이전"></a>
					<a href="join_form.jsp" ><input type="submit" value="다음"></a>
				</div>
				<hr>
				<p id="notice">선택약관에 동의하지 않으셔도 가입이 가능합니다.</p>
				<br>
			</form>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>