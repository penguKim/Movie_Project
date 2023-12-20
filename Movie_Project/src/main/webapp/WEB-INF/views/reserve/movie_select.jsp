<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매하기</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/reserve.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		
		let M,T,D = null;
		$(".btnMovie").click(function(){
			$('.btnMovie').removeClass('selected');
			$(this).addClass('selected');
			param();
			M=1;
			if((M+T+D)==6){ajax();}
		});
		
		$(".btnTheater").click(function(){
			$('.btnTheater').removeClass('selected');
			$(this).addClass('selected');
			param();
			T=2;
			if((M+T+D)==6){ajax();}
		});
		$(".btnDate").click(function(){
			$('.btnDate').removeClass('selected');
			$(this).addClass('selected');
			param();
			D=3;
			if((M+T+D)==6){ajax();}
		});
		function ajax(){
			$.ajax({
				url: "reserveAjax",
				data: {
					movie_title: $('.btnMovie.selected').val()
					,theater_name: $('.btnTheater.selected').val()
					,play_date: $('.btnDate.selected').val()
				},
				dataType: "json",
			    success: function(data) {
			    	alert("ajax연결 성공!")
			    	console.log(data)
			    	// 이전에 있던 데이터 제거
			    	$(".overflow.time").html("<b>시간</b>");
			    	let roomNameArr = [];
			    	//선택한 영화, 극장, 날짜의 상영관 배열생
			    	for(let rName of data){
			    		roomNameArr.push(rName.room_name);
			    	}
			    	//상영관이 동일한 스케줄의 중복 제거를 위한 Set객체 사용
			    	let uniqueData = new Set(roomNameArr);
					for(let rName of uniqueData){
				    	$(".overflow.time").append("<input type ='button' value="+ rName +" class='RN room_name_"+rName+"'>"+"<div class='"+rName+"'></div>");
					}
					for(let pTime of data){
						if(pTime.room_name == 'IMAX관'){
							$(".IMAX관").append("<input type ='button' value=" + pTime.play_start_time +" class='btnTime' id='IMAX관'>");
						}else if(pTime.room_name == 'DolbyAtmos관'){
							$(".DolbyAtmos관").append("<input type ='button' value=" + pTime.play_start_time +" class='btnTime' id='DolbyAtmos관'>");
						}else if(pTime.room_name == '1관'){
							$(".1관").append("<input type ='button' value=" + pTime.play_start_time +" class='btnTime' id='1관'>");
						}else if(pTime.room_name == '2관'){
							$(".2관").append("<input type ='button' value=" + pTime.play_start_time +" class='btnTime' id='2관'>");
						}else if(pTime.room_name == '3관'){
							$(".3관").append("<input type ='button' value=" + pTime.play_start_time +" class='btnTime' id='3관'>");
						}else if(pTime.room_name == '4관'){
							$(".4관").append("<input type ='button' value=" + pTime.play_start_time +" class='btnTime' id='4관'>");
						}
					}
					$(".btnTime").click(function(){
						$('.btnTime').removeClass('selected');
						$(this).addClass('selected');
						param();
					});
					
			    }//success end
			    
			});//ajax end
			
		}//ajax function end
		function param() {
			let selectMovieValue = $('.btnMovie.selected').val();
			let selectTheaterValue = $('.btnTheater.selected').val();
			let selectDateValue = $('.btnDate.selected').val();
			let selectRoomValue = $('.btnTime.selected').prop('id');
			let selectTimeValue = $('.btnTime.selected').val();
			
		    // 선택된 데이터를 표시
		    var tableCells = $('#end_param td');
		    tableCells[0].textContent = selectMovieValue;
		    var CGVParamCells = $('#CGVParam td');
		    CGVParamCells[0].textContent = selectTheaterValue;
		    CGVParamCells[1].textContent = selectDateValue + selectTimeValue;
		    CGVParamCells[2].textContent = selectRoomValue;
		    
			// selectedValues의 각 속성을 각각의 hidden input 태그에 설정
			$("#movie_title").val(selectMovieValue); 
			$("#theater_name").val(selectTheaterValue);
			$("#play_date").val(selectDateValue);
			$("#room_name").val(selectRoomValue);
			$("#play_start_time").val(selectTimeValue);
		}
		
		$('.btnReset').click(function() {
		  location.reload();// 페이지를 새로고침합니다.
		});
		
	});// document.ready END

</script>
</head>
<body>
	<div id="wrapper"><%--CSS 요청으로 감싼 태그--%>
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content"><%--CSS 요청으로 감싼 태그--%>
			<h1 id="h01">예매하기</h1>
			<hr>
			<article>
				<div id="reserve_nav">
					<input type="button" value="&#x1F504; 다시 예매하기" class="btnReset">
				</div>
				<div id = "reserve_parameter">
						<div class="overflow movie"><b>영화</b>
							<c:forEach var="movieList" items="${movieList}">
								<input type ="button" value="${movieList.movie_title}" class="btnMovie"><br>
							</c:forEach>
						</div> 
						<div class="overflow theater"><b>극장</b>
							<c:forEach var="theaterList" items="${theaterList}">
								<input type ="button" value="${theaterList.theater_name}" class="btnTheater"><br>
							</c:forEach>
						</div>
						<div class="overflow date"><b>날짜</b>
							<c:forEach var="playList" items="${playList}">
								<input type ="button" value="${playList.play_date}" class="btnDate"><br>
							</c:forEach>
						</div> 
						<div class="overflow time"><b>시간</b> 
							<p id ="timeAreaNomalText">영화, 극장, 날짜를 선택해주세요.</p>
						</div>
				</div>
			</article>
		</section><%--CSS 요청으로 감싼 태그--%>
		<article id="select_info">
			<div class="print_parameter">
				<table id="end_param">
					<tr>
						<td>영화선택</td>
						<td>
								극장<br>
								일시<br>
								상영관<br>
								인원<br>
						</td>
						<td><img src="${pageContext.request.contextPath }/resources/img/화살표2.png" width="25px" height="25px">좌석선택</td>
						<td>결제</td>
						<td>
							<form action="seat_select" method="post">
							    <input type="hidden" name="movie_title" id="movie_title" value="">
							    <input type="hidden" name="theater_name" id="theater_name" value="">
							    <input type="hidden" name="play_date" id="play_date" value="">
							    <input type="hidden" name="room_name" id="room_name" value="">
							    <input type="hidden" name="play_start_time" id="play_start_time" value="">
							    <input type="submit" class="btnsubmit" value="좌석선택">
							</form>
						</td>
					</tr>
				</table>
			</div>
		</article>
		<footer>
				<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div><%--CSS 요청으로 감싼 태그--%>
</body>
</html>