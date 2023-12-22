<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환불내역</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.7.1.js"></script>
<script type="text/javascript">
window.onload = function() {//페이지 로딩이 끝난뒤 함수 실행
		document.querySelector("#checkbox3").onclick = function() { // id가 checkbox1 클릭시 실행할 함수

			for(let i = 0; i < document.checkform.checkbox3.length; i++) { 
				document.checkform.checkbox3[i].checked = document.querySelector("#checkbox3").checked;
			}
		}
	};
		//checkbox 체크박스를 클릭할 때 전체선택기능. checkform 폼 안에 있는 모든 checkbox1 체크박스)

</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
							
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
			
		<section id="content">
			<h1 id="h01">환불내역</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
						

			<!-- 바디부분 상단 -->
			<form action="" method="" name="checkform">
				<div id="refund_list">
					<h2>예매 취소내역</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>영화 제목</th>
							<th>내용</th>
							<th>상태</th>
						</tr>
						<tr>
							<td>[예매취소순번]</td>
							<td>[영화제목]</td>
							<td>[예매취소일]</td>
							<td>[환불완료]</td>
						</tr>
						<tr>
							<td>[예매취소순번]</td>
							<td>[영화제목]</td>
							<td>[예매취소일]</td>
							<td>[환불완료]</td>
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
				
				<div id="refund_info">
					<h2>환불 안내서</h2>
					<table id="my_table1">
						<tr>
							<td>인터넷 예매시에는 예매매수의 전체환불 및 교환만 가능합니다. 
								인터넷 예매분에 대해 교환환불 및 취소하고자 하실 경우,
								예매하신 내역 전체에 대해 취소 후
								새로 예매를 하시거나 해당 영화관을 방문하셔서 처리하셔야 합니다. 
								
								1) 인터넷상 취소 가능시간 (상영시간 20분전까지만 가능) 
								 - 전체 취소가능하며, 부분 취소 불가
								 EX) 인원수, 관람자, 시간변경은 모두 취소 후 재예매 해주셔야합니다.
								
								2) 현장 취소 가능시간(상영시간 전까지만 가능) 
								  - 전체환불 및 교환가능 단, 부분환불 및 교환은 사용하신 카드로 전체 취소 후 재결제하셔야 합니다.
							</td>
						</tr>
					</table>
				</div>
			</form>
		</section>
	</div>
		
	<footer>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</footer>
	
<!-- 바디부분 상단 끝 -->
</body>
</html>