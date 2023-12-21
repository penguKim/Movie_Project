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
		console.log($(".member_status").text());
		if($(".member_status").text() == 1) {
			$(".member_status").html("회원");
		} else if($(".member_status").text() == 2) {
			$(".member_status").html("탈퇴");
		}
		
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
								<a href="adminMemberMod?member_id=${member.member_id}&pageNum=${pageNum }">
									<input type="button" value="수정" id="ok">
								</a>
								</td>
							</tr>
						</c:forEach>
<!-- 						<tr> -->
<!-- 							<td>번호입니다</td> -->
<!-- 							<td>유형입니다</td> -->
<!-- 							<td>제목입니다</td> -->
<!-- 							<td>작성자입니다</td> -->
<!-- 							<td><a href="adminMemberMod"><input type="button" value="회원" id="admin_member"></a></td> -->
<!-- 						</tr> -->
					</table>
			</div>
					<section class="pagination">
					<input type="button" value="이전" 
						onclick="location.href='adminMember?pageNum=${pageNum - 1}'"
						<c:if test="${pageNum <= 1 }">disabled</c:if>
					>
					<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
						<c:choose>
							<c:when test="${pageNum eq i }">
								<b>${i }</b>
							</c:when>
							<c:otherwise>
								<a href="adminMember?pageNum=${i }">${i }</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<input type="button" value="다음" 
						onclick="location.href='adminMember?pageNum=${pageNum + 1}'"
						<c:if test="${pageNum >= pageInfo.maxPage }">disabled</c:if>
					>
					</section>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>