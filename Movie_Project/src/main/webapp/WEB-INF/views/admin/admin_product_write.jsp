<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 상품 등록</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
$(function() {
	let isDuplicateProudct = false;
	$("#product_id").on("change", function() {
		$.ajax({
			type:"GET",
			url:"productDupl",
			data: {
				product_id: $("#product_id").val()
			},
			success: function(result) {
				// 중복 결과를 "true", "false" 문자열로 반환
				if(result == 'true') {
					alert("이미 등록된 상품번호입니다!");
					isDuplicateProudct = true;
					$("#product_id").focus();
				} else {
					isDuplicateProudct = false;
				}
			},
			error: function() {
				alert("실패");
			}
		});
	});
	
	
	// submit 시 수행할 동작
	$("form").on("submit", function() {
		
		var price = $("#product_price").val();
		var regex = /^[0-9]+$/;

		
		if(isDuplicateProudct) { // 등록된 상품 아이디인지 판별
			alert("이미 등록된 상품번호입니다!");
			return false;
		} else if($("#product_id").val() == '') {
			alert("상품코드를 입력하세요!");
			$("#product_id").focus();
			return false;
		} else if($("#product_name").val() == '') {
			alert("상품 이름을 입력하세요!");
			$("#product_name").focus();
			return false;
		} else if($("#product_txt").val() == '') {
			alert("상품설명을 입력하세요!");
			$("#product_txt").focus();
			return false;
		} else if(price == '') {
			alert("상품가격을 입력하세요!");
			$("#product_price").focus();
			return false;
		} else if (!regex.test(price)) {
			alert("상품가격은 숫자만 입력이 가능합니다");
			$("#product_price").focus();
			return false;
		 } else if($("#imgFile").val() == '') {
			alert("상품이미지를 입력하세요!");
			$("#imgFile").focus();
			return false;
		}
		
		return confirm("상품을 추가하시겠습니까?");
	});
	
}); // $(document).ready() 끝
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
			<h1 id="h01">상품 등록</h1>
			<hr>
			<div id="admin_main">
					<form action="adminProductInsert" method="post" id="movieRegist" enctype="multipart/form-data">
						<table id="movieTable">
							<tr>
								<th width="100px">상품코드</th>
								<td><input type="text" name="product_id" id="product_id" class="shortInput"></td>
							</tr>
							<tr>
								<th width="100px">상품이름</th>
								<td><input type="text" name="product_name" id="product_name" class="shortInput"></td>
							</tr>
							<tr>
								<th width="100px">상품설명</th>
								<td><input type="text" name="product_txt" id="product_txt" class="shortInput"></td>
							</tr>
							<tr>
								<th>상품가격</th>
								<td ><input type="text" name="product_price" id="product_price" class="shortInput"></td>
							</tr>
							<tr>
								<th>이미지 파일 첨부</th>
								<td ><input type="file" name="imgFile" id="imgFile" class="shortInput" accept=".gif, .jpg, .png"></td>
							</tr>
						</table>
					<input type="submit" value="등록" id="regist">
					<input type="button" value="창닫기" onclick="history.back();">
				</form>
			</div>
		</section>
	</div>
</body>
</html>