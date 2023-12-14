<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/css/login.css" rel="stylesheet" type="text/css">
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
	};

</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<h1 id="h01">마이페이지</h1><%--XXX <-회원가입후 로그인된 이름 또는 아이디 출력(db데이터 가지고오기  --%>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form action="" method="" name="checkform">
				<div id="my_list">
					<h2>나의 예매내역</h2>
					<table id="my_table1">
						<tr>
							<th width="50px"><input type="checkbox" id="checkbox1"></th><th>No.</th>
							<th>영화제목</th>
							<th>영화극장 정보</th>
							<th>상태</th>
							<th>예매 내역 정보</th>
						</tr>
						<tr>
							<td><input type="checkbox" name="checkbox1"></td><td>[예매순번]</td>
							<td>[영화제목]</td>
							<td>[영화관 / 좌석번호]</td>
							<td>[예매완료]</td>
							<td><input type="button" value="예매상세정보" onclick="window.open('popup1.jsp', '_blank', 'width=500, height=400');"></td>
						</tr>
						
						<tr>
							<td><input type="checkbox" name="checkbox1"></td><td>[예매순번]</td>
							<td>[영화제목]</td>
							<td>[영화관 / 좌석번호]</td>
							<td>[예매완료]</td>
							<td><input type="button" value="예매상세정보" onclick="window.open('popup1.jsp', '_blank', 'width=500, height=400');"></td>
						</tr>
					</table><br>
								
					<div class="pagination">
						<a href="#">&laquo;</a>
						<a href="#">1</a>
						<a class="active" href="#">2</a>
						<a href="#">3</a>
						<a href="#">4</a>
						<a href="#">5</a>
						<a href="#">&raquo;</a>
					</div>
				</div>
				
				<div id="buy_list">
					<h2>상품 구매내역</h2>
					<table id="my_table1">
						<tr>
							<th width="50px"><input type="checkbox" id="checkbox2"></th><th>No.</th>
							<th>상품명</th>
							<th>구매일</th>
							<th>상태</th>
							<th>상품 구매 정보</th>
						</tr>
						<tr>
							<td><input type="checkbox" name="checkbox2"></td><td>[구매순번 최신순]</td>
							<td>[상품명]</td>
							<td>[구매일]</td>
							<td>[구매완료]</td>
							<td><input type="button" value="상품상세정보" onclick="window.open('popup2.jsp', '_blank', 'width=500, height=400');"></td>
							
						</tr>
						<tr>
							<td><input type="checkbox" name="checkbox2"></td><td>[구매순번 최신순]</td>
							<td>[상품명]</td>
							<td>[구매일]</td>
							<td>[구매완료]</td>
							<td><input type="button" value="상품상세정보" onclick="window.open('popup2.jsp', '_blank', 'width=500, height=400');"></td>
						</tr>
					</table><br>
								
						<div class="pagination">
						<a href="#">&laquo;</a>
						<a href="#">1</a>
						<a class="active" href="#">2</a>
						<a href="#">3</a>
						<a href="#">4</a>
						<a href="#">5</a>
						<a href="#">&raquo;</a>
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