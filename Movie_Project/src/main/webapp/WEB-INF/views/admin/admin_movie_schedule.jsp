<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영일정관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function btnRgst() {
		var result = confirm("상영일정을 등록하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	function btnMod() {
		var result = confirm("상영일정을 수정하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	
	function btnDlt() {
		var result = confirm("상영일정을 삭제하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	
	function btnLookup() {
		location.reload();
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
			<h1 id="h01">상영일정관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<form action="" class="schedule">
					<div id="schedule_search">
						<select id="select">
							<option>A지점</option>
							<option>B지점</option>
							<option>C지점</option>
							<option>D지점</option>
						</select>
						<label id="lbl">상영날짜</label><input type="date">
						<input type="button" value="조회" onclick="btnLookup()">&nbsp;&nbsp;&nbsp;
						<label id="lbl">휴게시간(분)</label><input type="text">
					</div>
				</form>
					
				<table border="1" width="1000" height="500">
					<tr>
						<th width="100">상영관명</th>
						<th>1회차</th>
						<th>2회차</th>
						<th>3회차</th>
						<th>4회차</th>
						<th>관리</th>
					</tr>
					<tr>
						<td>
							A관<br>
							<select>
								<option>영화1</option>
								<option>영화2</option>
								<option>영화3</option>
								<option>영화4</option>
							</select>
						</td>
						<td>
							상영번호 : <br>
							690<br>
							상영기간 : <br>
							2023.11.22 ~ 2023.11.25<br><br>
							상영시간 : <br>
							18:22:00 ~ 00:00:00<br><br>
							러닝타임 : <br>
							180분<br><br>
							영화명 : <br>
							A영화
						</td>
						<td>
							상영번호 : <br>
							690<br>
							상영기간 : <br>
							2023.11.22 ~ 2023.11.25<br><br>
							상영시간 : <br>
							18:22:00 ~ 00:00:00<br><br>
							러닝타임 : <br>
							180분<br><br>
							영화명 : <br>
							A영화
						</td>
						<td>
							상영번호 : <br>
							690<br>
							상영기간 : <br>
							2023.11.22 ~ 2023.11.25<br><br>
							상영시간 : <br>
							18:22:00 ~ 00:00:00<br><br>
							러닝타임 : <br>
							180분<br><br>
							영화명 : <br>
							A영화
						</td>
						<td>
							상영번호 : <br>
							690<br>
							상영기간 : <br>
							2023.11.22 ~ 2023.11.25<br><br>
							상영시간 : <br>
							18:22:00 ~ 00:00:00<br><br>
							러닝타임 : <br>
							180분<br><br>
							영화명 : <br>
							A영화
						</td>
						<td>
							<input type="button" value="등록" onclick="btnRgst()"><br><br><br>
							<input type="button" value="수정" onclick="btnMod()" ><br><br><br>
							<input type="button" value="삭제" onclick="btnDlt()">
						</td>
					</tr>
					<tr>
						<td>
							A관<br>
							<select>
								<option>영화1</option>
								<option>영화2</option>
								<option>영화3</option>
								<option>영화4</option>
							</select>
						</td>
						<td>
							상영정보 없음
						</td>
						<td>
							미등록<br>
							상영번호 : <br>
							690<br>
							상영기간 : <br>
							2023.11.22 ~ 2023.11.25<br><br>
							상영시간 : <br>
							18:22:00 ~ 00:00:00<br><br>
							러닝타임 : <br>
							180분<br><br>
							영화명 : <br>
							A영화
						</td>
						<td>
							상영정보 없음
						</td>
						<td>
							상영정보 없음
						</td>
						<td>
							<input type="button" value="등록"><br><br><br>
							<input type="button" value="수정"><br><br><br>
							<input type="button" value="삭제" onclick="btnDlt()">
						</td>
					</tr>
				</table>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>