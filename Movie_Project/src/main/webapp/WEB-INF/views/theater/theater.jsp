<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>극장정보</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/theater.css" rel="stylesheet" type="text/css">
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
				<img src="../img/CGV서면.png" alt="cgv" id="image">
			</div>
			<hr>
			<div class="menu" >
				<nav class="theater1">
					<input type="button" id="서면CGV" value="서면CGV점">
					<input type="button" id="삼정타워" value="삼정타워점">
					<input type="button" id="상상마당점" value="상상마당점">
					<input type="button" id="동래" value="동래점">
				</nav>
				<nav class="theater2">
					<input type="button" id="CGV대연" value="CGV대연">
					<input type="button" id="CGV아시아드" value="CGV아시아드">
					<input type="button" id="CGV센텀시티" value="CGV센텀시티">
					<input type="button" id="CGV울산동구" value="CGV울산동구">
				</nav>
				<nav class="theater3">
					<input type="button" id="CGV정관" value="CGV정관">
					<input type="button" id="CGV울산신천" value="CGV울산신천">
					<input type="button" id="CGV울산삼산" value="CGV울산삼산">
					<input type="button" id="CGV부산명지" value="CGV부산명지">
				</nav>
				<nav class="theater4">
					<input type="button" id="CGV화명" value="CGV화명">
					<input type="button" id="CGV해운대" value="CGV해운대">
					<input type="button" id="CGV대구" value="CGV대구">
					<input type="button" id="CGV대구수성" value="CGV대구수성">
				</nav>
				<nav class="theater5">
					<input type="button" id="CGV대구아카데미" value="CGV대구아카데미">
					<input type="button" id="CGV대구스타디움" value="CGV대구스타디움">
					<input type="button" id="CGV대구연경" value="CGV대구연경">
					<input type="button" id="CGV대구한일" value="CGV대구한일">
				</nav>
			</div>
				
			<div class="price_table">
				<table id="price_table">
					<tr>
						<th colspan="4" id="table_name">일반 2D</th>
					</tr>
					<tr>
						<th>요일</th>
						<th>시간대</th>
						<th>일반</th>
						<th>청소년</th>
					</tr>
					<tr>
						<td rowspan="4">월~목</td>
						<td>모닝(06:00~ )</td>
						<td>10,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>브런치(10:01~ )</td>
						<td>13,000</td>
						<td>10,000</td>
					</tr>
					<tr>
						<td>일반(13:01~ )</td>
						<td>14,000</td>
						<td>11,000</td>
					</tr>
					<tr>
						<td>심야(24:00~ )</td>
						<td>9,000</td>
						<td>9,000</td>
					</tr>
			
					<tr>
						<td rowspan="4">금~일<br>(공휴일)</td>
						<td>모닝(06:00~ )</td>
						<td>11,000</td>
						<td>8,000</td>
					</tr>
					<tr>
						<td>브런치(10:01~ )</td>
						<td>15,000</td>
						<td>12,000</td>
					</tr>
					<tr>
						<td>일반(13:01~ )</td>
						<td>15,000</td>
						<td>9,000</td>
					</tr>
					<tr>
						<td>심야(24:00~ )</td>
						<td>9,000</td>
						<td>9,000</td>
					</tr>
				</table>
			</div>
			<div class="theater_right">
				<table class="notice">
					<tr>
						<th>공지사항 <a href="https://www.daum.net" target = "_Blank">더보기</a></th>
					</tr>
					<tr>
						<td><a href="공지사항.jsp" onclick="window.open(this.href, '_blank', 'width=800, height=800,left=700,top=100' ); return false;">&#9917; [GS&POINT] 시스템 정기 정검 안내(3/9)</a></td>
					</tr>
					<tr>
						<td><a href="공지사항.jsp" onclick="window.open(this.href, '_blank', 'width=800, height=800,left=550,top=100' ); return false;">&#9917; 회원등급 조정 및 VIP쿠폰북 관련 안내</a></td>
					</tr>
					<tr>
						<td><a href="공지사항.jsp" onclick="window.open(this.href, '_blank', 'width=800, height=800,left=550,top=100' ); return false;">&#9917; 동백씨네마 시스템 점검 안내(2/21)</a></td>
					</tr>
					<tr>
						<td><a href="공지사항.jsp" onclick="window.open(this.href, '_blank', 'width=800, height=800,left=550,top=100' ); return false;">&#9917; [라이브뷰잉]아이유 콘서트 안내</a></td>
					</tr>
					<tr>
						<td><a href="공지사항.jsp" onclick="window.open(this.href, '_blank', 'width=800, height=800,left=550,top=100' ); return false;">&#9917; SKT 휴대폰본인확인 서비스 일시 중단 발생 안내(2/9)</a></td>
					</tr>
				</table>
				
					
				<div id="map" style="width:400px;height:300px;">
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9f6c3bc1e6871394d3b26ee55215784"></script>
					<script>
						var container = document.getElementById('map');
						var options = {
							center: new kakao.maps.LatLng(35.149236094733254, 129.0635624238869),
							level: 3
						};
						var map = new kakao.maps.Map(container, options);
					
						
						// 마커가 표시될 위치입니다 
						var markerPosition  = new kakao.maps.LatLng(35.149278694688036, 129.06357447166218); 
				
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});
				
						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);
					</script>
	
					<script>
					  // 이미지 지도로 변경 및 마커스 찍기
					  function changeImage() {
					    var image = document.getElementById("image");
					    image.src = "../img/동래.JPG";
					    var maps = document.getElementById("map");
						var container = document.getElementById('map');
						var options = {
							center: new kakao.maps.LatLng(35.221414075646194, 129.0855232950597),
							level: 2
						};
						var map = new kakao.maps.Map(container, options);
						// 마커가 표시될 위치 
						var markerPosition  = new kakao.maps.LatLng(35.221414075646194, 129.0855232950597); 
					
						// 마커를 생성
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});
						marker.setMap(map);
					  }
					  
					  
					  function changeImage2() {
					    var image = document.getElementById("image");
					    image.src = "../img/삼정타워점.JPG";
						var container = document.getElementById('map');
						var options = {
							center: new kakao.maps.LatLng(35.15301369233767, 129.05962274791744),
							level: 2
						};
						var map = new kakao.maps.Map(container, options);
					
						
						// 마커가 표시될 위치입니다 
						var markerPosition  = new kakao.maps.LatLng(35.15301369233767, 129.05962274791744); 
					
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});
					
						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);
					  }
					  
					  function changeImage3() {
					    var image = document.getElementById("image");
					    image.src = "../img/상상마당.JPG";
						var container = document.getElementById('map');
						var options = {
							center: new kakao.maps.LatLng(35.15423948976798, 129.05748931736966),
							level: 2
						};
						var map = new kakao.maps.Map(container, options);
					
						
						// 마커가 표시될 위치입니다 
						var markerPosition  = new kakao.maps.LatLng(35.15423948976798, 129.05748931736966); 
					
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});
					
						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);
					    
					  }
					  
					  function changeImage4() {
					    var image = document.getElementById("image");
					    image.src = "../img/CGV서면.png";
						var container = document.getElementById('map');
						var options = {
							center: new kakao.maps.LatLng(35.149236094733254, 129.0635624238869),
							level: 2
						};
						var map = new kakao.maps.Map(container, options);
					
						
						// 마커가 표시될 위치입니다 
						var markerPosition  = new kakao.maps.LatLng(35.149278694688036, 129.06357447166218); 
					
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});
					
						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);
					  }
					  // 클릭 이벤트에 함수 연결
					  function changeImage5() {
					    var image = document.getElementById("image");
					    image.src = "../img/대연점.png";
					    var maps = document.getElementById("map");
						var container = document.getElementById('map');
						var options = {
							center: new kakao.maps.LatLng(35.13736147621278, 129.09906942841351 ),
							level: 2
						};
						var map = new kakao.maps.Map(container, options);
						// 마커가 표시될 위치 
						var markerPosition  = new kakao.maps.LatLng(35.13736147621278, 129.09906942841351 ); 
					
						// 마커를 생성
						var marker = new kakao.maps.Marker({
						    position: markerPosition
						});
						marker.setMap(map);
					  }
				  
				  
						  function changeImage6() {
						    var image = document.getElementById("image");
						    image.src = "../img/아시아드점.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.19154582406568, 129.06328187601284 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.19154582406568, 129.06328187601284); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						  }
						  
						  function changeImage7() {
						    var image = document.getElementById("image");
						    image.src = "../img/센텀점.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.1691119842877, 129.13038331260668 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.1691119842877, 129.13038331260668 ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						    
						  }
						  
						  function changeImage8() {
						    var image = document.getElementById("image");
						    image.src = "../img/동구점.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.489848332547005, 129.43101483150292  ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.489848332547005, 129.43101483150292  ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						  }
						  // 클릭 이벤트에 함수 연결
						  function changeImage9() {
						    var image = document.getElementById("image");
						    image.src = "../img/정관점.png";
						    var maps = document.getElementById("map");
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.32141718176421, 129.17843458395896 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
							// 마커가 표시될 위치 
							var markerPosition  = new kakao.maps.LatLng(35.32141718176421, 129.17843458395896 ); 
						
							// 마커를 생성
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
							marker.setMap(map);
						  }
						  
						  
						  function changeImage10() {
						    var image = document.getElementById("image");
						    image.src = "../img/울산신천.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.63497085947518, 129.3557985601116 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.63497085947518, 129.3557985601116 ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						  }
						  
						  function changeImage11() {
						    var image = document.getElementById("image");
						    image.src = "../img/울산삼산.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.54124734903711, 129.33896396513606 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.54124734903711, 129.33896396513606 ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						    
						  }
						  
						  function changeImage12() {
						    var image = document.getElementById("image");
						    image.src = "../img/명지점.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.09440141296223, 128.90351489468253 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.09440141296223, 128.90351489468253 ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						  }
						  // 클릭 이벤트에 함수 연결
						  function changeImage13() {
						    var image = document.getElementById("image");
						    image.src = "../img/화명점.png";
						    var maps = document.getElementById("map");
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.23471793459627, 129.00987511366884 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
							// 마커가 표시될 위치 
							var markerPosition  = new kakao.maps.LatLng(35.23471793459627, 129.00987511366884 ); 
						
							// 마커를 생성
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
							marker.setMap(map);
						  }
						  
						  
						  function changeImage14() {
						    var image = document.getElementById("image");
						    image.src = "../img/해운대점.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.1628435626128, 129.1584244156929 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.1628435626128, 129.1584244156929 ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						  }
						  
						  function changeImage15() {
						    var image = document.getElementById("image");
						    image.src = "../img/CGV대구.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.8699247159092, 128.59426921010606 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.8699247159092, 128.59426921010606 ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						    
						  }
						  
						  function changeImage16() {
						    var image = document.getElementById("image");
						    image.src = "../img/대구수성.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.831384441489035, 128.6868725440225 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.831384441489035, 128.6868725440225 ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						  }
						  // 클릭 이벤트에 함수 연결
						  function changeImage17() {
						    var image = document.getElementById("image");
						    image.src = "../img/대구아카데미.png";
						    var maps = document.getElementById("map");
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.86992486283135, 128.5942581416202 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
							// 마커가 표시될 위치 
							var markerPosition  = new kakao.maps.LatLng(35.86992486283135, 128.5942581416202 ); 
						
							// 마커를 생성
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
							marker.setMap(map);
						  }
						  
						  
						  function changeImage18() {
						    var image = document.getElementById("image");
						    image.src = "../img/대구스타디움.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.83141651543073, 128.6868344923691 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.83141651543073, 128.6868344923691 ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						  }
						  
						  function changeImage19() {
						    var image = document.getElementById("image");
						    image.src = "../img/대구연경.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.94146987572242, 128.62289343513828),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.94146987572242, 128.62289343513828); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						    
						  }
						  
						  function changeImage20() {
						    var image = document.getElementById("image");
						    image.src = "../img/대구한일.png";
							var container = document.getElementById('map');
							var options = {
								center: new kakao.maps.LatLng(35.87062755958917, 128.59529080175332 ),
								level: 2
							};
							var map = new kakao.maps.Map(container, options);
						
							
							// 마커가 표시될 위치입니다 
							var markerPosition  = new kakao.maps.LatLng(35.87062755958917, 128.59529080175332 ); 
						
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
							    position: markerPosition
							});
						
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						  }
						  // 클릭 이벤트에 함수 연결
						  
						
						  var container = document.getElementById("동래");
						  container.onclick = changeImage;
						  var container = document.getElementById("삼정타워");
						  container.onclick = changeImage2;
						  var container = document.getElementById("상상마당점");
						  container.onclick = changeImage3;
						  var container = document.getElementById("서면CGV");
						  container.onclick = changeImage4;
						  var container = document.getElementById("CGV대연");
						  container.onclick = changeImage5;
						  var container = document.getElementById("CGV아시아드");
						  container.onclick = changeImage6;
						  var container = document.getElementById("CGV센텀시티");
						  container.onclick = changeImage7;
						  var container = document.getElementById("CGV울산동구");
						  container.onclick = changeImage8;
						  var container = document.getElementById("CGV정관");
						  container.onclick = changeImage9;
						  var container = document.getElementById("CGV울산신천");
						  container.onclick = changeImage10;
						  var container = document.getElementById("CGV울산삼산");
						  container.onclick = changeImage11;
						  var container = document.getElementById("CGV부산명지");
						  container.onclick = changeImage12;
						  var container = document.getElementById("CGV화명");
						  container.onclick = changeImage13;
						  var container = document.getElementById("CGV해운대");
						  container.onclick = changeImage14;
						  var container = document.getElementById("CGV대구");
						  container.onclick = changeImage15;
						  var container = document.getElementById("CGV대구수성");
						  container.onclick = changeImage16;
						  var container = document.getElementById("CGV대구아카데미");
						  container.onclick = changeImage17;
						  var container = document.getElementById("CGV대구스타디움");
						  container.onclick = changeImage18;
						  var container = document.getElementById("CGV대구연경");
						  container.onclick = changeImage19;
						  var container = document.getElementById("CGV대구한일");
						  container.onclick = changeImage20;
					 </script>
				</div>
			</div>
		</div>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>