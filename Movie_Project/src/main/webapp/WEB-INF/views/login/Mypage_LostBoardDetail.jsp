<%-- admin_board_lostnfound_detail.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#admin_sub {
	display: inline-block;
	position: relative;
	left: 6em;
}

</style>
<title>분실물 문의 상세</title>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<%-- <link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		$("#modify").on("click", function() {
			if(confirm("답변을 수정하시겠습니까?")) {
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

		
		<section id="content">
			<h1 id="h01">분실물 문의 상세 조회페이지</h1>
			<hr>		

			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			<div id="admin_sub" align="center">
				<form action="" method="post">
					<table border="1" id="my_table2">
						<tr>
							<th>번호</th>
							<td>${myLostDetail.cs_id}</td>
						</tr>
						<tr>
							<th>분실장소</th>
							<td>${myLostDetail.theater_name }</td>
						</tr>
						<tr>
							<th>분실일시</th>
							<td>${myLostDetail.cs_date }</td>
						</tr>
						<tr>
							<th>문의 제목</th>
							<td>${myLostDetail.cs_subject }</td>
						</tr>
						<tr>
							<th>문의 작성자</th>
							<td>${myLostDetail.member_id }</td>
						</tr>
						<tr>
							<th height="300">문의 내용</th>
							<td>${myLostDetail.cs_content }</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<div class = "file">
									<c:if test="${not empty myLostDetail.cs_file}">
										<c:set var="original_file_name" value="${fn:substringAfter(myLostDetail.cs_file, '_')}"/>
										${original_file_name}
										<a href="${pageContext.request.contextPath }/resources/upload/${myLostDetail.cs_file}" download="${original_file_name}"><input type="button" value="다운로드"></a>
									</c:if>
								</div>
							</td>
						</tr>
						<tr>
							<th height="300">답변 내용</th>
							<td>
								${myLostDetail.cs_reply }
							</td>
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="hidden" name="cs_id" value="${myLostDetail.cs_id }">	
						<input type="hidden" name="pageNum" value="${param.pageNum }">	
<!-- 						<input type="submit" value="답변 삭제" formaction=""> -->
						<input type="button" value="돌아가기" onclick="history.back();">
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