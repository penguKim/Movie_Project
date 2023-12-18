<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/cs.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">
			
			<h1 id="h01">고객센터</h1>
			<hr>
			<div id="cs_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="cs_menubar.jsp"></jsp:include>
			</div>
			
			<section id="cs_main_div">	
				<div id="main_shortcuts"><%-- 바로가기 --%>
					<a href="csOneOnOneForm">
						<img src="${pageContext.request.contextPath}/resources/img/1to1.png" alt="1:1 이미지"> <br>
						1 : 1 문의 <br>
					</a>
					<a href="csLostForm">
						<img src="${pageContext.request.contextPath}/resources/img/lost.png" alt="분실물 이미지"> <br>
						분실물 문의 <br>
					</a>
					<a href="csFaq">
						<img src="${pageContext.request.contextPath}/resources/img/fqa.png" alt="FQA 이미지"> <br>
						자주 묻는 질문 <br>
					</a>
				</div>
				
				<hr>
				<section id="cs_best">
					<div id="main_faq"> <%-- 자주묻는질문 바로가기 --%>
						<h3>자주 묻는 질문 BEST5</h3>
						<a href="csFaq">더보기</a>
						<ol>
							<c:choose>
								<c:when test="${empty faqMainist}">
									자주묻는질문 없음
								</c:when>
								<c:otherwise>
									<c:forEach begin="0" end="4" var="faq" items="${faqMainist}">
										<li><a href="">${faq.cs_subject}</a></li> <%-- 자주묻는질문 상위 5개만 보여주기 --%>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</ol>
					</div>
					
					<div id="main_notice"> <%-- 공지사항 바로가기 --%>
						<h3>공지사항</h3>
						<a href="csNotice">더보기</a>
						<ol>
							<c:choose>
								<c:when test="${empty noticeMainList}">
									공지사항 없음
								</c:when>
								<c:otherwise>
									<c:forEach begin="0" end="4" var="notice" items="${noticeMainList}">
										<li><a href="">${notice.cs_subject}<a></li> <%-- 자주묻는질문 최신 5개만 보여주기 --%>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</ol>
					</div>
				</section>
			</section>	
		</section>
		
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>