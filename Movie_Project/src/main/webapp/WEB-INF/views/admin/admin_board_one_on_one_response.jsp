<%-- admin_board_one_on_one_response.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1 : 1 문의 상세</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	btnMod() {
		
	}
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">1 : 1 문의 상세페이지</h1>
			<hr>		
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>

			<div id="admin_sub">
				<form action="" method="post"> <!-- 복수개의 서브밋 처리 필요 -->
					<table border="1">
						<tr>
							<th>번호</th>
							<td>${oneOnOne.cs_id}</td>
						</tr>
						<tr>
							<th>문의 유형</th>
							<td>${oneOnOne.cs_type_detail }</td>
						</tr>
						<tr>
							<th>문의 제목</th>
							<td>${oneOnOne.cs_subject }</td>
						</tr>
<%-- 						<c:if test="${oneOnOne.theater_id ne '' }"> --%>
<!-- 							<tr> -->
<!-- 								<th>문의 지점</th> -->
<%-- 								<td>${oneOnOne.theater_name }</td> --%>
<!-- 							</tr> -->
<%-- 						</c:if> --%>
						
						<tr>
							<th>문의 작성자</th>
							<td>${oneOnOne.member_id }</td>
						</tr>
						<tr>
							<th height="300">문의 내용</th>
							<td>${oneOnOne.cs_content }</td>
						</tr>
						<tr>
							<th>사진 첨부</th>
							<td><input type="file"></td>
						</tr>
						<tr>
							<th height="300">답변 내용</th>
							<td>
								<textarea rows="30" cols="80" name="cs_reply" placeholder="${oneOnOne.cs_reply }"></textarea>
							</td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="hidden" name="cs_id" value="${oneOnOne.cs_id }">	
						<input type="hidden" name="pageNum" value="${param.pageNum }">	
						<c:choose>
							<c:when test="${empty oneOnOne.cs_reply }">
								<input type="submit" value="답변 등록" formaction="boardOneOnOneRsp">
							</c:when>
							<c:otherwise>
								<input type="submit" value="답변 수정" formaction="">
								<input type="submit" value="답변 삭제" formaction="">
							</c:otherwise>
						</c:choose>	
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