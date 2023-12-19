<%-- admin_board_lostnfound.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분실물 문의 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1 로 저장) --%>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">분실물 문의 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			<div id="admin_main">
				<table border="1">
					<tr>
						<th width="70">번호</th>
						<th width="120">분실장소</th>
						<th>제목</th>
						<th width="100">작성자</th>
						<th width="120">등록일</th>
						<th width="95">답변상태</th>
					</tr>
					<c:forEach var="lnf" items="${lostnfoundList }">
						<tr>
							<td>${lnf.cs_id }</td>
<!-- 							분실장소인 극장은 아직 넘겨받을 데이터가 없다. -->
							<td>${lnf.theater_id }</td>
							<td>${lnf.cs_subject }</td>
							<td>${lnf.member_id }</td>
							<td>${lnf.cs_date }</td>
							<c:choose>
								<c:when test="${empty lnf.cs_reply }">
									<td><a href="adminLostNFoundResp?cs_id=${lnf.cs_id }">답변등록</a></td>
								</c:when>
								<c:otherwise>
									<td><a href="adminLostNFoundResp?cs_id=${lnf.cs_id }">등록완료</a></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
<!-- 				<div class="pagination"> -->
<!-- 					<a href="#">&laquo;</a> -->
<!-- 					<a href="#">1</a> -->
<!-- 					<a class="active" href="#">2</a> -->
<!-- 					<a href="#">3</a> -->
<!-- 					<a href="#">4</a> -->
<!-- 					<a href="#">5</a> -->
<!-- 					<a href="#">&raquo;</a> -->
<!-- 				</div> -->
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
		<section class="pagination">
		<%-- [이전] 버튼 클릭 시 BoardList.bo 서블릿 요청(파라미터 : 현재 페이지번호 - 1) --%>
		<%-- 단, 현재 페이지 번호(pageNum) 가 1보다 클 경우에만 동작(아니면 비활성화 처리) --%>
		<input type="button" value="이전" 
			onclick="location.href='adminLostNFound?pageNum=${pageNum - 1}'"
			<c:if test="${pageNum <= 1 }">disabled</c:if>
		>
		<%-- 현재 페이지 번호가 저장된 pageInfo 객체를 통해 페이지 번호 출력 --%>
		<%-- 시작페이지(startPage) 부터 끝페이지(endPage) 까지 표시 --%>
		<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
			<%-- 각 페이지마다 하이퍼링크 설정(페이지번호를 pageNum 파라미터로 전달 --%>
			<%-- 단, 현재 페이지는 하이퍼링크 제거하고 굵게 표시 --%>
			<c:choose>
				<%-- 현재 페이지번호와 표시될 페이지번호가 같을 경우 판별 --%>
				<c:when test="${pageNum eq i }">
					<b>${i }</b> <%-- 현재 페이지 번호 --%>
				</c:when>
				<c:otherwise>
					<a href="adminLostNFound?pageNum=${i }">${i }</a> <%-- 다른 페이지 번호 --%>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<%-- [다음] 버튼 클릭 시 BoardList.bo 서블릿 요청(파라미터 : 현재 페이지번호 + 1) --%>
		<%-- 단, 현재 페이지 번호(pageNum) 가 최대 페이지번호 보다 작을 경우에만 동작(아니면 비활성화 처리) --%>
		<input type="button" value="다음" 
			onclick="location.href='adminLostNFound?pageNum=${pageNum + 1}'"
			<c:if test="${pageNum >= pageInfo.maxPage }">disabled</c:if>
		>
	</section>
	</div>
</body>
</html>