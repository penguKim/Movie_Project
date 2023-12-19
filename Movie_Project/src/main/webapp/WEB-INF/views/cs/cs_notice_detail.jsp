<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/cs.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">공지사항</h1>
			<hr>
			<div id="cs_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="cs_menubar.jsp"></jsp:include>
			</div>
			
			<div id="notice_content">
				<table id="notice_table">
					<tr>
						<th colspan="4">${cs.cs_subject}</th>
					</tr>
					<tr>
						<td class="notice_info">영화관</td>
						<c:choose>
							<c:when test="${cs.theater_id eq 1}"><td class="notice_info">지점명1</td></c:when>
							<c:when test="${cs.theater_id eq 2}"><td class="notice_info">지점명2</td></c:when>
							<c:when test="${cs.theater_id eq 3}"><td class="notice_info">지점명3</td></c:when>
							<c:when test="${cs.theater_id eq 4}"><td class="notice_info">지점명4</td></c:when>
							<c:when test="${cs.theater_id eq 5}"><td class="notice_info">지점명5</td></c:when>
						</c:choose>	
						<td class="notice_info">등록일</td>
						<td class="notice_info">${cs.cs_date}</td>
					</tr>
					<tr>
						<td colspan="4"  class="notice_content">${cs.cs_content}<br><br><br><br><br><br><br></td>
					</tr>
					<tr>
						<td>이전  ▲</td>
						<c:choose>
							<c:when test="${param.cs_type_list_num > 0}">
								<td colspan="3"><a href="csNoticeDetail?cs_type=${param.cs_type}&cs_type_list_num=${param.cs_type_list_num - 1}&pageNum=${param.pageNum}" id="notice_tit">
									이전 공지사항 보기</a></td>								
							</c:when>
							<c:otherwise>
								<td>이전 공지사항이 없습니다</td>
							</c:otherwise>
						</c:choose>
						
					</tr>
					<tr>
						<td>다음  ▼</td>
						<c:choose>
							<c:when test="${param.cs_type_list_num < maxCount - 1}">
								<td colspan="3"><a href="csNoticeDetail?cs_type=${param.cs_type}&cs_type_list_num=${param.cs_type_list_num + 1}&pageNum=${param.pageNum}" id="notice_tit">
									다음 공지사항 보기</a></td>								
							</c:when>
							<c:otherwise>
								<td>다음 공지사항이 없습니다</td>
							</c:otherwise>
						</c:choose>
					</tr>
				</table>
				<div id="button"><a href="csNotice?pageNum=${param.pageNum}"><input type="button" value="목록"></a></div>
			</div>
		</section>
		
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>