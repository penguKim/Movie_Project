<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>현재상영작</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/movie.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		var sId = "<%= session.getAttribute("sId") %>";  
		if(sId != "null") {
			$.ajax({
				url: "likeShow",
				data: {
					member_id: sId
				},
				dataType: "json",
				success: function(result) {
					if(result.length != 0){
						for(let i = 0; i < ${fn:length(movieList)}; i++) {
							let movie_id = $("#likeBtn" + i).data("id");
							for(let like of result) {
								if(like.movie_id == movie_id) {
									console.log(i);
									$("#likeBtn" + i).addClass("likeCheck");
									$("#likeBtn" + i).html("<i class='fa fa-heart'></i>좋아요");
								}
							}
						}
					} else {
						console.log("좋아요 없음");
					}
				},
				error: function(xhr, textStatus, errorThrown) {
// 					alert("현재 상영작 불러오기를 실패했습니다.\n새로고침을 해주세요.");
				}
			});
			
			$("#sortType").on("change", function() {
				 $("form").submit();
			});
			
		}
		
	});
	
	function likeBtnClick(like, index) {
		var sId = "<%= session.getAttribute("sId") %>";
		if(sId != "null") {
			console.log($("#likeBtn" + index).data("id") + ", " + $("#likeBtn" + index).data("title"));
			console.log(sId);
			$.ajax({
				url: "likeCheck",
				data: {
					member_id: sId,
					movie_id: $("#likeBtn" + index).data("id")
				},
				success: function(like) {
					if(like == 'true') {
						$("#likeBtn" + index).toggleClass("likeCheck");
						$("#likeBtn" + index).html("<i class='fa fa-heart'></i>좋아요");
					} else if(like == 'false') {
						$("#likeBtn" + index).toggleClass("likeCheck");
						$("#likeBtn" + index).html("<i class='fa fa-heart-o'></i>좋아요");
					}
				},
				error: function(xhr, textStatus, errorThrown) {
					alert("찜하기를 실패했습니다.");
				}
			});
		} else {
			if(confirm("로그인이 필요한서비스입니다. 로그인하시겠습니까?")){
				location.href = "memberLogin";
			}
		}
		
	}
	
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
						
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">현재상영작</h1>
			<hr>
			<nav class="movie-menu">
				<ul>
					<li class="active"><a href="release">
						<input type="button" value="현재상영작"></a></li>
					<li><a href="comming">
						<input type="button" value="상영예정작"></a></li>
				</ul>
			</nav>
			<section class="movie-section">
				<div class="sort-menu">
					<form action="release">
						<select name="sortType" id="sortType">
							<option value="1" <c:if test="${param.sortType eq '1' }">selected</c:if>>개봉일순</option>
							<option value="2" <c:if test="${param.sortType eq '2' }">selected</c:if>>가나다순</option>
							<option value="3" <c:if test="${param.sortType eq '3' }">selected</c:if>>관객수순</option>
						</select>
					</form>
				</div>
				<div class="container">
					<div class="movie-grid">
					<c:forEach var="movie" items="${movieList}" varStatus="status">
						<div class="movie">
							<a href="detail?movie_id=${movie.movie_id}">
							<c:choose>
								<c:when test="${movie.movie_rating eq '12세' }">
									<b class="movie-rating age12">12</b>
								</c:when>
								<c:when test="${movie.movie_rating eq '15세' }">
									<b class="movie-rating age15">15</b>
								</c:when>
								<c:when test="${movie.movie_rating eq '18세' }">
									<b class="movie-rating age18">18</b>
								</c:when>
								<c:when test="${movie.movie_rating eq '전체' }">
									<b class="movie-rating ageAll">ALL</b>
								</c:when>
							</c:choose>
							<div class="movie-poster">
								<div class="poster">
									<img alt="" src="${movie.movie_poster }">
								</div>
								<div>
									<p class="title">${movie.movie_title }</p>
								</div>
							</div>
								<p class="date">
									<fmt:formatDate value="${movie.movie_release_date }" pattern="yyyy.MM.dd"/>
									<span class="release-type">개봉</span>
								</p>
							</a>
<!-- 							<div id=""> -->
<!-- 							</div> -->
							<div class="reserve_area">
								<button id="likeBtn${status.index}" class="likeBtn" data-id="${movie.movie_id }" data-title="${movie.movie_title }" onclick="likeBtnClick(this, ${status.index})"><i class="fa fa-heart-o"></i>좋아요</button>
	 							<a href="movie_select?movie_id=${movie.movie_id }" class="rel_reservBtn">
									<input type="button" value="예매하기"
								></a>
							</div>
						</div>
					</c:forEach>
					</div>
				</div>
			</section>
		</section>
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>