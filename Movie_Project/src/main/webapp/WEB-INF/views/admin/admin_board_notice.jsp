<%-- admin_board_notice.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">
		<nav id="navbar">
			<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		</nav>
	
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
		
		<section id="content">
			<h1 id="h01">공지사항 관리</h1>
			<hr>
			
			<div id="admin_main">
				<div id="admin_search">
					<%-- 검색 기능을 위한 폼 생성 --%>
					<form id="serch_submit">
						<input type="text" name="searchValue" placeholder="지점, 제목으로 검색">
						<input type="submit" value="검색">
					</form>
					<div id="admin_writer2">
						<a href="adminNoticeWriteForm"><input type="button" value="글쓰기"></a>
					</div>
				</div>
				<table border="1">
					<tr>
						<th width="60">번호</th>
						<th width="150">지점</th>
						<th>제목</th>
						<th width="150">등록일</th>
					</tr>
					<c:choose>
						<c:when test="${empty NoticeList}">
							<tr><td colspan="4">검색 결과가 없습니다</td></tr>						
						</c:when>
						<c:otherwise>
							<c:forEach var="notice" items="${NoticeList}">
								<tr>
									<td>${notice.cs_type_list_num}</td>
									<c:choose>
										<c:when test="${notice.theater_id == null}">
											<td>전체</td>
										</c:when>
										<c:otherwise>
											<td>${notice.theater_name}</td>
										</c:otherwise>
									</c:choose>
									<td class="post_name"><a href="adminNoticeView?cs_type=${notice.cs_type}&cs_type_list_num=${notice.cs_type_list_num}&pageNum=${pageNum}">${notice.cs_subject}</a></td>
									<td>
										<fmt:parseDate value='${notice.cs_date}' pattern="yyyy-MM-dd" var='cs_date'/>
										<fmt:formatDate value="${cs_date}" pattern="yyyy-MM-dd"/>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
				<div class="pagination">
					<%-- '<<' 버튼 클릭 시 현체 페이지보다 한 페이지 앞선 페이지 요청 --%>
					<%-- 다만, 페이지 번호가 1일 경우 비활성화 --%>		
					<c:choose>
						<c:when test="${pageNum eq 1}">
							<a href="" >&laquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminNotice?pageNum=${pageNum-1}" >&laquo;</a>
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
								<a href="adminNotice?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<%-- '>>' 버튼 클릭 시 현체 페이지보다 한 페이지 다음 페이지 요청 --%>
					<%-- 다만, 페이지 번호가 마지막 경우 비활성화 --%>		
					<c:choose>
						<c:when test="${pageNum eq pageInfo.endPage}">
							<a href="" >&raquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminNotice?pageNum=${pageNum+1}" >&raquo;</a>
						</c:otherwise>				
					</c:choose>
				</div>
			</div>
		</section>
	</div>
</body>
</html>