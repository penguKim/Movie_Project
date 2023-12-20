<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영일정수정</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">상영일정수정</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">

				<table border="1">
					<tr>
						<th>지점명</th>
						<th>상영관명</th>
						<th>영화제목</th>
						<th>상영날짜</th>
						<th>상영시작시간</th>
						<th>상영종료시간</th>
						<th></th>
					</tr>
					<tr>
						<td>
							<select>
								<option>서면점</option>
							</select>
						</td>
						<td>
							<select>
								<option>1관</option>
							</select>
						</td>
						<td>
							<select>
								<option>서울의봄</option>
							</select>
						</td>
						<td>
							<input type="date">
						</td>
						<td>
							<select>
								<option>09:00</option>
							</select>
						</td>
						<td>
							<input type="text" readonly>
						</td>

						<td>
							<input type="button" value="등록">
						</td>
					</tr>
				</table>
				<br>
				<table border="1">
					<tr>
						<th>지점명</th>
						<th>상영관명</th>
						<th>영화제목</th>
						<th>상영날짜</th>
						<th>상영시작시간</th>
						<th>상영종료시간</th>
						<th></th>
					</tr>
					<tr>
						<td>서면점</td>
						<td>1관</td>
						<td>서울의 봄</td>
						<td>2023/12/21</td>
						<td>12:30</td>
						<td>14:10</td>
						<td>
							<input type="button" value="수정">
							<input type="button" value="삭제">
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