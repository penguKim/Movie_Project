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
    .selected { 
    	background-color: #de1010; 
    } 
    .SelectPeople{
    	background-color: #00ffff; 
    }
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script>
   let selectNumArr;//선택된 인원수 배열
   function toggleNum(num) {
	    // 클릭된 요소가 속한 행을 찾음
	    var row = $(num).closest('tr');
	    // 해당 행의 모든 .NumOfPeo 요소를 찾음
	    var elements = row.find('.NumOfPeo');
	    // 모든 .NumOfPeo 요소에서 'SelectPeople' 클래스를 제거
	    elements.removeClass('SelectPeople');
	    // 클릭된 요소에만 'selected' 클래스를 추가
	    $(num).addClass('SelectPeople');
	    
	    var selectPeople = $(".SelectPeople");
	    var selectPeopleArr = [];
	    $.each(selectPeople, function(index, people) { // 반복문을 통해 선택된 좌석의 값을 배열에 저장
	    	selectPeopleArr.push($(people).attr("value"));
	    });
	    $(".Result_NumOfPeople_Param").text(selectPeopleArr.join(","));
	    console.log("selectPeopleArr : " + selectPeopleArr);
	    
	    var selectNum = $(".SelectPeople");
	    selectNumArr = []; 
	    $.each(selectNum, function(index, Num) { // 반복문을 통해 선택된 좌석의 값을 배열에 저장
	    	selectNumArr.push(parseInt($(Num).text()));
	    });
	    console.log("selectNumArr : " + selectNumArr);
	   
	    let Count2=0;
	    let Count3=0;
	    let Count4=0;
	    let sumCountNum = selectNumArr.length
	    if(sumCountNum == 2){
		    for(let i = 0; i<sumCountNum; i++){
		    	Count2 += selectNumArr[i];
		    }
		    console.log("Count2 : " + Count2);
		    
	    }else if(sumCountNum == 3){
	    	 for(let i = 0; i<sumCountNum; i++){
		    	Count3 += selectNumArr[i];
		    }
		    console.log("Count3 : " + Count3);
		    
	    }else if(sumCountNum == 4){
	    	 for(let i = 0; i<sumCountNum; i++){
			    	Count4 += selectNumArr[i];
		    }
			console.log("Count4 : " + Count4);
		    }
	
    	if(Count2>8||Count3>8||Count4>8){
    		alert("8명초과 예매 불가입니다!")
	    	$(".SelectPeople").removeClass("SelectPeople");
	    	$(".Result_NumOfPeople_Param").text("");
	    	Count2=0;
	    	Count3=0;
	    	Count4=0;
	    	selectNumArr = [];
    	}
	    

	}   
   function toggleSeat(seat) {
	   let countSeat = 0; //선택할 좌석 수 
	   let selectSeat = 0; //선택된 좌석 수
       seat.classList.toggle("selected");
       selectSeat++;
       /* 12/22 17:38 여기까지 진행함
       진행상황
       완료 
       - 영화선택 페이지 미선택 항목 출력 후 돌려보내기
       - 세션아이디 미인증시 접근 불가 페이지 둘다
       - 인원수 선택 8명 이상 선택 불가 처리
       미완료
       - 인원수랑 좌석 선택 연동기능 진행중
        (현재 좌석 선택후 인원선택은 원활 반대는 문제가 발생!)
       - 1명 선택시 지정불가 좌석 처리
       - 인설트 구문 작성 하여 직접 데이터 처리
       - 예매 게시판 2개
       */
       console.log("좌석선택 시 selectNumArr : " + selectNumArr);
       if(selectNumArr != null){
	       for(let i=0; i<selectNumArr.length; i++){
	    	   countSeat += selectNumArr[i];
	       }
	       console.log("선택할 좌석수 countSeat : " + countSeat);
	       if(countSeat!=selectSeat){
	    	   alert("선택된 인원수를 초과한 좌석 지정이 불가능합니다!")
	    	   seat.classList.toggle("selected");
	       }
       }
       displaySelectedSeats(); // 좌석 선택 시 선택된 좌석을 출력하는 함수 호출
   }
   
   function displaySelectedSeats() {
	   let selectedSeats = $(".selected"); // 선택된 좌석값의 위치
	   let selectedSeatValues = []; // 여러개의 좌석값을 저장한 변수 선언
	   
	   $.each(selectedSeats, function(index, seat) { // 반복문을 통해 선택된 좌석의 값을 배열에 저장
	     selectedSeatValues.push($(seat).attr("value"));
	   });
	   // 아래메뉴영역에 선택된 좌석 표시
       $("#selected_seats").text(selectedSeatValues.join(", ") + " 선택됨");
       // 선택된 좌석 값을 숨겨진 input 요소에 할당
       $("#hidden_select_seat").val(selectedSeatValues.join(","));
       console.log(selectedSeatValues);
   }
   
   function back(){
   	history.back();
   }

   $(function(){
	   $("#subBtn").click(function(){
			if(sum==0){
				alert("인원선택 필수!")
				return false;
			}
			if(!$('.seat').hasClass("selected")){
				alert("좌석선택 필수!")
				return false;
			}
	   });
   });
   
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
<!-- ================================================================== -->
	<c:set var="inputDate" value="${reserveVO.play_date}" />
	
	<c:set var="dateParts" value="${fn:split(inputDate, '-')}"/>
	<c:set var="year" value="${dateParts[0]}"/>
	<c:set var="month" value="${dateParts[1]}"/>
	<c:set var="day" value="${dateParts[2]}"/>
	
	<c:set var="monthString" value=""/>
	<c:forEach begin="1" end="12" varStatus="loop">
	  <c:if test="${month == loop.index}">
	    <c:set var="monthString" value="${loop.index}" />
	  </c:if>
	</c:forEach>
	
	<c:set var="outputDate" value="${year}년 ${monthString}월 ${day}일" />
	
<!-- ================================================================== -->

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
									<c:set var="type" value="${fn:split('일반,청소년,경로,우대',',')}" /><%--행을결정지을 변수 x 선언--%>
									<c:forEach var="j" begin="0" end="${fn:length(type)-1}">
									<tr>
										<td>
											${type[j]}
										</td>
										<c:forEach var="i" begin="1" end="8">
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
								${reserveVO.theater_name } ${reserveVO.room_name} 남은좌석 ${176-fn:length(SeatList)}/176<br>
							 	<b>${outputDate} ex)상영시간 10:39~13:10</b>
							 </th>
						</tr>
					</table>
				</div>
				<c:forEach var="SeatList" items="${SeatList}">
<!-- 					예매된 좌석을 하나의 변수에 저장하는 반복문 -->
					<c:set var="seat_name" value="${seat_name}${SeatList.seat_name}," />
				</c:forEach>
				<div id="seat_num">
					<c:set var="x" value="${fn:split('A,B,C,D,E,F,G,H,I,J,K', ',')}" /><%--행을결정지을 변수 x 선언--%>
				   
				    <h1 id="screenArea">Screen</h1>
					<c:forEach var="i" begin="0" end="${fn:length(x)-1}">		<%--행을 반복할 반복문 선언--%>
				    	<div class="center">
					 	<c:forEach var="j" begin="1" end="16">
					    	<c:set var="seat_type" value="${x[i]}${j}" />
					    	<c:set var="index" value="${fn:indexOf(seat_name, seat_type)}"/>
					    	<c:choose>
					    		 <%--예매된 좌석이 있을경우를 처리하는 when--%>
					    		<c:when test="${index != -1}">
					    			<c:choose>
					    				<%-- 'A1' 좌석일 경우 A10좌석과 판별할때 오류가 발생하므로 해결하기 위한 판별문 when --%>
										<c:when test="${j == 1}">
											<%-- JSTL 1.1버전 이후에는 <c:break/> 기능을 지원하나 현재 버전에선 미 지원이므로
											     return 처럼 사용할 변수 stopIteration 선언 --%>
											<c:set var="stopIteration" value="false" />
											<%-- 'A1'좌석의 예매여부를 확인하기 위해 예매된 좌석을 배열로 변수에 저장 --%>
											<c:set var="seatArr" value="${fn:split(seat_name,',')}" /> 
											<c:forEach var="sa" begin="0" end="${fn:length(seatArr)-1}" varStatus="status">
												<%-- 만약 'A1'좌석이 예매되지 않았을 경우 --%>
												<c:if test="${seatArr[sa] ne 'A1' && !stopIteration}">
						    						<div class="seat ${j}" onclick="toggleSeat(this)" value="${seat_type}">${seat_type}</div>
						    						<c:set var="stopIteration" value="true" />
												</c:if>
												<%-- 만약 'A1'좌석이 예매되었을 경우 --%>
												<c:if test="${seatArr[sa] eq 'A1' && !stopIteration}">
													<div class="reserved seat" value="${seat_type}">${seat_type}</div>
													<c:set var="stopIteration" value="true" />
												</c:if>
											</c:forEach>
										</c:when>					    		
										<c:otherwise>
											<%-- 'A1'좌석이 아닌 다른 좌석이 예매되어 있을 경우 예매 reserved처리  --%>
							    			<div class="reserved seat" value="${seat_type}">${seat_type}</div>
										</c:otherwise>    		
					    			</c:choose>
					    		</c:when>
					    		<c:otherwise>
					    			<div class="seat ${j}" onclick="toggleSeat(this)" value="${seat_type}">${seat_type}</div>
					    		</c:otherwise>
					    	</c:choose>
						</c:forEach><%-- 열반복 종료 --%>
						</div>
					</c:forEach><%-- 행반복 종료 --%>
					<table id="seatCondition">
						<tr>
							<td><img src="${pageContext.request.contextPath }/resources/img/좌석상태표.png" width="90px" height="160px"></td>
						</tr>
					</table>
				</div>
			</article>
		</section><%--CSS 요청으로 감싼 태그--%>
		
		<article id="select_info">				
			<table id="end_param" class="center">
				<tr>
					<td class="button_area"><input type="button" value="영화선택" onclick="back()" class="button"></td>
					<td class="seatSelectPage_Result_M">${reserveVO.movie_title}</td>
					<td class="">
						<table>
							<tr>
								<td class="widthSmall">극장</td>
								<td>${reserveVO.theater_name}</td>
							</tr>
							<tr>
								<td class="widthSmall">일시</td>
								<td>${reserveVO.play_date} ${reserveVO.play_start_time}</td>
							</tr>
							<tr>
								<td class="widthSmall">상영관</td>
								<td>${reserveVO.room_name}</td>
							</tr>
							<tr>
								<td class="widthSmall">인원</td>
								<td class="Result_NumOfPeople_Param"></td>
							</tr>
						</table>
					</td>
					<td class="seatSelectPage_Result_S">
						<h3 id="selected_seats">좌석 선택</h3>
					</td>
					<td class="seatSelectPage_Result_P">
						<h3 id="">결제</h3>
					</td>
					<td class="button_area">
						<form action="ReservationComplete" method="post" onsubmit="setSelectedSeatValue()">
						    <input type="hidden" name="movie" value="${reserveVO.movie_title}">		    <%-- 선택된 값을 숨겨진 input 요소에 할당 --%>
						    <input type="hidden" name="Theater" value="${reserveVO.theater_name}">
						    <input type="hidden" name="Date" value="${reserveVO.play_date}">
						    <input type="hidden" name="Time" value="${reserveVO.play_start_time}">
						    <input type="hidden" name="Room" value="${reserveVO.room_name}">
						    <input type="hidden" id="hidden_select_seat" name="select_seat" value="">			<%--  선택된 좌석 값 전달 --%>	    
						    <input type="submit" value="결제하기" class="button" id="subBtn">
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