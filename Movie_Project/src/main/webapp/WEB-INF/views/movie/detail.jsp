<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화정보</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/movie.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
$(function() {
	var sId = "<%= session.getAttribute("sId") %>";  
	if(sId != "null") { <%-- 로그인한 회원인지 판별 --%>
		$.ajax({
			url: "likeShow", <%-- 회원별 찜 정보 가져오기 --%>
			data: {
				member_id: sId
			},
			dataType: "json",
			success: function(result) {
				if(result.length != 0){ <%-- 찜 정보가 있을 경우 --%>
					for(let like of result) {
						if(like.movie_id == ${movie_id}) { <%-- 찜한 영화가 상영작 페이지에 있을 경우 --%>
							$("#likeBtn").addClass("likeCheck");
							$("#likeBtn").html("<i class='fa fa-heart'></i>찜하기");
						}
					}
				} else {
					console.log("찜한 영화 없음");
				}
			},
			error: function(xhr, textStatus, errorThrown) {
//					alert("현재 상영작 불러오기를 실패했습니다.\n새로고침을 해주세요.");
			}
		});
	}
}); <%-- 로그인한 회원의 찜 정보 가져오기 끝 --%>

// 찜하기 버튼
function likeBtnClick(like) { <%-- 함수를 호출하는 버튼의 인덱스를 파라미터로 사용 --%>
	var sId = "<%= session.getAttribute("sId") %>";
	if(sId != "null") { <%-- 로그인한 회원인지 판별 --%>
		console.log("${movie_id}");
		console.log(sId);
		$.ajax({
			url: "likeCheck", <%-- 해당 영화의 찜 정보가 DB에 있는지 판별 --%>
			data: {
				member_id: sId,
				movie_id: ${movie_id}
			},
			success: function(like) {
				if(like == 'true') { <%-- 찜을 등록하는 경우 --%>
					$("#likeBtn").toggleClass("likeCheck");
					$("#likeBtn").html("<i class='fa fa-heart'></i>찜하기");
				} else if(like == 'false') { <%-- 찜을 삭제하는 경우 --%>
					$("#likeBtn").toggleClass("likeCheck");
					$("#likeBtn").html("<i class='fa fa-heart-o'></i>찜하기");
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("찜하기를 실패했습니다.");
			}
		});
	} else {
		if(confirm("로그인이 필요한 서비스입니다.\n로그인하시겠습니까?")){
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
			<h1 id="h01">영화정보</h1>
			
			<hr>
			<section class="detail_container">
				<!-- 포스터, 제목 영역 -->
				<div class="detail_info">
					<div class="detail_poster">
						<img alt="" src=${movie_poster } width="200" height="280">
					</div>	
					<div class="info_title">
						<div class="detail_title">${movie_title }</div>
						<ul>
							<li><span>기본 정보 : </span> ${movie_nation } | ${movie_runtime}분 | ${movie_genre }</li>
							<li><span>개&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;봉 : 	</span> ${movie_release_date } </li>
							<li><span>감&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;독 : </span> ${movie_director }</li>
							<li><span>배&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;우 : </span> ${movie_actor }</li>
							<li><span>등&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;급 : </span> ${movie_rating }</li>
							<li><span>총관객수 : </span> ${movie_audience }명</li>
						</ul>
					</div>
					<div class="detail_reserve_clear">
<!-- 					<div class="reserve_area"> -->
						<button id="likeBtn" class="detail_likeBtn likeBtn" data-id="${movie_id }" data-title="${movie_title }" onclick="likeBtnClick(this)"><i class="fa fa-heart-o"></i>찜하기</button>
						<a href="movie_select?movie_id=${movie_id}">
							<input type="button" value="예매하기"></a>
					</div>
				</div>
				<hr>
				<ul class="click_link">
					<li><a href="#movie_story"><input type="button" value="줄거리"></a></li>	
					<c:if test="${not empty movie_trailer }">
						<li><a href="#movie_trailer"><input type="button" value="트레일러"></a></li>	
					</c:if>
					<li><a href="#movie_cut"><input type="button" value="스틸컷"></a></li>	
					<li><a href="#review"><input type="button" value="리뷰"></a></li>	
				</ul>
			    <div class="movie_story" id="movie_story">
			    ${movie_plot }
			    </div>
				<c:if test="${not empty movie_trailer }">
				    <div class="movie_trailer" id="movie_trailer">
				    	<hr>
				    	<h2>트레일러</h2>
					    <video class="trailer" src="${movie_trailer }"  controls autoplay muted></video>
				    </div>
				</c:if>
			    <div class="movie_cut" id="movie_cut">
			    	<hr>
			    	<h2>스틸컷</h2>
<!-- 			    	<img alt="" src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000087/87596/87596220582_727.jpg" width="600px" height="350px"> -->
						<c:if test="${not empty movie_still1 }"><img src="${movie_still1 }"></c:if>
						<c:if test="${not empty movie_still2 }"><img src="${movie_still2 }"></c:if>
						<c:if test="${not empty movie_still3 }"><img src="${movie_still3 }"></c:if>
			    </div>
			    <div class="review" id="review">
			    	<hr>
			    	<h2>리뷰</h2>
						<form action="reviewPro">
					    	<input type="text" name="review_content" placeholder="리뷰 입력" size="50">
<%-- 					    	<input type="hidden" name="movie_id" value="#{movie_id}"> --%>
					    	<input type=submit value="등록"> <!-- 어떤 영화에 상세페이지로 갈것인가 movie_id=20235098-->
						</form>
				    	<br>
		    			<table>
		    			<tr>
			    			<td rowspan="6" width="200">
			    				평점이 들어간다면<br>
			    				넣을 자리
			    			</td>
			    			<th>아이디</th>
			    			<th>내용</th>
			    			<th>작성일</th>
			    		</tr>
			    		<c:forEach begin="1" end="5">
						   	<tr>
<%-- 				    			<th>${review1.member_id}</th> <!-- 세션에 저장된 id  --> --%>
<%-- 				    			<td>${review1.movie_title}</td> <!-- insert로 생성된 내용 --> --%>
<%-- 				    			<td>${review1.movie_id}</td> <!-- insert로 생성된 datetime --> --%>
				    		</tr>
		    			</c:forEach>
		    			</table>
			    </div>
			</section>
		</section>	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>