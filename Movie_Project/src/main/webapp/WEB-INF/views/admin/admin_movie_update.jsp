<%-- admin_movie_update.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 등록 팝업</title>
<link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet" type="text/css">
</head>
<style>
input[type="text"], input[type="date"]{
font-size: 20px;}
</style>
<body>
	<form action="" class="admin_movie_update">
		<div id="divCtr">
			<select>
				<option>아이유의 기묘한모험</option>
				<option>B영화</option>
				<option>C영화</option>
				<option>D영화</option>
				<option>E영화</option>
				<option>F영화</option>
			</select>
			<input type="button" value="조회"><br><br>
			<img src="iu2.jpg" width="250" height="400"><br>
			<input type="file"><br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화코드</sup><br>
				&nbsp;&nbsp;<input type="text" value="19930516">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화제목</sup><br>
				&nbsp;&nbsp;<input type="text" value="아이유콘서트">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>영화감독</sup><br>
				&nbsp;&nbsp;<input type="text" value="벙준호">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>출연진</sup><br>
				&nbsp;&nbsp;<input type="text" value="아이유">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>장르</sup><br>
				&nbsp;&nbsp;<input type="text" value="15세 로맨스">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>관람객수</sup><br>
				&nbsp;&nbsp;<input type="text" value="1000만명">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>러닝타임</sup><br>
				&nbsp;&nbsp;<input type="text" value="4시간">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>심의등급</sup><br>
				&nbsp;&nbsp;<input type="text" value="15세">
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
				&nbsp;&nbsp;<input type="text" value="로맨스">
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
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷1</sup><br>
				&nbsp;&nbsp;<input type="file">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷2</sup><br>
				&nbsp;&nbsp;<input type="file">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>스틸컷3</sup><br>
				&nbsp;&nbsp;<input type="file">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>예고영상</sup><br>
				&nbsp;&nbsp;<input type="file">
			</div>
			<br><br>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>줄거리</sup><br>
				&nbsp;&nbsp;<input type="text" value="아이유짱짱짱짱짱짱">
			</div>
				<br><br>
			<div id="grayBlockWide">
				&nbsp;&nbsp;<sup>상영상태</sup><br>
				&nbsp;&nbsp;<input type="text" value="아이유짱짱짱짱짱짱">
			</div>
			<br><br>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>검색할 영화 제목</sup><br>
				&nbsp;&nbsp;<input type="text" placeholder="검색할영화">
			</div>
			<div id="grayBlock">
				&nbsp;&nbsp;<sup>조회 연도</sup><br>
				&nbsp;&nbsp;<input type="text" value="2002">
			</div>
			<br><br>
			<br>	
			<input type="submit" value="등록" onclick="confirm('등록하시겠습니까?')">
			<input type="submit" value="창닫기" onclick="window.close()">
		</div>
	</form>
</body>
</html>