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
<link href="${pageContext.request.contextPath }/resources/css/store.css" rel="stylesheet" type="text/css">
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
										+ "<a href='movie_select?movie_title=" +  result[i].movie_title + "' class='rel_reservBtn'>"
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
										+ "<a href='movie_select?movie_title=" +  result[i].movie_title + "' class='rel_reservBtn'>"
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
				
		// 메인페이지의 이벤트 목록 
		$.ajax({
			url: "eventList",
			dataType: "json",
			success: function(result) {
				for(let i = 0; i < result.length; i++) {
					$(".event-grid").append(
							"<div class='event myBtn" + i + "' data-content='" 
								+ result[i].event_image + "' onclick='eventModal(" + i + ")'>"	
								+ "<div class='event-image'>"
									+ "<img src='" + result[i].event_thumnail + "'>"
									+ "<div class='event-info'>"
										+ "<p class='event-title'>" + result[i].event_title + "</p>"
										+ "<p class='event-date'>" + result[i].event_release_date 
											+ " ~ " + result[i].event_close_date + "</p>"
									+ "</div>"
								+ "</div>"
							+ "</div>"
							);
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("이벤트 목록을 불러오는데 실패했습니다.\n새로고침을 해주세요.");
			}
		});
		
		// 모달 닫기 버튼 클릭 이벤트
		$(".close").on("click", function() {
			$("body").removeClass("not_scroll"); <%-- body 영역 스크롤바 추가 --%>
		  $("#myModal").hide(); <%-- div 영역 숨김 --%>
		});

		// 모달 외부 영역 클릭 시 모달 닫기
		$(window).on("click", function(event) {
			if ($(event.target).is("#myModal")) { <%-- 클릭한 곳이 모달창 바깥 영역일 경우 --%>
				$("body").removeClass("not_scroll"); <%-- body 영역 스크롤바 추가 --%>
				$("#myModal").hide(); <%-- div 영역 숨김 --%>
			}
		});
	});
	
	// 모달 열기 버튼 클릭 이벤트
	function eventModal(index) {
		$("body").addClass("not_scroll"); <%-- body 영역 스크롤바 삭제 --%>
		<%-- ajax에서 data 속성으로 추가한 상세이미치 불러오기 --%>
		$(".modal-content img").attr("src", $(".myBtn" + index).data("content"));
		$("#myModal").show();
	}
	
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
	
		
	
	function pageMove(move_num, pro_id) {
		
		<%-- 페이지 이동용 번호 --%>
		let move = move_num;
		<%-- 상품 아이디 지정 --%>
		let pro = pro_id;
		
		<%-- 상세페이지로 이동--%>
		if(move == 1 ) {
			location.href = "http://localhost:8081/c5d2308t1/storeDetail?product_id=" + pro;
		}
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
<!-- 		<div class="slideshow"> -->
<!-- 		<video class="main_trailer" src="https://www.kmdb.or.kr/trailer/play/MK036259_P02.mp4" controls autoplay muted></video> -->
<!-- 		</div> -->
			
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
			<div id="storeArea">
				<div id=storePage><a href="http://localhost:8081/c5d2308t1/store"><input type="button" value="전체보기"></a></div>
			</div>
					<div class="snack_menu">
						<!-- 상품 상세 페이지 바로가기 -->
						<a id="storeDetail" href="#" onclick="pageMove(1, 'P005')">
							<img alt="" src="${pageContext.request.contextPath}/resources/img/snack/우리패키지.jpg" width="310" height="250" ><br>
							<span>우리패키지</span><br>
							<span class="snack_detail">영화관람권 4매+더블콤보 1개</span><br><br>
							<span>61,000<span id="won">원&nbsp;&nbsp;</span></span>
							<span style="text-decoration: line-through;" class="snack_detail">65,000
								<span id="won">원</span>
							</span>
						</a>
						<!-- 장바구니에 담고 버튼 클릭 시 모달창 확인 -->
					</div>
					<div class="snack_menu">
						<a href="#" onclick="pageMove(1, 'P002')">
						<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/나랑너패키지.jpg" width="310" height="250"><br>
						<span>나랑너패키지</span><br>
						<span class="snack_detail">영화관람권 2매+스위트콤보 1개</span><br><br>
							<span>34,000<span id="won">원&nbsp;&nbsp;</span>
						</span>
						<span style="text-decoration: line-through;" class="snack_detail">36,000
							<span id="won">원</span>
						</span></a>
					</div>
					<div class="snack_menu">
						<a href="#" onclick="pageMove(1, 'P003')">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/snack/시네마패키지.jpg" width="310" height="250"><br>
							<span>시네마패키지</span><br>
							<span class="snack_detail">미니 시네마+팝콘L1개+콜라M2개</span><br><br>
							<span>31,000<span id="won">원&nbsp;&nbsp;</span></span><span style="text-decoration: line-through;" class="snack_detail">36,000<span id="won">원</span></span>
						</a>
					</div>
			 <div class="container">
				 <hr>
		        <h2>진행 중인 이벤트</h2>
		        <div class="event-grid">
					<!-- 모달 배경 -->
					<div id="myModal" class="modal">
						<!-- 모달 컨텐츠 -->
						<div class="modal-content">
							<span class="close">&times;</span>
							<img src="">
						</div>
					</div>
				</div>
	     	</div>
		</div>
		<footer>
			<jsp:include page="inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
</body>
</html>