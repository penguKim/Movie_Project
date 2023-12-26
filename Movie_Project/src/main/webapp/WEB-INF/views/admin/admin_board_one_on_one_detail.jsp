<%-- admin_board_one_on_one_response.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1 : 1 문의 상세</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">1 : 1 문의 상세 조회 페이지</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>

			<div id="admin_sub">
				<form action="OneonOneMoveToModify?pageNum=${param.pageNum }" method="post">
					<table border="1">
						<tr>
							<th>번호</th>
							<td>${oneOnOne.cs_type_list_num}</td>
						</tr>
						<tr>
							<th>문의 유형</th>
							<td>${oneOnOne.cs_type_detail }</td>
						</tr>
						<c:if test="${not empty oneOnOne.theater_id }">
							<tr>
								<th>문의 지점</th>
								<td>${oneOnOne.theater_name }</td>
							</tr>
						</c:if>
						<tr>
							<th>문의 작성일</th>
							<td>${oneOnOne.cs_date }</td>
						</tr>
						<tr>
							<th>문의 제목</th>
							<td>${oneOnOne.cs_subject }</td>
						</tr>
						
						<tr>
							<th>문의 작성자</th>
							<td>${oneOnOne.member_id }</td>
						</tr>
						<tr>
							<th height="300">문의 내용</th>
							<td>${oneOnOne.cs_content }</td>
						</tr>
						<tr>
							<th>첨부 파일</th>
						
							<c:choose>
								<c:when test="${not empty oneOnOne.cs_file }">
								<c:set var="original_file_name" value="${fn:substringAfter(oneOnOne.cs_file, '_') }"/>
										<td>
											<a href="${pageContext.request.contextPath}/resources/upload/${oneOnOne.cs_file }" download="${original_file_name }">${original_file_name }</a>
										</td>
								</c:when>
								<c:otherwise>
										<td>없음</td>
								</c:otherwise>
							</c:choose>

						</tr>
						<tr>
							<th height="300">답변 내용</th>
							<td>
								${oneOnOne.cs_reply }
							</td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="hidden" name="cs_id" value="${oneOnOne.cs_id }">	
						<input type="hidden" name="pageNum" value="${param.pageNum }">	
						<input type="submit" value="답변 수정/삭제">
						<input type="button" value="돌아가기" onclick="history.back()">
					</div>
				</form>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>			
</body>
</html>