<%-- admin_board_faq_write.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="${pageContext.request.contextPath}/resources//js/jquery-3.7.1.js"></script>
<script type="text/javascript">

	$(function() {
		$("form").submit(function() {
			if(confirm("문의를 등록하시겠습니까?")) {
				if($("#select").val() == "") {
					alert("문의 유형을 선택해주세요");
					$("#select").focus();
					return false;
				} else if($("#subject").val() == "") {
					alert("제목을 입력해주세요");
					$("#subject").focus();
					return false;
				} else if($("#textarea").val() == "") { 
					alert("내용을 입력해주세요");
					$("#textarea").focus();
					return false;
				}
				return true;
				
			} else {
				return false;
			}	
		});
	});


	$(function() {
		$("#cancel").on("click", function() {
			if(confirm("작성을 취소하시겠습니까?")) {
				location.href="adminFaq";
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
			<h1 id="h01">자주 묻는 질문 관리</h1>
			<hr>		
			<div id="admin_sub">
				<form action="adminFaqModifyPro" method="post">
					<table border="1">
						<tr>
							<th width="90px">유형</th>
							<td>
							
								<select id="select" name="cs_type_detail">
									<option value="">유형선택</option>
									<option value="예매" <c:if test="${faqDetail.cs_type_detail eq '예매'}">selected</c:if>>예매</option>
									<option value="스토어" <c:if test="${faqDetail.cs_type_detail eq '스토어'}">selected</c:if>>스토어</option>
									<option value="홈페이지" <c:if test="${faqDetail.cs_type_detail eq '홈페이지'}">selected</c:if>>홈페이지</option>
									<option value="영화관이용"  <c:if test="${faqDetail.cs_type_detail eq '영화관이용'}">selected</c:if>>영화관이용</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><input type="text" id="id" name="member_id" value="${sessionScope.sId}" readonly></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" id="subject" name="cs_subject" value="${faqDetail.cs_subject}"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea id="textarea" name="cs_content">${faqDetail.cs_content}</textarea></td>
							<input type="hidden" name="cs_type" value="${faqDetail.cs_type}">
							<input type="hidden" name="cs_type_list_num" value="${param.cs_type_list_num}">
						</tr>
					</table>
					<div id="admin_writer"> 
						<input type="submit" value="등록">
						<input type="button" value="돌아가기" id="cancel">
					</div>
				</form>
			</div>
		</section>
	</div>
</body>
</html>