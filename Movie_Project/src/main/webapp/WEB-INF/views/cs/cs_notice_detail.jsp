<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/cs.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">공지사항</h1>
			<hr>
			<div id="cs_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="cs_menubar.jsp"></jsp:include>
			</div>
			
			<div id="notice_content">
				<table id="notice_table">
					<tr>
						<th colspan="4">[주제] 제목</th>
					</tr>
					<tr>
						<td class="notice_info">영화관</td>
						<td class="notice_info">전체</td>
						<td class="notice_info">등록일</td>
						<td class="notice_info">등록날짜</td>
					</tr>
					<tr>
						<td colspan="4"  class="notice_content">내용<br><br><br><br><br><br><br></td>
					</tr>
					<tr>
						<td>이전  ▲</td>
						<td colspan="3">링크</td>
					</tr>
					<tr>
						<td>다음  ▼</td>
						<td colspan="3">링크</td>
					</tr>
				</table>
				<div id="button"><a href="cs_notice.jsp"><input type="button" value="목록"></a></div>
			</div>
		</section>
		
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>