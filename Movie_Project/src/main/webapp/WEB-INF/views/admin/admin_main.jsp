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
				</div>					
				
			</div>
		</section>
	</div>
</body>
</html>