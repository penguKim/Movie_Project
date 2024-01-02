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
		// 회원의 찜 정보 가져오기
		$.ajax({
			url: "likeShow", <%-- 회원별 찜 정보 가져오기 --%>
			dataType: "json",
			success: function(result) { <%-- List 타입으로 찜 데이터 응답 --%>
				for(let i = 0; i < ${fn:length(movieList)}; i++) { // <%-- 상영작 페이지의 목록만큼 반복 --%>
					let movie_id = $("#likeBtn" + i).data("id");
					for(let like of result) { <%-- 하나의 찜 데이터와 영화 코드 비교 --%>
						if(like.movie_id == movie_id) { <%-- 찜한 영화가 상영작 페이지에 있을 경우 --%>
							$("#likeBtn" + i).addClass("likeCheck");
							$("#likeBtn" + i).html("<i class='fa fa-heart'></i>찜하기");
						}
					}
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("찜정보 불러오기를 실패했습니다.\n새로고침을 해주세요.");
			}
		}); 
		
		// 정렬 방식 변경하기
		$("#sortType").on("change", function() {
			 $("form").submit();
		});
		
	}); <%-- 로그인한 회원의 찜 정보 가져오기 끝 --%>
	
	// 찜하기 버튼
	function likeBtnClick(index) { <%-- 함수를 호출하는 버튼의 인덱스를 파라미터로 사용 --%>
		$.ajax({
			url: "likeCheck", <%-- 해당 영화의 찜 정보가 DB에 있는지 판별 --%>
			data: {
				movie_id: $("#likeBtn" + index).data("id")
			},
			success: function(result) { <%-- 응답 결과가 문자열로 전송 --%>
				if(result == 'login') {
					if(confirm("로그인이 필요한 서비스입니다.\n로그인하시겠습니까?")){
						location.href = "memberLogin";
					}
				} else if(result == 'false') { <%-- 찜을 등록하는 경우 --%>
					$("#likeBtn" + index).toggleClass("likeCheck");
					$("#likeBtn" + index).html("<i class='fa fa-heart'></i>찜하기");
				} else if(result == 'true') { <%-- 찜을 삭제하는 경우 --%>
					$("#likeBtn" + index).toggleClass("likeCheck");
					$("#likeBtn" + index).html("<i class='fa fa-heart-o'></i>찜하기");
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("찜하기를 실패했습니다.");
			}
		});
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
								<button id="likeBtn${status.index}" class="likeBtn" data-id="${movie.movie_id }" data-title="${movie.movie_title }" onclick="likeBtnClick(${status.index})"><i class="fa fa-heart-o"></i>찜하기</button>
	 							<a href="movie_select?movie_title=${movie.movie_title }" class="rel_reservBtn">
									<input type="button" value="예매하기"></a>
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