<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>iTicket</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/theater.css" rel="stylesheet" type="text/css">
<head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
$(function() {
	  $(document).ready(function() {
	    var urlParams = new URLSearchParams(window.location.search);
	    var theaterName = urlParams.get('theater_name');

	    // 버튼들을 선택합니다
	    var theaterButtons = $("input[name='theaterNames']");

	    // 버튼 클릭 이벤트 핸들러를 등록합니다
	    theaterButtons.on("click", function() {
	      // 이전에 선택된 버튼의 배경색을 초기화합니다
	      theaterButtons.css("background-color", "");

	      // 클릭한 버튼의 배경색을 보라색으로 변경합니다
	      $(this).css("background-color", "purple");
	    });

	    // 파라미터로 넘어온 버튼을 찾아서 해당 버튼을 클릭한 것처럼 처리합니다
	    theaterButtons.each(function() {
	      if ($(this).val() === theaterName) {
	        $(this).trigger("click");
	      }
	    });
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
		
		<div id="content">
						<h1 id="h01">극장정보</h1>
			<hr>
			<div id="img_div">
				<img src="${pageContext.request.contextPath}/resources/img/CGV서면.png" alt="cgv" id="image">
			</div>
			<hr>
			<div class="menu" >
				<nav class="theater1">
					<c:forEach var="theaterName" items="${theaterNames}" varStatus="status">
						<input type="button" name="theaterNames" class="${theaterName.theater_name}" id="${theaterName.theater_name}" value="${theaterName.theater_name}">
					</c:forEach>
				</nav>
			</div>
			<hr>
			<div id="theater_event">
				<a href="http://localhost:8081/c5d2308t1/detail?movie_id=20203702">
				<img src="${pageContext.request.contextPath}/resources/img/이벤트.jpg" alt="cgv" id="image">
				</a>
			</div>
			
			<ul class="tab-menu" id="menu">
		        <li><a href="theater" >관람료안내</a></li>
		        <li class="on"><a href="movieSelect?theater_name=${theaterName.theater_name}" title="현재 선택됨">예매하기</a></li>
		        <li><a href="#sec01">위치/주차안내</a></li>
<!-- 		        <li><input type="button">위치/주차안내</li> -->
		    </ul>
			
			
			
	    	<div class="sub_content">
	    	
	    			<section id="sec01">
							<div class="col-detail"> 
							    <div class="sect-theater-info">
		        					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
		        					<div class="info-contents">
							            <p># 지하철<br><br>
										1호선 범내골역 6번출구, 2호선 전포역 1번출구
										<br>
										<br>
										# 버스<br>
										지오플레이스 앞 : 5-1, 10번, 24번, 29번, 38번, 43번, 52번, 54번, 57번,<br>
							            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;67번, 80번, 82번, 99번, 111번, 160번, 583번,<br>
							            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;급행 1000번, 급행 1000(심야)<br>
									</div>
									<a class="round red" href="https://map.naver.com/p/search/%EC%84%9C%EB%A9%B4cgv?c=16.39,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
								</div>
		 				   <div class="sect-theater-info">
								<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
								<div class="info-contents">
								   ※ 지상주차장과 지하주차장의 할인등록 위치가 다르니 해당 위치의 할인기에서 사전 등록해야 할인적용이 됩니다.<br><br>
						           1. 홈플러스 지하주차장<br>
									- 영화 관람 시 3시간 무료<br> 
									(당일 영화 관람 시 6층 CGV상영관 안쪽 기둥 주차키오스크에서 셀프 사전등록 必)<br>
									- 홈플러스 지하 5층 전용<br>
									<span id="parking">- 추가 요금: 무료 주차(30분) 초과 시 10분당 1,000원<br></span>
									※ 주차할인 미인증 시 요금부과 되오니 반드시 6층 CGV 주차키오스크에서 사전 등록 必<br>
									※ 주차장 출구에서 할인 적용 불가,<br>
									※ 주차할인 미등록 후 출차 시 발생되는 요금 환불 불가<br>
									※ 2편 이상 관람 시 1편 관람 이후 무료 시간 내 출차하고 재 입차 必<br><br>
					
					
									2. 지상주차장(유료 주차장)<br>
									<span id="parking">- 주중: 4시간 1,000원<br>
									- 주말/공휴일: 3시간 1,000원<br>
									- 추가 요금: 무료 주차(30분) 초과 시 10분당 300원<br></span>
									
									※ 당일 영화 관람 고객대상 할인가능<br>
									※ 사전 결제 미 진행 시 할인 불가하오니 반드시 6층 CGV로비 티켓판매기에서 사전 결제 必<br>
									※ 주차장 출구에서 할인 적용 불가<br>
									※ 사전 결제 미진행 후 출차 시 발생되는 요금 환불 불가<br>
									※ 2편 이상 관람 시 1편 관람 이후 할인 시간 내 출차하고 재 입차하여 재 결제 必<br><br>
									 
									
									3. 주차장 입구
										<ul>
											<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img alt="" height="206" src="${pageContext.request.contextPath}/resources/img/주차장약도.jpg" width="606"></li>
											<li>&nbsp;</li>
										</ul>
						            <br><br>
						        </div>
						    </div>
						</div>
					</section>
			<script>
			
			var selectedId;
//				이미지 지도로 변경 및 마커스 찍기
		 function changeImage(imageSrc) {
		  var image = document.getElementById("image");
		  image.src = imageSrc;
		}
			
		
		 var locations = [
			  {
			    id: "서면삼정타워",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/삼정타워점.JPG",
			    lat: 35.15301369233767,
			    lng: 129.05962274791744
			  },
			  {
			    id: "동래",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/동래.JPG",
			    lat: 35.221414075646194,
			    lng: 129.0855232950597
			  },
			  {
			    id: "서면상상마당",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/상상마당.JPG",
			    lat: 35.15423948976798,
			    lng: 129.05748931736966
			  },
			  {
			    id: "부산명지",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/명지점.png",
			    lat: 35.09440141296223,
			    lng: 128.90351489468253
			  },
			  {
			    id: "아시아드",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/아시아드점.png",
			    lat: 35.19154582406568,
			    lng: 129.06328187601284
			  },
			  {
			    id: "센텀시티",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/센텀점.png",
			    lat: 35.1691119842877,
			    lng: 129.13038331260668
			  },
			  {
			    id: "하단아트몰링",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/하단아트몰링.png",
			    lat: 35.489848332547005,
			    lng: 129.43101483150292
			  },
			  {
			    id: "서면",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/CGV서면.png",
			    lat: 35.149278694688036,
			    lng: 129.06357447166218
			  },
			  {
			    id: "화명",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/화명점.png",
			    lat: 35.23471793459627,
			    lng: 129.00987511366884
			  },
			  {
			    id: "해운대",
			    imageSrc: "${pageContext.request.contextPath}/resources/img/해운대점.png",
			    lat: 35.1628435626128,
			    lng: 129.1584244156929
			  }
			];
		 
		 var selectedContainer = null;
		 
		 locations.forEach(function(location) {
		   var container = document.getElementById(location.id);
		   if (container) { 
		     container.onclick = function() {
		       changeImage(location.imageSrc);
		       selectedId = location.id; // 클릭한 위치의 ID를 변수에 저장합니다
		       var theaterElements = document.getElementsByName("theaterNames");
		       for (var i = 0; i < theaterElements.length; i++) {
		         var value = theaterElements[i].value;
		       }
		       
		       if (selectedContainer) {
		         selectedContainer.style.backgroundColor = ''; // 체크된 버튼의 배경색을 원래의 배경색으로 변경합니다
		       }
		       
		       // 선택한 버튼의 배경색을 변경합니다
		       container.style.backgroundColor = 'purple';
		       
		       // 선택한 버튼을 selectedContainer 변수에 저장합니다
		       selectedContainer = container;
		       
		       changeImageIfNeeded();
		     };
		   }
		 });



		 var buttons = document.querySelectorAll('input[type="button"]');
		 buttons.forEach(function(button) {
		   button.addEventListener('click', function(event) {
		     // 선택된 버튼의 아이디 값을 가져와서 변수에 저장
		     selectedId = event.target.id;
		   });
		 });

		 document.querySelector('.on a').addEventListener('click', function(event) {
		   event.preventDefault();
		   var url = event.target.href;
		   if (selectedId) {
		     url += selectedId;
		   }
		   window.location.href = url;
		 });
			 </script>
			</div>
		</div>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	  $('input[name="theaterNames"]').click(function() {
	    var selectedTheater = $(this).val(); // 선택한 극장 이름 가져오기
// 	    var encodedTheater = encodeURIComponent(selectedTheater);
	    var currentURL = window.location.href; // 내가 현재 있는 페이지 저장
	    // AJAX 호출
	    
	    $.ajax({
	      type: "GET", 
	      url: currentURL, // AJAX 호출을 처리할 URL
	      data: { selectedTheater: selectedTheater }, 
	      success: function(response) {
	    	  if(selectedTheater == "동래") {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    			    <!-- 동래 점의 내용 -->
	    			    <div class="col-detail">
	    			      <div class="sect-theater-info">
	    			        <h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
	    			        <div class="info-contents">
	    			          <p># 지하철<br><br>
	    			          1호선 │ 온천장역 3번출구
	    			          <br>
	    			          <br>
	    			          # 버스<br>
	    			          80번, 80-1번, 77번, 189번, 188번, 100번, 100-1번, 144번,<br><br>
	    			          
	    			          [SK 허브 스카이 앞]<br>
	    			          37번
	    			          
	    			          <br><br>
	    			          
	    			          [노포동, 구서동 방면에서 오시는 길]<br>
	    			          산업도로(지하철 보이는 큰길) → 구름다리 오기전 홈플러스 시계탑 우회전 → 온천장 뒷길 → 온천장 뒷길 10M 직진 → 좌측 상가주차장 입구
	    			          
	    			          <br><br>
	    			          
	    			          [서면, 사직동 방면에서 오시는 길]<br>

	    			          산업도로(지하철 보이는 큰길) → 구름다리지나서 유턴 → 온천장 뒷길(동래 롯데백화점과 아웃백사이 도로) → SK허브스카이건물 우회전
	    			          
	    			          </div>
	    			          <a class="round red" href="https://map.naver.com/p?title=CGV%EB%8F%99%EB%9E%98&lng=129.0853950&lat=35.2216110&zoom=15&type=0&c=15.00,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
	    			        </div>
	    			      </div>
	    			      <div class="sect-theater-info">
	    			        <h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
	    			        <div class="info-contents">
	    			          <!-- 동래 점의 주차안내 내용 -->
	    			          <주차 요금 안내><br>

	    			          ①무료주차(건물 지하4층 4시간)<br>
	    			          -6F 매표/매점에서 ★사전주차등록★진행<br>
	    			          -초과 시 10분당 500원<br>
	    			           (주차미인증 후 출차시 3시간 9,000원)<br>
	    			          -사전등록 미진행 후 출차시 결제 금액 환불 불가<br>

	    			          ②유료주차(홈플러스 지하2층,3층)<br>
	    			          -홈플러스 주차장은 유료주차장입니다.<br>
	    			          -무료출차 불가, 10분당 500원<br>
	    			          -홈플러스 주차장 23시 이후 출차 불가<br>
	    			           (2,4주차 휴무일은 22시 이후 출차 불가)<br><br>
	    			                 CGV동래로 오시는 길<br><br>
	    			                 &nbsp;&nbsp;온천장 뒷길로 오는 방법<br><br>
	    			                 <img alt="" src="${pageContext.request.contextPath}/resources/img/동래지도.jpg" width="606"><br><br>
	    			                 &nbsp;&nbsp;산업도로에서 오는 방법<br><br>
	    			                 <img alt="" src="${pageContext.request.contextPath}/resources/img/동래지도2.jpg" width="606"><br><br><br>
	    			                 
	    			                 
	    			        </div>
	    			      </div>
	    			    </div>
	    			  `;
	    		  document.getElementById(sectionId).innerHTML = newContent;
	    	  
	    	  } else if(selectedTheater == "서면") {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    		  
					<div class="col-detail"> 
				    <div class="sect-theater-info">
    					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
    					<div class="info-contents">
				            <p># 지하철<br><br>
							1호선 범내골역 6번출구, 2호선 전포역 1번출구
							<br>
							<br>
							# 버스<br>
							지오플레이스 앞 : 5-1, 10번, 24번, 29번, 38번, 43번, 52번, 54번, 57번,<br>
				            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;67번, 80번, 82번, 99번, 111번, 160번, 583번,<br>
				            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;급행 1000번, 급행 1000(심야)<br>
						</div>
						<a class="round red" href="https://map.naver.com/p?title=CGV%EC%84%9C%EB%A9%B4&lng=129.0644922&lat=35.1496859&zoom=15&type=0&c=15.00,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
					</div>
				   <div class="sect-theater-info">
					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
					<div class="info-contents">
					   ※ 지상주차장과 지하주차장의 할인등록 위치가 다르니 해당 위치의 할인기에서 사전 등록해야 할인적용이 됩니다.<br><br>
			           1. 홈플러스 지하주차장<br>
						- 영화 관람 시 3시간 무료<br> 
						(당일 영화 관람 시 6층 CGV상영관 안쪽 기둥 주차키오스크에서 셀프 사전등록 必)<br>
						- 홈플러스 지하 5층 전용<br>
						<span id="parking">- 추가 요금: 무료 주차(30분) 초과 시 10분당 1,000원<br></span>
						※ 주차할인 미인증 시 요금부과 되오니 반드시 6층 CGV 주차키오스크에서 사전 등록 必<br>
						※ 주차장 출구에서 할인 적용 불가,<br>
						※ 주차할인 미등록 후 출차 시 발생되는 요금 환불 불가<br>
						※ 2편 이상 관람 시 1편 관람 이후 무료 시간 내 출차하고 재 입차 必<br><br>
		
		
						2. 지상주차장(유료 주차장)<br>
						<span id="parking">- 주중: 4시간 1,000원<br>
						- 주말/공휴일: 3시간 1,000원<br>
						- 추가 요금: 무료 주차(30분) 초과 시 10분당 300원<br></span>
						
						※ 당일 영화 관람 고객대상 할인가능<br>
						※ 사전 결제 미 진행 시 할인 불가하오니 반드시 6층 CGV로비 티켓판매기에서 사전 결제 必<br>
						※ 주차장 출구에서 할인 적용 불가<br>
						※ 사전 결제 미진행 후 출차 시 발생되는 요금 환불 불가<br>
						※ 2편 이상 관람 시 1편 관람 이후 할인 시간 내 출차하고 재 입차하여 재 결제 必<br><br>
						 
						
						3. 주차장 입구
							<ul>
								<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img alt="" height="206" src="${pageContext.request.contextPath}/resources/img/주차장약도.jpg" width="606"></li>
								<li>&nbsp;</li>
							</ul>
			            <br><br>
			        </div>
			    </div>
			</div>
			`;
			
			document.getElementById(sectionId).innerHTML = newContent;
	    	  } else if(selectedTheater == '서면삼정타워') {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    		  
					<div class="col-detail"> 
				    <div class="sect-theater-info">
    					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
    					<div class="info-contents">
	    			  * 지하철<br><br>
	    			  1) 1,2호선 서면역 2번 출구<br>
	    			  2) 2호선 전포역 5번 출구<br><br>
	    			  * 버스<br>
	    			  - 시내버스: 20번, 24번, 301번, 66번, 63번, 103번, 81번, 83-1번, 86번, 133번, 17번, 23번 등
						</div>
						<a class="round red" href="https://map.naver.com/p/?title=CGV%EC%84%9C%EB%A9%B4%EC%82%BC%EC%A0%95%ED%83%80%EC%9B%8C&lng=129.059655&lat=35.153219&zoom=15&type=0" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
					</div>
				   <div class="sect-theater-info">
					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
					<div class="info-contents">
					● 주차안내<br>
					- 요금 안내 : 당일 영화 관람시 3시간 기준 1,000원 (초과시 10분 당 1,000원)<br>
					- 확인 방법 : 13층 매표소에서 차량 번호 확인 및 1천원 결제 후 출차가능<br><br>

					주차공간이 많이 협소하오니, 대중교통 이용 부탁드리겠습니다.
			            <br><br><br>
			        </div>
			    </div>
			</div>
			`;
			
			document.getElementById(sectionId).innerHTML = newContent;
	    		  
	    	  }else if (selectedTheater == '서면상상마당') {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    		  
					<div class="col-detail"> 
				    <div class="sect-theater-info">
    					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
    					<div class="info-contents">
    					지하철 서면역 7번출구에서 도보 5분거리
						</div>
						<a class="round red" href="https://map.naver.com/p?title=CGV%EC%84%9C%EB%A9%B4%EC%83%81%EC%83%81%EB%A7%88%EB%8B%B9&lng=129.05749296682558&lat=35.15427547429185&zoom=15&type=0&c=15.00,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
					</div>
				   <div class="sect-theater-info">
					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
					<div class="info-contents">
	    			  1) 주차정보 : 서면 상상마당거리에서 KT&G건물 왼편 지하주차장 위치,<br>
	    			  (2) 주차장이용 : 건물 B4-B2 주차장 운영<br>
	    			  (3) 이용요금 : 당일 영화 관람 시 4시간 무료 / 초과 시 20분당 1천원<br>
	    			  - 반드시 매점에서 당일 영화 티켓 제시 후 차량번호 인증 시 4시간 무료 적용 가능합니다. (미 인증 시 요금 부과)<br>
	    			  - 입차 시점부터 4시간 무료 가능하며, 입차 및 영화에 따른 추가시간은 출차 시 유료 결제됩니다<br>
	    			  (4) 이용안내 :<br>
	    			   - 주차공간이 매우 협소하여, 이용이 거의 불가하오니 대중교통 이용 부탁드립니다.<br>
	    			  - 만차 시 입차에 30분 이상 소요될 수 있습니다. (주차 가능 대수: 50여 대)<br>
	    			  - 최대 4시간 이후 추가 인증이 불가하며, 입점 건물 주차 정책에 따라 건물 내 타 매장과 무료주차 인증 중복이 불가합니다.<br>
			            <br><br><br>
			        </div>
			    </div>
			</div>
			`;
	    		  document.getElementById(sectionId).innerHTML = newContent;
	    	  } else if (selectedTheater == '아시아드') {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    		  
					<div class="col-detail"> 
				    <div class="sect-theater-info">
    					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
    					<div class="info-contents">
    					버스<br><br>

    					일반버스: 44, 50, 54, 57, 80, 111, 131, 1002(심야)
						</div>
						<a class="round red" href="https://map.naver.com/p?title=CGV%EC%95%84%EC%8B%9C%EC%95%84%EB%93%9C&lng=129.06199376&lat=35.1913709&zoom=15&type=0&c=15.00,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
					</div>
				   <div class="sect-theater-info">
					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
					<div class="info-contents">
					■ 주차정보<br>
					- 홈플러스 주차장을 함께 이용. 최대 2,200대 주차가능<br>
					- 무인정산시스템<br>
					- 퇴장로 셀프 정산기/티켓판매기/APP에서 당일 관람 후 티켓 인증 시 3시간 무료<br>
					(※2편 이상 관람 시에도 최대 3시간 무료)<br>
					- 홈플러스 건물 內 타매장 이용 후 주차 합산 가능<br>
					- 매점만 이용 시 주차등록 불가<br>
					- 추가요금은 카드결제만 가능(현금결제 불가, 초과요금 10분당 200원)<br>

					■ 홈플러스 휴점일 이용 고객님 출입구<br> 
					1. 도보/대중 교통 이용 시<br>
					   - 창신초등학교 맞은편 횡단보도쪽 홈플러스 정문 입구 이용<br>
					2. 자차 이용 시<br>
					   - 홈플러스 지하주차장 -1F(12) 기둥쪽 외부로 연결된 사잇길로 나와<br>
					     왼쪽 인도로 걸어서 홈플러스 정문 입구 이용<br><br><br>
			        </div>
			    </div>
			</div>
			`;
	    		  document.getElementById(sectionId).innerHTML = newContent;
	    	  } else if(selectedTheater == '화명') {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    		  
					<div class="col-detail"> 
				    <div class="sect-theater-info">
    					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
    					<div class="info-contents">
    					지하철<br><br>

    					2호선 | 화명역 1번출구(롯데마트에서 화명대교 방향으로 300m, 좌측에 위치)<br><br>

    					버스<br>
    					 - 경부선화명역 고용복지센터 정류장 하자: 300번<br>
    					 - 와석 정류장 하자: 15번, 59번, 111번, 121번, 126번<br>
						</div>
						<a class="round red" href="https://map.naver.com/p?title=CGV%ED%99%94%EB%AA%85&lng=129.0097622&lat=35.234777&zoom=15&type=0&c=15.00,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
					</div>
				   <div class="sect-theater-info">
					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
					<div class="info-contents">
					■ 주차 안내<br>
					1) '코아회센터 주차장'이용 시 3시간 무료(초과시 30분당 1천원)<br>
					  - 매점 內 셀프 주차 인증 PC에서 주차 할인 등록 필요<br>
					  - 도보 5분거리 부산북부고용센터 뒤쪽 건물 주차장 5층부터 주차 가능<br><br>

					 2) 건물 지하주차장 이용 시 1시간 1천원 부과<br>
					    (티켓 또는 주차영수증 도장 날인시)<br><br>
					 ※ 티켓 또는 주차영수증 미날인시 30분 1천원 부과<br><br><br>
					CGV화명 오시는 길<br><br>
					
					<img alt="" src="${pageContext.request.contextPath}/resources/img/화명지도.png"><br><br><br>
					
			        </div>
			    </div>
			</div>
			`;
	    		  document.getElementById(sectionId).innerHTML = newContent;
	    		  
	    	  } else if (selectedTheater == '하단아트몰링') {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    		  
					<div class="col-detail"> 
				    <div class="sect-theater-info">
    					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
    					<div class="info-contents">
    					지하철 1호선 하단역과 지하 1층 연결 (3번과 5번출구)<br>
    					시내버스: 55번, 58번, 58-2번, 68번, 168번, 520번 급행버스 2000번<br>
    					좌석버스: 58-1번, 58-1번(심야), 221번, 2000번(하단.연사)<br>
						</div>
						<a class="round red" href="https://map.naver.com/p?title=CGV%ED%95%98%EB%8B%A8%EC%95%84%ED%8A%B8%EB%AA%B0%EB%A7%81&lng=128.966328&lat=35.106605&zoom=15&type=0&c=15.00,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
					</div>
				   <div class="sect-theater-info">
					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
					<div class="info-contents">
					아트몰링 건물 내 지하주차장 이용<br>
					■ 주차장이용<br>
					: 지하 2F ~ 지하 6F 이용가능<br>
					★ 주차 할인안내<br>
					 - 무인정산기에서 셀프 정산 진행 (3시간 무료)<br>
					: 종이 티켓의 경우 티켓 아래쪽 바코드를 기계에 인식<br>
					: 모바일 티켓의 경우, 예매번호 15자리를 기계에 입력<br>
					: 셀프 정산은 영화 관람후 출차시 진행<br>
					: 건물 내 타 매장과 합산시 최대 6시간 무료<br>
					: 차량이 2대 이상일 경우에는 7F 매표소로 문의<br><br><br>
			        </div>
			    </div>
			</div>
			`;
	    		  document.getElementById(sectionId).innerHTML = newContent;
	    		  
	    	  } else if (selectedTheater == '센텀시티') {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    		  
					<div class="col-detail"> 
				    <div class="sect-theater-info">
    					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
    					<div class="info-contents">
    					지하철<br><br>

    					2호선 센텀시티역 12번 출구<br><br>

    					버스<br><br>

    					좌석버스 : 1001번, 1002번<br>
    					일반버스 : 36번, 115번, 63번, 50번, 5번, 5-1번, 155번, 141번, 181번, 39번, 141번(심야)<br>
    					마을버스 : 3-1번, 3-2번<br>
						</div>
						<a class="round red" href="https://map.naver.com/p?title=CGV%EC%84%BC%ED%85%80%EC%8B%9C%ED%8B%B0&lng=129.1298471&lat=35.1694941&zoom=15&type=0&c=15.00,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
					</div>
				   <div class="sect-theater-info">
					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
					<div class="info-contents">
					주차정보<br><br>


					1. 이용요금: CGV센텀시티에서 영화 관람 후, 당일 티켓으로 정산시 3시간 무료<br>
					2. 정산안내: 주차장 에스컬레이터, 엘리베이터 홀 무인 주차 정산기 이용하여 주차 정산<br>
					- 기본 30분 무료 주차 적용 / 사전 정산 시, 출차 유예시간 30분 무료 지급<br>
					- 신용카드, 삼성페이 결제 가능 / 현금, SSG 페이 결제 불가<br>
					- 주차통합콜센터: 051-745-1191~1192 <br>

					&nbsp;&nbsp;&nbsp;  CGV센텀시티로 오시는 길<br>
					
					<img alt="" src="${pageContext.request.contextPath}/resources/img/센텀시티지도.jpg"><br><br><br>
					
					
					
					&nbsp;&nbsp;&nbsp; 백화점 휴무시 CGV및 씨네드쉐프 이용 고객님 출입구<br>
					
					<img alt="" src="${pageContext.request.contextPath}/resources/img/센텀시티지도2.jpg"><br><br><br>
					
					
					
					&nbsp;&nbsp;&nbsp; 백화점 휴무시 CGV및 씨네드쉐프 이용차량 출입구<br>
					
					<img alt="" src="${pageContext.request.contextPath}/resources/img/센텀시티지도3.jpg"><br><br><br>
					
			        </div>
			    </div>
			</div>
			`;
	    		  document.getElementById(sectionId).innerHTML = newContent;
	    	  } else if(selectedTheater == '해운대') {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    		  
					<div class="col-detail"> 
				    <div class="sect-theater-info">
    					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
    					<div class="info-contents">
    					- 지하철 2호선 해운대역과 지하2층 연결 (5번과 7번출구)<br>
    					- 시내버스 : 31번, 38번, 39번, 63번, 100번, 100-1번, 115번, 141번, 141번(심야), 181번, 200번<br> 
    					- 급행버스 : 1001번, 1006번, 1011번<br>
						</div>
						<a class="round red" href="https://map.naver.com/p?title=CGV%ED%95%B4%EC%9A%B4%EB%8C%80&lng=129.1584931&lat=35.1629813&zoom=15&type=0&c=15.00,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
					</div>
				   <div class="sect-theater-info">
					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
					<div class="info-contents">
					- 영화관 지하 라뮤에뜨 상가 지하주차장 이용 (지하 2F ~ 지하 5F 이용가능)<br>
					- 2층 매표소 옆 셀프 주차 인증 코너에서 3시간 무료주차 등록 가능 (미인증으로발생한 주차비 환불 불가)<br>
					- 3시간 초과시, 지하 2,3층 주차장 무인정산기기 이용하여 정산<br>
					(30분까지 1,500원 이후 10분 당 500원 부과)<br>
					- 정산은 신용카드 결제만 가능<br><br><br>
					
			        </div>
			    </div>
			</div>
			`;
	    		  document.getElementById(sectionId).innerHTML = newContent;
	    		  
	    	  } else if (selectedTheater == '부산명지') {
	    		  var sectionId = "sec01";
	    		  var newContent = `
	    		  
					<div class="col-detail"> 
				    <div class="sect-theater-info">
    					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/교통안내.png"></span>&nbsp;교통안내</h4>
    					<div class="info-contents">
    						버스 CGV 정류장 : 강서구 21
						</div>
						<a class="round red" href="https://map.naver.com/p?title=CGV%EB%B6%80%EC%82%B0%EB%AA%85%EC%A7%80&lng=128.90345377222332&lat=35.09436632486654&zoom=15&type=0&c=15.00,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span id="find">실시간 빠른 길 찾기</span></a>
					</div>
				   <div class="sect-theater-info">
					<h4><span class="ico-bus"><img src="${pageContext.request.contextPath}/resources/img/주차안내.png"></span>주차안내</h4>
					<div class="info-contents">
					(1) 주차정보: 명지 플러스시네마 지하1층, 2층<br>
					(2) 이용안내: 영화관람시 3시간 무료<br><br><br>
			        </div>
			    </div>
			</div>
			`;
	    		  document.getElementById(sectionId).innerHTML = newContent;
	    	  }
	    	  
	    	  
	      },
	      error: function(xhr, status, error) {
	    	  alert("호출실패!");
	        // AJAX 호출이 실패했을 때 실행할 코드 작성
	        // 오류 처리를 위한 코드를 작성해주세요.
	      }
	    });
	  });
	});

</script>
</html>