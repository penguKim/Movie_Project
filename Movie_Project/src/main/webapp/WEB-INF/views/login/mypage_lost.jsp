<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분실물 문의상세페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/css/login.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.7.1.js"></script>
<script>
	$(function() {
		
		// id 선택자 없는 경우 name 속성 지정하여 설정함. id 선택자 추가 가능(css 꼬일까봐 안했습니다) 
		$("form").submit(function() {
			// 개인정보 수집 동의 미 체크 시 
			if(!$("#checkbox").prop("checked")) {	// 단일 체크 박스여서 인덱스 설정 하지 않았고 checked 속성이 아닐 경우 이므로 not 사용!
				alert("개인정보 수집에 대한 동의를 선택해 주세요");
				return false;
				// 분실장소 미선택시 
			} else if($("select[name=place]").val() == "") { // id 선택자 값 없어서 name 속성 지정
				alert("분실장소 선택은 필수입니다");
				$("select[name=place]").focus();
				return false;
				// 분실물 일시 내용 없을 시 
				// 시간 선택을 입력 없이 캘린더 선택만 하는건 어떤지?
			} else if($("input[name=time]").val() == "") { // id 선택자 값 없어서 name 속성 지정
				alert("분실일시 선택은 필수입니다");
				$("input[name=time]").focus();
				return false;
				// id 세션값으로 가져올 예정임
				// 현재 세션 값이 없어서 하나 만들어둠
			} else if($("#id").val() == "") { 
				alert("로그인을 해주세요");
				return false;
				// 분실물 주의 제목 입력 내용 없을 시 
			} else if($("#title").val() == "") { // 
				alert("제목 입력은 필수입니다");
				$("#title").focus();
				return false;
				// 분실물 주의 입력 내용 없을 시 
			} else if($("textarea[name=content]").val() == "") {  // id 선택자 값 없어서 name 속성 지정
				alert("내용 입력은 필수입니다");
				$("textarea[name=content]").focus();
				return false;
			}
			return true;
		});
		
		// 삭제버튼을 클릭
		$("#delete").on("click",function() {
			let confirmation = confirm("게시글을 삭제하시겠습니까?");
				if (confirmation) {
					window.location.href = "myboard.jsp";
				};
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
			<h1 id="h01">분실물 문의 상세페이지</h1>
			<hr>
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			<form action="" method=""  name="loginForm">
<!-- 				<p>분실물에 관련하여 문의가 있으시면 아래의 정보를 입력해주세요. -->
<!-- 				담당자 확인 후 신속히 답변을 드리겠습니다.</p> -->
<%-- 				<section id="agree_msg"> 개인정보 수집 동의 영역 --%>
<!-- 					<input type="checkbox" id="checkbox"> -->
<!-- 					<label for="checkbox">개인정보 수집에 대한 동의</label> -->
<!-- 					<hr> -->
<!-- 					<p>귀하께서 문의하신 다음의 내역은 법률에 의거 개인정보 수집·이용에 대한 본인동의가 필요한 항목입니다. <br> -->
<!-- 					<br> -->
<!-- 					<b>[개인정보의 수집 및 이용목적]</b> <br> -->
<!-- 					회사는 분실물 문의 내역의 확인, 요청사항 처리 또는 완료 시 원활한 의사소통 경로 확보를 위해 수집하고 있습니다. <br> -->
<!-- 					<br> -->
<!-- 					<b>[필수 수집하는 개인정보의 항목]</b> <br> -->
<!-- 					이름, 연락처, 이메일, 문의내용, 비밀번호(게시글 열람용) <br> -->
<!-- 					<br> -->
<!-- 					<b>[개인정보의 보유기간 및 이용기간]</b> <br> -->
<!-- 					문의 접수 ~ 처리 완료 후 3년 <br> -->
<!-- 					(단, 관계법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존) <br> -->
<!-- 					자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.</p> -->
<!-- 				</section> -->
<!-- 				<b class="warning">* 원활한 서비스 이용을 위한 최소한의 개인정보이므로 동의하지 않을 경우 서비스를 이용하실 수 없습니다.</b> -->
<!-- 				<br> -->
<%-- 				<section id="input_table"> 분실물 문의 입력창 --%>
<!-- 					<b class="warning">* 필수입력항목</b> <br> -->
				<table id="login_table2">
					<tr>
						<th>분실장소<b>*</b></th>
						<td>
							<select name="place" >
								<option value="">전체검색</option>
								<option value="지점명">지점명A</option> <%-- 지점명 정해지면 수정 --%>
								<option value="지점명">지점명B</option>
							</select>
						</td>
						<th>분실일시<b>*</b></th>
						<td>
							<input type="datetime-local" name="time">
						</td>
					</tr>
					<tr>
						<th>아이디<b>*</b></th>
						<td colspan="3"><input type="text" id="id"></td> <%-- 세션아이디 받아오기 --%>
					</tr>
					<tr>
						<th>제목<b>*</b></th>
						<td colspan="3"><input type="text" id="title" name="title"></td>
					</tr>
					<tr>
						<th>내용<b>*</b></th>
						<td colspan="3"><textarea rows="15" cols="90" name="content"></textarea></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3"><input type="file" id="file"></td>
					</tr>
				</table>
				<div id="login_button">
					<input type="button" value="취소"> <%-- 취소하시겠습니까? 메세지 출력 후 마이페이지로 바로 이동 --%>
					<input type="submit" value="등록"> <%-- 문의가 접수되고 마이페이지 페이지로 이동 --%>
					<input type="button" value="삭제" id="delete"> <%-- 게시글 삭제되고 마이페이지로 이동 --%>
				</div>
			</form>
		</section>
		
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>