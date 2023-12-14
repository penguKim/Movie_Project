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
			
			<div id="fqa_main">
			
				<form action="" method="" name="" >
					<section id="search">
						<b>빠른 검색</b>
						<input type="search" placeholder="검색어를 입력해주세요"> <%-- 검색어 입력창 --%>
						<a href="csFaq"><input type="button" value="검색"></a>
					</section>
				</form>
			
				<nav id="fqa_button">
					<ul>
						<li><a href="csFaq"><input type="button" value="전체" id="all"></a></li> <%-- 전체 질문 보기 --%>
						<li><a href="faqDetail?cs_type_detail=예매"><input type="button" value="예매" id="reserve"></a></li> <%-- 예매 관련 질문 모아보기 --%>
						<li><a href="faqDetail?cs_type_detail=관람권"><input type="button" value="관람권" id="ticket"></a></li> <%-- 관람권 관련 질문 모아보기 --%>
						<li><a href="faqDetail?cs_type_detail=할인혜택"><input type="button" value="할인혜택" id="discount"></a></li> <%-- 할인 관련 질문 모아보기 --%>
						<li><a href="faqDetail?cs_type_detail=영화관이용"><input type="button" value="영화관이용" id="theater"></a></li> <%-- 영화관 관련 질문 모아보기 --%>
					</ul>
				</nav>
				
				<c:choose>
					<c:when test="${empty faqList}">
						자주 묻는 질문 없음
					</c:when>
					<c:when test="${empty faqDetail}">
						<%-- FQA 질문 리스트 List<CsVO> 객체(faqList) 활용하여 목록 출력 --%>
						<c:forEach var="faq" items="${faqList}">
							<div id="fqa_list">
								<button class="accordion"><div id="topic">[ ${faq.cs_type_detail} ]</div><div id="subject">${faq.cs_subject}</div></button>
								<div class="panel">
									<p id="writing">
										${faq.cs_content}
									</p>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<%-- FQA 질문 리스트 List<CsVO> 객체(faqList) 활용하여 목록 출력 --%>
						<c:forEach var="faq" items="${faqDetail}">
							<div id="fqa_list">
								<button class="accordion"><div id="topic">[ ${faq.cs_type_detail} ]</div><div id="subject">${faq.cs_subject}</div></button>
								<div class="panel">
									<p id="writing">
										${faq.cs_content}
									</p>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				
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
					<%-- '<<' 버튼 클릭 시 현체 페이지보다 한 페이지 앞선 페이지 요청 --%>
					<%-- 다만, 페이지 번호가 1일 경우 비활성화 --%>		
					<c:choose>
						<c:when test="${pageNum eq 1}">
							<a href="" >&laquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="csFaq?pageNum=${pageNum-1}" >&laquo;</a>
						</c:otherwise>				
					</c:choose>
					<%-- 현재 페이지가 저장된 pageInfo 객체를 통해 페이지 번호 출력 --%>
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<%-- 각 페이지마다 하이퍼링크 설정(페이지번호를 pageNum 파라미터로 전달) --%>
						<%-- 단, 현재 페이지는 하이퍼링크 제거하고 굵게 표시 --%>
						<c:choose>
							<%-- 현재 페이지번호와 표시될 페이지번호가 같을 경우 판별 --%>
							<c:when test="${pageNum eq i}">
								<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
							</c:when>
							<c:otherwise>
								<a href="csFaq?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<%-- '>>' 버튼 클릭 시 현체 페이지보다 한 페이지 다음 페이지 요청 --%>
					<%-- 다만, 페이지 번호가 마지막 경우 비활성화 --%>		
					<c:choose>
						<c:when test="${pageNum eq pageInfo.maxPage}">
							<a href="" >&raquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="csFaq?pageNum=${pageNum+1}" >&raquo;</a>
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