<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시사회이벤트</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/css/event.css" rel="stylesheet">
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>

		<section id="content">
			<h1 id="h01">시사회이벤트</h1>
			<hr>
			<nav class="event-menu">
				<ul>
			        <li><a href="event_movie.jsp"><input type="button" value="영화"></a></li>
			        <li><a href="event_theater.jsp"><input type="button" value="극장"></a></li>
			        <li><a href="event_partnership.jsp"><input type="button" value="제휴"></a></li>
			        <li class="active"><a href="event_preview.jsp"><input type="button" value="시사회"></a></li>
				</ul>
			</nav>
		    <section class="event-section">
		         <div class="container">
			        <h1>진행 중인 이벤트</h1>
			        <div class="event-grid">
			        <c:forEach begin="1" end="8">
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
			            <!-- 이벤트 항목을 추가로 작성 -->
			        </div>
			    </div>
		     
		    </section>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>