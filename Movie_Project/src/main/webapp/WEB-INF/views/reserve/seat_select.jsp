<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/reserve.css" rel="stylesheet" type="text/css">

<style>
	.seat {
    width: 30px;
    height: 30px;
	    background-color: #ccc; 
	    margin: 5px; 
    display: inline-block;
    cursor: pointer;
   }
   .selected {
   	background-color: #de1010;
   }
</style>
<script>
   function toggleSeat(seat) {
       seat.classList.toggle("selected");
       displaySelectedSeats(); // 좌석 선택 시 선택된 좌석을 출력하는 함수 호출
   }
   
   function toggleNum(num){
       // 클릭된 요소가 속한 행을 찾음
       var row = num.parentNode.parentNode;

       // 해당 행의 모든 .NumOfPeo 요소를 찾음
       var elements = row.querySelectorAll('.NumOfPeo');

       // 모든 .NumOfPeo 요소에서 'selected' 클래스를 제거
       elements.forEach(function(element) {
           element.classList.remove('selected');
       });

       // 클릭된 요소에만 'selected' 클래스를 추가
       num.classList.add('selected');
       displaySelectedSeats(); // 인원 선택 시 선택된 인원을 출력하는 함수 호출
   }
   
   function displaySelectedSeats() {
       var selectedSeats = document.getElementsByClassName("selected");
       var selectedSeatValues = [];
       
       for (var i = 0; i < selectedSeats.length; i++) {
           selectedSeatValues.push(selectedSeats[i].getAttribute("value"));
       }
       
       var selectedSeatsElement = document.getElementById("selected_seats");
       selectedSeatsElement.textContent = selectedSeatValues.join(", ") + " 선택됨";
       
       // 선택된 좌석 값을 숨겨진 input 요소에 할당
       document.getElementById("select_seat").value = selectedSeatValues.join(",");
   }
   
   function back(){
   	history.back();
   }
</script>
</head>
<body>
<%request.setCharacterEncoding("UTF-8"); %> 
	<div id="wrapper"><%--CSS 요청으로 감싼 태그--%>
		<header>
				<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content"><%--CSS 요청으로 감싼 태그--%>
		
			<h1 id="h01">좌석선택</h1>
			<hr>
			<article id="seat_select">
				<div id="header_box">
					<table class="header_box">
						<tr>
							<td colspan="6"><h3>인원 / 좌석</h3></td>
						<tr>	
						<tr id="height50">
							<th colspan="3">
								<table class="hbt">
									<c:set var="type" value="${fn:split('일반,청소년,경로,우대',',')}" /><!--행을결정지을 변수 x 선언-->
									<c:forEach var="j" begin="0" end="${fn:length(type)-1}">
									<tr>
										<td>
											${type[j]}
										</td>
										<c:forEach var="i" begin="0" end="8">
										<c:set var="NumOfpeople" value="${type[j]}${i}"/>
										<td>
											<div class="NumOfPeo" onclick="toggleNum(this)" value="${NumOfpeople}">${i}</div>
										</td>
										</c:forEach>
									</tr>
									</c:forEach>
								</table>
							</th>
							<th colspan="3" class="header_box_Runtime">
								극장 : ${param.theater} ex)3관 11층 ex)남은좌석 100/120<br>
							 	<b>2023년 12월 ${param.date} ex)상영시간 10:39~13:10</b>
							 </th>
						</tr>
					</table>
				</div>
				
				<div id="seat_num">
					<c:set var="x" value="${fn:split('A,B,C,D,E,F,G,H,I,J,K', ',')}" /><!--행을결정지을 변수 x 선언-->
				    <h1 class="center">Screen</h1>
					<c:forEach var="i" begin="0" end="${fn:length(x)-1}">		<!--행을 반복할 반복문 선언-->
				    	<div class="center">
					 	<c:forEach var="j" begin="1" end="16">
					    	<c:set var="seat_type" value="${x[i]}${j}" />
					    	<div class="seat ${j}" onclick="toggleSeat(this)" value="${seat_type}">${seat_type}</div>
						</c:forEach><!-- 열반복 종료 -->
						</div>
					</c:forEach><!-- 행반복 종료 -->
				</div>
			</article>
		</section><%--CSS 요청으로 감싼 태그--%>
		
		<article id="select_info">				
			<table id="end_param">
				<tr>
					<td class="button_area"><input type="button" value="영화선택" onclick="back()" class="button"></td>
					<td class="text_left">${param.movie}</td>
					<td class="text_left">
						극장 : ${param.theater}<br>
						날짜 : ${param.date} <br>
						시간 : ${param.time} <br>
					</td>
					<td class="text_left">
						<h3 id="selected_seats">인원 좌석 선택</h3>
					</td>
					<td class="button_area">
						<form action="../money.jsp" method="post" onsubmit="setSelectedSeatValue()">
						    <input type="hidden" name="movie" value="${param.movie}">		    <!-- 선택된 값을 숨겨진 input 요소에 할당 -->
						    <input type="hidden" name="Theater" value="${param.theater}">
						    <input type="hidden" name="Date" value="${param.date}">
						    <input type="hidden" name="Time" value="${param.time}">
						    <input type="hidden" id="select_seat" name="select_seat" value="">			<!--  선택된 좌석 값 전달 -->	    
						    <input type="submit" value="결제하기" class="button">
						</form>
					</td>
				</tr>
			</table>
		</article>		
		
		<footer>
				<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div> <%--CSS 요청으로 감싼 태그--%>
</body>
</html>