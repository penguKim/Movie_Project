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
<script src="${pageContext.request.contextPath }/js/jquery-3.7.1.js"></script>
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
	
			<form  action="join_form.jsp" method="post" name="joinAgree">
				<hr>
				<h3 id="join_top">약관 및 정보활용 동의</h3>
				<label><input type="checkbox" id="agreeAll">전체동의</label> <br>
				<hr>
				<section id="agree" name="agree">
					<label id="required"><input type="checkbox" name="agree" value="서비스 이용 약관 동의(필수)">
					서비스 이용 약관 동의(필수)</label> <br>
					<textarea readonly>약관</textarea> <br> <br>
					<label id="required"><input type="checkbox" name="agree" value="개인정보 수집 및 이용 동의(필수)">
					개인정보 수집 및 이용 동의(필수)</label> <br>
					<textarea readonly>약관</textarea> <br> <br>
					<label><input type="checkbox" name="agree" value="마케팅 활용을 위한 개인정보 수집 및 이용 안내(선택)">
					마케팅 활용을 위한 개인정보 수집 및 이용 안내(선택)</label> <br>
					<textarea readonly>약관</textarea> <br> <br>
					<label><input type="checkbox" name="agree" value="위치기반서비스 이용 약관 동의(선택)">
					위치기반서비스 이용 약관 동의(선택)</label> <br>	
					<textarea readonly>약관</textarea>
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