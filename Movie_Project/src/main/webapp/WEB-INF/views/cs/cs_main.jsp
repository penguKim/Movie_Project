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
					<b>고객센터 바로가기</b><br>
					<a href="csOneOnOneForm">
						<img src="${pageContext.request.contextPath}/resources/img/1to1.png" alt="1:1 이미지">
						<span>1 : 1 문의</span>
					</a>
					<a href="csLostForm">
						<img src="${pageContext.request.contextPath}/resources/img/lost.png" alt="분실물 이미지">
						<span>분실물 문의</span>
					</a>
					<a href="csFaq">
						<img src="${pageContext.request.contextPath}/resources/img/fqa.png" alt="FQA 이미지">
						<span>자주 묻는 질문</span>
					</a>
				</div>
				<hr>
				<div id="main_shortcuts"><%-- 바로가기 --%>
					<b>자주 찾는 서비스</b><br>
					<a href="memberLogin">
						<img src="${pageContext.request.contextPath}/resources/img/id-card.png" alt="1:1 이미지">
						<span>아이디/<br>비밀번호<br>찾기</span>
					</a>
					<a href="Mypage_Reserv_boardList">
						<img src="${pageContext.request.contextPath}/resources/img/ticket.png" alt="분실물 이미지">
						<span>예매/취소<br>내역 확인</span>
					</a>
					<a href="Mypage_OneOnOneList">
						<img src="${pageContext.request.contextPath}/resources/img/list.png" alt="FQA 이미지">
						<span>나의 문의<br>내역 확인</span>
					</a>
				</div>
				
				<hr>
				<section id="cs_best">
					<div id="main_faq"> <%-- 자주묻는질문 바로가기 --%>
						<h2>자주 묻는 질문 BEST5</h2>
						<a href="csFaq">더보기</a>
						<ol>
							<c:choose>
								<c:when test="${empty faqMainList}">
									자주묻는질문 없음
								</c:when>
								<c:otherwise>
									<c:forEach begin="0" end="4" var="faq" items="${faqMainList}">
										<li><a href="csFaq">${faq.cs_subject}</a></li> <%-- 자주묻는질문 상위 5개만 보여주기 --%>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</ol>
					</div>
					
					<div id="main_notice"> <%-- 공지사항 바로가기 --%>
						<h2>공지사항</h2>
						<a href="csNotice">더보기</a>
						<ol>
							<c:choose>
								<c:when test="${empty noticeMainList}">
									공지사항 없음
								</c:when>
								<c:otherwise>
									<c:forEach begin="0" end="4" var="notice" items="${noticeMainList}">
										<li><a href="csNoticeDetail?cs_type=${notice.cs_type}&cs_type_list_num=${notice.cs_type_list_num}&pageNum=1">${notice.cs_subject}<a></li> <%-- 자주묻는질문 최신 5개만 보여주기 --%>
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