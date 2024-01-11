<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/dailyBoxOffice.js"></script> --%>
<script>
	$(function() {
		let now = new Date(); // 오늘 날짜
		let today = {
			year: now.getFullYear(),
			month: ('0' + (now.getMonth() + 1)).slice(-2),
			day: ('0' + now.getDate()).slice(-2)
		};
		// yyyy-MM-dd 형식으로 어제날짜 변환
		let todayFmt = today.year + "-" + today.month + "-" + today.day;
		// ===============================================
		
		// 현재 날짜 이전으로는 이벤트 등록을 못한다.
		$("#event_release_date").attr("min", todayFmt);
		
		// 자동 선택 이후 개봉일을 변경할 경우 종영일의 최소값을 변경한다.
		$("#event_release_date").on("change", function() {
			$("#event_close_date").attr("min", $("#event_release_date").val());
		});
		
		// 파일 이미지로만 제한
		$(function() {
			$(".file").on("change", function() {
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
		});

		// submit 시 수행할 동작
		$("form").on("submit", function() {
			if($("input[name=eventFile1]").get(0).files.length === 0) {
				alert("이벤트 썸네일을 등록하세요");
				$("input[name=eventFile1]").focus();
				return false;
			} else if($("input[name=eventFile2]").get(0).files.length === 0) {
				alert("이벤트 본문 이미지를 등록하세요");
				$("input[name=eventFile2]").focus();
				return false;
			} else if($("#event_title").val() == "") {
				alert("이벤트 제목을 입력하세요");
				$("#event_title").focus();
				return false;
			} else if($("#event_release_date").val() == "") {
				alert("이벤트 시작 기간을 입력하세요");
				$("#event_release_date").focus();
				return false;
			} else if($("#event_close_date").val() == "") {
				alert("이벤트 종료 기간을 입력하세요");
				$("#event_close_date").focus();
				return false;
			}
			
			return confirm("이벤트를 등록하시겠습니까?");
		});
		
		
	}); // $(document).ready() 끝
</script>


</head>
<body>
	<div id="wrapper">
		<nav id="navbar">
            <jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
        </nav>
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
		<section id="content">
		<h1 id="h01">이벤트 등록</h1>
		<hr>
			<div id="admin_main">
				<form action="eventRgst" method="post" id="movieRegist" enctype="multipart/form-data">
					<table id="movieTable">
						<tr>
							<th>썸네일</th>
							<td><input type="file" class="file" name="eventFile1" accept=".gif, .jpg, .png"></td>
						</tr>            
						<tr>
							<th>컨텐츠</th>
							<td><input type="file" class="file" name="eventFile2" accept=".gif, .jpg, .png"></td>
						</tr>            
						<tr>
							<th>제목</th>
							<td><input type="text" class="longInput" name="event_title" id="event_title"></td>
						</tr>            
						<tr>
							<th>시작기간</th>
							<td><input type="date" name="event_release_date" id="event_release_date" class="shortInput"></td>
						</tr>
						<tr>
							<th>종료기간</th>
							<td><input type="date" name="event_close_date" id="event_close_date" class="shortInput"></td>
						</tr>
					</table>
					<input type="submit" value="등록" id="regist">
					<input type="button" value="돌아가기" onclick="history.back();">
				</form>
			</div>
		</section>
	</div>
</body>
</html>