<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화관</title>
<%-- MS commit test --%>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="resources/css/default.css" rel="stylesheet" type="text/css">
<link href="resources/css/main.css" rel="stylesheet" type="text/css">
<link href="resources/css/autoSlide.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery-3.7.1.js"></script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="inc/top.jsp"></jsp:include>
		</header>
	
		<jsp:include page="inc/menu_nav.jsp"></jsp:include>
		
		<%-- 오토슬라이드 인클루드 --%>
		<jsp:include page="inc/autoSlide.jsp"></jsp:include>
		
			
		<div id="main_page">
			<div id="Sort">
				<ul>
					<li><a href=""><input type="button" value="무비차트"></a></li>
					<li><a href=""><input type="button" value="상영예정작"></a></li>
					<li><a href=""><input type="button" value="관람객순"></a></li>
				</ul>
			</div>
			
			<div id="boxoffice">
				<div>
					<a href=""><img src="img/비투비게임.jpeg"></a><br>
					<input type="button" value="👍 좋아요">
				</div>
				<div>
					<a href=""><img src="img/비투비게임.jpeg"></a><br>
					<input type="button" value="👍 좋아요">
				</div>
				<div>
					<a href=""><img src="img/싱글 인 서울.jpeg"></a><br>
					<input type="button" value="👍 좋아요">
				</div>
				<div>
					<a href=""><img src="img/프레디의 피자가게.jpeg"></a><br>
					<input type="button" value="👍 좋아요">
				</div>
				<div>
					<a href=""><img src="img/비투비게임.jpeg"></a><br>
					<input type="button" value="👍 좋아요">
				</div>
			</div>
		
			<div id="main_store">
				<hr>
				<h2>스토어 베스트 상품</h2>
				<img alt="" src="img/짜파게티팝콘패키지.jpg" width="250" height="200">
				<img alt="" src="img/팝콘패키지.jpg" width="250" height="200">
				<img alt="" src="img/맥주패키지.jpg" width="250" height="200">
			</div>
			
			
			 <div class="container">
				 <hr>
		        <h2>진행 중인 이벤트</h2>
		        <div class="event-grid">
		        <c:forEach begin="1" end="4">
		            <div class="event">
		            	<a href="event_detail.jsp" class="event_link">
			            	<div class="event-image">
				                <img src="https://img.megabox.co.kr/SharedImg/event/2023/11/21/GuvlkLZPAUjb8uk2ikaFSmI6C4E6GRtg.jpg" alt="이벤트 썸네일">
				            </div>
				            <div>
				                <p class="event-title">이벤트 제목</p>
				                <p class="event-date">2023. 11. 1 ~ 2023. 11. 30</p>
				            </div>    
		                </a>
		            </div>
	            </c:forEach>
		            <%-- 이벤트 항목을 추가로 작성 --%>
		        </div>
	     	</div>
		</div>
	
		<footer>
			<jsp:include page="inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>