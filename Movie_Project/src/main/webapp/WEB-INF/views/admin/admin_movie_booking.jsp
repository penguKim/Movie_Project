<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 예매 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">영화 예매 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			
			<div id="admin_main">
				<form action="" class ="admin_movie_booking">
					<table border="1" id="admin_table">
						<tr>
							<th>결제번호</th>
							<th>영화명</th>
							<th>회원ID</th>
							<th>영화관명</th>
							<th>날짜</th>
							<th>좌석</th>
							<th>회원정보</th>
							<th>수정/삭제</th>
						</tr>
						<tr>
							<td>13251245</td>
							<td>A영화</td>
							<td>coming</td>
							<td>지점명A</td>
							<td>2023-01-01</td>
							<td>A3, B4</td>
							<td>비정상인사람</td>
							<td><input type="button" value="MORE" 
							onclick = "window.open('admin_movie_booking_modify.jsp', '_blank', 'width=800, height=800,left=550,top=100' ); return false;"></td>
						</tr>
						<tr>
							<td>13251245</td>
							<td>A영화</td>
							<td>coming</td>
							<td>지점명B</td>
							<td>2023</td>
							<td>01:01</td>
							<td>2023-06-06</td>
							<td><input type="button" value="MORE" 
							onclick = "window.open('admin_movie_booking_modify.jsp', '_blank', 'width=800, height=800,left=550,top=100' ); return false;"></td>
						</tr>
						<tr>
							<td>13251245</td>
							<td>A영화</td>
							<td>coming</td>
							<td>지점명C</td>
							<td>2023</td>
							<td>01:01</td>
							<td>2023-06-06</td>
							<td><input type="button" value="MORE" 
							onclick = "window.open('admin_movie_booking_modify.jsp', '_blank', 'width=800, height=800,left=550,top=100' ); return false;"></td>
						</tr>
						<tr>
							<td>13251245</td>
							<td>A영화</td>
							<td>coming</td>
							<td>지점명D</td>
							<td>2023</td>
							<td>01:01</td>
							<td>2023-06-06</td>
							<td><input type="button" value="MORE" 
							onclick = "window.open('admin_movie_booking_modify.jsp', '_blank', 'width=800, height=800,left=550,top=100' ); return false;"></td>
						</tr>
						<tr>
							<td>13251245</td>
							<td>A영화</td>
							<td>coming</td>
							<td>지점명E</td>
							<td>2023</td>
							<td>01:01</td>
							<td>2023-06-06</td>
							<td><input type="button" value="MORE" 
							onclick = "window.open('admin_movie_booking_modify.jsp', '_blank', 'width=800, height=800,left=550,top=100' ); return false;"></td>
						</tr>
						<tr>
							<td>13251245</td>
							<td>A영화</td>
							<td>coming</td>
							<td>지점명F</td>
							<td>2023</td>
							<td>01:01</td>
							<td>2023-06-06</td>
							<td><input type="button" value="MORE" 
							onclick = "window.open('admin_movie_booking_modify.jsp', '_blank', 'width=800, height=800,left=550,top=100' ); return false;"></td>
						</tr>
						<tr>
							<td>13251245</td>
							<td>A영화</td>
							<td>coming</td>
							<td>지점명G</td>
							<td>2023</td>
							<td>01:01</td>
							<td>2023-06-06</td>
							<td><input type="button" value="MORE" 
							onclick = "window.open('admin_movie_booking_modify.jsp', '_blank', 'width=800, height=800,left=550,top=100' ); return false;"></td>
						</tr>
					</table>
					<div class="pagination">
						<a href="#">&laquo;</a>
						<a href="#">1</a>
						<a class="active" href="#">2</a>
						<a href="#">3</a>
						<a href="#">4</a>
						<a href="#">5</a>
						<a href="#">&raquo;</a>
					</div>
				</form>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>
