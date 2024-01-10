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
<link href="${pageContext.request.contextPath}/resources/css/cs.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	<%-- 분실 일시는 오늘 날짜 이전만 선택할 수 있음 --%>
	$(function() {
		var now_utc = Date.now() // 지금 날짜를 밀리초로
		// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
		var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
		// new Date(today-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
		var today = new Date(now_utc-timeOff).toISOString().substring(0, 16);
		
		$("#lost_datetime").attr("max", today);


		// 지점명 불러오기
		$.ajax({
			type: "GET",
			url: "getTheater",
			success: function(result) {
				for(let theater of result) {
					$("#theater_id").append("<option value='" + theater.theater_id + "'>" + theater.theater_name + "</option>");
				}
			},
			error: function(request,status,error) {
				alert("지점명 로딩 오류입니다.");
			}
			
		});


		// id 선택자 없는 경우 name 속성 지정하여 설정함. id 선택자 추가 가능(css 꼬일까봐 안했습니다) 
		$("form").submit(function() {
			if(confirm("문의를 등록하시겠습니까?")) {
				// 개인정보 수집 동의 미 체크 시 
				if(!$("#checkbox").prop("checked")) {	// 단일 체크 박스여서 인덱스 설정 하지 않았고 checked 속성이 아닐 경우 이므로 not 사용!
					alert("개인정보 수집에 대한 동의를 선택해 주세요");
					return false;
					// 분실장소 미선택시 
				} else if($("#theater_id").val() == "") {
					alert("분실장소 선택은 필수입니다");
					$("#theater_id").focus();
					return false;
				} else if($("#lost_datetime").val() == "") {
					alert("분실일시 선택은 필수입니다");
					$("#lost_datetime").focus();
					return false;
				} else if($("#id").val() == "") { 
					alert("로그인을 해주세요");
					return false;
					// 분실물 주의 제목 입력 내용 없을 시 
				} else if($("#title").val() == "") { // 
					alert("제목 입력은 필수입니다");
					$("#title").focus();
					return false;
					// 분실물 주의 입력 내용 없을 시 
				} else if($("textarea[name=cs_content]").val() == "") {  // id 선택자 값 없어서 name 속성 지정
					alert("내용 입력은 필수입니다");
					$("textarea[name=cs_content]").focus();
					return false;
				}
				return true;
				
			} else {
				return false;
			}	
		});


		// 파일 이미지로만 제한
		$("#file").on("change", function() {
			let fileVal = $(this).val();
			if (fileVal != "") {
				let ext = fileVal.split('.').pop().toLowerCase(); // 확장자 분리
				
				// 허용되는 확장자 리스트
				let allowedExtensions = ['jpg', 'jpeg', 'gif', 'png'];
				
				// 허용되지 않는 확장자일 경우 경고 메시지 출력 후 등록 취소
				if (!allowedExtensions.includes(ext)) {
					alert("jpg, gif, jpeg, png 파일만 업로드 할 수 있습니다.");
					$(this).val(""); // 파일 입력 필드 초기화
					return false;
				}
			}
		});


		$("#cancel").on("click", function() {
			if(confirm("문의 작성을 취소하시겠습니까?")) {
				location.href="csMain";
			} else {
				return false;
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
			<h1 id="h01">분실물 문의</h1>
			<hr>
			<div id="cs_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="cs_menubar.jsp"></jsp:include>
			</div>
			<form action="csBoardPro" method="post"  name="csForm" enctype="multipart/form-data">
				<p>분실물에 관련하여 문의가 있으시면 아래의 정보를 입력해주세요.
				담당자 확인 후 신속히 답변을 드리겠습니다.</p>
				<section id="agree_msg"> <%-- 개인정보 수집 동의 영역 --%>
					<input type="checkbox" id="checkbox">
					<label for="checkbox">개인정보 수집에 대한 동의</label>
					<hr>
					<p>귀하께서 문의하신 다음의 내역은 법률에 의거 개인정보 수집·이용에 대한 본인동의가 필요한 항목입니다. <br>
					<br>
					<b>[개인정보의 수집 및 이용목적]</b> <br>
					회사는 분실물 문의 내역의 확인, 요청사항 처리 또는 완료 시 원활한 의사소통 경로 확보를 위해 수집하고 있습니다. <br>
					<br>
					<b>[필수 수집하는 개인정보의 항목]</b> <br>
					아이디, 문의내용 <br>
					<br>
					<b>[개인정보의 보유기간 및 이용기간]</b> <br>
					문의 접수 ~ 처리 완료 후 3년 <br>
					(단, 관계법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존) <br>
					자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.</p>
				</section>
				<b class="warning">* 원활한 서비스 이용을 위한 최소한의 개인정보이므로 동의하지 않을 경우 서비스를 이용하실 수 없습니다.</b>
				<br>
				<section id="input_table"> <%-- 분실물 문의 입력창 --%>
					<b class="warning">* 필수입력항목</b> <br>
					<table id="cs_table2">
						<tr>
							<th>분실장소<b>*</b></th>
							<td>
								<select name="theater_id" id="theater_id">
									<option value="">지점을 선택하세요.</option>
								</select>
							</td>
							<th>분실일시<b>*</b></th>
							<td>
								<input type="datetime-local" id="lost_datetime" name="lost_datetime">
							</td>
						</tr>
						<tr>
							<th>아이디<b>*</b></th>
							<td colspan="3"><input type="text" id="id" name="member_id" value="${sessionScope.sId}" readonly></td> <%-- 세션아이디 받아오기 --%>
						</tr>
						<tr>
							<th>제목<b>*</b></th>
							<td colspan="3"><input type="text" id="title" name="cs_subject"></td>
						</tr>
						<tr>
							<th>내용<b>*</b></th>
							<td colspan="3"><textarea name="cs_content"></textarea></td>
						</tr>
						<tr>
							<th>첨부이미지</th>
							<td colspan="3"><input type="file" id="file" name="mFile" accept=".gif, .jpg, .png"></td>
							<input type="hidden" name="cs_type" value="분실물문의">
						</tr>
					</table>
					<div id="cs_button">
						<input type="button" value="취소" id="cancel"> <%-- 취소하시겠습니까? 메세지 출력 후 고객센터 메인 페이지로 바로 이동 --%>
						<input type="submit" value="등록"> <%-- 문의가 접수되고 고객센터 메인 페이지로 이동 --%>
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