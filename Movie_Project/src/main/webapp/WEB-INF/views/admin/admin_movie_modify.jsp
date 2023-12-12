<%-- admin_movie_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 수정 팝업</title>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
</head>
<body>
	<form action="">
		<div id="grayDiv">
			<select>
				<option>A영화</option>
				<option>B영화</option>
				<option>C영화</option>
				<option>D영화</option>
				<option>E영화</option>
				<option>F영화</option>
			</select>
			<input type="button" value="조회"><br><br>
			<img src="${pageContext.request.contextPath}/resources/img/cobweb.jpg" width="250" height="400"><br>
			<input type="file"><br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화코드</sup><br>
				&nbsp;&nbsp;<input type="text" value="19930516">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화제목</sup><br>
				&nbsp;&nbsp;<input type="text" value="거미집">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>제작년도</sup><br>
				&nbsp;&nbsp;<input type="text" value="2023-11-16">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영시간</sup><br>
				&nbsp;&nbsp;<input type="text" value="04:23">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람등급</sup><br>
				&nbsp;&nbsp;<input type="text" value="전체관람가">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>장르</sup><br>
				&nbsp;&nbsp;<input type="text" value="스릴러">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>상영일</sup><br>
				&nbsp;&nbsp;<input type="date" value="2024-05-16">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>종영일</sup><br>
				&nbsp;&nbsp;<input type="date" value="2099-12-30">
			</div>
			<br><br>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>줄거리</sup><br>
				&nbsp;&nbsp;<input type="text" value="줄거리란입니다">
			</div>
				<br><br>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>상영상태</sup><br>
				&nbsp;&nbsp;<input type="text" value="상영중">
			</div>
			<br>
			<input type="submit" value="수정" onclick="confirm('수정하시겠습니까?')">
			<input type="submit" value="창닫기" onclick="window.close()">
		</div>
	</form>
</body>
</html>