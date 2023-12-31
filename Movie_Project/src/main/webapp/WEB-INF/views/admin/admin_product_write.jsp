<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 상품 등록</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/dailyBoxOffice.js"></script> --%>
<script type="text/javascript"> <!-- 연습 -->

</script>
<script>
$(function() {
	let isDuplicateMovie = false;
	$("#product_id").on("change", function() {
		alert($("#product_id").val());
		
		$.ajax({
			type:"GET",
			url:"productDupl",
			data: {
				product_id: $("#product_id").val()
			},
			success: function(result) {
				// 중복 결과를 "true", "false" 문자열로 반환
				if(result == 'true') {
					alert("이미 등록된 상품입니다!");
					isDuplicateMovie = true;
					$("#product_id").focus();
				} else {
					isDuplicateMovie = false;
				}
			},
			error: function() {
				alert("실패");
			}
		});
	});
	
	// submit 시 수행할 동작
	$("form").on("submit", function() {
		if(isDuplicateMovie) { // 등록된 영화인지 판별
			alert("이미 등록된 상품입니다!");
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
		} else if($("#product_price").val() == '') {
			alert("상품가격을 입력하세요!");
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
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
	<section id="content">
	<h1 id="h01">상품 등록</h1>
	<hr>
	<div id="admin_nav">
		<jsp:include page="admin_menubar.jsp"></jsp:include>
	</div>
	<div id="admin_main">
			<form action="adminProductInsert" method="post" id="movieRegist" enctype="multipart/form-data">
				<table id="movieTable">
		            <colgroup> 
		                <col style="width: 20%;">
		                <col style="width: 20%;">   
		                <col style="width: 20%;"> 
		                <col style="width: 40%;">   
		            </colgroup> 
					<tr>
						<td rowspan="5" colspan="2" id="posterArea">
							<img src="" id="posterThumnail"><br>
						</td>
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
						<td ><input type="file" name="imgFile" id="imgFile" class="shortInput"></td>
					</tr>
				</table>
				<input type="submit" value="등록" id="regist">
				<input type="button" value="창닫기" onclick="history.back();">
			</form>
	</div>
	</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>