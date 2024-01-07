<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>극장정보</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/theater.css" rel="stylesheet" type="text/css">
<head>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
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
					<input type="button" class="${theaterName.theater_name}" id="${theaterName.theater_name}" value="${theaterName.theater_name}">
				</c:forEach>
				</nav>
			</div>
			<hr>
			<div id="theater_event">
				<a href="http://localhost:8080/c5d2308t1/detail?movie_id=20203702">
				<img src="${pageContext.request.contextPath}/resources/img/이벤트.jpg" alt="cgv" id="image">
				</a>
			</div>
			
			<ul class="tab-menu" id="menu">
		        <li><a href="theater" >관람료안내</a></li>
		        <li class="on"><a href="movie_select?theater_name=${theaterName.theater_name}" title="현재 선택됨">예매하기</a></li>
		        <li><a href="#sec01">위치/주차안내</a></li>
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
							<a class="round red" href="https://map.naver.com/p/search/%EC%84%9C%EB%A9%B4cgv?c=16.39,0,0,0,dh" id="btn_roadmap" target="_blank" title="새창 열림"><span>실시간 빠른 길 찾기</span></a>
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
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9f6c3bc1e6871394d3b26ee55215784"></script>
				<script>
				var selectedId;
//					이미지 지도로 변경 및 마커스 찍기
			 function changeImage(imageSrc, lat, lng) {
			  var image = document.getElementById("image");
			  image.src = imageSrc;
			  
			  var container = document.getElementById('map');
			  var options = {
			    center: new kakao.maps.LatLng(lat, lng),
			    level: 2
			  };
			  var map = new kakao.maps.Map(container, options);
			  
			  var markerPosition = new kakao.maps.LatLng(lat, lng);
			  var marker = new kakao.maps.Marker({
			    position: markerPosition
			  });
			  marker.setMap(map);
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
				    imageSrc: "${pageContext.request.contextPath}/resources/img/동구점.png",
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
			 
			 locations.forEach(function(location) {
				  var container = document.getElementById(location.id);
				  if (container) { 
				    container.onclick = function() {
				      changeImage(location.imageSrc, location.lat, location.lng);
				      selectedId = location.id; // 클릭한 위치의 ID를 변수에 저장합니다.
				      console.log("Selected ID: " + selectedId); // 선택된 ID를 콘솔에 출력합니다.
				    };
				  }
				});
			    
			    var buttons = document.querySelectorAll('input[type="button"]');
			    buttons.forEach(function(button) {
			      button.addEventListener('click', function(event) {
			        // 선택된 버튼의 아이디 값을 가져와서 변수에 저장
			        selectedId = event.target.id;
			        console.log("Selected ID: " + selectedId); // 선택된 아이디 값을 콘솔에 출력
			      });
			    });

				document.querySelector('.on a').addEventListener('click', function(event) {
					  event.preventDefault();
					  var url = event.target.href;
					  if (selectedId) {
					    url += selectedId;
					    console.log("Redirecting to: " + url); // 이동할 URL을 콘솔에 출력합니다.
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
</html>