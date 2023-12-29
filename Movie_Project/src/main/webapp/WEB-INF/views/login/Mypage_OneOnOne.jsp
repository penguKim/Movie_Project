<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		$("#oneOnOneDelete").on("click", function() {
			if(confirm("문의 글을 삭제하시겠습니까?")) {
				return true;
			} else {
				return false;
			}
		});
		
	});

</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<h1 id="h01">나의 게시글</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form action="MyPageOneOnOneDelete" name="checkform">
				<div id="my_list">
					<h2>1대1문의 내역 상세 조회</h2>
					<table id="my_table1">
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
							<th>작성일</th>
							<td>${oneOnOne.cs_date }</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>${oneOnOne.cs_subject }</td>
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
					</table><br>
					<input type="submit" value="문의 삭제" id="oneOnOneDelete"><br><br>
					<input type="hidden" name="cs_id" value="${oneOnOne.cs_id }">
								
					<div class="pagination">
						<a href="#">&laquo;</a>
						<a href="#">1</a>
						<a class="active" href="#">2</a>
						<a href="#">3</a>
						<a href="#">4</a>
						<a href="#">5</a>
						<a href="#">&raquo;</a>
					</div>
				</div>
							
			</form>
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
	
</body>
</html>