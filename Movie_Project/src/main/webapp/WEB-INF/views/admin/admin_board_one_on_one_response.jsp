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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script type="text/javascript">
	$(function() {
		$("#responseWrite").on("click", function() { // 등록 버튼 클릭 이벤트 처리
			if($("#cs_reply").val() == "") { 
				alert("내용을 입력하지 않을 경우 답변 등록이 불가능합니다!");
				$("#cs_reply").focus();
				return false;
			}
			
		});
	});
	
	$(function() {
		let previousValue = $("#cs_reply").val(); // 변수에 현재 내용 저장
		
		$("#responseModify").on("click", function() {
			let currentValue = $("#cs_reply").val();
			if(previousValue == currentValue) { // textarea의 기존 값과 입력한 내용을 비교했을 경우 변동이 없다면
				alert("변경된 내용이 없을 경우 답변 수정이 불가능합니다!");
				$("#cs_reply").focus();
				return false;
			} else {
				if(confirm("수정 내용을 등록하시겠습니까?")) {
					$.post("OneOnOneModify"), // 제이쿼리 포스트 방식 요청 처리 미완****************
				}
			}
		});
		
	});
	
	
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>

		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
<%-- 		<c:choose> --%>
<%-- 			<c:when test=""> --%>
				<h1 id="h01">1 : 1 문의 답변 등록 페이지</h1>
<%-- 			</c:when> --%>
<%-- 			<c:otherwise> --%>
<!-- 				<h1 id="h01">1 : 1 문의 답변 수정/삭제 페이지</h1> -->
<%-- 			</c:otherwise> --%>
<%-- 		</c:choose>		 --%>
		
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
							<th>문의 작성일</th>
							<td>${oneOnOne.cs_date }</td>
						</tr>
						<tr>
							<th>문의 제목</th>
							<td>${oneOnOne.cs_subject }</td>
						</tr>
						<c:if test="${not empty oneOnOne.theater_id }">
							<tr>
								<th>문의 지점</th>
								<td>${oneOnOne.theater_name }</td> <!-- "지점"으로 출력... whyrano... -->
							</tr>
						</c:if>
						
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
							<td>******파일이름처리**********</td>
						</tr>
						<tr>
							<th height="300">답변 내용</th>
							<td>
								<textarea rows="30" cols="80" id="cs_reply" name="cs_reply">${oneOnOne.cs_reply }</textarea>
							</td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="hidden" name="cs_id" value="${oneOnOne.cs_id }">	
						<input type="hidden" name="cs_type_list_num" value="${oneOnOne.cs_type_list_num }">	
						<input type="hidden" name="pageNum" value="${param.pageNum }">	
						<c:choose>
							<c:when test="${empty oneOnOne.cs_reply }">
								<input type="submit" value="답변 등록하기" id="responseWrite" formaction="OneOnOneResponse">
							</c:when>
							<c:otherwise>
<!-- 								<input type="submit" value="답변 수정" id="responseModify" formaction="OneOnOneModify"> -->
								<input type="button" value="답변 수정" id="responseModify">
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