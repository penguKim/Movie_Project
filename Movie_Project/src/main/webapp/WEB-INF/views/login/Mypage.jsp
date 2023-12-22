<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.7.1.js"></script>
<script type="text/javascript">
window.onload = function() {//페이지 로딩이 끝난뒤 함수 실행
		document.querySelector("#checkbox1").onclick = function() { // id가 checkbox1 클릭시 실행할 함수

			for(let i = 0; i < document.checkform.checkbox1.length; i++) { 
				document.checkform.checkbox1[i].checked = document.querySelector("#checkbox1").checked;
			}
		}
		//checkbox 체크박스를 클릭할 때 전체선택기능. checkform 폼 안에 있는 모든 checkbox1 체크박스)
		
		
		document.querySelector("#checkbox2").onclick = function() {

			for(let i = 0; i < document.checkform.checkbox2.length; i++) {
				document.checkform.checkbox2[i].checked = document.querySelector("#checkbox2").checked;
			}
		}
	}; //window.onload 이벤트끝

</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<h1 id="h01">마이페이지</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
<!-- 			<form action="Mypage" method="get" name="checkform"> -->
			<div class="mapage_table">
				<div id="my_list">
					<h2>나의 예매내역</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>영화제목</th>
							<th>영화극장 정보</th>
							<th>상태</th>
						</tr>
						
						<tr>
							<td>[예매순번]</td>
							<td>[영화제목]</td>
							<td>[영화관 / 좌석번호]</td>
							<td>[예매완료]</td>
						</tr>
						
						<tr>
							<td>[예매순번]</td>
							<td>[영화제목]</td>
							<td>[영화관 / 좌석번호]</td>
							<td>[예매완료]</td>
						</tr>
					</table><br>
								
				</div>
				
				<div id="buy_list">
					<h2>상품 구매내역</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>상품명</th>
							<th>구매일</th>
							<th>상태</th>
						</tr>
						<tr>
							<td>[구매순번 최신순]</td>
							<td>[상품명]</td>
							<td>[구매일]</td>
							<td>[구매완료]</td>
							
						</tr>
						<tr>
							<td>[구매순번 최신순]</td>
							<td>[상품명]</td>
							<td>[구매일]</td>
							<td>[구매완료]</td>
						</tr>
					</table><br>
				</div>
			</div>
<!-- 			</form> -->
			
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
	
</body>
</html>