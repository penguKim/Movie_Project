<%-- admin_board_notice_detail.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리</title>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	function confirmDelete() {
		if(confirm("삭제하시겠습니까?")) {
			location.href="adminNoticeDelete?cs_type=${noticeDetail.cs_type}&cs_type_list_num=${noticeDetail.cs_type_list_num}&pageNum=${param.pageNum}";
		}
	}
</script>
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
				<form action="adminNoticeModifyForm?cs_type=${noticeDetail.cs_type}&cs_type_list_num=${noticeDetail.cs_type_list_num}&pageNum=${param.pageNum}" method="post">
					<table border="1">
						<tr>
							<th width="100px">번호</th>
							<td>${param.cs_type_list_num}</td>
						</tr>
						<tr>
							<th>지점</th>
							<td>
								<c:choose>
									<c:when test="${noticeDetail.theater_id == null}">
										전체
									</c:when>							
									<c:otherwise>
										${noticeDetail.theater_name}						
									</c:otherwise>
								</c:choose>
							</td>
							<input type="hidden" value="${noticeDetail.theater_id}">
						</tr>
						<tr>
							<th>제목</th>
							<td>${noticeDetail.cs_subject}</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>
								<fmt:parseDate value='${noticeDetail.cs_date}' pattern="yyyy-MM-dd" var='cs_date'/>
								<fmt:formatDate value="${cs_date}" pattern="yyyy-MM-dd"/>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td><pre id="content_table">${noticeDetail.cs_content}</pre></td>
						</tr>
					</table>
					<div id="admin_writer">
						<input type="submit" value="수정">
						<a href="adminNotice?pageNum=${param.pageNum}"><input type="button" value="돌아가기"></a>
						<a href="javascript:confirmDelete()"><input type="button" value="삭제"></a>
					</div>
				</form>
			</div>
		</section>
	</div>			
</body>
</html>