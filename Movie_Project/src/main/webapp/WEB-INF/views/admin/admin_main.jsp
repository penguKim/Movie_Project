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
		// 10일 간의 날짜를 계산하기
		function getFormattedDates() {
		const today = new Date();
		const formattedDates = [];
	
			for (let i = 1; i <= 20; i++) {
				const pastDate = new Date(today.getTime() - (i * 24 * 60 * 60 * 1000));
				const formattedDate = pastDate.toISOString().split('T')[0];
				formattedDates.push(formattedDate);
			}
	
			return formattedDates;
		}
	
		const formattedDates = getFormattedDates().reverse();
		const queryString = "formattedDate=" + formattedDates.join(",");
	
		function drawChart(counts) {
			const date = [];
	
			for (let i = 0; i < counts.length; i++) {
				date.push(formattedDates[i]);
			}
	
			new Chart("joinCount", {
				type: "line",
				data: {
					labels: date,
					datasets: [
						{
							fill: false,
							pointRadius: 1,
							borderColor: "rgba(255,0,0,0.5)",
							data: counts,
						},
					],
				},
				options: {
					legend: { display: false },
					title: {
						display: true,
						text: "일일 가입자 수",
						fontSize: 16,
					},
				},
			});
		}
	
		// ajax를 이용하여 db에서 일일가입자수를 불러옴
		$.ajax({
			type: "GET",
			url: "joinCount",
			data: {
				"formattedDate": queryString,
			},
			success: function(result) {
				drawChart(result);
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
				new Chart("myChart", {
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
					<h1>일일가입자수</h1>
					<canvas id="joinCount" style="width:100%;max-width:550px"></canvas>
					<h1>인기 영화 차트</h1>
					<canvas id="myChart" style="width:100%;max-width:600px"></canvas>
				</div>					

				
				
			</div>
		</section>
	</div>
</body>
</html>