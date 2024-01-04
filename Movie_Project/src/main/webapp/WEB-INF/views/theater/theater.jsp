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
<!-- <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script> -->
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
		        <li class="on"><a href="movie_select" title="현재 선택됨">예매하기</a></li>
		        <li class="last" onclick=""><a href="theater_parking">위치/주차안내</a></li>
		    </ul>
		    
		<section id="sec07">
	    <div class="sub_content">
			<div id="theater_top">
				<div id="theater_price">
					<h3>[ 가격 안내 ]</h3>
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
				
				<div id="theater_map">
					<h3>[ 오시는 길 ]</h3>
						<div id="map">
							<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7f2cbaab42a6ec66232f961c71c7350f"></script>
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
									image.src = "${pageContext.request.contextPath}/resources/img/동래.JPG";
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
									image.src = "${pageContext.request.contextPath}/resources/img/삼정타워점.JPG";
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
									image.src = "${pageContext.request.contextPath}/resources/img/상상마당.JPG";
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
									image.src = "${pageContext.request.contextPath}/resources/img/CGV서면.png";
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
								function changeImage6() {
								    var image = document.getElementById("image");
								    image.src = "${pageContext.request.contextPath}/resources/img/아시아드점.png";
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
								    image.src = "${pageContext.request.contextPath}/resources/img/센텀점.png";
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
								    image.src = "${pageContext.request.contextPath}/resources/img/동구점.png";
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
								  
								function changeImage12() {
								    var image = document.getElementById("image");
								    image.src = "${pageContext.request.contextPath}/resources/img/명지점.png";
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
								    image.src = "${pageContext.request.contextPath}/resources/img/화명점.png";
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
								    image.src = "${pageContext.request.contextPath}/resources/img/해운대점.png";
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
						  
						
								var container = document.getElementById("동래");
								container.onclick = changeImage;
								var container = document.getElementById("삼정타워");
								container.onclick = changeImage2;
								var container = document.getElementById("상상마당점");
								container.onclick = changeImage3;
								var container = document.getElementById("서면CGV");
								container.onclick = changeImage4;
								var container = document.getElementById("CGV아시아드");
								container.onclick = changeImage6;
								var container = document.getElementById("CGV센텀시티");
								container.onclick = changeImage7;
								var container = document.getElementById("CGV울산동구");
								container.onclick = changeImage8;
								var container = document.getElementById("CGV부산명지");
								container.onclick = changeImage12;
								var container = document.getElementById("CGV화명");
								container.onclick = changeImage13;
								var container = document.getElementById("CGV해운대");
								container.onclick = changeImage14;
							</script>
						</div>
					</div>
				</div>
				<div id="theater_notice">
					<h3>[ 공지사항 ]</h3>
					<table id="cs_table">
						<thead>
							<tr>
								<th>지점</th>
								<th>제목</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty noticeList}">
									공지사항 없음
								</c:when>
								<c:otherwise>
									<%-- 공지사항 리스트 List<CsVO> 객체(noticeList) 활용하여 목록 출력 --%>
									<c:forEach var="notice" items="${noticeList}">
										<tr>
										<c:choose>
											<c:when test="${notice.theater_id == null}">
												<td>전체</td>
											</c:when>
											<c:otherwise>
											<td>${notice.theater_name}</td>
											</c:otherwise>
										</c:choose>
											<%-- 제목 클릭 시 해당 게시물로 이동 --%>
											<td id="td_left"><a href="csNoticeDetail?cs_type=${notice.cs_type}&cs_type_list_num=${notice.cs_type_list_num}&pageNum=${pageNum}" id="notice_tit">${notice.cs_subject}</a></td>
											<td>
												<fmt:parseDate value='${notice.cs_date}' pattern="yyyy-MM-dd" var='cs_date'/>
												<fmt:formatDate value="${cs_date}" pattern="yyyy-MM-dd"/>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				</div>
			</section>
		</div>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>