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
	$(function() {
		<%-- faq 세부항목별 보기 버튼을 눌렀을 때 세부항목별로 모아서 보여주는 기능 --%> 
		$("#faq_button input").click(function() {
			<%-- 선택한 버튼의 이름값 가져와서 변수에 저장 --%>
			let buttonName = $(this).attr("name");
			console.log(buttonName);

			$.ajax({
				url: "faqDetail",
				data: { buttonName: buttonName },
				success: function(data) {
					$("#faq_button input").removeClass("btn-active").addClass("btn-inactive");
					$(".faqButton[name='" + buttonName +"']").removeClass("btn-inactive").addClass("btn-active");
					
					<%-- 세부항목을 눌렀을 때 --%>
					$("#faq_list").empty();
					
					for(let faq of data) {
						$("#faq_list").append (
							"<button class='accordion'><div id='topic'>[ " + faq.cs_type_detail + " ]</div><div id='subject'>" + faq.cs_subject + "</div></button>"
							+ "<div class='panel'>"
							+	"<p id='writing'>"
							+ 		faq.cs_content
							+	"</p>"
							+"</div>"
						);
					}		
							
					<%-- ajax에 아코디언 효과가 적용되지 않아 아래에 다시 적음 --%>
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
					
					
				},
				error: function(xhr, status, error) {
			      // 요청이 실패한 경우 처리할 로직
			      console.log("AJAX 요청 실패:", error); // 예시: 에러 메시지 출력
				}
			});
		});
		
		
		<%-- 검색을 클릭했을 때 제목이나 내용에서 해당 글자를 포함하는 내용을 보여주기 --%> 
		$("#faqSearch").click(function() {
			<%-- 검색창의 데이터 가져와서 변수에 저장 --%>
			let searchValue = $("#searchValue").val();
			
			$.ajax({
				url: "faqSearch",
				data: { searchValue: searchValue },
				success: function(data) {

					$("#faq_list").empty();
					
					if(data != "") {
						for(let faq of data) {
							$("#faq_list").append(
								"<button class='accordion'><div id='topic'>[ " + faq.cs_type_detail + " ]</div><div id='subject'>" + faq.cs_subject + "</div></button>"
								+ "<div class='panel'>"
								+	"<p id='writing'>"
								+ 		faq.cs_content
								+	"</p>"
								+"</div>"
							);
						}
						
					} else {
						$("#faq_list").append("<br><p style='text-align: center;'>검색 결과가 없습니다<p>");
					}
				
					
					<%-- ajax에 아코디언 효과가 적용되지 않아 아래에 다시 적음 --%>
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
					
					
				},
				error: function(xhr, status, error) {
			      // 요청이 실패한 경우 처리할 로직
			      console.log("AJAX 요청 실패:", error); // 예시: 에러 메시지 출력
				}
			});

		});
	
		<%-- 자주묻는질문을 클릭했을 때 펼쳐지면서 내용 보여주는 효과를 넣어줌 --%>
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
		
		// 검색어 입력창에서 엔터 키 이벤트 처리
		  $("#searchValue").keydown(function(event) {
		    if (event.keyCode === 13) { // 엔터 키 코드
		      event.preventDefault(); // 기본 동작(페이지 새로고침) 방지

		      // 검색 버튼 클릭 이벤트 실행
		      $("#faqSearch").click();
		    }
		  });
		
	});
	
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
					<input type="search" placeholder="유형, 제목으로 검색하기" id="searchValue" name="searchValue"> <%-- 검색어 입력창 --%>
					<input type="button" value="검색" id="faqSearch">
				</form>
			
				<nav id="faq_button">
					<ul>
						<li><input type="button" value="전체" class="faqButton btn-active" name="전체"></li> <%-- 전체 질문 보기 --%>
						<li><input type="button" value="예매" class="faqButton btn-inactive" name="예매"></li> <%-- 예매 관련 질문 모아보기 --%>
						<li><input type="button" value="관람권" class="faqButton btn-inactive" name="관람권"></li> <%-- 관람권 관련 질문 모아보기 --%>
						<li><input type="button" value="할인혜택" class="faqButton btn-inactive" name="할인혜택"></li> <%-- 할인 관련 질문 모아보기 --%>
						<li><input type="button" value="영화관이용" class="faqButton btn-inactive" name="영화관이용"></li> <%-- 영화관 관련 질문 모아보기 --%>
					</ul>
				</nav>
				
				<div id="faq_list">
					<c:choose>
						<c:when test="${empty faqList}">
							검색 결과가 없습니다					
						</c:when>
						<c:otherwise>
							<%-- FAQ 질문 리스트 List<CsVO> 객체(faqList) 활용하여 목록 출력 --%>
							<c:forEach var="faq" items="${faqList}">
								<div class="faq_list">
									<button class="accordion">
										<div id="topic">[ ${faq.cs_type_detail} ]</div><div id="subject">${faq.cs_subject}</div>
										<input type="hidden" name="cs_type_list_num" value="${faq.cs_type_list_num}">
									</button>
									<div class="panel">
										<pre id="faq_content">${faq.cs_content}</pre>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>	
</body>
</html>