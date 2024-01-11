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

<script type="text/javascript">
	$(function() {
		$("#responseWrite").on("click", function() { // 등록 버튼 클릭 이벤트 처리
			if($("#cs_reply").val() == "") { 
				alert("내용을 입력하지 않을 경우 답변 등록이 불가능합니다!");
				$("#cs_reply").focus();
				return false;
			}
			
		});

		let previousValue = $("#cs_reply").val(); // 변수에 현재 내용 저장
		
		$("#responseModify").on("click", function() {
			let currentValue = $("#cs_reply").val();
			if(currentValue == "") {
				alert("내용을 입력하지 않을 경우 답변 수정이 불가능합니다!");
				$("#cs_reply").focus();
				return false;
			} else {
				if(previousValue == currentValue) { // textarea의 기존 값과 입력한 내용을 비교했을 경우 변동이 없다면
					alert("변경된 내용이 없을 경우 답변 수정이 불가능합니다!");
					$("#cs_reply").focus();
					return false;
				} else {
					return confirm("답변을 수정하시겠습니까?");
				}
				
			}
		});
		
		$("#responseDelete").on("click", function() {
			if(confirm("답변을 삭제하시겠습니까?")) {
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
		<nav id="navbar">
            <jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
        </nav>
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
		
		<section id="content">
		<c:choose>
			<c:when test="${empty oneOnOne.cs_reply }">
				<h1 id="h01">1대1문의 답변 등록</h1>
			</c:when>
			<c:otherwise>
				<h1 id="h01">1대1문의 답변 수정/삭제</h1>
			</c:otherwise>
		</c:choose>		
		
			<hr>		
			<div id="admin_sub">
				<form method="post"> <!-- 복수개의 서브밋 처리 필요 -->
					<table border="1">
						<tr>
							<th width="200">번호</th>
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
						<tr>
							<th height="300">문의 내용</th>
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
						<tr>
							<th height="300">답변 내용</th>
							<td>
								<textarea rows="30" cols="80" id="cs_reply" name="cs_reply">${oneOnOne.cs_reply }</textarea>
							</td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="hidden" name="cs_id" value="${oneOnOne.cs_id }">	
						<input type="hidden" name="pageNum" value="${param.pageNum }">	
						<c:choose>
							<c:when test="${empty oneOnOne.cs_reply }">
								<input type="submit" value="답변 등록하기" id="responseWrite" formaction="OneOnOneResponse">
							</c:when>
							<c:otherwise>
								<input type="submit" value="답변 수정" id="responseModify" formaction="OneOnOneModify">
								<input type="submit" value="답변 삭제" id="responseDelete" formaction="OneOnOneDelete">
							</c:otherwise>
						</c:choose>	
						<input type="button" value="돌아가기" onclick="history.back();">
					</div>
				</form>
			</div>
		</section>
	</div>			
</body>
</html>