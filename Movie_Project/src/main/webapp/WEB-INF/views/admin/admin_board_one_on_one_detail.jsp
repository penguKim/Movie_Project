<%-- admin_board_one_on_one_response.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

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
			<h1 id="h01">1 : 1 문의 상세 조회 페이지</h1>
			<hr>		
			<div id="admin_sub">
				<form action="OneonOneMoveToModify?pageNum=${param.pageNum }" method="post">
					<table border="1" id="shortTable">
						<tr>
							<th width="150">번호</th>
							<td>${oneOnOne.cs_type_list_num}</td>
						</tr>
						<tr>
							<th>문의 유형</th>
							<td>${oneOnOne.cs_type_detail }</td>
						</tr>
						<c:choose>
							<c:when test="${not empty oneOnOne.theater_id}">
								<tr>
									<th>문의 지점</th>
									<td>${oneOnOne.theater_name }</td>
								</tr>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
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
						<tr id="shortTableContent">
							<th>문의 내용</th>
							<td>${oneOnOne.cs_content }</td>
						</tr>
						<tr>
							<th>첨부 사진</th>
								<td>
								<c:choose>
									<c:when test="${not empty oneOnOne.cs_file }">
									<c:set var="original_file_name" value="${fn:substringAfter(oneOnOne.cs_file, '_') }"/>
										<img alt="" src="${pageContext.request.contextPath }/resources/upload/${oneOnOne.cs_file}" height="300px">
										<br>${original_file_name }
										<a href="${pageContext.request.contextPath}/resources/upload/${oneOnOne.cs_file }" download="${original_file_name }">
											<input type="button" value="다운로드">
										</a>
									</c:when>
									<c:otherwise>
										없음
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr id="shortTableContent">
							<th>답변 내용</th>
							<td>
								<c:choose>
									<c:when test="${empty oneOnOne.cs_reply }">답변 처리가 필요한 문의입니다.</c:when>
									<c:otherwise>
										${oneOnOne.cs_reply }
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="hidden" name="cs_id" value="${oneOnOne.cs_id }">	
						<input type="hidden" name="pageNum" value="${param.pageNum }">
						<c:choose>
							<c:when test="${empty oneOnOne.cs_reply }">
								<a href="OneOnOneMoveToRegister?cs_id=${oneOnOne.cs_id }&pageNum=${pageNum }"><input type="button" value="답변하기"></a>
							</c:when>
							<c:otherwise>
								<input type="submit" value="답변 수정/삭제">
							</c:otherwise>
						</c:choose>	
						<input type="button" value="돌아가기" onclick="history.back()">
					</div>
				</form>
			</div>
		</section>
	</div>			
</body>
</html>