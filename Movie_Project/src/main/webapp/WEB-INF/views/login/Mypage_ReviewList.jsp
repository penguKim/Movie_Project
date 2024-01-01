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
$(document).ready(function(){
	var member_id = "<%= session.getAttribute("sId") %>";
    	
	$("#submitReview").click(function(){
//     if(member_id != "null" && currentDateTime > play_data && currentDateTime > play_endTime){
//			var play_data = reviewr1.play_data; // 영화상영일
//	        var play_endTime = reviewr1.play_end_time; // 영화끝나는시간
			var review_content = $("#review_content").val(); // 'review_content'라는 id를 가진 요소의 값을 가져옴
			var movie_id = ${param.movie_id};
			var formattedTime = year + '-' + // 현재 연도
				month + '-' + // 현재 월
				date + ' ' + // 현재 일
				hours + ':' + // 현재 시간
				minutes; // 현재 분
    
//				alert(movie_id);
				console.log(member_id);
		$.ajax({
			url: "reviewPro", // 요청을 보낼 URL
			type: "POST",
			data: {
				review_content : review_content,
				member_id : member_id,
				movie_id : movie_id
			},
			
			datatype: "json",
			success: function(data) { // 요청 성공
				$("#review_no").append(
					"<tr>"	
					+ "<td>" + member_id + "</td>"	
					+ "<td>" + review_content + "</td>"	
					+ "<td>" + formattedTime  + "</td>"	
					+ "</tr>"	
				);
				console.log("성공");
			},
			error: function(request, status, error) { // 요청 실패
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
// }else{ // 실패시 
// alert("로그인 후 작성이 가능합니다");
// location.href = "memberLogin";
// } //if
	}); //click 이벤트 끝
});

$(function() {
	$("#reviewDelete").on("click", function() {
		if(confirm("글을 삭제하시겠습니까?")) {
			return true;
		} else {
			return false;
		}
	}); //on click 끝
	
}); //function 끝
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<h1 id="h01">나의 리뷰 게시판</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form action="reviewDelete" method="get">
				<div id="my_list">
					<h2>나의 리뷰</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>제목</th>
							<th>내용</th>
							<th>등록일</th>
							<th>게시글 삭제</th>
						</tr>
						
						<c:forEach var="review" items="${myreview}" varStatus="status">
						<tr>
							<td>${status.index + 1}</td>
							<td>${review.movie_title}</td>
							<td>${review.review_content}</td>
							<td>${review.review_date}</td>
							<td><input type="submit" id="reviewDelete" value="삭제"></td>
						</tr>
						</c:forEach>
					</table><br>
								
				</div>
							
			</form>
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
	
</body>
</html>