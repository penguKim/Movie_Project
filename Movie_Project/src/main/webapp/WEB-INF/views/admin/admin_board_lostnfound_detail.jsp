<%-- admin_board_lostnfound_detail.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분실물 문의 상세</title>
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
			<h1 id="h01">분실물 문의 상세 조회페이지</h1>
			<hr>		
			<div id="admin_sub">
				<form action="LostNFoundMoveToModify?pageNum=${param.pageNum }" method="post">
					<table border="1">
						<tr>
							<th width="150">번호</th>
							<td>${lostnfound.cs_id }</td>
						</tr>
						<tr>
							<th>분실장소</th>
							<td>${lostnfound.theater_name }</td>
						</tr>
						<tr>
							<th>분실일시</th>
							<td>${lostnfound.cs_date }</td>
						</tr>
						<tr>
							<th>문의 제목</th>
							<td>${lostnfound.cs_subject }</td>
						</tr>
						<tr>
							<th>문의 작성자</th>
							<td>${lostnfound.member_id }</td>
						</tr>
						<tr>
							<th height="300">문의 내용</th>
							<td>${lostnfound.cs_content }</td>
						</tr>
						<tr>
							<th>첨부사진</th>
							<td>
								<c:choose>
									<c:when test="${not empty lostnfound.cs_file }">
									<c:set var="original_file_name" value="${fn:substringAfter(lostnfound.cs_file, '_') }"/>
										<img alt="" src="${pageContext.request.contextPath }/resources/upload/${lostnfound.cs_file}" height="300px">
										<br>${original_file_name }
										<a href="${pageContext.request.contextPath}/resources/upload/${lostnfound.cs_file }" download="${original_file_name }">
											<input type="button" value="다운로드">
										</a>
									</c:when>
									<c:otherwise>
										없음
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th height="300">답변 내용</th>
							<td>
								<c:choose>
									<c:when test="${empty lostnfound.cs_reply }">답변 처리가 필요한 문의입니다.</c:when>
									<c:otherwise>
										${lostnfound.cs_reply }
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="hidden" name="cs_id" value="${lostnfound.cs_id }">	
						<input type="hidden" name="pageNum" value="${param.pageNum }">	
						<c:choose>
							<c:when test="${empty lostnfound.cs_reply }">
								<a href="LostNFoundMoveToRegister?cs_id=${lostnfound.cs_id }&pageNum=${param.pageNum}"><input type="button" value="답변하기"></a>
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