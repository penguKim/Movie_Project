<%-- admin_payment.jsp --%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 관리자 페이지</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script type="text/javascript">
// 	// 무한 스크롤 기능(미완)
	
// 	// 페이지 번호 변수 선언(초기값 1)
// 	let pageNum = "1";
	
// 	// 끝페이지 번호 변수 선언(초기값 "")
// 	let maxPage = "";
	
// 	$(function() {
		
// 		// 게시물 목록 조회 수행을 위해 load_list() 함수 호출
// 		load_list(); 
		
// 		// 윈도우 스크롤 이벤트 핸들링
// 		// 무한 스크롤 기능을 통해 다음 글 목록 자동으로 로딩
// 		$(window).scroll(function() {
			
// 			// window 객체, document 객체 활용해 스크롤 관련 값 가져오기
// 			let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
// 			let windowHeight = $(window).height(); // 브라우저 창 높이
// 			let documentHeight = $(document).height(); // 문서 높이
			
			
// 			// 스크롤바 위치값 + 창 높이 + x 값이 문서 전체 높이 이상일 경우
// 			// 다음 페이지 게시물 목록 로딩하여 화면에 추가
// 			if(scrollTop + windowHeight + 50 >= documentHeight){
// 				pageNum++; // 다음 목록 조회를 위해 현재 페이지 번호 증가
				
// 				// 끝 페이지 번호가 널스트링이 아니고, 증가한 페이지번호보다 크거나 같을 경우에만 다음 페이지 로딩
// 				if(maxPage != "" && pageNum <= maxPage) {
// 					load_list(); // 다음 페이지 로딩을 위해 load_list() 함수 호출
// 				}
				
// 			}
			
// 		});
		
// 	});
	
// 	// load_list() 함수 정의
// 	// ajax를 이용해 게시물 목록 조회
// 	function load_list() {
// 		$.ajax({
// 			type: "get",
// 			url: "adminMovieScheduleList",
// 			data: {
// 				pageNum: pageNum
// 			},
// 			dataType: "json",
// 			success: function(result) {
				
// 			},
// 			error: function() {
// 				alert("게시물 목록 조회 요청 실패!");
// 			}
// 		});
		
// 	}

	
	// 데이터 조회해 상영 일시를 판별해 음영처리
	$(function(){
		// 현재 시간 가져오기
		let currentTime = new Date();
		
		// 각 tr 태그 반복해 상영 종료 시간과 상영 날짜 가져옴
		$("tr").each(function() {
			// 상영일자 변수에 저장
			let playDate = $(this).find("#play_date").val();
			console.log(playDate);
			console.log(typeof(playDate)); // string
			
			// 영화 상영 시간 전체 문자열 가져오기
			let playTime = $(this).find("#play_time").text();
			console.log(playTime);
			
			// ~을 델리미터로 나눠서 배열에 저장
			let playTimeArr = playTime.split("~");
			console.log(playTimeArr);
						
			// 값이 undefined가 아니라면 1번 인덱스 공백 제거하고 변수에 저장하고
			// 상영 종료 시간과 상영 날짜를 합친 문자열 new Date() 함수에 전달하여 
			// 자바스크립트의 Date 객체로 변환
			if(playTimeArr[1] != undefined) {
				let playEndTime = playTimeArr[1].trim();
				console.log(playEndTime);
				let endTime = new Date(playDate + " " + playEndTime);
				console.log(endTime);
				if (endTime < currentTime) { // 시간 비교해 현재 이전인 경우 
					$(this).css("background-color", "lightgray"); // 배경색 지정해 음영처리
				}
			} else {
				console.log("배열 인덱스 1의 값 없음");
			}
			
			
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
	
	// 조회 버튼 클릭 시 이벤트 처리
	$(function() { 
		$("#selectSchedule").on("click", function() {
// 			console.log($("#searchDate").val());
			if($("#theater_id").val() == "none" && $("#searchDate").val() == "") {
				alert("지점과 날짜를 선택해주세요!");
				$("#theater_id").focus();
				$("#theater_id").on("change", function() {
					if($("#theater_id").val() != "none" && $("#searchDate").val() == "") {
						$("#searchDate").focus();
					}
				});
				return;
			} else {
				if($("#theater_id").val() == "none") {
					alert("지점을 선택해주세요!");
					$("#theater_id").focus();
					return;
				} else if($("#searchDate").val() == "") {
					alert("날짜를 선택해주세요!");
					$("#searchDate").focus();
					return;
				} else {
					$.ajax({ // 조회 버튼 클릭시 ajax 요청
						type: "get",
						url: "ScheduleSearch",
						data: $("form").serialize(),
						success: function(result) {
							console.log(result);
							$("#scheduleTable>tbody").empty();
							
							if(result != "") {
								for(let schedule of result) {
									$("#scheduleTable>tbody").append(
											"<tr><td>" + schedule.theater_name + "</td><td>" 
											+ schedule.room_name + "</td><td>" 
											+ schedule.movie_title + "</td><td>" 
											+ schedule.play_start_time + " ~ " + schedule.play_end_time + "</td></tr>"
											);
								}
							} else {
								$("#scheduleTable>tbody").append("<tr><td colspan='4'>" + "상영일정이 존재하지 않습니다." + "</td></tr>");
							}
								
						},
						error: function(e) {
							alert("상영 일정 조회 요청 실패!");
							location.reload();
							return;
						}
						
					});// 조회버튼 클릭 시 ajax 요청 끝	
					
				} // else문 안의 if-else문 끝
				
			} // if-else문 끝
			
		}); // 조회버튼 클릭 시 이벤트 처리 끝
		
	}); // document.ready 끝
	


		
</script>
</head>
<body>
	<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1 로 저장) --%>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	<div id="wrapper">
		<nav id="navbar">
			<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		</nav>
	
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">상영 일정 조회</h1>
			<hr>
			
			<div id="admin_main">
				<a href="movieScheduleMod"><input type="button" value="상영일정관리"></a>
				<div id="schedule_search">
					<form action="">
						<select name="theater_id" id="theater_id">
							<option value="none">지점을 선택하세요.</option>
						</select>
						<input type="date" id="searchDate" name="play_date">
						<input type="button" value="조회" id="selectSchedule">
					</form>
				</div>
				<table border="1" width="1100" id="scheduleTable">
					<thead>
						<tr>
							<th width="200">지점</th>
							<th width="150">상영관</th>
							<th width="600">영화명</th>
							<th width="150">상영시간</th>
						</tr>
					</thead>
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td rowspan="2">IMAX관</td> -->
<!-- 							<td>쏘우</td> -->
<!-- 							<td>9시</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>짱구</td> -->
<!-- 							<td>10시</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td rowspan="4">돌비</td> -->
<!-- 							<td>쏘우</td> -->
<!-- 							<td>10시</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>짱구</td> -->
<!-- 							<td>9시</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>슬램덩크</td> -->
<!-- 							<td>11시</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>뽀로로</td> -->
<!-- 							<td>12시</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->




					<tbody>
					<%-- ******************************************************** --%>
					<%-- ****************************기존코드**************************** --%>
						<c:forEach items="${playList }" var="play">
							<tr id="searchResult">
								<td>${play.theater_name }</td>
								<td>${play.room_name }</td>
								<td>${play.movie_title }</td>
								<td id="play_time">${play.play_start_time } ~ ${play.play_end_time }</td>
								<input type="hidden" id="play_date" value="${play.play_date }">
							</tr>
						</c:forEach>
					<%-- ******************************************************** --%>
					<%-- ****************************2차 코드**************************** --%>
<%-- 						<c:forEach items="${playList }" var="play" varStatus="status"> <!-- 반복문 시작 --> --%>
<%-- 							<c:set var="count" value="1"/>  --%>
	 						<%--	
	 							현재 행의 room_name 값과 아래 행들의 room_name 값이 같을 경우를 세는 변수 선언
	 							rowspan 값으로 지정할 것이므로 기본 값은 1로 지정
 							 --%>
<%-- 							<c:set var="currentRoomName" value=""/> <!-- 현재 행의 room_name 값을 지정할 변수 선언(기본값 "") --> --%>
<%-- 							<c:set var="nextRoomName" value=""/> <!-- 다음 행의 room_name 값을 지정할 변수 선언(기본값 "") --> --%>
<%-- 							<c:if test="${not empty play.room_name }"> <!-- room_name 값이 있다면 --> --%>
<%-- 								<c:set var="currentRoomName" value="${play.room_name }"/>  --%>
 								<%-- 
									현재 행의 room_name 값을 지정할 변수 선언
	 								(기본값은 불러온 데이터의 첫 행의 room_name 값)  
 								--%>
<%-- 								<c:set var="nextPlay" value="${playList[status.index + 1] }"/> <!-- 다음 행의 데이터들의 값을 지정할 변수 선언하고 인덱스 1 증가 --> --%>
<%-- 								<c:if test="${not empty nextPlay }"> <!-- 다음 행의 데이터 값들이 존재한다면 --> --%>
<%-- 									<c:set var="nextRoomName" value="${nextPlay.room_name }"/> <!-- 다음행의 room_name 값을 앞서 지정한 변수에 덮어씀 --> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${currentRoomName eq nextRoomName }"> <!-- 현재 행의 room_name과 다음 행의 room_name 값이 일치한다면 --> --%>
<%-- 									<c:set var="nextRoomName" value="${nextPlay.room_name }"/> <!-- 다음행의 room_name 값을 앞서 지정한 변수에 덮어씀 --> --%>
<%-- 									<c:set var="count" value="${count + 1 }"/> <!-- 일치횟수를 세는 변수 count 1 증가 --> --%>
<%-- 								</c:if> --%>
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${currentRoomName eq nextRoomName }"> <!-- 현재 행의 room_name과 다음 행의 room_name 값이 일치한다면 -->  --%>
<!-- 										<tr> -->
<%-- 											<td rowspan="${count }">${nextPlay.room_name }</td> <!-- 일치횟수 count를 rowspan 값으로 지정  --> --%>
<%-- 											<td>${play.movie_title }</td> --%>
<%-- 											<td>${play.play_start_time }</td> --%>
<!-- 										</tr> -->
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> <!--  일치하지 않을 경우 --> --%>
<!-- 										<tr> -->
<%-- 											<td>${play.room_name }</td> <!-- rowspan 적용하지않은 원래대로 출력 --> --%>
<%-- 											<td>${play.movie_title }</td> --%>
<%-- 											<td>${play.play_start_time }</td> --%>
<!-- 										</tr> -->
<%-- 									</c:otherwise>									 --%>
<%-- 								</c:choose> --%>
<%-- 								<c:set var="status.index" value="${status.index + count - 1 }"/> --%>
<%-- 							</c:if> --%>
<%-- 						</c:forEach> --%>

					<%-- ******************************************************** --%>
					<%-- ****************************6차 코드**************************** --%>
<%-- 					<c:forEach items="${playList }" var="play" varStatus="status"> --%>
						<%-- 중복 카운트할 변수 선언 (rowspan 값으로 지정할 것이므로 기본값 1)--%>
<%-- 					<c:set var="count" value="1"/>  --%>
						<%-- 
							${play.room_name } 값이 중복인 경우를 판별해 횟수를 세고 rowspan 값으로 적용
							중복 횟수를 어떻게 셀 건지?
							=> 기존 행 값을 변수 지정
								이후 행 값을 변수 지정
								기존 행 변수와 이후 행 변수 비교해 같으면 카운트 값 추가
								카운트 값을 rowspan 값으로 지정하고
								rowspan - 1 의 값으로 병합된 tr 반복
						--%>
					
					<%-- 현재 행의 room_name 값 지정할 변수 --%>
<%-- 					<c:set var="currentRoomName" value=""/> --%>
					<%-- 다음 행의 room_name 값 지정할 변수 --%> 
<%-- 					<c:set var="nextRoomName" value=""/>  --%>
					<%-- room_name 값이 있다면 --%>
<%-- 					<c:if test="${not empty play.room_name }">  --%>
					
					
						<%-- 현재 행의 room_name값 지정 변수에 기본값인 불러온 데이터의 첫 행인 room_name값 지정 --%>
<%-- 						<c:set var="currentRoomName" value="${play.room_name}"/> --%>
						
						<%-- 다음 행의 데이터 리스트의 값을 지정할 변수 선언하고 인덱스 1 증가 --%>
<%-- 						<c:set var="nextPlay" value="${playList[status.index + 1]}"/> --%>
						
						<%-- 다음 행의 데이터 리스트가 비어있지않다면 --%>
<%-- 						<c:if test="${not empty nextPlay}">  --%>
							
							<%-- 다음 행의 room_name값을 앞에서 지정한 변수에 덮어씌움 --%>			
<%-- 							<c:set var="nextRoomName" value="${nextPlay.room_name}"/> --%>
<%-- 						</c:if> --%>
						
						<%-- 현재 행의 room_name과 다음 행의 room_name 값이 일치한다면 --%>
<%-- 						<c:if test="${currentRoomName eq nextRoomName}">  --%>
						
							<%-- 다음 행의 room_name값을 앞에서 지정한 변수에 덮어씌움 --%>	
<%-- 							<c:set var="nextRoomName" value="${nextPlay.room_name}"/> --%>
							<!-- 일치횟수를 세는 변수 count 1 증가 -->
<%-- 							<c:set var="count" value="${count + 1 }"/>  --%>
<%-- 						</c:if> --%>
						
<%-- 						<c:choose> --%>
							<%-- 현재 행의 room_name과 다음 행의 room_name 값이 일치할 경우 => rowspan 적용 --%>
<%-- 							<c:when test="${currentRoomName eq nextRoomName}"> --%>
<!-- 								<tr> -->
<%-- 									<td rowspan="${count}">${nextPlay.room_name }</td> --%>
<%-- 									<td>${play.movie_title }</td> --%>
<%-- 									<td>${play.play_start_time }</td> --%>
<!-- 								</tr> -->
								<%-- 아래의 tr은 rowspan - 1 값 만큼 반복해야한다 --%>
<%-- 								<c:forEach begin="1" end="${count - 1}">  --%>
<!-- 									<tr> -->
<%-- 										<td>${nextPlay.movie_title }</td> --%>
<%-- 										<td>${nextPlay.play_start_time }</td> --%>
<!-- 									</tr> -->
<%-- 								</c:forEach>			 --%>
<%-- 							</c:when> --%>
							<%-- 현재 행의 room_name과 다음 행의 room_name 값이 일치하지 않는 경우 => rowspan 적용 X --%>
<%-- 							<c:otherwise> --%>
<!-- 								<tr> -->
									<!-- rowspan 적용하지않은 원래대로 출력 -->
<%-- 									<td>${play.room_name }</td> --%>
<%-- 									<td>${play.movie_title }</td> --%>
<%-- 									<td>${play.play_start_time }</td> --%>
<!-- 								</tr> -->
<%-- 							</c:otherwise> --%>
						
<%-- 						</c:choose> --%>
						<%-- 인덱스 갱신 --%>
<%-- 						<c:set var="status.index" value="${status.index + count - 1 }"/> --%>
<%-- 					</c:if> --%>
<%-- 				</c:forEach> --%>
					</tbody>
				</table>
			</div>
		</section>
	</div>
</body>
</html>
