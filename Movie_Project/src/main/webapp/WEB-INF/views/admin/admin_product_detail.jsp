<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 상품 상세 페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/dailyBoxOffice.js"></script> --%>
<script type="text/javascript"> <!-- 연습 -->

</script>
<script>
$(function() {
	alert($("#product_img").val());
	// submit 시 수행할 동작
	$("form").on("submit", function() {
		if($("#product_name").val() == '') {
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
		} else if($("#product_img").val() == '') {
			alert("상품이미지를 입력하세요!");
			$("#product_img").focus();
			return false;
		}
		
		return confirm("상품내용을 변경하시겠습니까?");
	});
	
}); // $(document).ready() 끝

function productDel(id) {
	if(confirm("상품을 삭제하시겠습니까")) {
		location.href="adminProductDel?product_id=" + id
	}
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
	<h1 id="h01">상품 상세 정보</h1>
	<hr>
	<div id="admin_nav">
		<jsp:include page="admin_menubar.jsp"></jsp:include>
	</div>
	<div id="admin_main">
			<form action="adminProductUpd" method="post" id="movieRegist">
				<table id="movieTable">
		            <colgroup> 
		                <col style="width: 20%;">
		                <col style="width: 20%;">   
		                <col style="width: 20%;"> 
		                <col style="width: 40%;">   
		            </colgroup> 
					<tr>
						<td rowspan="5" colspan="2" id="posterArea">
							<img src="${product[0].product_img }" id=""><br>
						</td>
						<!-- 상품 코드 수정 불가 -->
						<th width="100px">상품코드</th>
						<td><input type="text" name="product_id" id="product_id" class="shortInput" value="${product[0].product_id }" readonly ></td>
					</tr>
					<tr>
						<th width="100px">상품이름</th>
						<td><input type="text" name="product_name" id="product_name" class="shortInput" value="${product[0].product_name }"></td>
					</tr>
					<tr>
						<th width="100px">상품설명</th>
						<td><input type="text" name="product_txt" id="product_txt" class="shortInput" value="${product[0].product_txt }"></td>
					</tr>
					<tr>
						<th>상품가격</th>
						<td ><input type="text" name="product_price" id="product_price" class="shortInput" value="${product[0].product_price }원"></td>
					</tr>
					<tr>
						<th>이미지 파일 첨부</th>
						<td><input type="file" name="imgFile" id="product_img" class="shortInput"></td>
					</tr>
				</table>
				<input type="submit" value="변경" id="regist">
				<input type="button" value="삭제" onclick="productDel('${product[0].product_id}')">
				<input type="button" value="뒤로가기" onclick="history.back();">
			</form>
	</div>
	</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>