<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 상품 상세 페이지</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/dailyBoxOffice.js"></script> --%>
<script type="text/javascript"> <!-- 연습 -->

</script>
<script>
$(function() {
	
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
		} else if($("#imgFile").val() == '') {
			alert("상품이미지를 입력하세요!");
			$("#imgFile").focus();
			return false;
		}
		
		return confirm("상품내용을 변경하시겠습니까?");
	});
	
}); // $(document).ready() 끝

function productDel(id) {
	if(confirm("상품을 삭제하시겠습니까")) {
		location.href="adminProductDel?product_id="+id;
	}
}

function deleteFile(product_id, product_img) {
//		alert(board_num + ", " + board_file + ", " + index); // 1, 2023/12/20/093ec3dc_daumlogo.png
	if(confirm("삭제하시겠습니까?")) {
		// 파일 삭제 작업을 AJAX 로 처리하기 - POST
		// BoardDeleteFile 서블릿 요청(파라미터 : 글번호, 파일명)
		$.ajax({
			url: "ProductDeleteFile", 
			type: "POST",
			data: {
				"product_id" : product_id,
				"product_img" : product_img
				// 전달받은 파일명을 컬럼 구별없이 검색하기 위해 board_file1 으로 지정(board_file2, board_file3 도 무관)
			},
			success: function(result) {
				console.log("파일 삭제 요청 결과 : " + result + ", " + typeof(result));
				
				// 삭제 성공/실패 여부 판별(result 값 문자열 : "true"/"false" 판별)
				if(result == "true") { // 삭제 성공 시
					// 기존 파일 다운로드 링크 요소를 제거하고
					// 파일 업로드를 위한 파일 선택 요소 표시 => html() 활용
					// => ID 선택자 "fileItemAreaX" 인 요소 지정(X 는 index 값 활용)
					// => 표시할 태그 요소 : <input type="file" name="file1" />
					//    => name 속성값도 index 값을 활용하여 각 파일마다 다른 name 값 사용
					$("#imgArea").html("이미지가 없습니다");
					$("#imgFileArea").html('<input type="file" name="imgFile" id="imgFile" class="shortInput">');
				} else if(result == "false") {
					console.log("파일 삭제 실패!");
				}
			}
		});
	}
}


</script>
<style type="text/css">
	input[type=text] {
		width: 50px;
	}
</style>
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
			<h1 id="h01">상품 상세 정보</h1>
			<hr>
			<div id="admin_main">
				<form action="adminProductModify" method="post" id="movieRegist" enctype="multipart/form-data">
					<table id="movieTable">
			            <colgroup> 
			                <col style="width: 20%;">
			                <col style="width: 20%;">   
			                <col style="width: 20%;"> 
			                <col style="width: 40%;">   
			            </colgroup> 
						<tr>
							<td rowspan="5" colspan="2" id="imgArea">
								<c:choose>
									<c:when test="${not empty product.product_img }">
										<img src="${pageContext.request.contextPath }/resources/upload/${product.product_img }" alt="상품이미지" width="310" height="250">
									</c:when>
									<c:otherwise>
										이미지가 없습니다
									</c:otherwise>
								</c:choose>
							</td>
							<!-- 상품 코드 수정 불가 -->
							<th width="100px">상품코드</th>
							<td><input type="text" name="product_id" id="product_id" class="shortInput" value="${product.product_id }" readonly ></td>
						</tr>
						<tr>
							<th width="100px">상품이름</th>
							<td><input type="text" name="product_name" id="product_name" class="shortInput" value="${product.product_name }"></td>
						</tr>
						<tr>
							<th width="100px">상품설명</th>
							<td><input type="text" name="product_txt" id="product_txt" class="shortInput" value="${product.product_txt }"></td>
						</tr>
						<tr>
							<th>상품가격</th>
							<td ><input type="text" name="product_price" id="product_price" class="shortInput" value="${product.product_price }" >원</td>
							
						</tr>
						<tr>
							<th><label for="product_img">이미지 첨부 파일</label></th>
							<td>
								<div class="file" id="imgFileArea">
									<c:choose>
										<c:when test="${not empty product.product_img}">
											<c:set var="original_img_name" value="${fn:substringAfter(product.product_img, '_')}"/>
											${original_img_name}
											<a href="javascript:deleteFile('${product.product_id }','${product.product_img}', 1)">
												<img src="${pageContext.request.contextPath }/resources/img/선택불가.png" class="img_btnDelete" width="20" height="20">
											</a>
										</c:when>
										<c:otherwise>
											<input type="file" name="imgFile" id="imgFile" class="shortInput">
										</c:otherwise>
									</c:choose>
								</div>
							</td>
						</tr>
					</table>
					<input type="submit" value="변경" id="regist">
					<input type="button" value="삭제" onclick="productDel('${product.product_id}')">
					<input type="button" value="뒤로가기" onclick="history.back();">
				</form>
			</div>
		</section>
	</div>
</body>
</html>