<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/cs.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	<%-- 무한스크롤 시작 --%>
	let pageNum = "1";
	let maxPage = "";
	
	$(function() {
		<%-- 페이지 로딩 시 게시물 목록 조회를 수행하는 load_list() 함수 호출 --%>
		load_list();
		
		$(window).scroll(function() {
			let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
			let windowHeight = $(window).height(); // 브라우저 창 높이
			let documentHeight = $(document).height(); // 문서 높이
// 			console.log("scrollTop : " + scrollTop + ", windowHeight : " + windowHeight + ", documentHeight : "+ documentHeight);
			
			if(scrollTop + windowHeight + 10 >= documentHeight) {
				pageNum++; // 페이지번호 1 층가
				
				// 페이지 번호를 계속 불러오는 현상 막기
				if(maxPage != "" && pageNum <= maxPage) {
					load_list();
				}
			}
			
		});
		
	});

	<%-- 게시물 목록을 조회하는 함수 --%>
	function load_list() {
		let urlParams = new URL(location.href).searchParams;
		let buttonName = urlParams.get('buttonName');
		let searchValue = $("#searchValue").val();
		// 게시물 조회를 요청하는 ajax
		$.ajax({
			type: "GET",
			url: "CsListJson",
			data: { 
				"searchValue": searchValue,
				"pageNum" : pageNum,
				"buttonName" : buttonName
			},
			dataType: "json",
			success: function(data) {
// 				console.log(data.faqList);

				$("#faq_button input").removeClass("btn-active").addClass("btn-inactive");
				$(".faqButton[name='" + buttonName +"']").removeClass("btn-inactive").addClass("btn-active");

				for(let faq of data.faqList) {
					let result = 
						'<div class="faq_list">'
						+	'<button class="accordion">'
						+		'<div id="topic">[' + faq.cs_type_detail + ']</div><div id="subject">' + faq.cs_subject + '</div>'
						+		'<input type="hidden" name="cs_type_list_num" value="' + faq.cs_type_list_num + '">'
						+	'</button>'
						+	'<div class="panel">'
						+		'<pre id="faq_content">' + faq.cs_content + '</pre>'
						+	'</div>'
						+'</div>'
					
					
					$("#faq_list").append(result);
						
					// 끝페이지 번호(maxPage) 값을 변수에 저장
					maxPage = data.maxPage;
	
				}
				
				<%-- 자주묻는질문을 클릭했을 때 펼쳐지면서 내용 보여주는 효과를 넣어줌 --%>
				var acc = document.getElementsByClassName("accordion");
				var i;
				
				for(i = 0; i < acc.length; i++) {
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
				
				// 고객센터 메인 페이지에서 선택한 자주묻는질문 바로 보기
				$(function() {
					// 파라미터로 cs_type_list_num 값 가져오기
					let urlParams = new URL(location.href).searchParams;
					let targetValue = urlParams.get('cs_type_list_num');
					// 해당 값을 가진 버튼을 찾아 클릭
					$('.accordion').each(function() {
						let hiddenInput = $(this).find('input[name="cs_type_list_num"]');
						if (hiddenInput.length > 0) {
							let buttonValue = hiddenInput.val();
						
							if (buttonValue === targetValue) {
								$(this).click(); // 버튼을 클릭
								return false; // 반복문 종료
							}
						}
					});
				});
			},
			error: function(request,status,error) {
		      // 요청이 실패한 경우 처리할 로직
		      console.log("AJAX 요청 실패:", error); // 예시: 에러 메시지 출력
			}
		});
		
		

		
	}

	$(function() {
		<%-- faq 세부항목별 보기 버튼을 눌렀을 때 세부항목별로 모아서 보여주는 기능  --%>
		$("#faq_button input").click(function() {
			
			<%-- 선택한 버튼의 이름값 가져와서 변수에 저장 --%>
			let buttonName = $(this).attr("name");
			
			// 파라미터를 가지고 csFaq 다시 요청
			location.href="csFaq?buttonName="+buttonName;

		});
		
		<%-- 검색어 입력창에서 엔터 키 이벤트 처리 --%>
		$("#searchValue").keydown(function(event) {
			if (event.keyCode === 13) { // 엔터 키 코드
				event.preventDefault(); // 기본 동작(페이지 새로고침) 방지
		
				// 검색 버튼 클릭 이벤트 실행
				$("#faqSearch").click();
			}
		});
		
	});
		
</script>
</head>
<body>
	<div id="wrapper">
		<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1로 설정) --%>
		<c:set var="pageNum" value="1"/>
		<c:if test="${not empty param.pageNum}">
			<c:set var="pageNum" value="${param.pageNum}"/>
		</c:if>
		
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
			
			<div id="faq_main">
			
				<form id="search">
					<b>빠른 검색</b>
					<input type="search" placeholder="유형, 제목으로 검색하기" id="searchValue" name="searchValue" value="${param.searchValue}"> <%-- 검색어 입력창 --%>
					<input type="submit" value="검색" id="faqSearch">
				</form>
			
				<nav id="faq_button">
					<ul>
						<li><input type="button" value="전체" class="faqButton btn-active" name=""></li> <%-- 전체 질문 보기 --%>
						<li><input type="button" value="예매" class="faqButton btn-inactive" name="예매"></li> <%-- 예매 관련 질문 모아보기 --%>
						<li><input type="button" value="스토어" class="faqButton btn-inactive" name="스토어"></li> <%-- 스토어 관련 질문 모아보기 --%>
						<li><input type="button" value="홈페이지" class="faqButton btn-inactive" name="홈페이지"></li> <%-- 홈페이지 관련 질문 모아보기 --%>
						<li><input type="button" value="영화관이용" class="faqButton btn-inactive" name="영화관이용"></li> <%-- 영화관 관련 질문 모아보기 --%>
					</ul>
				</nav>
				
				<div id="faq_list">
					<%-- faq 목록이 출력되는 영역 --%>
				</div>
			</div>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>	
</body>
</html>