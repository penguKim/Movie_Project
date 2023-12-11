<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문</title>
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
			<h1 id="h01">자주 묻는 질문</h1>
			<hr>
			<div id="cs_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="cs_menubar.jsp"></jsp:include>
			</div>
			
			<div id="fqa_main">
			
				<form action="" method="" name="" >
					<section id="search">
						<b>빠른 검색</b>
						<input type="search" placeholder="검색어를 입력해주세요"> <%-- 검색어 입력창 --%>
						<a href="cs_FAQ.jsp"><input type="button" value="검색"></a>
					</section>
				</form>
			
				<nav id="fqa_button">
					<ul>
						<li><a href="#div01"><input type="button" value="전체"></a></li> <%-- 전체 질문 보기 --%>
						<li><a href="#div02"><input type="button" value="예매"></a></li> <%-- 예매 관련 질문 모아보기 --%>
						<li><a href="#div03"><input type="button" value="관람권"></a></li> <%-- 관람권 관련 질문 모아보기 --%>
						<li><a href="#div03"><input type="button" value="할인혜택"></a></li> <%-- 할인 관련 질문 모아보기 --%>
						<li><a href="#div03"><input type="button" value="영화관이용"></a></li> <%-- 영화관 관련 질문 모아보기 --%>
					</ul>
				</nav>
				
				<%-- FQA 질문 리스트 --%>
				<div id="fqa_list">
					<button class="accordion"><div id="topic">[예매]</div><div id="subject">홈페이지 및 모바일에서 예매 취소는 어떻게 하나요?</div></button>
					<div class="panel">
						<p id="writing">■ 홈페이지
							  [로그인] → [마이] → [예매내역] → [해당 영화 클릭] → [결제취소]
							
							■ 모바일 앱
							  [로그인] → [바로티켓] → 예매 번호 하단 [예매취소] 클릭
							  [로그인] → [마이] → [결제내역] → 해당 영화 클릭 → [결제취소]
						</p>
					</div>
					<button class="accordion"><div id="topic">[영화관이용]</div><div id="subject">홈페이지 및 모바일에서 예매 취소는 어떻게 하나요?</div></button>
					<div class="panel">
						<p id="writing">■ 홈페이지
							  [로그인] → [마이] → [예매내역] → [해당 영화 클릭] → [결제취소]
							
							■ 모바일 앱
							  [로그인] → [바로티켓] → 예매 번호 하단 [예매취소] 클릭
							  [로그인] → [마이] → [결제내역] → 해당 영화 클릭 → [결제취소]
						</p>
					</div>
					<button class="accordion"><div id="topic">[할인혜택]</div><div id="subject">홈페이지 및 모바일에서 예매 취소는 어떻게 하나요?</div></button>
					<div class="panel">
						<p id="writing">■ 홈페이지
							  [로그인] → [마이] → [예매내역] → [해당 영화 클릭] → [결제취소]
							
							■ 모바일 앱
							  [로그인] → [바로티켓] → 예매 번호 하단 [예매취소] 클릭
							  [로그인] → [마이] → [결제내역] → 해당 영화 클릭 → [결제취소]
						</p>
					</div>
				</div>
				

				<script>
					var acc = document.getElementsByClassName("accordion");
					var i;
					
					for (i = 0; i < acc.length; i++) {
					  acc[i].addEventListener("click", function() {
					    this.classList.toggle("active");
					    var panel = this.nextElementSibling;
					    if (panel.style.display == "block") {
					      panel.style.display = "none";
					    } else {
					      panel.style.display = "block";
					    }
					  });
					}
				</script>
				

				<div class="pagination">
					<a href="#">&laquo;</a>
					<a href="#">1</a>
					<a class="active" href="#">2</a>
					<a href="#">3</a>
					<a href="#">4</a>
					<a href="#">5</a>
					<a href="#">&raquo;</a>
				</div>
			</div>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>	
</body>
</html>