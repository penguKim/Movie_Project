<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<script>
	// 일별 매출 차트
	$(function() {
		
		const xValues = [];
		const yValues = [];

		// ajax를 이용하여 db에서 일별매출을 불러옴
		$.ajax({
			type: "GET",
			url: "revenue",
			dataType: "json",
			success: function(result) {
				
				for(let i = 0; i < result.length; i++) {
				    let date = result[i].date;
				    let revenue = result[i].revenue;
					
				    xValues.push(date);
				    yValues.push(revenue);
				    
				}
// 				    console.log("xValues = " + xValues + ", yValues = " + yValues);

				new Chart("revenue", {
					type: "line",
					data: {
						labels: xValues, // 날짜
						datasets: [
							{
								fill: false,
								lineTension: 0,
							    backgroundColor: "rgba(0,0,255,1.0)",
							    borderColor: "rgba(0,0,255,0.1)",
								data: yValues, // 매출
							},
						],
					},
					options: {
						legend: { display: false },
						title: {
							display: true,
							fontSize: 16
						}
					},
				});
				
			},
			error: function(request, status, error) {
				console.log("AJAX 요청 실패:", error);
	    	},
		});
	});
	
</script>

<script>
	// 일일 가입자수 차트
	$(function() {
		
		const xValues = [];
		const yValues = [];

		// ajax를 이용하여 db에서 일일가입자수를 불러옴
		$.ajax({
			type: "GET",
			url: "joinCount",
			dataType: "json",
			success: function(result) {
				
				for(let i = 1; i < result.length; i++) {
				    let date = result[i].date;
				    let count = result[i].count;
				
				    xValues.push(date);
				    yValues.push(count);
				}

				new Chart("joinCount", {
					type: "line",
					data: {
						labels: xValues, //날짜
						datasets: [
							{
								fill: false,
								pointRadius: 1,
								borderColor: "#39DB54",
								data: yValues, //회원수
							},
						],
					},
					options: {
						legend: { display: false },
						title: {
							display: true,
							fontSize: 16
						},
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true, // 0부터 시작하게 합니다.
									stepSize: 1   // 1 씩 증가하도록 설정합니다.
								}
							} ]
						}
					},
				});
				
			},
			error: function(request, status, error) {
				console.log("AJAX 요청 실패:", error);
	    	},
		});
	});
	
</script>

<script type="text/javascript">
	// 인기 상품 차트
	$(function() {
		const xValues = [];
		const yValues = [];
		const barColors = ["#FF4633", "#39DB54","#009CF7","#F99E27","#FC4E7C"];
		
		// ajax를 이용하여 db에서 상품종류/판매수량 불러오기
		$.ajax({
			type: "GET",
			url: "productCount",
			dataType: "json",
			success: function(result) {
				for(let i = 0; i < result.length; i++) {
					let product_name = result[i].product_name;
				    let quantity = result[i].quantity;
				    
					xValues.push(product_name);
					yValues.push(quantity);
				}
				
				new Chart("productCount", {
					type: "bar",
					data: {
						labels: xValues, //상품명
						datasets: [{
							backgroundColor: barColors,
							data: yValues //구매 횟수
						}]
					},
					options: {
						legend: {display: false},
						title: {
							display: false,
							text: "현재까지 팔린 상품",
							fontSize: 16
						}
					}
				});
				
				
			},
			error: function(request, status, error) {
				console.log("AJAX 요청 실패:", error);
	    	},
		});
});
</script>

<script type="text/javascript">
	// 예매 순위 차트
	$(function() {
		var xValues = [];
		var yValues = [];
		var barColors = [
			  "#b91d47",
			  "#00aba9",
			  "#2b5797",
			  "#e8c3b9",
			  "#1e7145"
			];
		<%-- 7일전 날짜 --%>
		let previous = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);
		let previousDate = ('0' + (previous.getMonth() + 1)).slice(-2) + "-" 
							+ ('0' + previous.getDate()).slice(-2);
		<%-- 현재 날짜 --%>
		let current = new Date();
		let currentDate = ('0' + (current.getMonth() + 1)).slice(-2) + "-" 
		+ ('0' + current.getDate()).slice(-2);

		<%-- 7일 단위로 예매된 영화 이름과 횟수 가져오기 --%>
		$.ajax({
			type: "GET",
			url: "movieChart",
			dataType: "json",
			success: function(result) {
				for(let i = 0; i < result.length; i++) {
					xValues.push(result[i].movie_title);
					yValues.push(result[i].count);
				}
				new Chart("movieCount", {
					type: "pie",
					data: {
						labels: xValues, <%-- 영화 제목 배열 --%>
						datasets: [{
							backgroundColor: barColors,
							data: yValues <%-- 예매된 횟수 --%>
						}]
					},
					options: {
						title: {
							display: true,
							text: previousDate + " ~ " + currentDate
						}
					}
				});
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("영화차트 불러오기를 실패했습니다.\n새로고침을 해주세요.");
			}
		});
	});
</script>
</head>
<body>
	<div id="wrapper">
		<nav id="navbar">
			<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		</nav>
        
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
		<section id="content">
			<h1 id="h01">관리자페이지 메인</h1>
			<hr>
			<div id="admin_main">
				<div class="chart">
					<h2>일별 매출표</h2>
					<canvas id="revenue" style="width:100%;max-width:550px"></canvas>
				</div>
				<div class="chart">
					<h2>일일가입자수</h2>
					<canvas id="joinCount" style="width:100%;max-width:550px"></canvas>
				</div>
				<div class="chart">
					<h2>인기 영화 차트</h2>
					<canvas id="movieCount" style="width:100%;max-width:550px"></canvas>
				</div>
				<div class="chart">
					<h2>인기 상품 차트</h2>
					<canvas id="productCount" style="width:100%;max-width:550px"></canvas>
				</div>
			</div>					
		</section>
	</div>
</body>
</html>