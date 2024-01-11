<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket</title>
<style type="text/css">
 .table-container { 
   display: flex; 
   justify-content: center; 
   align-items: center; 
   height: 100vh; 
   flex-direction: column; 
 } 
 .discount-info { 
   caption-side: top; 
   text-align: left; 
   margin-bottom: 10px; 
 } 
 .styled-table { 
   border-collapse: collapse; 
   border: 1px solid black; 
   margin: auto; 
   border-right: none; 
   border-left: none; 
 } 
 th{
    background: #ebebeb;
    color: #383838;
    border: 1px solid;
 }
 td{
 	font-size: 12px;
 }
 .styled-table td { 
   border: 1px solid black; 
   padding: 8px; 
 } 
 .dI{ 
   background-color: black; 
   color:#fff; 

 } 
</style>
</head>
<body>
	<div id="admin_sub">
	<div class="table-container">
  	<table class="styled-table">
  	<caption class="discount-info"><h1 id="dI">할인 안내</h1></caption>
		<tr>
			<th>장애우대할인</th>
			<td>현장에서 복지카드를 소지한 장애인<br>
				(장애 1~3등급: 동반 1인까지 적용 / 4~6등급: 본인에 한함 /<br>
				일반 2D, 3D, 4DX 영화에 한함)</td>
		</tr>
		<tr>
			<th>심야할인</th>
			<td>극장별 심야할인 이벤트는 각 극장에 문의</td>
		</tr>
		<tr>
			<th>청소년 할인</th>
			<td>만 18세 미만을 증명할수 있는 신분증 제시<br>
				(만 4세 이상 ~ 만 18세 미만의 학생 또는 청소년(어린이)에 한함)</td>
		</tr>
		<tr>
			<th>수험표 할인</th>
			<td>이벤트 기간 한시적으로 운영하는 스페셜 할인 (11/16~11/19)<br>
				CGV 온라인 (웹/모바일) 예매 후, 2023년도 응시한 수험표 제시</td>
		</tr>
	</table>
	</div>
	</div>
</body>
</html>