<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 1:1문의 상세 게시판</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
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
					<table id=MyOneOnOneTable>
						<tr>
							<th width="150">번호</th>
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
							<th>첨부 사진</th>
							<td>
								<c:choose>
									<c:when test="${not empty oneOnOne.cs_file }">
									<c:set var="original_file_name" value="${fn:substringAfter(oneOnOne.cs_file, '_') }"/>
										<img alt="" src="${pageContext.request.contextPath }/resources/upload/${oneOnOne.cs_file}" style= "max-width: 600px; height: 300px">
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
							<c:choose>
								<c:when test="${empty oneOnOne.cs_reply}">
									<td id="oneOnOneReplyArea">
										더 나은 고객 응대를 위해<br>
										고객님의 문의를 꼼꼼히 확인하고 있습니다.<br>
										답변을 조금만 더 기다려주세요.<br>
										- 아이티켓
									</td>
								</c:when>
								<c:otherwise>
									<td>
										${oneOnOne.cs_reply }
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</table><br>
					<div id="myPageBottomArea">
						<input type="submit" value="문의 삭제" id="oneOnOneDelete">&nbsp;&nbsp;
						<input type="button" value="돌아가기" onclick="history.back()"><br><br>
						<input type="hidden" name="cs_id" value="${oneOnOne.cs_id }">
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