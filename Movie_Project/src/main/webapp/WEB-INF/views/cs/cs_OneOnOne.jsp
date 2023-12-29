<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1 : 1 문의</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/cs.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources//js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	
	$(function() {
		
		// 문의 지점 "선택안함" 선택 시 지점명 선택 비활성화
		$("input[type=radio]").on("change", function() {
			// "선택안함" 선택 시 비활성화
			if($("input:radio[name=ox]").eq(0).prop("checked")) {
				$("select[name=theater_id]").attr("disabled", true);
			// "선택함" 선택 시 활성화
			} else {
				$("select[name=theater_id]").attr("disabled", false);
			}
		});
		
		
		// id 선택자 없는 경우 name 속성 지정하여 설정함. id 선택자 추가 가능(css 꼬일까봐 안했습니다) 
		$("form").submit(function() {
				//
			if(!$("#checkbox").prop("checked")) {	// 단일 체크 박스여서 인덱스 설정 하지 않았고 checked 속성이 아닐 경우 이므로 not 사용!
				alert("개인정보 수집에 대한 동의를 선택해 주세요");
				return false;
				
				// id 세션값으로 가져올 예정임
				// 현재 세션 값이 없어서 하나 만들어둠
			} else if($("#id").val() == "") { 
				alert("로그인을 해주세요");
				return false;
				
				// 1:1 문의 유형 미선택시
			} else if($("select[name=cs_type_detail]").val() == "") { // id 선택자 값 없어서 name 속성 지정
				alert("문의유형 선택은 필수입니다");
				$("select[name=type]").focus();
				return false;
				
				// 1:1 문의 지점 미선택시 메세지 출력
			} else if($("input[type=radio]").eq(1).prop("checked")) { // id 선택자 값 없어서 타입 속성으로 지정
					if($("select[name=theater_id]").val() == "") { // id 선택자 값 없어서 name 속성 지정
						alert("지점명 선택은 필수입니다");
						$("select[name=theater_id]").focus();
						return false;
					}
				
				
			} 
			// 아래문장은 선택안함일때 작동이 되는데 선택함일 때만 작동이안됨
			// 1:1 문의 제목 입력 내용 없을 시 메시지 출력	
			if($("#title").val() == "") {  
				alert("문의 제목 입력은 필수입니다");
				$("#title").focus();
				return false;
				
			}	
			// 1:1 문의 입력 내용 없을 시 메시지 출력
			if($("textarea[name=cs_content]").val() == "") {  // id 선택자 값 없어서 name 속성 지정
				alert("문의 내용은 필수입니다");
				$("textarea[name=cs_content]").focus();
				return false;
			}
			return true;
		});
	});
	
	// 지점명 불러오기
	$(function() {
		$.ajax({
			type: "GET",
			url: "getTheater",
			success: function(result) {
				for(let theater of result) {
				$("#theater_id").append("<option value='" + theater.theater_id + "'>" + theater.theater_name + "</option>");
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("지점명 로딩 오류입니다.");
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
			<h1 id="h01">1 : 1 문의</h1>
			<hr>
			<div id="cs_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="cs_menubar.jsp"></jsp:include>
			</div>
			
			<form action="csBoardPro" method="Post"  name="csForm" enctype="multipart/form-data">
				<p>고객님의 문의에 답변하는 직원은 고객 여러분의 가족 중 한 사람일 수 있습니다.<br>
				고객의 언어폭력(비하, 욕설, 반말, 성희롱 등)으로부터 직원을 보호하기 위해<br> 
				관련 법에 따라 수사기관에 필요한 조치를 요구할 수 있으며, 형법에 의해 처벌 대상이 될 수 있습니다.<br>
				FAQ를 이용하시면 궁금증을 더 빠르게 해결하실 수 있습니다.<br>
				1:1 문의글 답변 운영시간 10:00 ~ 19:00<br>
				접수 후 48시간 안에 답변 드리겠습니다.</p>
			
				<section id="agree_msg"> <%-- 개인정보 수집 동의 영역 --%>
					<input type="checkbox" id="checkbox" >
					<label for="checkbox">개인정보 수집에 대한 동의</label>
					<hr>
					<p>귀하께서 문의하신 다음의 내역은 법률에 의거 개인정보 수집·이용에 대한 본인동의가 필요한 항목입니다.<br>
					<br>
					<b>[개인정보의 수집 및 이용목적]</b><br>
					회사는 1:1 문의 내역의 확인, 요청사항 처리 또는 완료 시 원활한 의사소통 경로 확보를 위해 수집하고 있습니다.<br>
					<br>
					<b>[필수 수집하는 개인정보의 항목]</b><br>
					이름, 휴대전화, 이메일, 문의내용<br>
					<br>
					<b>[개인정보의 보유기간 및 이용기간]</b><br>
					문의 접수 ~ 처리 완료 후 3년<br>
					(단, 관계법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존)<br>
					자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.</p>
				</section>
				<b class="warning">* 원활한 서비스 이용을 위한 최소한의 개인정보이므로 동의하지 않을 경우 서비스를 이용하실 수 없습니다</b>
				<br>
				<section id="input_table"> <%-- 문의 입력하면 고객센터 메인으로 이동 --%>
					<b class="warning">* 필수입력항목</b> <br>
					<table id="cs_table2">
						<tr>
							<th>아이디<b>*</b></th>
							<td><input type="text" id="id" name="member_id" value="${sessionScope.sId}" readonly></td> <%-- 세션아이디 받아오기 --%>
							<th>문의유형<b>*</b></th>
							<td>
								<select name="cs_type_detail">
									<option value="문의유형 선택">문의유형 선택</option>
									<option value="영화관">영화관</option>
									<option value="영화">영화</option>
									<option value="예매">예매/결제</option>
									<option value="관람권/할인권">관람권/할인권</option>
									<option value="개인정보">개인정보</option>
									<option value="칭찬/불만/제안">칭찬/불만/제안</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>문의지점<b>*</b></th>
							<td colspan="3">
								<label><input type="radio" name="ox" value="0" checked> 선택안함</label> <%-- 체크 시 select창 비활성화, 기본값 선택안함 체크 --%>
								<label><input type="radio" name="ox" value="선택함" > 선택함</label> <%-- 체크 시 지점명 필수선택 --%>
								<select name="theater_id" id="theater_id" disabled>
									<option value="">지점을 선택하세요.</option>
								</select>
							</td>
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
							<th>첨부파일</th>
							<td colspan="3"><input type="file" id="file" name="mFile"></td>
							<input type="hidden" name="cs_type" value="1대1문의">
						</tr>
					</table>
					<div id="cs_button">
						<input type="button" value="취소"> <%-- 취소하시겠습니까? 메세지 출력 후 고객센터 메인 페이지로 바로 이동 --%>
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