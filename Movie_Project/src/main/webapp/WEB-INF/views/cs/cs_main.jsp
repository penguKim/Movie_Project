<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/cs.css" rel="stylesheet" type="text/css">
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
			
			<form action="" method="" name="">
				<section id="search">
					<b>빠른 검색</b>
					<input type="search" placeholder="검색어를 입력해주세요"> <%-- 검색어 입력창 --%>
					<a href="cs_FAQ.jsp"><input type="button" value="검색"></a>
				</section>
				
				<section id="main_shortcuts"><%-- 바로가기 --%>
					<a href="cs_lost.jsp">
						<img src="../img/lost.png" alt="분실물 이미지"> <br>
						분실물 문의 <br>
					</a>
					<a href="cs_OneToOne.jsp">
						<img src="../img/1to1.png" alt="1:1 이미지"> <br>
						1 : 1 문의 <br>
					</a>
					<a href="cs_FAQ.jsp">
						<img src="../img/fqa.png" alt="FQA 이미지"> <br>
						자주 묻는 질문 <br>
					</a>
				</section>
				
				<hr>
			
				<section id="main_faq"> <%-- 자주묻는질문 바로가기 --%>
					<h3>자주 묻는 질문 BEST5</h3>
					<a href="cs_FAQ.jsp"">더보기</a>
					<ol>
						<li><a href="">내용</a></li> <%-- 자주묻는질문 상위 5개만 보여주기 --%>
						<li><a href="">내용</a></li>
						<li><a href="">내용</a></li>
						<li><a href="">내용</a></li>
						<li><a href="">내용</a></li>
					</ol>
				</section>
				
				<section id="main_notice"> <%-- 공지사항 바로가기 --%>
					<h3>공지사항</h3>
					<a href="cs_notice.jsp">더보기</a>
					<ol>
						<li><a href="">내용</a></li> <%-- 자주묻는질문 최신 5개만 보여주기 --%>
						<li><a href="">내용</a></li>
						<li><a href="">내용</a></li>
						<li><a href="">내용</a></li>
						<li><a href="">내용</a></li>
					</ol>
				</section>
			</form>
		</section>
		
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>