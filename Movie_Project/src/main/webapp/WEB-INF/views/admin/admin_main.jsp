<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
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
				
				for(let i = 0; i < result.counts.length-1; i++) {
				    let date = result.counts[i].date;
				    let count = result.counts[i].count;
				
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
								borderColor: "rgba(255,0,0,0.5)",
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
			success: function(result) {
				for(let i = 0; i < result.length; i++) {
					xValues.push(result[i].product_name);
					yValues.push(result[i].quantity);
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