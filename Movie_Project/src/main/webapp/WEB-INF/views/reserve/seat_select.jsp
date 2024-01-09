<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket좌석 선택</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/reserve.css" rel="stylesheet" type="text/css">
<style>
    .selected { 
    	background-color: #de1010; 
    } 
    .SelectPeople{
    	background-color: black;
    	color: white; 
    }
    .StartSelectPeople{
    	background-color: black;
    	color: white; 
    }
    .seatSelectPage_Result_M,.seatSelectPage_Result_T{
    	color: #fff;
    	font-size: 12px;
    }
    .seatSelectPage_Result_M{
		white-space: nowrap;
    }
    #seat_select {
    	background-color: #f1f0e5;
   		padding-bottom: 20px;
    }
    #titleArea h3{
   	    background-color: #323232;
	    color: #bababb;
	    height: 50px;
	    line-height: 50px;
	    margin-bottom: 40px;
	    margin-top: -18.72px;
    }
    .stwelveYearsOld,.sfifteenYearsOld,.seighteenYearsOld,.sallUsers{
        width: 60px;
	    height: 60px;
	    font-size: 45px;
	    line-height: 60px;
	    font-weight: 800;
	    color: #fff;
	    text-align: center;
	    border-radius: 7px;
	   
    }
    
    .stwelveYearsOld{
		background-color:#d9a92b; 
	}
	.sfifteenYearsOld{
		background-color:#cd6b2a; 
	}
	.seighteenYearsOld{
		background-color:#ca2731; 
	}
	.sallUsers{
		background-color:#228f4e;
		font-size: 2em; 
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script>
   let selectNumArr;//선택된 인원수 배열
   let Count2;
   let Count3;
   let Count4;
   let isAlone = false; // 1명인지 판별하는 변수
   var selectPeopleArr; //선택한 인원 타입 배열
	
   function toggleNum(num) {
	    // 클릭된 요소가 속한 행을 찾음
	    var row = $(num).closest('tr');
	    // 해당 행의 모든 .NumOfPeo 요소를 찾음
	    var elements = row.find('.NumOfPeo');
	    // 모든 .NumOfPeo 요소에서 'SelectPeople' 클래스를 제거
	    elements.removeClass('SelectPeople');
	    elements.removeClass('StartSelectPeople');
	    $("#seat_num").removeClass("opacity");
	    // 클릭된 요소에만 'selected' 클래스를 추가
	    $(num).addClass('SelectPeople');
	    
	    var selectPeople = $(".SelectPeople");
	    selectPeopleArr = [];
	    $.each(selectPeople, function(index, people) { // 반복문을 통해 선택된 좌석의 값을 배열에 저장
	    	if (!($(people).attr("value")=="일반0" || $(people).attr("value")=="청소년0" || $(people).attr("value")=="경로0" || $(people).attr("value")=="우대0")) {
		    	selectPeopleArr.push($(people).attr("value"));
	    	}

	    	
	    });
	    $(".Result_NumOfPeople_Param").text(selectPeopleArr.join(","));
	    $("#hidden_typeCount").val(selectPeopleArr.join(","));
	    
	    console.log("selectPeopleArr : " + selectPeopleArr);
	    
	    var selectNum = $(".SelectPeople");
	    selectNumArr = []; 
	    $.each(selectNum, function(index, Num) { // 반복문을 통해 선택된 좌석의 값을 배열에 저장
	    	selectNumArr.push(parseInt($(Num).text()));
	    });
	    console.log("selectNumArr : " + selectNumArr);
	   
	    Count2=0;
	    Count3=0;
	    Count4=0;
	    let sumCountNum = selectNumArr.length
	    if(sumCountNum == 2){
		    for(let i = 0; i<sumCountNum; i++){
		    	Count2 += selectNumArr[i];
		    }
		    
	    }else if(sumCountNum == 3){
	    	 for(let i = 0; i<sumCountNum; i++){
		    	Count3 += selectNumArr[i];
		    }
		    
	    }else if(sumCountNum == 4){
	    	 for(let i = 0; i<sumCountNum; i++){
			    	Count4 += selectNumArr[i];
		    }
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
    	
    	
    	
    	//==================인원이 1명인지 판별하기 위한 판별 식===================
    	var aloneCount = 0; 
    	var NotAloneCount = 0;

    	for (var i = 0; i < selectNumArr.length; i++) {
    	  if (selectNumArr[i] === 1) {
    		  aloneCount++;
    		  console.log("aloneCount++ : " + aloneCount);
    	  }else if(selectNumArr[i] !== 1 && selectNumArr[i] !== 0){
    		  NotAloneCount++;
    		  console.log("NotAloneCount++ : " + NotAloneCount);
    	  }else if(selectNumArr[i] === 0){
    		  NotAloneCount=0;
    		  console.log("otAloneCount=0 : " + NotAloneCount);
    	  }
    	}

    	if (aloneCount === 1 && NotAloneCount===0) {
      		// 1이 하나만 존재하는 경우에 대한 동작을 수행합니다.
    	  isAlone = true;
    	  console.log('isAlone : ' + isAlone);
    	}else{
    	  isAlone = false;
    	}
    	let changeDate;
   	  	if(isAlone){
 			$("div.seat.2, div.seat.3, div.seat.6, div.seat.11, div.seat.14, div.seat.15, .btnMovie").addClass('alone');
   		    var selectedCount = $("div.seat.2, div.seat.3, div.seat.6, div.seat.11, div.seat.14, div.seat.15, .btnMovie").filter('.selected').length;
//    		    alert("제거할 갯수 : " + selectedCount);
	   		NumberOfSeatsCurrentlySelected -= selectedCount;
	   		NumberOfSeatsToChoose = 1;
	   		$(".selected:not(.alone)").each(function() {
	   			changeDate = $(this).text();
	   		})
	   		// 아래메뉴영역에 선택된 좌석 표시
	        $("#selected_seats").text(changeDate+ " 선택됨");
	        // 선택된 좌석 값을 숨겨진 input 요소에 할당
	        $("#hidden_select_seat").val(changeDate);
	   		$("div.seat.2, div.seat.3, div.seat.6, div.seat.11, div.seat.14, div.seat.15, .btnMovie").removeClass('selected');
   		}else if(isAlone == false || isAlone == null){
   		 	$("div.seat.2, div.seat.3, div.seat.6, div.seat.11, div.seat.14, div.seat.15, .btnMovie").removeClass('alone');
   		}
//    	   	alert(changeDate);
		/*
		일반 15000
		청소년 11000
		경로 7000
		우대 5000
		*/
		
	    

	}// 인원수 선택 함수 끝
	
   let NumberOfSeatsCurrentlySelected = 0 ; // 현재 선택한 좌석 수
   let NumberOfSeatsToChoose; //선택할 좌석 수 (선택한 인원 수)
   function toggleSeat(seat) {
	   $('#total_Payment').css('font-size', '12px');
       $('#total_Payment').css('color', 'white');
	   $('.seatSelectPage_Result_S').css('font-size', '12px');
       $('.seatSelectPage_Result_S').css('color', 'white');
   	   NumberOfSeatsToChoose = 0; //선택할 좌석 수 
//        NumberOfSeatsCurrentlySelected++;
   	  if (seat.classList.contains('selected')) {
   	    NumberOfSeatsCurrentlySelected--;
   	  } else {
   	    NumberOfSeatsCurrentlySelected++;
   	  }
       console.log("선택된 좌석 수 NumberOfSeatsCurrentlySelected : " + NumberOfSeatsCurrentlySelected);
		if(selectNumArr != null){
		  	for(let i=0; i<selectNumArr.length; i++){
				NumberOfSeatsToChoose += selectNumArr[i];
			}
			console.log("선택할 좌석수 NumberOfSeatsToChoose : " + NumberOfSeatsToChoose);
			if(NumberOfSeatsToChoose<NumberOfSeatsCurrentlySelected){
				alert("선택된 인원수를 초과한 좌석 지정이 불가능합니다!")
				NumberOfSeatsCurrentlySelected--;
			}else{
				seat.classList.toggle("selected");
			}
		}
		displaySelectedSeats(); // 좌석 선택 시 선택된 좌석을 출력하는 함수 호출
		$("#total_Payment").html("<table class='paymentResult'></table>");
		var regexLan = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g;
		var regexNum = /\d+/g;
  	 	
		for(let arr of selectPeopleArr){
			var resultLan = arr.match(regexLan).join("");
			var resultNum = arr.match(regexNum).join("");
			switch (resultLan) {
				case "일반": resultNum = "15000원 X " + resultNum; break;
				case "청소년": resultNum = "11000원 X " + resultNum; break;
				case "경로": resultNum = "7000원 X " + resultNum; break;
				case "우대": resultNum = "5000원 X " + resultNum; break;
				default: resultNum=""; break;
			}
			
			$(".paymentResult").append(
			"<tr>"
			+"<td class='widthSmall'>"+ arr.match(regexLan).join("") +"</td>"
			+"<td>"+resultNum+"</td>"
			+"</tr>");
		}// for End
		  
	}//toggle Seat End
   
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
       console.log("선택된 좌석 값" + selectedSeatValues);
   }
   
   function back(){
   	history.back();
   }
   
   
   $(function(){
		//====================모달===================
	   var modalContainer = $('.modal-container');
	  var modalClose = $('.modal-close');
	  var modalButton = $('.modal-button');
	
	  modalClose.click(closeModal);
	  modalButton.click(closeModal);
	
	  function closeModal() {
	    modalContainer.hide();
	  }
		//====================모달===================	   
	   
	   $(".subBtn").click(function(){
		   if(selectPeopleArr==""){
			   alert("인원선택 필수!")
			   return false;
			}
		   if(NumberOfSeatsCurrentlySelected==null){
		       alert("좌석선택 필수!")
			   return false;
			}
		   
		   if(NumberOfSeatsCurrentlySelected != NumberOfSeatsToChoose){
			   alert("인원수와 좌석수가 일치하지 않습니다!")
// 			   alert("골라야하는갯수 : " +NumberOfSeatsToChoose+ " 고른수 : " + NumberOfSeatsCurrentlySelected);
			   return false;
			}
		});
	   $("#DiscountInfo").click(function(){
			   var width = 500; // 팝업 창의 가로 크기
			   var height = 400; // 팝업 창의 세로 크기
			   var left = (window.innerWidth / 2) - (width / 2); // 화면 가로 중앙에 위치
		       var top = (window.innerHeight / 2) - (height / 2); // 화면 세로 중앙에 위치

			   var options = "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top;

			   window.open("DiscountInfo", "관람할인안내", options);
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
							<td colspan="6" id="titleArea" style="height: 45px;"><h3>인원 / 좌석</h3></td>
						<tr>	
						<tr id="height50">
							<th colspan="2" id="peoSelTableTh">
								<table class="peoSelTable">
									<c:set var="type" value="${fn:split('일반,청소년,경로,우대',',')}" /><%--행을결정지을 변수 x 선언--%>
									<c:forEach var="j" begin="0" end="${fn:length(type)-1}">
									<tr>
										<td>
											${type[j]}
										</td>
										<c:forEach var="i" begin="0"  end="8">
										<c:set var="NumOfpeople" value="${type[j]}${i}"/>
										<td>
											<div <c:if test="${i eq 0}"> class="NumOfPeo StartSelectPeople" </c:if> class="NumOfPeo" onclick="toggleNum(this)" value="${NumOfpeople}">${i}</div>
										</td>
										</c:forEach>
									</tr>
									</c:forEach>
								</table>
								</th>
							<td id="DiscountInformation">
								<div>*최대 8명 선택 가능</div>
								<div id="popup">
								<input type="button" id="DiscountInfo" value="관람할인안내">
								</div>
							</td>
							<th colspan="3" class="header_box_Runtime">
								${reserveVO.theater_name } ${reserveVO.room_name} 남은좌석 ${176-fn:length(SeatList)}/176<br>
							 	<b>${outputDate} ${fn:substring(reserveVO.play_start_time, 0, 5)} ~ ${fn:substring(reserveVO.play_end_time, 0, 5)}</b>
							 </th>
						</tr>
					</table>
				</div>
				<!-- 모달 창 -->
				<div class="modal-container">
				  <div class="modal-content">
				    <div class="modal-header">
				      <span>관람등급 안내</span>
				      <span class="modal-close">X</span>
				    </div>
				    <c:choose>
				    	<c:when test="${reserveVO.movie_rating eq 'ALL'}"><script>$(function(){$(".modal-close").click();})</script></c:when>
				    	<c:when test="${reserveVO.movie_rating eq '12'}"><div class="ageInfoArea stwelveYearsOld">12</div></c:when>
				    	<c:when test="${reserveVO.movie_rating eq '15'}"><div class="ageInfoArea sfifteenYearsOld">15</div></c:when>
				    	<c:when test="${reserveVO.movie_rating eq '18'}"><div class="ageInfoArea seighteenYearsOld">18</div></c:when>
				    </c:choose>
				    <div class="modal-body">
				      <p>본 영화는 [${reserveVO.movie_rating}세 이상 관람가]입니다.</p>
				      <p>만 ${reserveVO.movie_rating}세 미만 고객은 만 19세 이상 성인 보호자 동반 시 관람이 가능합니다.</p>
				      <p>연령확인 불가 시 입장이 제한될 수 있습니다.</p>
				      <p>※생년월일 확인 수단 지참: 학생증, 모바일 학생증, 청소년증, 여권</p>
				      <p>(사진, 캡쳐본 불가)</p>
				    </div>
				    <div class="modal-footer">
				      <button class="modal-button">동의하고 예매하기</button>
				    </div>
				  </div>
				</div>
				<!-- 모달 창 -->

				<c:forEach var="SeatList" items="${SeatList}">
				<!-- 예매된 좌석을 하나의 변수에 저장하는 반복문 -->
					<c:set var="seat_name" value="${seat_name}${SeatList.seat_name}," />
				</c:forEach>
				<div id="seat_num" class="opacity">
					<c:set var="x" value="${fn:split('A,B,C,D,E,F,G,H,I,J,K', ',')}" /><%--행을결정지을 변수 x 선언--%>
				   
				    <h1 id="screenArea">Screen ${isAlone} </h1>
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
								<%-- <c:if test='${isAlone eq true and (j eq 2 or j eq 3 or j eq 6 or j eq 11 or j eq 14 or j eq 15)}'>alone</c:if> --%>
					    			<div class="seat ${j}" onclick="toggleSeat(this)" value="${seat_type}">${seat_type}</div>
					    		</c:otherwise>
					    	</c:choose>
						</c:forEach><%-- 열반복 종료 --%>
						</div>
					</c:forEach><%-- 행반복 종료 --%>
					<table id="seatCondition">
						<tr>
							<td><img src="${pageContext.request.contextPath}/resources/img/seatCondition.png" width="90px" height="160px"></td>
						</tr>
					</table>
				</div>
			</article>
		</section><%--CSS 요청으로 감싼 태그--%>
		
		<article id="select_info">				
			<table id="end_param" class="center">
				<tr>
					<td class="button_area"><input type="button" value="영화선택" onclick="back()" class="button"></td>
					<td class="seatSelectPage_Result_M">
						<img src="${reserveVO.movie_poster}" width="75" height="95"><span class="endparamMoviename">${reserveVO.movie_title}</span>
					
					</td>
					<td class="seatSelectPage_Result_T">
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
					<td id="total_Payment"><h3>결제</h3></td>
					<td class="button_area">
						<form action="reservePay" method="post" onsubmit="setSelectedSeatValue()">
						    <input type="hidden" name="movie" value="${reserveVO.movie_title}">		    <%-- 선택된 값을 숨겨진 input 요소에 할당 --%>
						    <input type="hidden" name="Theater" value="${reserveVO.theater_name}">
						    <input type="hidden" name="Date" value="${reserveVO.play_date}">
						    <input type="hidden" name="StartTime" value="${reserveVO.play_start_time}">
						    <input type="hidden" name="EndTime" value="${reserveVO.play_end_time}">
						    <input type="hidden" name="Room" value="${reserveVO.room_name}">
						    <input type="hidden" id="hidden_typeCount" name="typeCount" value="">
						    <input type="hidden" id="hidden_select_seat" name="select_seat" value="">			<%--  선택된 좌석 값 전달 --%>	    
						    <input type="submit" value="결제하기" class="button subBtn">
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