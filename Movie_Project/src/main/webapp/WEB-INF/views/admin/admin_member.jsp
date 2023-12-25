<%-- admin_member.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
// 		if($(".member_status").text() == 1) {
// 			$(".member_status").html("회원");
// 		} else if($(".member_status").text() == 2) {
// 			$(".member_status").html("탈퇴");
// 		}
		
	});
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
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">회원정보관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<table border="1" width="1000">
					<div id="member_Search">
						<%-- 검색 기능을 위한 폼 생성 --%>
						<form action="adminMember">
							<select name="searchType">
								<option value="member">아이디</option>
								<option value="name">이름</option>
							</select>
							<input type="text" name="searchKeyword">
							<input type="submit" value="검색">
						</form>
					</div>
					<tr>
						<th width="120">이름</th>
						<th width="120">아이디</th>
						<th>이메일</th>
						<th width="100">회원상태</th>
						<th width="100">계정종류 및 변경</th>
					</tr>
					<c:forEach var="member" items="${memberList }">
						<tr>
							<td>${member.member_name}</td>
							<td>${member.member_id}</td>
							<td>${member.member_email}</td>
							<td class="member_status">
							<c:choose>
								<c:when test="${member.member_status eq 1 }">
								<span id="admin_member">회원</span>
								</c:when>
								<c:when test="${member.member_status eq 2 }">
								<span id="admin_Cmember">탈퇴</span>
								</c:when>
							</c:choose>
							</td>
							<td>
							<a href="adminMemberMod?member_id=${member.member_id}&pageNum=${pageNum }" id="ok">
								<input type="button" value="수정" id="ok">
							</a>
							</td>
						</tr>
					</c:forEach>
				</table>
				<div class="pagination">
						<%-- '<<' 버튼 클릭 시 현체 페이지보다 한 페이지 앞선 페이지 요청 --%>
						<%-- 다만, 페이지 번호가 1일 경우 비활성화 --%>		
						<c:choose>
							<c:when test="${pageNum eq 1}">
								<a href="" >&laquo;</a>					
							</c:when>
							<c:otherwise>
								<a href="adminMember?pageNum=${pageNum-1}" >&laquo;</a>
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
									<a href="adminMember?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
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
								<a href="adminMember?pageNum=${pageNum+1}" >&raquo;</a>
							</c:otherwise>				
						</c:choose>
			</div>
				</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
<!-- 					<section class="pagination"> -->
<!-- 					<input type="button" value="이전"  -->
<%-- 						onclick="location.href='adminMember?pageNum=${pageNum - 1}'" --%>
<%-- 						<c:if test="${pageNum <= 1 }">disabled</c:if> --%>
<!-- 					> -->
<%-- 					<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }"> --%>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${pageNum eq i }"> --%>
<%-- 								<b>${i }</b> --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<%-- 								<a href="adminMember?pageNum=${i }">${i }</a> --%>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<%-- 					</c:forEach> --%>
<!-- 					<input type="button" value="다음"  -->
<%-- 						onclick="location.href='adminMember?pageNum=${pageNum + 1}'" --%>
<%-- 						<c:if test="${pageNum >= pageInfo.maxPage }">disabled</c:if> --%>
<!-- 					> -->
<!-- 					</section> -->
</body>
</html>