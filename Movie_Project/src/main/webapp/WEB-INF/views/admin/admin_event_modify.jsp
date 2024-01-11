<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
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

		// 모달 닫기 버튼 클릭 이벤트
		$(".close").on("click", function() {
			$("body").removeClass("not_scroll"); <%-- body 영역 스크롤바 추가 --%>
		  $("#myModal").hide(); <%-- div 영역 숨김 --%>
		});

		// 모달 외부 영역 클릭 시 모달 닫기
		$(window).on("click", function(event) {
			if ($(event.target).is("#myModal")) { <%-- 클릭한 곳이 모달창 바깥 영역일 경우 --%>
				$("body").removeClass("not_scroll"); <%-- body 영역 스크롤바 추가 --%>
				$("#myModal").hide(); <%-- div 영역 숨김 --%>
			}
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
		
		// 수정 시 수행할 동작
		$("#movieMod").on("click", function() {
			if($("input[name=eventFile1]").get(0).files.length === 0) {
				alert("이벤트 썸네일을 등록하세요");
				$("input[name=eventFile1]").focus();
				return false;
			} else if($("input[name=eventFile2]").get(0).files.length === 0) {
				alert("이벤트 본문 이미지를 등록하세요");
				$("input[name=eventFile2]").focus();
				return false;
			} else if($("#eventTitle").val() == "") {
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
			return confirm("이벤트를 수정하시겠습니까?");
		});
		
		// 삭제시 수행할 동작
		$("#movieDlt").on("click", function() {
			return confirm("이벤트를 삭제하시겠습니까?");
		});
		
	}); // $(document).ready() 끝
	
	// 파일 삭제 함수
	function deleteFile(id, file, index) {
		if(confirm('파일을 삭제하시겠습니까?')) {
			$.ajax({
				type: "POST",
				url: "eventDeleteFile",
				data: {
					"event_id": id,
					"event_thumnail": file
				},
				success: function(result) {
					console.log("파일 삭제 요청 결과 : " + result + ", " + typeof(result));
					// 삭제 성공/실패 여부 판별(result 값 문자열 : "true"/"false" 판별)
					if(result == 'true') { // 삭제 성공 시
						$("#fileItemArea" + index).html("<input type='file' class='file' name='eventFile" + index + "'>");
					} else if(result == 'false') {
						console.log("파일 삭제 실패!");	
					}
				}
			});
		}
	}
	
	// 이미지 클릭 시 모달창 띄우기
	function modalShow(file) {
		$("#modal-subject").html(
				'<img alt="" src="${pageContext.request.contextPath }/resources/upload/' 
				+ file + '">'
		);
		$("#myModal").show();
	}
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
		<h1 id="h01">이벤트 수정</h1>
		<hr>
			<div id="admin_main">
				<form action="" method="post" id="eventRegist" enctype="multipart/form-data">
					<table id="eventTable">
						<tr>
							<th>썸네일</th>
							<td>
								<div class="file" id="fileItemArea1">
									<c:choose>
										<c:when test="${not empty event.event_thumnail  }">
										<c:set var="original_file_name" value="${fn:substringAfter(event.event_thumnail , '_') }"/>
											<img class="event_img" alt="" src="${pageContext.request.contextPath }/resources/upload/${event.event_thumnail }" height="200px" onclick="modalShow('${event.event_thumnail}')">
											<br>${original_file_name }
											<a href="${pageContext.request.contextPath}/resources/upload/${event.event_thumnail  }" download="${original_file_name }">
												<input type="button" value="다운로드">
											</a>
											<a href="javascript:deleteFile(${event.event_id}, '${event.event_thumnail }', 1)">
												<img src="${pageContext.request.contextPath }/resources/img/선택불가.png" class="img_btnDelete" width="20" height="20">
											</a>
										</c:when>
										<c:otherwise>
											<input type="file" class="file" name="eventFile1" accept=".gif, .jpg, .png">
										</c:otherwise>
									</c:choose>
								</div>
							</td>
						</tr>            
						<tr>
							<th>컨텐츠</th>
							<td>
								<div class="file" id="fileItemArea2">
									<c:choose>
										<c:when test="${not empty event.event_image  }">
										<c:set var="original_file_name" value="${fn:substringAfter(event.event_image , '_') }"/>
											<img class="event_img" alt="" src="${pageContext.request.contextPath }/resources/upload/${event.event_image }" height="300px" onclick="modalShow('${event.event_image}')">
											<br>${original_file_name }
											<a href="${pageContext.request.contextPath}/resources/upload/${event.event_image  }" download="${original_file_name }">
												<input type="button" value="다운로드">
											</a>
											<a href="javascript:deleteFile(${event.event_id}, '${event.event_image }', 2)">
												<img src="${pageContext.request.contextPath }/resources/img/선택불가.png" class="img_btnDelete" width="20" height="20">
											</a>
										</c:when>
										<c:otherwise>
											<input type="file" class="file" name="eventFile2  accept=".gif, .jpg, .png">
										</c:otherwise>
									</c:choose>
								</div>
							</td>
						</tr>            
						<tr>
							<th>제목</th>
							<td><input type="text" class="longInput" name="event_title" id="eventTitle" value="${event.event_title }"></td>
						</tr>            
						<tr>
							<th>시작기간</th>
							<td><input type="date" name="event_release_date" id="event_release_date" value="${event.event_release_date }"></td>
						</tr>
						<tr>
							<th>종료기간</th>
							<td><input type="date" name="event_close_date" id="event_close_date" value="${event.event_close_date }"></td>
						</tr>
					</table>
					<input type="submit" value="수정" id="movieMod" formaction="eventMod">
					<input type="submit" value="삭제" id="movieDlt" formaction="eventDlt">
					<input type="hidden" name="event_id" value="${event.event_id }">
					<input type="button" value="창닫기" onclick="history.back();">
				</form>
			</div>
		<!-- 모달 배경 -->
		<div id="myModal" class="modal">
			<!-- 모달 컨텐츠 -->
			<div class="modal-content">
				<span class="close">&times;</span>
				<div id="modal-subject"></div>
			</div>
		</div>
		</section>
	</div>
</body>
</html>