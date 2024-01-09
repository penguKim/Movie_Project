<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 최신 영화 등록</title>
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
		// ============= api 조회에 쓸 변수 목록 =============
		let key = "811a25b246549ad749b278bba8257502"; // kobis 발급 키
		var today = new Date(); // 오늘 날짜
		today.setDate(today.getDate() - 1); // 어제 날짜로 변환
		// 어제 날짜의 객체 생성
		let yesterday = {
			year: today.getFullYear(),
			month: ('0' + (today.getMonth() + 1)).slice(-2),
			day: ('0' + today.getDate()).slice(-2)
		};
		// yyyy-MM-dd 형식으로 어제날짜 변환
		let yesterdayFmt = yesterday.year + "-" + yesterday.month + "-" + yesterday.day;
		// 조회할 날짜의 기본값으로 어제 날짜를 선택
		$("#dateSelect").val(yesterdayFmt);
		// 일일 박스오피스는 오늘 날짜는 조회가 안되므로 어제 날짜까지 조회하게한다.
		$("#dateSelect").attr("max", yesterdayFmt);
		// ======== 개봉일과 상영상태를 비교하는 변수 목록 ========
		let nowTime = new Date().getTime(); // 계산의 기준이 될 날짜를 밀리초 단위로 리턴
		let movieReleaseTime = ''; // 계산의 대상이 될 날짜를 밀리초 단위로 리턴
		let differenceTime = ''; // 기준 날짜와 대상 날짜의 차이
		// ===== submit 수행 시 값의 판별에 사용할 변수 목록 =====
		let isDuplicateMovie = false;
		// ===============================================
		
			
			
// 		$("form").on("submit", function() {
			
// 		});
			
			
			
		$("#eventTitle").on("blur", function() {
			let value = $(this).val().split($(this).val().indexOf("]"));
			console.log(value);
		});	
			
			
			
			
			
			
	}); // $(document).ready() 끝
	
	function deleteFile(id, file, index) {
		if(confirm('삭제하시겠습니까?')) {
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
						$("#fileItemArea" + index).html("<input type='file' name='eventFile" + index + "'>");
					} else if(result == 'false') {
						console.log("파일 삭제 실패!");	
					}
				}
			});
		}
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
		<h1 id="h01">영화등록</h1>
		<hr>
			<div id="admin_main">
				<form action="" method="post" id="movieRegist" enctype="multipart/form-data">
					<table id="movieTable">
						<tr>
							<th>썸네일</th>
							<td>
								<div class="file" id="fileItemArea1">
									<c:choose>
										<c:when test="${not empty event.event_thumnail  }">
										<c:set var="original_file_name" value="${fn:substringAfter(event.event_thumnail , '_') }"/>
											<img alt="" src="${pageContext.request.contextPath }/resources/upload/${event.event_thumnail }" height="300px">
											<br>${original_file_name }
											<a href="${pageContext.request.contextPath}/resources/upload/${event.event_thumnail  }" download="${original_file_name }">
												<input type="button" value="다운로드">
											</a>
											<a href="javascript:deleteFile(${event.event_id}, '${event.event_thumnail }', 1)"><i class="material-icons" style="font-size:36px">delete_forever</i></a>
										</c:when>
										<c:otherwise>
											<input type="file" name="eventFile1">
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
											<img alt="" src="${pageContext.request.contextPath }/resources/upload/${event.event_image }" height="300px">
											<br>${original_file_name }
											<a href="${pageContext.request.contextPath}/resources/upload/${event.event_image  }" download="${original_file_name }">
												<input type="button" value="다운로드">
											</a>
											<a href="javascript:deleteFile(${event.event_id}, '${event.event_image }', 2)"><i class="material-icons" style="font-size:36px">delete_forever</i></a>
										</c:when>
										<c:otherwise>
											<input type="file" name="eventFile2">
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
							<td><input type="date" name="event_release_date" id="event_release_date" value="${event.event_release_date }" class="shortInput"></td>
						</tr>
						<tr>
							<th>종료기간</th>
							<td><input type="date" name="event_close_date" id="event_close_date" value="${event.event_close_date }" class="shortInput"></td>
						</tr>
					</table>
					<input type="submit" value="수정" id="movieMod" formaction="eventMod">
					<input type="submit" value="삭제" id="movieDlt" formaction="eventDlt">
					<input type="hidden" name="event_id" value="${event.event_id }">
					<input type="button" value="창닫기" onclick="history.back();">
				</form>
			</div>
		</section>
	</div>
</body>
</html>