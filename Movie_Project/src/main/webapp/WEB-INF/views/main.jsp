<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화관</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/autoSlide.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/movie.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
	$(function() {
		// 메인 페이지의 영화목록         
		$.ajax({
			url:"mainMovieChart",
			data: {
				status: "release",
				sort: "dateSort"
			},
			dataType: "json",
			success: function(result) {
				$("#moviePage a").attr("href", "release?sortType=1");
				$("#boxoffice").empty();
				for(let i = 0; i < result.length; i++) {
					$("#boxoffice").append(
								"<div id=movie" + i + ">"
									+ "<a href='detail?movie_id=" +  result[i].movie_id + "'>" + 
									"<img src='" + result[i].movie_poster + "'></a>"
									+ "<div class='main_reserve_area'>"
										+ "<button id='likeBtn" + i + "' class='likeBtn' data-id='" 
										+ result[i].movie_id + "' data-title='" + result[i].movie_title 
										+ "' onclick='likeBtnClick(" + i + ")'><i class='fa fa-heart-o'></i>찜하기</button>"
										+ "<a href='movie_select?movie_id=" +  result[i].movie_id + "' class='rel_reservBtn'>"
										+ "<input type='button' value='예매하기'></a></div>"		
								+ "</div>"
								);
				}					
				// 회원의 찜 정보 가져오기
				$.ajax({
					url: "likeShow", <%-- 회원별 찜 정보 가져오기 --%>
					dataType: "json",
					async: "false",
					success: function(result) { <%-- List 타입으로 찜 데이터 응답 --%>
						for(let i = 0; i < 5; i++) { // <%-- 상영작 페이지의 목록만큼 반복 --%>
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
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("상영정보를 불러오지 못했습니다\n새로고침을 해주세요.");
			}
		});
		
		$("#Sort input").on("click", function() {
			let status = $(this).data("status");
			let sortType = $(this).data("sorttype");
			let name = $(this).attr("name");
			$.ajax({
				url:"mainMovieChart",
				data: {
					status: status,
					sort: $(this).data("sort")
				},
				dataType: "json",
				success: function(result) {
					$("#Sort input").removeClass("active");
					$("#Sort input[name=" + name + "]").addClass("active");
					$("#moviePage a").attr("href", status + "?sortType=" + sortType);
					$("#boxoffice").empty();
					for(let i = 0; i < result.length; i++) {
						$("#boxoffice").append(
								"<div id=movie" + i + ">"
									+ "<a href='detail?movie_id=" +  result[i].movie_id + "'>" + 
									"<img src='" + result[i].movie_poster + "'></a>"
									+ "<div class='main_reserve_area'>"
										+ "<button id='likeBtn" + i + "' class='likeBtn' data-id='" 
										+ result[i].movie_id + "' data-title='" + result[i].movie_title 
										+ "' onclick='likeBtnClick(" + i + ")'><i class='fa fa-heart-o'></i>찜하기</button>"
										+ "<a href='movie_select?movie_id=" +  result[i].movie_id + "' class='rel_reservBtn'>"
										+ "<input type='button' value='예매하기'></a></div>"		
								+ "</div>"
								);
					}					
					// 회원의 찜 정보 가져오기
					$.ajax({
						url: "likeShow", <%-- 회원별 찜 정보 가져오기 --%>
						dataType: "json",
						async: "false",
						success: function(result) { <%-- List 타입으로 찜 데이터 응답 --%>
							for(let i = 0; i < 5; i++) { // <%-- 상영작 페이지의 목록만큼 반복 --%>
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
				},
				error: function(xhr, textStatus, errorThrown) {
					alert("상영정보를 불러오지 못했습니다\n새로고침을 해주세요.");
				}
			});
		});
	});
	
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
			<jsp:include page="inc/top.jsp"></jsp:include>
		</header>
	
		<jsp:include page="inc/menu_nav.jsp"></jsp:include>
		
		<%-- 오토슬라이드 인클루드 --%>
		<jsp:include page="inc/autoSlide.jsp"></jsp:include>
		
			
		<div id="main_page">
			<div id="Sort">
				<ul>
					<li><input type="button" value="현재상영작" class="movieBtn active" data-status="release" data-sort="dateSort" data-sortType="1" name="release"></li>
					<li><input type="button" value="상영예정작" class="movieBtn" data-status="comming" data-sort="dateSort" data-sortType="1" name="comming"></li>
					<li><input type="button" value="관람객순" class="movieBtn" data-status="release" data-sort="audienceSort" data-sortType="3" name="audience"></li>
				</ul>
			</div>
			<div id="movieArea">
				<div id="moviePage"><a href=""><input type="button" value="전체보기"></a></div>
				<div id="boxoffice"></div>
			</div>
			<div id="main_store">
				<hr>
				<h2>스토어 베스트 상품</h2>
				<img alt="" src="img/짜파게티팝콘패키지.jpg" width="250" height="200">
				<img alt="" src="img/팝콘패키지.jpg" width="250" height="200">
				<img alt="" src="img/맥주패키지.jpg" width="250" height="200">
			</div>
			 <div class="container">
				 <hr>
		        <h2>진행 중인 이벤트</h2>
		        <div class="event-grid">
		        <c:forEach begin="1" end="4">
		            <div class="event">
		            	<a href="event_detail.jsp" class="event_link">
			            	<div class="event-image">
				                <img src="https://img.megabox.co.kr/SharedImg/event/2023/11/21/GuvlkLZPAUjb8uk2ikaFSmI6C4E6GRtg.jpg" alt="이벤트 썸네일">
				            </div>
				            <div>
				                <p class="event-title">이벤트 제목</p>
				                <p class="event-date">2023. 11. 1 ~ 2023. 11. 30</p>
				            </div>    
		                </a>
		            </div>
	            </c:forEach>
		            <%-- 이벤트 항목을 추가로 작성 --%>
		        </div>
	     	</div>
		</div>
	
		<footer>
			<jsp:include page="inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>