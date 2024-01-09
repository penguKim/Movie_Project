<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 1:1문의 게시판</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.7.1.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
	<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1 로 저장) --%>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<h1 id="h01">1:1 문의 게시판</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form name="checkform">
				<div id="my_list">
					<h2>1대1문의 내역 조회</h2>
					<table id="MyOneOnOneTable">
						<tr>
							<th>제목</th>
							<th width="150">문의 유형</th>
							<th width="100">등록일</th>
						</tr>
							<c:choose>
								<c:when test="${empty myOneOnOneList }">
									<tr>
										<td colspan="3">1대1문의 내역이 존재하지 않습니다.</td>
									</tr>								
								</c:when>
								<c:otherwise>
									<c:forEach var="ooo" items="${myOneOnOneList }">
										<tr id="move_menu">
											<c:set var="cs_subject" value="${ooo.cs_subject }"/>
											<td id="MyOneOnOneSubject"><a href="MypageOneOnOneDetail?cs_id=${ooo.cs_id }">
												<c:choose>
													<c:when test="${fn:length(cs_subject) > 30 }">
														${fn:substring(cs_subject, 0, 28) }...
													</c:when>
													<c:otherwise>
														${ooo.cs_subject }
													</c:otherwise>
												</c:choose>
											</a></td>
											<td>${ooo.cs_type_detail }</td>
											<td>${ooo.cs_date }</td>
										</tr>
									</c:forEach>
							</c:otherwise>
						</c:choose>
					</table><br><br>
					
					<div class="pagination">
						<%-- '<<' 버튼 클릭 시 현체 페이지보다 한 페이지 앞선 페이지 요청 --%>
						<%-- 다만, 페이지 번호가 1일 경우 비활성화 --%>		
						<c:choose>
							<c:when test="${pageNum eq 1}">
								<a href="" >&laquo;</a>					
							</c:when>
							<c:otherwise>
								<a href="Mypage_OneOnOneList?pageNum=${pageNum-1}" >&laquo;</a>
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
									<a href="Mypage_OneOnOneList?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
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
								<a href="Mypage_OneOnOneList?pageNum=${pageNum+1}" >&raquo;</a>
							</c:otherwise>				
						</c:choose>
					</div>
				</div>
			</form>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
	
</body>
</html>