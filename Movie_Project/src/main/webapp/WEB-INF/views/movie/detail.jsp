<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/movie.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url: "likeShow", <%-- 회원별 찜 정보 가져오기 --%>
			dataType: "json",
			success: function(result) { <%-- List 타입으로 찜 데이터 응답 --%>
				console.log(result);
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
		
		// 모달 닫기 버튼 클릭 이벤트
		$(".close").on("click", function() {
			$(".modal").hide(); <%-- div 영역 숨김 --%>
		});

		// 모달 외부 영역 클릭 시 모달 닫기
		$(window).on("click", function(event) {
			if ($(event.target).is(".modal")) { <%-- 클릭한 곳이 모달창 바깥 영역일 경우 --%>
				$(".modal").hide(); <%-- div 영역 숨김 --%>
			}
		});
		
	}); <%-- 로그인한 회원의 찜 정보 가져오기 끝 --%>
	
	$(function() {
		<%-- 리뷰 작성 여부 확인 및 등록 --%>
		$("#submitReview").on("click", function() {
			$.ajax({
				url: "reviewCheck",
				type: "POST",
				dataType: "json",
				data: {
					movie_id: ${param.movie_id},
					review_content : $("#review_content").val()
				},
				success: function(data) {
					if(data.result == "false") {
						if(confirm("로그인이 필요한 서비스입니다.\n로그인하시겠습니까?")) {
							location.href = "memberLogin";							
						}
					} else if(data.result == "notReserve") {
						if(confirm("영화를 관람하신 회원만 작성가능합니다.\n예매페이지로 이동하시겠습니까?")) {
							location.href = "movieSelect?movie_title=" + ${param.movie_id};							
						}
					} else if(data.result == "isBefore") {
						alert("영화 상영 후 리뷰가 작성가능합니다.");
					} else if(data.result == "ReviewWritied") {
						alert("이미 리뷰를 작성하셨습니다.");
					} else if(data.result == "error") {
						alert("리뷰 등록에 실패했습니다.");
					} else if(data.result == "true") {
						alert("리뷰를 등록하였습니다.");
						$("#review_no tr:gt(0)").remove(); // 기존 리뷰 지우기
						$.each(data.reviewList, function(index, review) {
							let row = 
								"<tr>"
								+ "<td>" + review.member_id + "</td>"
								+ "<td>" + review.review_content+ "</td>"
								+ "<td>" + review.review_date.split("T")[0] + "</td>"
								+ "</tr>";
							console.log(row);
							$("#review_no").append(row);
						});
						$("#review_content").val("");
					}
				}
			});
		});
		
		<%-- 리뷰 전체보기 --%>
		$("#reviewList").on("click", function() {
			$.ajax({
				type: "POST",
				url: "reviewListPro",
				data: {
					movie_id: ${param.movie_id}
				},
				dataType: "json",
				success: function(data) {
// 					console.log(data);
					$("#review_no tr:gt(0)").remove();
					$.each(data, function(index, review) {
						$("#reviewListTable").append(
							"<tr>"
							+ "<td>" + review.member_id + "</td>"
							+ "<td>" + review.review_content+ "</td>"
							+ "<td>" + review.review_date.split("T")[0] + "</td>"
							+ "</tr>"
						);			
					});
					
					$("#reviewModal").show();
				}
			});
			
		});
		
		// 제목 글자수 제한
	    $("#review_content").on("input", function() {
	        var text = $(this).val();
	        
	        // 텍스트 제한
	        if(text.length == 0 || text == "") {
		        $("#contentLenth").text("글자수 (0/100)");
	        } else {
		        $("#contentLenth").text("글자수 (" + text.length + "/100)");
	        }
	        
	        // 글자수 제한
	        if (text.length > 100) {
	        	// 제한수 넘으면 자르기
	            $(this).val($(this).val().substring(0, 100));
	            $("#contentLenth").text("글자수 (100/100)");
	            alert("100자까지 입력이 가능합니다.");
	        };
	    });
	});
	
	// 모달 열기 버튼 클릭 이벤트
	function imageModal(img) {
		console.log($(img).attr("src"));
		$(".modal-content img").attr("src", $(img).attr("src"));
		$("#myModal").show();
	}
	
	
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
	
// $(document).ready(function(){ //이창이 열리면 밑에 코드들이 실행됨
<%-- 	var member_id = "<%= session.getAttribute("sId") %>";  --%>
// 	var movie_id = ${param.movie_id}; //영화 선택시 주소에 movie_id ="111"값을 movie_id에 저장 
	
// 	var currentDate = new Date(); // 현재 날짜와 시간을 currentDate 변수에 저장
// 	var year = currentDate.getFullYear();  // 현재 연도 추출
// 	var month = (currentDate.getMonth() + 1).toString().padStart(2, '0'); // 현재 월 추출하고 2자리로 만들기
// 	var day = currentDate.getDate().toString().padStart(2, '0'); // 현재 일 추출하고 2자리로 만들기

// 	var formattedDate = year + "-" + month + "-" + day; // 연도, 월, 일을 formattedDate 변수에 저장

// 	$("#submitReview").click(function(){ //클릭시 실행되는 함수
// 		alert(member_id);
// 		var review_content = $("#review_content").val();
		
// 		if(member_id == "null") {
// 		    alert("로그인 후 리뷰작성이 가능합니다");
// 		    location.href="memberLogin";
		
// 		} else if(review_content === "" || review_content === null){
// 			alert("내용을 작성해주세요");
// 			return;
			
// 		}else{
// 			$.ajax({
// 				type: "POST",
// 				url: "reviewCheck",
// 				data: {
// 					review_content : review_content, 
// 					member_id : member_id,
// 					movie_id : movie_id
// 				},
// 				success: function(result) {
										
// 				}
				
// 				url: "reviewPro", // 데이터를 가지고 보낼 주소
// 				type: "POST",
// 				data: {
// 						review_content : review_content, 
// 						member_id : member_id,
// 						movie_id : movie_id
// 				},
// 				datatype: "json",
// 				success: function(data) { // 요청 성공
					
// 						$("#review_tr").after( //id="review_tr" 뒤에 데이터들 출력하기
// 							"<tr>"	
// 							+ "<td>" + member_id + "</td>"	
// 							+ "<td>" + review_content + "</td>"	
// 							+ "<td>" + formattedDate  + "</td>"	
// 							+ "</tr>"	
// 						);
					
// 					// 리뷰가 5개 이상일 경우 가장 아래에 있는 리뷰 삭제
// 		            if ($("#review_no tr").length > 5) {
// 		                $("#review_no tr:last-child").remove();
// 		            }
// 					console.log("성공");
// 				},
// 				error: function(request, status, error) { // 요청 실패
// 					console.log("실패");
// 				}
// 			});//ajax
// 		}; //else문 끝
// 	}); //click
// });
</script>
<script type="text/javascript">
	<%-- 연령대 차트 --%>
	$(function() {
		const xValues = [];
		const yValues = [];
		const barColors = ["red", "green","blue","orange","brown"];
		
		$.ajax({
			type: "GET",
			url: "movieAgeGroup",
			data: {
				movie_id: ${param.movie_id}
			},
			dataType: "json",
			success: function(result) {
				for(let ageGroup of result) {
					xValues.push(ageGroup.age + "대");
					yValues.push(ageGroup.count);
				}
				let total = yValues.reduce(function(sum, value) {
				    return sum + value;
				}, 0);
				let percentData = yValues.map(function(value) {
				    return Math.floor((value / total) * 100);
				}); 
				
				new Chart("ageGroupChart", {
				  type: "bar",
				  data: {
				    labels: xValues,
				    datasets: [{
			        backgroundColor: function(context) {
			            var index = context.dataIndex; // 데이터 항목
			            var value = context.dataset.data[index]; // 데이터 배열에서 해당 항목을 value로 저장
			            // ... 연산자를 사용하여 배열의 모든 항목을 꺼내서 비교한다.
			            return value === Math.max(...percentData) ? '#FF0000' : '#9E9E9E'; 
			          },
				      data: percentData
				    }]
				  },
					options: {
						legend: {display: false},
						title: {
							display: true,
							text: "연령대별 예매 분포"
						},
						scales : {
							yAxes : [ {
								ticks : {
					                beginAtZero: true, // 0부터 시작하게 합니다.
					                min: 0, // 최소 값
					                max: 100, // 최대 값
					                stepSize: 25, // 간격
					                callback: function(value) {
					                    return value + '%'; // y축의 표시 형식을 퍼센트로 변경
					                }
								}
							} ],
	
						},
						tooltips: {
							callbacks: {
								label: function(tooltipItem, data) {
									var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
									return value + '%'; // 툴팁에 표시되는 데이터 형식을 퍼센트로 변경
								}
							}
						}
					}
				});
			},
			error : function() {
				alert("차트 로딩 실패!");
			}
		});
		
		$(function() {
			const xValues = ["남성", "여성"];
			const yValues = [];
			const barColors = [
			  "#b91d47",
			  "#00aba9"
			];
			
			
			$.ajax({
				url: "movieGenderGroup",
				data: {
					movie_id: ${param.movie_id}
				},
				dataType: "json",
				success: function(result) {
					for(let genderGroup of result) {
						yValues.push(genderGroup.count);
					}
					
					let total = yValues.reduce(function(sum, value) {
					    return sum + value;
					}, 0);
					let percentData = yValues.map(function(value) {
					    return Math.floor((value / total) * 100);
					});
					
					new Chart("genderChart", {
						type: "pie",
						data: {
							labels: xValues,
							datasets: [{
								backgroundColor: barColors,
								data: percentData
							}]
						},
						options: {
							title: {
								display: true,
								text: "성별 예매 분포"
							},
							tooltips: {
								callbacks: {
									label: function(tooltipItem, data) {
										var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
										return value + '%'; // 툴팁에 표시되는 데이터 형식을 퍼센트로 변경
									}
								}
							}
						}
					});
					
				}
			});

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
							<li><span>개&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;봉 : 	</span> ${movie_release_date } </li>
							<li><span>감&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;독 : </span> ${movie_director }</li>
							<li><span>배&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;우 : </span> ${movie_actor }</li>
							<li><span>등&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;급 : </span> ${movie_rating }</li>
							<li><span>총 관객수 : </span><fmt:formatNumber value="${movie_audience }" groupingUsed="true" /> 명</li>
						</ul>
					</div>
					<div class="detail_reserve_clear">
						<button id="likeBtn" class="detail_likeBtn likeBtn" data-id="${movie_id }" data-title="${movie_title }" onclick="likeBtnClick(this)"><i class="fa fa-heart-o"></i>찜하기</button>
						<a href="movieSelect?movie_title=${movie_title}">
							<input type="button" value="예매하기"></a>
					</div>
				</div>
				<hr>
				<ul class="click_link">
					<li><a href="#movie_story"><input type="button" value="줄거리"></a></li>
					<li><a href="#movie_reserv"><input type="button" value="예매 현황"></a></li>	
					<c:if test="${not empty movie_trailer }"> <%-- 트레일러가 없는 경우 --%>
						<li><a href="#movie_trailer"><input type="button" value="트레일러"></a></li>	
					</c:if>
					<li><a href="#movie_cut"><input type="button" value="스틸컷"></a></li>	
					<c:if test="${movie_status eq 1 }"> <%-- 현재상영작인 경우 --%>
						<li><a href="#review"><input type="button" value="리뷰"></a></li>	
					</c:if>
				</ul>
			    <div class="movie_story" id="movie_story">
		    	<hr>
		    	<h2>줄거리</h2>
		    	<div>
				    ${movie_plot }
		    	</div>
		    	<div class="movie_reserv" id="movie_reserv">
	    		<hr>
	    		<h2>예매 현황</h2>
				    <div class="chart">
					    <canvas id="genderChart" style="width:100%;max-width:290px; height:100%;"></canvas>
				    </div>
				    <div class="chart">
					    <canvas id="ageGroupChart" style="width:100%;max-width:290px; height:100%;"></canvas>
				    </div>
		    	</div>
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
					<c:if test="${not empty movie_still1 }"><img class="modalImg" src="${movie_still1 }" onclick="imageModal(this)"></c:if>
					<c:if test="${not empty movie_still2 }"><img class="modalImg" src="${movie_still2 }" onclick="imageModal(this)"></c:if>
					<c:if test="${not empty movie_still3 }"><img class="modalImg" src="${movie_still3 }" onclick="imageModal(this)"></c:if>
			    </div>
				<!-- 모달 배경 -->
				<div id="myModal" class="modal">
					<!-- 모달 컨텐츠 -->
					<div class="modal-content">
						<span class="close">&times;</span>
						<img src="" width="600">
					</div>
				</div>
				<c:if test="${movie_status eq 1}">				    	
					<div class="review" id="review">
						<hr>
						<h2>리뷰</h2>
						<input type="text" name="review_content" maxlength="100" placeholder="리뷰 입력" id="review_content">
						<input type=button value="등록" id="submitReview">
						<div id="contentLenth">글자수 (0/100)</div>
						<br>
						<div id="reviewListArea">
							<input type="button" id="reviewList" value="리뷰 전체보기">
							<div id="reviewModal" class="modal">
								<!-- 모달 컨텐츠 -->
								<div class="modal-content reviewModalArea" style="width: 30%;">
									<span class="close">&times;</span>
									<div class="reviewTableArea">
										<table id="reviewListTable">
											<tr id="review_tr">
												<th>아이디</th>
												<th width="70%">내용</th>
												<th>작성일</th>
											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
						<table id="review_no">
							<tr id="review_tr">
								<th>아이디</th>
								<th width="70%">내용</th>
								<th>작성일</th>
							</tr>
							<c:forEach var="movieReview" items="${movieReview}" begin="0" end="4">
								<tr>
									<td>${movieReview.member_id}</td>
									<td>${movieReview.review_content}</td>
									<td>${movieReview.review_date}</td>
								</tr>
						</c:forEach>
						</table>
					</div>
    			</c:if>
			</section>
		</section>
		<div id="footerMG"></div>	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>