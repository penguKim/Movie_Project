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
		$.ajax({
			url: "likeShow", <%-- 회원별 찜 정보 가져오기 --%>
			dataType: "json",
			success: function(result) { <%-- List 타입으로 찜 데이터 응답 --%>
				for(let like of result) {
					if(like.movie_id == ${movie_id}) { <%-- 찜한 영화가 상영작 페이지에 있을 경우 --%>
						$("#likeBtn").addClass("likeCheck");
						$("#likeBtn").html("<i class='fa fa-heart'></i>찜하기");
					}
				}
			},
			error: function(xhr, textStatus, errorThrown) {
					alert("현재 상영작 불러오기를 실패했습니다.\n새로고침을 해주세요.");
			}
		});
	}); <%-- 로그인한 회원의 찜 정보 가져오기 끝 --%>
	
	//찜하기 버튼
	function likeBtnClick(like) { <%-- 함수를 호출하는 버튼의 인덱스를 파라미터로 사용 --%>
// 		console.log("${movie_id}");
		$.ajax({
			url: "likeCheck", <%-- 해당 영화의 찜 정보가 DB에 있는지 판별 --%>
			data: {
				movie_id: ${movie_id}
			},
			success: function(result) { <%-- 응답 결과가 문자열로 전송 --%>
				if(result == 'login') {
					if(confirm("로그인이 필요한 서비스입니다.\n로그인하시겠습니까?")){
						location.href = "memberLogin";
					}
				} else if(result == 'false') { <%-- 찜을 등록하는 경우 --%>
					$("#likeBtn").toggleClass("likeCheck");
					$("#likeBtn").html("<i class='fa fa-heart'></i>찜하기");
				} else if(result == 'true') { <%-- 찜을 삭제하는 경우 --%>
					$("#likeBtn").toggleClass("likeCheck");
					$("#likeBtn").html("<i class='fa fa-heart-o'></i>찜하기");
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("찜하기를 실패했습니다.");
			}
		});
	} <%-- 찜하기 버튼 클릭 이벤트 종료 --%>
	
$(document).ready(function(){
        var member_id = "<%= session.getAttribute("sId") %>";
        	
    $("#submitReview").click(function(){
    	
    	let targetDate = new Date();
    	let nowTime = new Date().getTime(); // 계산의 기준이 될 날짜를 밀리초 단위로 리턴
//     	let targetDate = 
//     	alert(nowTime);
//     	alert(targetDate);
    	movieReleaseTime = new Date(repRlsDate).getTime(); // 계산의 대상이 될 날짜를 밀리초 단위로 리턴
		// 두 날짜의 차이를 초 -> 분 -> 시 -> 일 비교값으로 나타내기
		differenceTime = Math.round((nowTime - movieReleaseTime) / 1000 / 60 / 60 / 24);
		// 개봉상태 지정
		if(differenceTime> 0) { // 오늘보다 개봉일이 이전인 경우
			$("#release").prop("selected", true);
		} else { // 오늘보다 개봉일이 이후인 경우
			$("#comming").prop("selected", true);
		}
        
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
            	 console.log("실패");
            }
        });//ajax
//   		  	}else{ // 실패시 
// 		    	alert("로그인 후 작성이 가능합니다");
// 		    	location.href = "memberLogin";
//    		 	} //if
    });
});
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
				<c:if test="${movie_status eq 1}">				    	
			     <div class="review" id="review">
			    	<hr>
				    	<h2>리뷰</h2>
						<form action="reviewPro" method="post">
					    	<input type="text" name="review_content" placeholder="리뷰 입력" size="50" id="review_content">
					    	<input type=button value="등록" id="submitReview"> <!-- 어떤 영화에 상세페이지로 갈것인가 movie_id=20235098-->
					    	<input type="hidden" name="movie_id" value="${movie_id}">
						</form>
				    	<br>
						
		    			<table id="review_no">
		    			<tr>
			    			<td rowspan="6" width="200">
			    				평점이 들어간다면<br>
			    				넣을 자리
			    			</td>
			    			<th>아이디</th>
			    			<th>내용</th>
			    			<th>작성일</th>
			    		</tr>
<%-- 			    		<c:forEach var="rev" items="${reviews}"> --%>
<!-- 						   	<tr> -->
<%-- 				    			<td id="review_no">${rev.member_id}</td> <!-- 세션에 저장된 id  --> --%>
<%-- 				    			<td>${rev.movie_title}</td> <!-- insert로 생성된 내용 --> --%>
<%-- 				    			<td>${rev.movie_id}</td> <!-- insert로 생성된 datetime --> --%>
<!-- 				    		</tr> -->
<%-- 		    			</c:forEach> --%>
		    			</table>
		  		  </div>
    			</c:if>
			</section>
		</section>	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>