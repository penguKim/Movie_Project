<%-- admin_board_lostnfound_response.jsp --%>
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
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		let previousValue = $("#cs_reply").val(); // 변수에 현재 내용 저장
	    
	    $("#regist").on("click", function() {
	        // "cs_reply"의 내용이 비어 있다면
	        if ($("#cs_reply").val() == "") {
	            // 확인창을 띄웁니다.
	            alert("답변 내용을 입력하세요.");
	            $("#cs_reply").focus();
	            // 'submit' 이벤트를 취소합니다.
	            return false;
	        } else {
	            // "cs_reply"의 내용이 있다면 confirm 창을 띄웁니다.
	            return confirm("정말로 등록하시겠습니까?");
	        }
	    });
	    
	    $("#modify").on("click", function() {
	    	let currentValue = $("#cs_reply").val();
	    	if (currentValue == "") {
	    		alert("수정할 내용을 입력해주세요!");
				$("#cs_reply").focus();
				return false;
	    	} else if(previousValue == currentValue) {
				alert("변경된 내용이 없을 경우 답변 수정이 불가능합니다!");
				$("#cs_reply").focus();
				return false;
			} else {
				return confirm("답변을 수정하시겠습니까?");
			}
		});
	    
		
		$("#delete").on("click", function() {
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
			<h1 id="h01">분실물 문의 상세페이지</h1>
			<hr>		
			<div id="admin_sub">
				<form action="" method="post">
					<table border="1">
						<tr>
							<th>번호</th>
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
							<th>첨부파일</th>
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
							<td><textarea name="cs_reply" id="cs_reply" rows="20" cols="80">${lostnfound.cs_reply }</textarea></td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="hidden" name="cs_id" value="${lostnfound.cs_id }">	
						<input type="hidden" name="pageNum" value="${param.pageNum }">	
						<c:choose>
							<c:when test="${empty lostnfound.cs_reply }">
								<input type="submit" value="답변 등록하기" formaction="LostNFoundResponse" id="regist">
							</c:when>
							<c:otherwise>
								<input type="submit" value="답변 수정" formaction="LostNFoundModify" id="modify">
								<input type="submit" value="답변 삭제" formaction="LostNFoundDelete" id="delete">
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