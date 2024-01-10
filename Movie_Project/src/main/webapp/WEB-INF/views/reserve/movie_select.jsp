<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket예매하기</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/reserve.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<style type="text/css">
	#content{
	padding-bottom:80px!important;
	}
</style>
<script type="text/javascript">
	$(function() {
		$(document).ready(function() {
		    // 파라미터로 넘어온 theater_name 값 저장
		    var urlParams = new URLSearchParams(window.location.search);
		    var theaterName = urlParams.get('theater_name');
		    // 극장 버튼들을 순회하며 theater_name과 일치하는 버튼을 선택
		    $('.btnTheater').each(function() {
		        if ($(this).val() === theaterName) {
		            $(this).addClass('selected');
		            $('#Result_T').text($('.btnTheater.selected').val());
		            param();
	                T = true; // 선택된 상태로 표시하기
                    T_Ajax(); 
		        }
		    });
		});
		let M,T,D = null;
		$(".btnMovie").click(function(){
			$('.btnMovie').removeClass('selected');
			$(this).addClass('selected');
		    $('#Result_M').html('<img src='+ $('.btnMovie.selected').data('movie_poster') +' alt="이미지 예시" width="75" height="95">'+ '<span class="endparamMoviename">'+$('.btnMovie.selected').data('movie_title')+'</span>');
		    $('#Result_M').css('font-size', '12px');
            $('#Result_M').css('color', 'white');
			param();
			M = true;
			
			if(M == true && D == true && T==true){
				MTD_Ajax();
			}else if(M == true && D == true){
				MD_Ajax();
			}else if(M == true && T == true){
				MT_Ajax();
			}else if(M == true){
				M_Ajax();
			}
			
		});
		
		$(".btnTheater").click(function(){
			$('.btnTheater').removeClass('selected');
			$(this).addClass('selected');
			theaterInfo();
			param();
			T = true;
			if(M == true && D == true && T==true){
				MTD_Ajax();
			}else if(M == true && T == true){
				MT_Ajax();
			}else if(T == true && D == true){
				TD_Ajax();
			}else if(T == true){
				T_Ajax();
			}
			$("#endParamTd2").html("<td>극장<br>일시<br>상영관<br>인원<br></td>");
		});
		$(".btnDate").click(function(){
			$('.btnDate').removeClass('selected');
			$(this).addClass('selected');
			theaterInfo();
			param();
			D = true;
			if(M == true && D == true && T==true){
				MTD_Ajax();
			}else if(M == true && D == true){
				MD_Ajax();
			}else if(T == true && D == true){
				TD_Ajax();
			}else if(D == true){
				D_Ajax();
			}
		});
		
		function M_Ajax(){
			$.ajax({
				url: "MTDAjax",
				data: {
					movie_title: $('.btnMovie.selected').data('movie_title')
				},
				dataType: "json",
			    success: function(data) {
			    	$(".overflow.theater").html("<b>극장</b>");
			    	$(".overflow.date").html('<b>날짜</b><span>2024<b style="background: transparent; color: black; font-size: 30px;" >1</b></span>');
			    	
			    	let theaterNameArr = [];
			       	let playDateArr = [];
			    	//선택한 영화에 해당하는 극장, 날짜의 배열생성
			    	for(let result of data){
			    		theaterNameArr.push(result.theater_name);
			    	}
			    	for(let result of data){
			    		playDateArr.push(result.play_date);
			    	}
			    	//중복 제거를 위한 Set객체 사용
			    	let uniqueTheaterNameData = new Set(theaterNameArr);
			    	let uniquePlayDateData = new Set(playDateArr);
			    	
			    	
			     	for(let theater of uniqueTheaterNameData){
				    	$(".overflow.theater").append("<input type ='button' value="+ theater +" class='btnTheater'><br>");

			     	}
			     	for (let date of uniquePlayDateData) {
			     	    let viewDate = formatDate(date);
			     	    var week = viewDate.charAt(0);
			     	    var day = viewDate.slice(1);
			     	    let textColor = week == '일' ? 'red' : week == '토' ? 'blue' : 'black';
			     	    $(".overflow.date").append("<input type='button' value='" + week + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + day + "' data-date='" + date + "' class='btnDate' style='color: " + textColor + ";'><br>");
			     	}


			     	$(".btnTheater").click(function(){
						$('.btnTheater').removeClass('selected');
						$(this).addClass('selected');
						theaterInfo();
						param();
						T = true;
						if(M == true && D == true && T==true){
							MTD_Ajax();
						}else if(M == true && T == true){
							MT_Ajax();
						}else if(T == true && D == true){
							TD_Ajax();
						}else if(T == true){
							T_Ajax();
						}
						$("#endParamTd2").html("<td>극장<br>일시<br>상영관<br>인원<br></td>");
					});
					$(".btnDate").click(function(){
						$('.btnDate').removeClass('selected');
						$(this).addClass('selected');
						theaterInfo();
						param();
						D = true;
						if(M == true && D == true && T==true){
							MTD_Ajax();
						}else if(M == true && D == true){
							MD_Ajax();
						}else if(T == true && D == true){
							TD_Ajax();
						}else if(D == true){
							D_Ajax();
						}
					});

   				},//success end
			    error:function(data){
			    	alert("ajax실패!");
			    }
			});//ajax end
				
		}// M_Ajax
		function T_Ajax(){
			$.ajax({
				url: "MTDAjax",
				data: {
					theater_name: $('.btnTheater.selected').val()
				},
				dataType: "json",
			    success: function(data) {
			    	$(".overflow.movie").html("<b>영화</b>");
			    	$(".overflow.date").html('<b>날짜</b><span>2024<b style="background: transparent; color: black; font-size: 30px;" >1</b></span>');
			    	
			       	let movieArr = [];
			       	let playDateArr = [];
			    	//선택한 극장에 해당하는 영화, 날짜의 배열생성
			    	for(let result of data){
			    		const movieObj = {
		    				movie_title: result.movie_title,
	    			        movie_rating: result.movie_rating,
	    			        movie_poster: result.movie_poster
	    			    };
		    			movieArr.push(movieObj);
			    	}
			    	for(let result of data){
			    		playDateArr.push(result.play_date);
			    	}
			    	console.log(movieArr);
			    	//중복 제거를 위한 Set객체 사용
			    	let uniqueMovieData = new Set(movieArr);
			    	let uniquePlayDateData = new Set(playDateArr);
			    	
			    	let uniqueTitles = [];
			    	for (let movie of uniqueMovieData) {
			    		if (uniqueTitles.includes(movie.movie_title)) {
			    	        continue; // 이미 출력된 영화인 경우 반복문 건너뛰기
			    	    }
			    	    uniqueTitles.push(movie.movie_title); // 출력된 영화 제목 저장
			    	    
			    		if (movie.movie_rating == "12세관람가") {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="twelveYearsOld">12</span>' + movie.movie_title + "</button><br>");
			    		} else if (movie.movie_rating == "15세관람가") {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="fifteenYearsOld">15</span>' + movie.movie_title + "</button><br>");
			    		} else if (movie.movie_rating == "18세관람가(청소년관람불가)") {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="eighteenYearsOld">18</span>' + movie.movie_title + "</button><br>");
			    		} else {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="allUsers">ALL</span>' + movie.movie_title + "</button><br>");
			    		}
			    	}								
			    	for (let date of uniquePlayDateData) {
			     	    let viewDate = formatDate(date);
			     	    var week = viewDate.charAt(0);
			     	    var day = viewDate.slice(1);
			     	    let textColor = week == '일' ? 'red' : week == '토' ? 'blue' : 'black';
			     	    $(".overflow.date").append("<input type='button' value='" + week + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + day + "' data-date='" + date + "' class='btnDate' style='color: " + textColor + ";'><br>");
			     	}
			     	$(".btnMovie").click(function(){
						$('.btnMovie').removeClass('selected');
						$(this).addClass('selected');
					    $('#Result_M').html('<img src='+ $('.btnMovie.selected').data('movie_poster') +' alt="이미지 예시" width="75" height="95">'+ '<span class="endparamMoviename">'+$('.btnMovie.selected').data('movie_title')+'</span>');
					    $('#Result_M').css('font-size', '12px');
			            $('#Result_M').css('color', 'white');
						param();
						M = true;
						
						if(M == true && D == true && T==true){
							MTD_Ajax();
						}else if(M == true && D == true){
							MD_Ajax();
						}else if(M == true && T == true){
							MT_Ajax();
						}else if(M == true){
							M_Ajax();
						}
						
					});
			     	$(".btnDate").click(function(){
						$('.btnDate').removeClass('selected');
						$(this).addClass('selected');
						theaterInfo();
						param();
						D = true;
						if(M == true && D == true && T==true){
							MTD_Ajax();
						}else if(M == true && D == true){
							MD_Ajax();
						}else if(T == true && D == true){
							TD_Ajax();
						}else if(D == true){
							D_Ajax();
						}
					});
				},//success end
			    error:function(data){
			    	alert("ajax실패!");
			    }
			});//ajax end
				
		}
		function D_Ajax(){
			$.ajax({
				url: "MTDAjax",
				data: {
					play_date: $('.btnDate.selected').data('date')
				},
				dataType: "json",
			    success: function(data) {
			    	$(".overflow.movie").html("<b>영화</b>");
			    	$(".overflow.theater").html("<b>극장</b>");
			    	
			    	let movieArr = [];
			       	let theaterNameArr = [];
			    	//선택한 극장에 해당하는 영화, 날짜의 배열생성
			       	for(let result of data){
			    		const movieObj = {
		    				movie_title: result.movie_title,
	    			        movie_rating: result.movie_rating,
	    			        movie_poster: result.movie_poster
	    			    };
		    			movieArr.push(movieObj);
			    	}
			    	for(let result of data){
			    		theaterNameArr.push(result.theater_name);
			    	}
			    	//중복 제거를 위한 Set객체 사용
			    	let uniqueMovieData = new Set(movieArr);
			    	let uniqueTheaterNameData = new Set(theaterNameArr);
			    	
			    	let uniqueTitles = [];
			    	for (let movie of uniqueMovieData) {
			    		if (uniqueTitles.includes(movie.movie_title)) {
			    	        continue; // 이미 출력된 영화인 경우 반복문 건너뛰기
			    	    }
			    	    uniqueTitles.push(movie.movie_title); // 출력된 영화 제목 저장
			    		if (movie.movie_rating == "12세관람가") {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="twelveYearsOld">12</span>' + movie.movie_title + "</button><br>");
			    		} else if (movie.movie_rating == "15세관람가") {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="fifteenYearsOld">15</span>' + movie.movie_title + "</button><br>");
			    		} else if (movie.movie_rating == "18세관람가(청소년관람불가)") {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="eighteenYearsOld">18</span>' + movie.movie_title + "</button><br>");
			    		} else {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="allUsers">ALL</span>' + movie.movie_title + "</button><br>");
			    		}
			    		
			    	}		
			     	for(let theater of uniqueTheaterNameData ){
				    	$(".overflow.theater").append("<input type ='button' value="+ theater +" class='btnTheater'><br>");
			     	}
			     	
			     	$(".btnMovie").click(function(){
						$('.btnMovie').removeClass('selected');
						$(this).addClass('selected');
					    $('#Result_M').html('<img src='+ $('.btnMovie.selected').data('movie_poster') +' alt="이미지 예시" width="75" height="95">'+ '<span class="endparamMoviename">'+$('.btnMovie.selected').data('movie_title')+'</span>');
					    $('#Result_M').css('font-size', '12px');
			            $('#Result_M').css('color', 'white');
						param();
						M = true;
						
						if(M == true && D == true && T==true){
							MTD_Ajax();
						}else if(M == true && D == true){
							MD_Ajax();
						}else if(M == true && T == true){
							MT_Ajax();
						}else if(M == true){
							M_Ajax();
						}
						
					});
					
					$(".btnTheater").click(function(){
						$('.btnTheater').removeClass('selected');
						$(this).addClass('selected');
						theaterInfo();
						param();
						T = true;
						if(M == true && D == true && T==true){
							MTD_Ajax();
						}else if(M == true && T == true){
							MT_Ajax();
						}else if(T == true && D == true){
							TD_Ajax();
						}else if(T == true){
							T_Ajax();
						}
						$("#endParamTd2").html("<td>극장<br>일시<br>상영관<br>인원<br></td>");
					});
			     	
				},//success end
				error:function(data){
					alert("D_Ajax 실패!");
				}// error end
			});// ajax end
		}
		function MT_Ajax(){
			$.ajax({
				url: "MTDAjax",
				data: {
					movie_title: $('.btnMovie.selected').data('movie_title')
					,theater_name: $('.btnTheater.selected').val()
				},
				dataType: "json",
			    success: function(data) {
			    	$(".overflow.date").html('<b>날짜</b><span>2024<b style="background: transparent; color: black; font-size: 30px;" >1</b></span>');
			       	let playDateArr = [];
			    	//선택한 극장에 해당하는 영화, 날짜의 배열생성
			    	for(let result of data){
			    		playDateArr.push(result.play_date);
			    	}
			    	//중복 제거를 위한 Set객체 사용
			    	let uniquePlayDateData = new Set(playDateArr);
			    	for (let date of uniquePlayDateData) {
			     	    let viewDate = formatDate(date);
			     	    var week = viewDate.charAt(0);
			     	    var day = viewDate.slice(1);
			     	    let textColor = week == '일' ? 'red' : week == '토' ? 'blue' : 'black';
			     	    $(".overflow.date").append("<input type='button' value='" + week + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + day + "' data-date='" + date + "' class='btnDate' style='color: " + textColor + ";'><br>");
			     	}
			     	$(".btnDate").click(function(){
						$('.btnDate').removeClass('selected');
						$(this).addClass('selected');
						theaterInfo();
						param();
						D = true;
						if(M == true && D == true && T==true){
							MTD_Ajax();
						}else if(M == true && D == true){
							MD_Ajax();
						}else if(T == true && D == true){
							TD_Ajax();
						}else if(D == true){
							D_Ajax();
						}
					});
			    },//success End
			    error:function(data){
			    	alert("ajax실패!");
			    }//error End
			});// ajax end
		}
		function MD_Ajax(){
			$.ajax({
				url: "MTDAjax",
				data: {
					movie_title: $('.btnMovie.selected').data('movie_title')
					,play_date: $('.btnDate.selected').data('date')
				},
				dataType: "json",
			    success: function(data) {
					$(".overflow.theater").html("<b>극장</b>");
			       	let theaterNameArr = [];
			    	//선택한 극장에 해당하는 영화, 날짜의 배열생성
			    	for(let result of data){
			    		theaterNameArr.push(result.theater_name);
			    	}
			    	//중복 제거를 위한 Set객체 사용
			    	let uniqueTheaterNameData = new Set(theaterNameArr);
			    	for(let theater of uniqueTheaterNameData ){
				    	$(".overflow.theater").append("<input type ='button' value="+ theater +" class='btnTheater'><br>");
			     	}
			    	$(".btnTheater").click(function(){
						$('.btnTheater').removeClass('selected');
						$(this).addClass('selected');
						theaterInfo();
						param();
						T = true;
						if(M == true && D == true && T==true){
							MTD_Ajax();
						}else if(M == true && T == true){
							MT_Ajax();
						}else if(T == true && D == true){
							TD_Ajax();
						}else if(T == true){
							T_Ajax();
						}
						$("#endParamTd2").html("<td>극장<br>일시<br>상영관<br>인원<br></td>");
					});
			     	
			    },//success End
			    error:function(data){
			    	alert("ajax실패!");
			    }//error End
			});// ajax end
		}
		function TD_Ajax(){
			$.ajax({
				url: "MTDAjax",
				data: {
					theater_name: $('.btnTheater.selected').val()
					,play_date: $('.btnDate.selected').data('date')
				},
				dataType: "json",
			    success: function(data) {
			    	$(".overflow.movie").html("<b>영화</b>");
			    	
			       	let movieArr = [];
			    	//선택한 극장에 해당하는 영화, 날짜의 배열생성
			       	for(let result of data){
			    		const movieObj = {
		    				movie_title: result.movie_title,
	    			        movie_rating: result.movie_rating,
	    			        movie_poster: result.movie_poster
	    			    };
		    			movieArr.push(movieObj);
			    	}
			    	//중복 제거를 위한 Set객체 사용
			    	let uniqueMovieData = new Set(movieArr);
			    	
			    	
			    	let uniqueTitles = [];
			    	for (let movie of uniqueMovieData) {
			    		if (uniqueTitles.includes(movie.movie_title)) {
			    	        continue; // 이미 출력된 영화인 경우 반복문 건너뛰기
			    	    }
			    	    uniqueTitles.push(movie.movie_title); // 출력된 영화 제목 저장
			    	    if (movie.movie_rating == "12세관람가") {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="twelveYearsOld">12</span>' + movie.movie_title + "</button><br>");
			    		} else if (movie.movie_rating == "15세관람가") {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="fifteenYearsOld">15</span>' + movie.movie_title + "</button><br>");
			    		} else if (movie.movie_rating == "18세관람가(청소년관람불가)") {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="eighteenYearsOld">18</span>' + movie.movie_title + "</button><br>");
			    		} else {
			    		    $(".overflow.movie").append("<button type='button' class='btnMovie' data-movie_title='" + movie.movie_title + "' data-movie_poster='" + movie.movie_poster + "'>" + '<span class="allUsers">ALL</span>' + movie.movie_title + "</button><br>");
			    		}
			    		
			    	}	
			    	$(".btnMovie").click(function(){
						$('.btnMovie').removeClass('selected');
						$(this).addClass('selected');
					    $('#Result_M').html('<img src='+ $('.btnMovie.selected').data('movie_poster') +' alt="이미지 예시" width="75" height="95">'+ '<span class="endparamMoviename">'+$('.btnMovie.selected').data('movie_title')+'</span>');
					    $('#Result_M').css('font-size', '12px');
			            $('#Result_M').css('color', 'white');
						param();
						M = true;
						
						if(M == true && D == true && T==true){
							MTD_Ajax();
						}else if(M == true && D == true){
							MD_Ajax();
						}else if(M == true && T == true){
							MT_Ajax();
						}else if(M == true){
							M_Ajax();
						}
						
					});
			    },//success End
			    error:function(data){
			    	alert("ajax실패!");
			    }//error End
			});// ajax end
		}
		
		function MTD_Ajax(){
			$.ajax({
				url: "reserveAjax",
				data: {
					movie_title: $('.btnMovie.selected').data('movie_title')
					,theater_name: $('.btnTheater.selected').val()
					,play_date: $('.btnDate.selected').data('date')
				},
				dataType: "JSON",
			    success: function(data) {
			    	console.log(data)
			    	// 이전에 있던 데이터 제거
			    	$(".overflow.time").html("<b>시간</b>");
			    	let roomNameArr = [];
			    	//선택한 영화, 극장, 날짜의 상영관 배열생성
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
						theaterInfo();
						param();
					});
					
					if(data==''){
				    	if(confirm("상영일정이 없습니다. 다시 선택 하시겠습니까?")){
				    		location.reload();
				    	}else{
				    		// 취소 시 선택한 데이터는 그대로
				    	}
					}
					
			    }//success end
			    
			});//ajax end
			
		}//ajax function end
		
		// 날짜 형식 변환 함수
		function formatDate(dateString) {
		    var date;

		    if (typeof dateString === 'string') {
		        date = new Date(dateString);
		    } else if (dateString instanceof Date) {
		        date = dateString;
		    } else {
		        throw new Error('Invalid date format');
		    }

		    var year = date.getFullYear();
		    var month = date.getMonth() + 1;
		    var day = date.getDate();

		    // 월을 'M' 형식으로 변환
		    var formattedMonth = (month < 10) ? '0' + month : month.toString();

		    // 일을 'D' 형식으로 변환
			var formattedDay = (day < 10) ? day : day.toString();


		    // 요일을 구함
		    var daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
		    var dayOfWeek = daysOfWeek[date.getDay()];

		    // 변환된 날짜와 요일을 반환
		    return dayOfWeek+formattedDay;
		}
		
		function theaterInfo(){
			let $selectedTheater = $('.btnTheater.selected');
			let selectTheaterValue;
			if ($selectedTheater.length > 0) {
				selectTheaterValue = $selectedTheater.val();
			} else {
				selectTheaterValue = "";
			}
			
			let $selectedDate = $('.btnDate.selected');
			let selectDateValue;
			if ($selectedDate.length > 0) {
				selectDateValue = $selectedDate.data('date');
			} else {
				selectDateValue = "";
			}
			
			let $selectedRoom = $('.btnTime.selected');
			let selectRoomValue;
			if ($selectedRoom.length > 0) {
				selectRoomValue = $selectedRoom.prop('id');
			} else {
				selectRoomValue = "";
			}
			
			let $selectedTime = $('.btnTime.selected');
			let selectTimeValue;
			if ($selectedTime.length > 0) {
				selectTimeValue = $selectedTime.val();
			} else {
				selectTimeValue = "";
			}
			
			
			$('#Result_T').html(
			    	"<table id='secondInfoTable'>"
			    	+"<tr>"
			    	+"<td class='widthSmall'>극장</td>"
			    	+"<td>"+ selectTheaterValue +"</td>"
			    	+"</tr>"
			    	+"<tr>"
			    	+"<td class='widthSmall'>일시</td>"
			    	+"<td>"+selectDateValue+" "+selectTimeValue+"</td>"
			    	+"</tr>"
			    	+"<tr>"
			    	+"<td class='widthSmall'>상영관</td>"
			    	+"<td>"+selectRoomValue+"</td>"
			    	+"</tr>"
			    	+"<tr>"
			    	+"<td class='widthSmall'>인원</td>"
			    	+"<td></td>"
			    	+"</tr>"
			    	+"</table>"
			    	);
		}
		
		function param() {
			// selectedValues의 각 속성을 각각의 hidden input 태그에 설정
			$("#movie_name").val($('.btnMovie.selected').data('movie_title')); 
			$("#movie_poster").val($('.btnMovie.selected').data('movie_poster')); 
			$("#movie_rating").val($('.btnMovie.selected span').text()); 
			$("#theater_name").val($('.btnTheater.selected').val());
			$("#play_date").val($('.btnDate.selected').data('date'));
			$("#room_name").val($('.btnTime.selected').prop('id'));
			$("#play_start_time").val($('.btnTime.selected').val());
		}
		
		$('.btnReset').click(function() {
		  location.reload();// 페이지를 새로고침합니다.
		});
	});// document.ready END
	function subBtn(){
		let sId = '<%= session.getAttribute("sId") %>';   	
		if(sId == null){
			if(confirm("로그인이 필요한서비스입니다. 로그인하시겠습니까?")){
				location.href = "memberLogin";
			}else{// 취소 버튼 클릭시 좌석 선택페이지로 넘어가지 않고 현재 페이지 그대로 유지}
			}
			return false;
		}
		if($("#movie_name").val()==""){
			alert("영화선택 필수!")
			return false;
		}
		if($("#theater_name").val()==""){
			alert("극장선택 필수!")
			return false;
		}
		if($("#play_date").val()==""){
			alert("날짜선택 필수!")
			return false;
		}
		if($("#play_start_time").val()==""){
			alert("시간선택 필수!")
			return false;
		}
	}

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
					<button class="btnReset" style="border: none;"><img src="${pageContext.request.contextPath }/resources/img/reserveReset.jpg"></button>
				</div>
				<div id = "reserve_parameter">
						<div class="overflow movie" id="movie_title"><b>영화</b>
							<c:forEach var="movieList" items="${movieList}">
								<c:choose>
									<c:when test="${movieList.movie_title eq param_movie_title}">
										<button type="button" class="btnMovie" id="selectedVal" data-movie_title="${movieList.movie_title}" data-movie_poster="${movieList.movie_poster}" data-movie_rating="${movieList.movie_rating}">
										 	<c:choose>
											<c:when test="${movieList.movie_rating eq '12세관람가'}"><span class="twelveYearsOld">12</span></c:when>
											<c:when test="${movieList.movie_rating eq '15세관람가'}"><span class="fifteenYearsOld">15</span></c:when>
											<c:when test="${movieList.movie_rating eq '18세관람가(청소년관람불가)'}"><span class="eighteenYearsOld">18</span></c:when>
											<c:otherwise><span class="allUsers">ALL</span></c:otherwise>
											</c:choose>
										 	${movieList.movie_title}
										</button><br>
										<script>
									        $(document).ready(function() {
									            $("#selectedVal").click(function(){
									                $('.btnMovie').removeClass('selected');
									                $(this).addClass('selected');
									    		    $('#Result_M').html('<img src='+ $('.btnMovie.selected').data('movie_poster') +' alt="이미지 예시" width="75" height="95">'+ '<span class="endparamMoviename">'+$('.btnMovie.selected').data('movie_title')+'</span>');
									                param();
									                M = true;
								                    M_Ajax();
									            });
									
									            // 조건을 만족할 경우 $(".btnMovie").click() 호출
									            $("#selectedVal").click();
									        });
									    </script>
									</c:when>
									<c:otherwise></c:otherwise>
								</c:choose>
							</c:forEach>
							<c:forEach var="movieList" items="${movieList}">
								<c:choose>
									<c:when test="${movieList.movie_title eq param_movie_title}"></c:when>
									<c:otherwise>
										<button type="button" class="btnMovie" data-movie_title="${movieList.movie_title}" data-movie_poster="${movieList.movie_poster}" data-movie_rating="${movieList.movie_rating}">
										 	<c:choose>
											<c:when test="${movieList.movie_rating eq '12세관람가'}"><span class="twelveYearsOld">12</span></c:when>
											<c:when test="${movieList.movie_rating eq '15세관람가'}"><span class="fifteenYearsOld">15</span></c:when>
											<c:when test="${movieList.movie_rating eq '18세관람가(청소년관람불가)'}"><span class="eighteenYearsOld">18</span></c:when>
											<c:otherwise><span class="allUsers">ALL</span></c:otherwise>
											</c:choose>
										 	${movieList.movie_title}
										 </button><br>

									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div> 
						<div class="overflow theater"><b>극장</b>

							<c:forEach var="theaterList" items="${theaterList}">
								<input type ="button" value="${theaterList.theater_name}" class="btnTheater"><br>
							</c:forEach>
						</div>
						<div class="overflow date"><b>날짜</b><span>2024<b style="background: transparent; color: black; font-size: 30px;" >1</b></span>
							<c:forEach var="playList" items="${playList}">
								<fmt:parseDate var="date" value="${playList.play_date}" pattern="yyyy-MM-dd" />
								<fmt:formatDate value='${date}' pattern='E          d' var='viewDate'/>
								<input type="button" value="${viewDate}" data-date="${playList.play_date}" class="btnDate" style="color: ${fn:containsIgnoreCase(viewDate, '일') ? 'red' : fn:containsIgnoreCase(viewDate, '토') ? 'blue' : 'black'};"><br>
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
						<td id="Result_M">영화선택</td>
						<td id="Result_T">극장선택</td>
						<td class="Result_S">좌석선택</td>
						<td class="Result_P">결제</td>
						<td id="selectSeatBtn">
							<form action="seatSelect" onsubmit="return subBtn()" method="get">
							    <input type="hidden" name="movie_title" id="movie_name" value="">
							    <input type="hidden" name="movie_poster" id="movie_poster" value="">
							    <input type="hidden" name="movie_rating" id="movie_rating" value="">
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