<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>극장정보</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/theater.css" rel="stylesheet" type="text/css">
<head>
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
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
					<input type="button" id="삼정타워" value="서면삼정타워">
					<input type="button" id="서면CGV" value="서면">
					<input type="button" id="상상마당점" value="서면상상마당">
					<input type="button" id="CGV아시아드" value="아시아드">
					<input type="button" id="CGV화명" value="화명"><br>
					<input type="button" id="CGV울산동구" value="하단아트몰링">
					<input type="button" id="CGV센텀시티" value="센텀시티">
					<input type="button" id="CGV해운대" value="해운대">
					<input type="button" id="동래" value="동래">
					<input type="button" id="CGV부산명지" value="부산명지"><br>
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
		        <li class="on"><a href="movie_select" title="현재 선택됨">예매하기</a></li>
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
				  function changeImage() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/삼정타워점.JPG";
				  }
				  function changeImage2() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/CGV서면.png";
				  }					
				  function changeImage3() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/상상마당.JPG";
				  }
				  function changeImage4() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/아시아드점.png";
				  }
				  function changeImage5() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/화명점.png";
				  }
				  function changeImage6() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/동구점.png";
				  }
				  function changeImage7() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/센텀점.png";
				  }
				  function changeImage8() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/해운대점.png";
				  }
				  // 클릭 이벤트에 함수 연결
				  function changeImage9() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/동래.JPG";
				  }
				  function changeImage10() {
				    var image = document.getElementById("image");
				    image.src = "${pageContext.request.contextPath}/resources/img/명지점.png";
				  }

					var container = document.getElementById("삼정타워");
					container.onclick = changeImage;
					var container = document.getElementById("서면CGV");
					container.onclick = changeImage2;
					var container = document.getElementById("상상마당점");
					container.onclick = changeImage3;
					var container = document.getElementById("CGV아시아드");
					container.onclick = changeImage4;
					var container = document.getElementById("CGV화명");
					container.onclick = changeImage5;
					var container = document.getElementById("CGV울산동구");
					container.onclick = changeImage6;
					var container = document.getElementById("CGV센텀시티");
					container.onclick = changeImage7;
					var container = document.getElementById("CGV해운대");
					container.onclick = changeImage8;
					var container = document.getElementById("동래");
					container.onclick = changeImage9;
					var container = document.getElementById("CGV부산명지");
					container.onclick = changeImage10;
			 </script>
			</div>
		</div>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>