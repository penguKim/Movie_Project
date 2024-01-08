<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영 일정 등록</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources//js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	
	// 데이터 조회해 상영 일시를 판별해 음영처리
	$(function(){
		// 현재 시간 가져오기
		var currentTime = new Date();
		
		// 각 tr 태그 반복해 상영 종료 시간과 상영 날짜 가져옴
		$("tr").each(function() {
			var playEndTime = $(this).find("#play_end_time_mod").text();
			var playDate = $(this).find("#play_date_mod").text();
			
			// 상영 종료 시간과 상영 날짜를 합친 문자열 new Date() 함수에 전달하여 자바스크립트의 Date 객체로 변환
			var endTime = new Date(playDate + " " + playEndTime);
			
			if (endTime < currentTime) { // 시간 비교해 현재 이전인 경우 
				$(this).css("background-color", "lightgray"); // 배경색 지정해 음영처리
			}
		});
		
	});
	

	$(function() {
		// 지점명 불러오기
		$.ajax({
			type: "GET",
			url: "getTheater",
			success: function(result) {
				for(let theater of result) {
					$("#theater_id").append("<option value='" + theater.theater_id + "'>" + theater.theater_name + "</option>");
				}
				
				// 상영관 불러오기
				$("#theater_id").change(function() {
					let theater_id = $("#theater_id").val();
					$.ajax({
						type: "GET",
						url: "getRoom",
						data: {
							theater_id : theater_id
						},
						success: function(result) {
							$("#room_id").empty();
							$("#room_id").append("<option value=''>상영관 선택</option>");
							for(let room of result) {
								$("#room_id").append("<option value='" + room.room_id + "'>" + room.room_name + "</option>");
							}
						},
						error: function(xhr, textStatus, errorThrown) {
							alert("상영관 로딩 오류입니다.");
						}
						
					});
				});
				
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("지점명 로딩 오류입니다.");
			}
			
		});
	});

		
	$(function() {	
		// 상영중인 영화 불러오기
		$.ajax({
			type: "GET",
			url: "nowPlaying",
			success: function(result) {
				for(let movie of result) {
					$("#movie_id").append("<option value='" + movie.movie_id + "'>" + movie.movie_title + "</option>");
				}
				
				// 선택 가능한 날짜 불러오기
				$("#movie_id").change(function() {
					let movie_id = $("#movie_id").val();
					$.ajax({
						type: "GET",
						url: "getMovieInfo",
						data: {
							movie_id : movie_id
						},
						success: function(result) {
							if(movie_id != '') {						
								let release_date = new Date(result.movie_release_date + 86400000); // 밀리초단위를 날짜로 변환
								let f_release_date = release_date.toISOString().split('T')[0]; // 날짜의 형태를 0000-00-00으로 변환
								let close_date = new Date(result.movie_close_date + 86400000); // 밀리초단위를 날짜로 변환
								let f_close_date = close_date.toISOString().split('T')[0]; // 날짜의 형태를 0000-00-00으로 변환
								let now = new Date();  // 현재 날짜와 시간을 가져옵니다.
								now.setDate(now.getDate() + 1);  // 현재 날짜에 1일을 더합니다.
								let tomorrow = now.toISOString().split('T')[0];
								// 일정을 미리 등록하는 것이므로 오늘 날짜 이전은 등록할 수 없음
								if(now > release_date) { // 오늘 이전에 개봉해도 오늘 날짜 이전은 선택할 수 없다(내일것부터 일정 정할 수 있음)
									$("#date").html("<input type='date' id='play_date' name='play_date' min='" + tomorrow + "' max='" + f_close_date + "'>");									
								} else { // 오늘 이후에 개봉하는 것은 미리 등록해둘 수 있음
									$("#date").html("<input type='date' id='play_date' name='play_date' min='" + f_release_date + "' max='" + f_close_date + "'>");									
								}
								
								
								
								// 해당 일자의 해당하는 상영관의 스캐줄 가져와서
								// 중복되는 시간에 상영일정 잡지 못하게 막기
								// 해당 상영관, 해당 일자 필요함(지점은 X)
								$("#play_date").on("input", function() { 
//						 		
									console.log("date blur 이벤트 발생!");
									let room_id = $("#room_id").val();
									let play_date = $("#play_date").val();
									console.log(room_id +", "+ play_date);
									
								    let timeOption = []; // 상영 시간 모든 옵션 담을 배열 생성
								    
								    
									$.ajax({
										type: "GET",
										url: "getPlayTimeInfo",
										data: {
											room_id : room_id,
											play_date : play_date
										},
										success: function(result) {
//						 					console.log(JSON.stringify(result));
											// 각 배열에 가지고 있는 값: movie_id, play_date, play_end_time, play_id, play_start_time, play_turn, room_id
											if(result == "") { // 이전 등록한 상영 일정이 없는 경우
						 						$("#play_start_time").html(
					 								"<option value=''>시작 시간 선택</option><option value='09:00'>09:00</option><option value='10:00'>10:00</option>"
					 								+ "<option value='11:00'>11:00</option><option value='12:00'>12:00</option><option value='13:00'>13:00</option>"
					 								+ "<option value='14:00'>14:00</option><option value='15:00'>15:00</option><option value='16:00'>16:00</option>"
													+ "<option value='17:00'>17:00</option><option value='18:00'>18:00</option><option value='19:00'>19:00</option>"
													+ "<option value='20:00'>20:00</option><option value='21:00'>21:00</option>");
						 					} else { // 이전 등록한 상영 일정이 있는 경우
						 								
						 						timeOption = 
						 							$('#play_start_time option').map(function() {
													  return $(this).val();
													}).get();
												// 옵션 밸류값 : ,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00

												let disabledTime = [];	// disabled 처리된 값을 담을 배열 생성
													
						 						for(var i = 0; i < result.length; i++) { // 반복문을 통해 result 배열의 각 요소에 접근
						 							let value = result[i].play_start_time;
													let intStartTimeHour = parseInt(result[i].play_start_time.split(":")[0]);
													let intEndTimeHour = parseInt(result[i].play_end_time.split(":")[0]);
													// => 비교를 위해 변환 필요
// 													console.log(intStartTimeHour, intEndTimeHour);
// 													console.log(typeof(intStartTimeHour), typeof(intEndTimeHour));
													
													for(var j = 0; j < timeOption.length; j++) {
						 								if(value == timeOption[j]) { // 옵션의 value와 이미 등록된 영화의 시작 시간이 같을 경우
							 								// 기본적으로 영화가 1시간 이상이므로 두 타임을 차지하고 있으므로
							 								// j, j+1을 disabled 처리   
							 								$("#play_start_time option").eq(j).attr("disabled", true);
							 								$("#play_start_time option").eq(j+1).attr("disabled", true);
//						 	 								console.log("디스에이블드값1 = " + $("#play_start_time option").eq(j).val() + "디스에이블드값2 = " + $("#play_start_time option").eq(j+1).val())
//						 									disabledTime.push(parseInt($("#play_start_time option").eq(j).val().split(":")[0]));
//						 									disabledTime.push(parseInt($("#play_start_time option").eq(j+1).val().split(":")[0]));
							 								
							 								if(intEndTimeHour - intStartTimeHour == 2) { // 이미 등록된 영화가 두시간 이상일 경우
								 								$("#play_start_time option").eq(j+2).attr("disabled", true); // j+2도 disabled 처리
//						 										disabledTime.push(parseInt($("#play_start_time option").eq(j+2).val().split(":")[0]));
															}
														} 
						 								
						 							} // 안쪽 for문 끝
						 						
						 						} // 바깥쪽 for문 끝	
						 						
						 						// ---------- 선택한 영화를 남은 시간에 등록할 수 있는지 판단 ------
						 						// disabled 여부를 true/false로 반환
						 						// disabled면(선택불가능) true / 선택가능이면 false
						 						let isDisabled = []; // 선택한 영화 등록 가능 여부 담을 배열 생성(true: 선택불가능 / false: 선택가능)
						 						for(let i = 0; i < timeOption.length; i++) {
						 							if($("#play_start_time option").eq(i).attr("disabled")) { // disabled가 맞으면
						 								isDisabled.push(true);	
						 							} else { // disabled가 아니면
						 								isDisabled.push(false);	
						 							}
						 						}
						 						// 러닝타임에 따라 영화를 비어있는 중간시간에 상영할수있는지 없는지를 판별하는 함수 호출
						 						$("#play_start_time").click(function() {
						 							selectable(isDisabled);
							 						console.log(isDisabled);
						 						});				

											} // if-else문 끝 
											
										}, // success 끝
										error: function(xhr, textStatus, errorThrown) {
											alert("종료 시간 출력 오류입니다.");
										}
									});
									
								});
											
							}
						},
						error: function(xhr, textStatus, errorThrown) {
							alert("상영관 로딩 오류입니다.");
						}
					});
				});
			
				// 러닝타임에 따라 영화를 비어있는 중간시간에 상영할수있는지 없는지를 판별하는 함수 정의
				function selectable(isDisabled) {
					console.log(isDisabled);
					// 선택한 영화의 러닝타임을 가져와서 시간 단위로 나누기
					let movie_id = $("#movie_id").val();
						
					$.ajax({
						type: "GET",
						url: "getMovieInfo",
						data: {
							movie_id : movie_id
						},
						success: function(result) {
							let movie_runtime = result.movie_runtime;
								
							// 러닝타임을 60분으로 나눈 다음 몫을 구한 다음 +1을 해주면
							// 시간 셀렉트박스에 몇 칸을 차지하는지 알 수 있다
							// (78분 영화의 경우 1.xxx가 나오므로 2타임을 차지한다!)
							let movieTime = Math.floor(movie_runtime / 60) + 1;
							
							// 선택한 영화가 차지하는 칸 movieTime (2 또는 3)
							// disabled면(선택불가능) true / 선택가능이면 false인
							// isDisabled 배열이 있음
							// movieTime이 2인 경우 = isDisabled[i], isDisabled[i+1] 중 하나라도 선택 불가능하면 글자 색상 변경
							// movieTime이 3인 경우 = isDisabled[i], isDisabled[i+1], isDisabled[i+2] 중 하나라도 선택 불가능하면 글자 색상 변경
							console.log("몇타임인지 : " + movieTime);
							
							if(movieTime == 2) { // 0번 인덱스가 ''인데?
								for(let i = 0; i < isDisabled.length; i++) {
									if(isDisabled[i] || isDisabled[i+1]) { // 연달아 있는 2칸중 한 칸이라도 선택 불가능하면(true)
										$("#play_start_time option").eq(i).attr("disabled", true);
									}
								}
							} else if(movieTime == 3) {
								for(let i = 0; i < isDisabled.length; i++) {
									if(isDisabled[i] || isDisabled[i+1] || isDisabled[i+2]) { // 연달아 있는 2칸중 한 칸이라도 선택 불가능하면(true)
										$("#play_start_time option").eq(i).attr("disabled", true);
									}
								}
							}
							
							
						},
						error: function(xhr, textStatus, errorThrown) {
							alert("종료 시간 출력 오류입니다.");
						}
					});
				}	
				
				// 영화 종료 시간 자동으로 계산
				$("#play_start_time").change(function() {
					let movie_id = $("#movie_id").val();
					let start_time = $("#play_start_time").val().split(":")[0];
					
					$.ajax({
						type: "GET",
						url: "getMovieInfo",
						data: {
							movie_id : movie_id
						},
						success: function(result) {
							if(start_time == '') {
								$("#play_end_time").val('');
							} else {
								let end_time = (start_time * 60) + parseInt(result.movie_runtime)
								
								let hours = Math.floor(end_time / 60); // 시간 계산
								let minutes = end_time % 60; // 분 계산
								
								// 시간과 분이 한 자리 수인 경우 0으로 채우기
								let formatted_hours = hours < 10 ? "0" + hours : hours;
								let formatted_minutes = minutes < 10 ? "0" + minutes : minutes;
								
								let formatted_end_time = formatted_hours + ":" + formatted_minutes; // "00:00" 형식으로 변환된 종료 시간
								
								$("#play_end_time").val(formatted_end_time);						
							}
						},
						error: function(xhr, textStatus, errorThrown) {
							alert("종료 시간 출력 오류입니다.");
						}
					});
				});
				
			},
			error: function(xhr, textStatus, errorThrown) {
				alert("상영중인 영화 로딩 오류입니다.");
			}
			
		});
	});

	
	$(function() {
		// 선행되어야 할 선택값이 필요한 경우 다음 선택을 하지 못하도록 막음
		$("#room_id").click(function() {
			if($("#theater_id").val() == '') {
				alert("지점을 선택해주세요");
				$("#theater_id").focus();
			}
		});
		
		$("#movie_id").click(function() {
			if($("#theater_id").val() == '') {
				alert("지점을 선택해주세요");
				$("#theater_id").focus();
			} else if($("#room_id").val() == '') {
				alert("상영관을 선택해주세요");
				$("#room_id").focus();
			}
		});
		
		$("#date").click(function() {
			if($("#theater_id").val() == '') {
				alert("지점을 선택해주세요");
				$("#theater_id").focus();
			} else if($("#room_id").val() == '') {
				alert("상영관을 선택해주세요");
				$("#room_id").focus();
			} else if($("#movie_id").val() == '') {
				alert("영화를 선택해주세요");
				$("#movie_id").focus();
			}
		});
		
		$("#play_start_time").click(function() {
			if($("#theater_id").val() == '') {
				alert("지점을 선택해주세요");
				$("#theater_id").focus();
			} else if($("#room_id").val() == '') {
				alert("상영관을 선택해주세요");
				$("#room_id").focus();
			} else if($("#movie_id").val() == '') {
				alert("영화를 선택해주세요");
				$("#movie_id").focus();
			} else if($("#play_date").val() == '') {
				alert("날짜를 선택해주세요");
				$("#play_date").focus();
			}
		});
	});
		
	$(function() {	
		// 등록하기
		$("#registForm").submit(function() {
			if($("#theater_id").val() == '') {
				alert("지점을 선택해주세요");
				$("#theater_id").focus();
				return false;
			} else if($("#room_id").val() == '') {
				alert("상영관을 선택해주세요");
				$("#room_id").focus();
				return false;
			} else if($("#movie_id").val() == '') {
				alert("영화를 선택해주세요");
				$("#movie_id").focus();
				return false;
			} else if($("#date>input").val() == '') {
				alert("상영날짜를 선택해주세요");
				$("#date>input").focus();
				return false;
			} else if($("#play_start_time").val() == '') {
				alert("상영시작시간을 선택해주세요");
				$("#play_start_time").focus();
				return false;
			} 
			
		});
	});
	


	// 이전에 선택한 tr의 id 값 저장할 변수 설정
	let previousTrId = null;

	// 수정 버튼 클릭 시
	function CannotDuplicateModify(currentTrId, play_start_time, play_date) {

		console.log(play_date);
		
		console.log("이전 tr : " + previousTrId);
		console.log("파라미터로 넘어온 현재 tr :" + currentTrId);
		
		console.log(play_start_time);
		console.log(typeof(play_start_time));
		
		// 문자열 날짜를 정수형으로 변환
		let intPlayDate = convertStringDateToInt(play_date);
		
		// 오늘 날짜 가져오기
		let today = getToday();
		
		// 현재 시간 가져오기
		let currentTime = getCurrentTime();
		
	    // 문자열인 play_start_time을 정수형으로 변환하는 함수 호출해 변수에 저장
	    let intPlayStartTime = convertStringTimeToInt(play_start_time);
		
		// 현재 일시와 비교
		if(intPlayDate < today || (intPlayDate == today && intPlayStartTime < currentTime)) {
		// => 기준 날짜가 오늘 이전인 경우
		//    혹은 오늘과 같지만 영화 시작시간이 현재 시각 이전인 경우
			alert("이전 상영일정은 수정할 수 없습니다!");
			
		} else {
			// 클릭한 버튼이 속한 행을 선택합니다.
	     	var row = $(".btnModify_" + currentTrId).closest("tr");
	
	        // 버튼 이름 변경 (수정->완료)
	        $(row).find(".btnModify_" + currentTrId).val("완료");
	        
	
	        // 이전에 선택한 <tr>이 있을 때의 처리
	        if(previousTrId && previousTrId !== currentTrId) {
	// 			console.log("어떻게 처리하지");
	
	
				// 등록하기 이후 조회 처리와 동일 -> 이전 tr태그의 내용을 db에 등록된 정보로 덮어쓴다
				// 기존 play_id를 넘겨줘서 아래의 데이터들을 받아온다 
				// => 받아올 데이터 : theater_name, room_name, room_id, movie_title, movie_id, play_date, play_start_time, play_end_time
				$.ajax({
					type: "POST",
					url: "previousScheduleInfo",
					data: {
						previousTrId: previousTrId
					},
					success: function(result) {
						console.log(result);
						console.log("상영관 이름 : " + result.theater_name);
						$("#" + result.play_id).html(
								 '<td id="theater_name_mod" data-theater-name="' + result.theater_name + '">' + result.theater_name + '</td>'
								+ '<td id="room_name_mod" data-room_name="' + result.room_name + '">' + result.room_name + '</td>'
								+ '<input type="hidden" value="' + result.room_id+ '" id="room_id">'
								+ '<td id="movie_title_mod" data-movie_title="' + result.movie_title + '">' + result.movie_title + '</td>'
								+ '<input type="hidden" value="' + result.movie_id + '" id="movie_id">'
								+ '<td id="play_date_mod">' + result.play_date + '</td>' // 포맷 완료
								+ '<td id="play_start_time_mod" data-play_start_time="' + result.play_start_time + '">' + result.play_start_time + '</td>'
								+ '<td id="play_end_time_mod">' + result.play_end_time + '</td>'
								+ '<td><input type="button" value="수정" class="btnModify_' + result.play_id + '" onclick="CannotDuplicateModify(' + result.play_id + ', \'' + result.play_start_time + '\', \'' + result.play_date + '\')">'
								+ '</td><td><input type="hidden" value="' + result.play_id + '" name="play_id" id="play_id">'
								+ '<input type="button" value="삭제" id="btnDelete_' + result.play_id + '" onclick="confirmDelete(' + result.play_id + ', \'' + result.play_start_time + '\', \'' + result.play_date + '\')">'
								+ '</td>'
						);
					},
					error: function(xhr, textStatus, errorThrown) {
						console.log("요청 실패");
					}
				
					
				});
				
// 				// 이전에 선택한 tr을 다시 null로 초기화
// 				previousTrId = null;
				
	        } // 이전에 선택한 tr이 있는 경우 끝
	        
			
	        // 이전에 선택한 tr이 없는 경우 시작
	        
	
	        // 수정폼 띄우기
				
				// 해당하는 행의 play_id 가져오기
		        var play_id = row.find("#play_id").val();
		        console.log("play_id = " + play_id);
	
		   		// 각 칸에 대해 개별적으로 셀렉트 박스를 생성
		   		// 원래 db에 있던 속성을 불러옴
		        // 지점 선택
		        var theaterName = $("<select id='modifyTheater'></select>");
		        $(row).find("#theater_name_mod").html(theaterName);
		        
		        // 상영관 선택
		        var roomName = $("<select id='modifyRoom'></select>");
		        var roomId = $(row).find("#room_id").val();
		        roomName.append("<option value='" + roomId + "'>" + $(row).find('#room_name_mod').attr("data-room_name") + "</option>");
		        $(row).find("#room_name_mod").html(roomName);
		        
		   		// 영화 선택
		        var movieTitle = $("<select id='modifyMovie'></select>");
		        var movieId = $(row).find("#movie_id").val();
		        movieTitle.append("<option value='" + movieId + "'>" + $(row).find('#movie_title_mod').attr("data-movie_title") + "</option>");
		        $(row).find("#movie_title_mod").html(movieTitle);
		        
		    	// 상영 날짜 선택
				var playDate = $("<input type='date' id='modifyDate'>");
				playDate.val($(row).find("#play_date_mod").text());
				$(row).find("#play_date_mod").html(playDate);
				
				// 상영 시작 시간 선택
				var startTime = $("<select id='modifyStart'></select>");
				startTime.html(
				  "<option value=''>시작 시간 선택</option>" +
				  "<option value='09:00'>09:00</option>" +
				  "<option value='10:00'>10:00</option>" +
				  "<option value='11:00'>11:00</option>" +
				  "<option value='12:00'>12:00</option>" +
				  "<option value='13:00'>13:00</option>" +
				  "<option value='14:00'>14:00</option>" +
				  "<option value='15:00'>15:00</option>" +
				  "<option value='16:00'>16:00</option>" +
				  "<option value='17:00'>17:00</option>" +
				  "<option value='18:00'>18:00</option>" +
				  "<option value='19:00'>19:00</option>" +
				  "<option value='20:00'>20:00</option>" +
				  "<option value='21:00'>21:00</option>"
				);
	
				// 선택한 옵션 표시
				var selectedTime = $(row).find("#play_start_time_mod").data("play_start_time");
				startTime.val(selectedTime);
	
				// 선택한 요소에 새로운 <select> 요소로 대체
				$(row).find("#play_start_time_mod").html(startTime);
				
				
				// 상영 종료 시간 선택
		        var endTime = $("<input type='text' id='modifyEnd' readonly>");
		        endTime.val($(row).find("#play_end_time_mod").text());
		        $(row).find("#play_end_time_mod").html(endTime);
	

		        
		     	// 지점 불러오기
		        $.ajax({
					type: "GET",
					url: "getTheater",
					success: function(result) {
						theaterName.append("<option value='0'>지점 선택</option>");

						
						for(let theater of result) {
							if (theater.theater_name == $(row).find('#theater_name_mod').attr("data-theater-name")) {
				                theaterName.append("<option value='" + theater.theater_id + "' selected>" + theater.theater_name + "</option>");
				            } else {
				                theaterName.append("<option value='" + theater.theater_id + "'>" + theater.theater_name + "</option>");
				            }
						}

						

						
						 // 지점 선택에 따른 상영관 출력
						$("#modifyTheater").blur(function() {
							
						    var theater_id = $("#modifyTheater").val();
						    console.log("theater_id = " + theater_id);
						    
							$.ajax({
								type: "GET",
								url: "getRoom",
								data: {
									theater_id : theater_id
								},
								success: function(result) {
									roomName.html("<option value='0'>상영관 선택</option>");
									
									for(let room of result) {
										if(room.room_name == $(row).find('#room_name_mod').attr("data-room_name")) {
											roomName.append("<option value='" + room.room_id + "' selected>" + room.room_name + "</option>");
										} else {
											roomName.append("<option value='" + room.room_id + "'>" + room.room_name + "</option>");
										}
									}
									

	
								},
								error: function(xhr, textStatus, errorThrown) {
									alert("상영관 로딩 오류입니다.");
								}
								
							});
						});
						
					},
					error: function(xhr, textStatus, errorThrown) {
						alert("지점명 로딩 오류입니다.");
					}
				});
			   
				// 상영중인 영화 불러오기
				var room_id = $("#modifyRoom").val();
			    console.log("room_id = " + room_id);
		    	// 상영중인 영화 선택
				$.ajax({
					type: "GET",
					url: "nowPlaying",
					success: function(result) {
						movieTitle.html("<option value='0'>영화 선택</option>");
						for(let movie of result) {
							if (movie.movie_title == $(row).find('#movie_title_mod').attr("data-movie_title")) {
				                movieTitle.append("<option value='" + movie.movie_id + "' selected>" + movie.movie_title + "</option>");
				            } else {
				                movieTitle.append("<option value='" + movie.movie_id + "'>" + movie.movie_title + "</option>");
				            }
						}
	
					
							
						// 선택 가능한 날짜 불러오기
						$("#modifyMovie").blur(function() {
							let movie_id = $("#modifyMovie").val();
							$.ajax({
								type: "GET",
								url: "getMovieInfo",
								data: {
									movie_id : movie_id
								},
								success: function(result) {
									if(movie_id != '') { // 영화 정보가 존재하는 경우		
										let release_date = new Date(result.movie_release_date + 86400000); // 밀리초단위를 날짜로 변환
										let f_release_date = release_date.toISOString().split('T')[0]; // 날짜의 형태를 0000-00-00으로 변환
										let close_date = new Date(result.movie_close_date + 86400000); // 밀리초단위를 날짜로 변환
										let f_close_date = close_date.toISOString().split('T')[0]; // 날짜의 형태를 0000-00-00으로 변환
										
										let now = new Date();  // 현재 날짜와 시간을 가져와서
										now.setDate(now.getDate() + 1);  // 현재 날짜에 1일을 더하기
										let tomorrow = now.toISOString().split('T')[0]; // 현재보다 하루 뒤의 일자를 tomorrow 변수에 저장
										
										// 일정을 미리 등록하는 것이므로 오늘 날짜 이전은 등록할 수 없도록 처리
										if(now > release_date) { // 오늘 이전에 개봉해도 오늘 날짜 이전은 선택할 수 없다(내일것부터 일정 정할 수 있음)
											playDate.attr("min", tomorrow); // 상영시작가능일을 현재보다 하루 뒤의 일자로 지정
										} else { // 오늘 이후에 개봉하는 것은 미리 등록해둘 수 있음
											playDate.attr("min", f_release_date); // 상영시작가능일을 영화 정보에 등록된 개봉일로 지정
										}
										playDate.attr("max", f_close_date); // 상영종영일
										// 날짜선택에 최소값과 최대값 주기
										
	
										// 해당 일자의 해당하는 상영관의 스캐줄 가져와서
										// 중복되는 시간에 상영일정 잡지 못하게 막기
										// 해당 상영관, 해당 일자 필요함(지점은 X)
										$("#modifyDate").blur(function() {
											console.log("date blur 이벤트 발생!");
											let room_id = $("#modifyRoom").val();
											let play_date = $("#modifyDate").val();
											console.log(room_id +", "+ play_date);
											
										    let timeOption = [];
	
											$.ajax({
												type: "GET",
												url: "getPlayTimeInfo",
												data: {
													room_id : room_id,
													play_date : play_date
												},
												success: function(result) {
	//								 				console.log(JSON.stringify(result));
													// 각 배열에 가지고 있는 값: movie_id, play_date, play_end_time, play_id, play_start_time, play_turn, room_id
						
							 						timeOption = 
							 							$('#play_start_time_mod option').map(function() {
														  return $(this).val();
														}).get();
															
	// 												console.log(timeOption);
													// 옵션 밸류값 : ,09:00,10:00,11:00,12:00,13:00,14:00,15:00,16:00,17:00,18:00,19:00,20:00,21:00
	
													let disabledTime = [];	// disabled 처리된 값을 담을 배열 생성
														
							 						for(var i = 0; i < result.length; i++) { // 반복문을 통해 result 배열의 각 요소에 접근
							 							let value = result[i].play_start_time;
														let intStartTimeHour = parseInt(result[i].play_start_time.split(":")[0]);
														let intEndTimeHour = parseInt(result[i].play_end_time.split(":")[0]);
														// => 비교를 위해 변환 필요
	// 	 												console.log(intStartTimeHour, intEndTimeHour);
	// 	 												console.log(typeof(intStartTimeHour), typeof(intEndTimeHour));
															
	
														for (var j = 0; j < timeOption.length; j++) {
														  if (value == timeOption[j]) {
														    // 옵션의 value와 이미 등록된 영화의 시작 시간이 같을 경우
														    // 기본적으로 영화가 1시간 이상이므로 두 타임을 차지하고 있으므로
														    // j, j+1을 disabled 처리
														    $("#modifyStart option").eq(j).prop("disabled", true);
														    $("#modifyStart option").eq(j + 1).prop("disabled", true);
														
														    disabledTime.push(parseInt($("#modifyStart option").eq(j).val().split(":")[0]));
														    disabledTime.push(parseInt($("#modifyStart option").eq(j + 1).val().split(":")[0]));
														
														    if (intEndTimeHour - intStartTimeHour >= 2) {
														      // 이미 등록된 영화가 두시간 이상일 경우
														      $("#modifyStart option").eq(j + 2).prop("disabled", true); // j+2도 disabled 처리
														      disabledTime.push(parseInt($("#modifyStart option").eq(j + 2).val().split(":")[0]));
														    }
														  }
														} // 안쪽 for문 끝
							 						
							 						} // 바깥쪽 for문 끝	
							 						
							 						// ---------- 선택한 영화를 남은 시간에 등록할 수 있는지 판단 ------
							 						// disabled 여부를 true/false로 반환
							 						// disabled면(선택불가능) true / 선택가능이면 false
							 						let isDisabled = []; // disabled 여부를 true/false로 저장할 배열 생성
							 						for(let i = 0; i < timeOption.length; i++) {
							 							if($("#play_start_time_mod option").eq(i).attr("disabled")) { // disabled가 맞으면
							 								isDisabled.push(true);	
							 							} else { // disabled가 아니면
							 								isDisabled.push(false);	
							 							}
							 						}
							 						// 시간이 겹쳐 선택할 수 없는 영화를 판별하는 함수 호출
							 						$("#modifyStart").click(function() {
							 							selectable(isDisabled);
								 						console.log(isDisabled);
							 						});				
	
	
												}, // success 끝
												error: function(xhr, textStatus, errorThrown) {
													alert("상영 날짜 출력 오류입니다.");
												}
											});
											
										});
										
										
									}
										
								},
								error: function(xhr, textStatus, errorThrown) {
									alert("상영관 로딩 오류입니다.");
								}
							});
						});
						
						
						// 러닝타임에 따라 영화를 비어있는 중간시간에 상영할수있는지 없는지를 판별하는 함수 정의
						function selectable(isDisabled) {
							console.log(isDisabled);
							// 선택한 영화의 러닝타임을 가져와서 시간 단위로 나누기
							let movie_id = $("#modifyMovie").val();
								
							$.ajax({
								type: "GET",
								url: "getMovieInfo",
								data: {
									movie_id : movie_id
								},
								success: function(result) {
									let movie_runtime = result.movie_runtime;
										
									// 러닝타임을 60분으로 나눈 다음 몫을 구한 다음 +1을 해주면
									// 시간 셀렉트박스에 몇 칸을 차지하는지 알 수 있다
									// (78분 영화의 경우 1.xxx가 나오므로 2타임을 차지한다!)
									let movieTime = Math.floor(movie_runtime / 60) + 1;
									
									// 선택한 영화가 차지하는 칸 movieTime (2 또는 3)
									// disabled면(선택불가능) true / 선택가능이면 false인
									// isDisabled 배열이 있음
									// movieTime이 2인 경우 = isDisabled[i], isDisabled[i+1] 중 하나라도 선택 불가능하면 글자 색상 변경
									// movieTime이 3인 경우 = isDisabled[i], isDisabled[i+1], isDisabled[i+2] 중 하나라도 선택 불가능하면 글자 색상 변경
									console.log("몇타임인지 : " + movieTime);
									
									if(movieTime == 2) { // 0번 인덱스가 ''인데?
										for(let i = 0; i < isDisabled.length; i++) {
											if(isDisabled[i] || isDisabled[i+1]) { // 연달아 있는 2칸중 한 칸이라도 선택 불가능하면(true)
												$("#modifyStart option").eq(i).attr("disabled", true);
											}
										}
									} else if(movieTime == 3) {
										for(let i = 0; i < isDisabled.length; i++) {
											if(isDisabled[i] || isDisabled[i+1] || isDisabled[i+2]) { // 연달아 있는 2칸중 한 칸이라도 선택 불가능하면(true)
												$("#modifyStart option").eq(i).attr("disabled", true);
											}
										}
									}
								
								},
								error: function(xhr, textStatus, errorThrown) {
									alert("상영 시작 시간 출력 오류입니다.");
								}
							});
						}	
						
						// 영화 종료 시간 자동으로 계산
						$("#modifyStart").change(function() {
							let movie_id = $("#modifyMovie").val();
							let start_time = $("#modifyStart").val().split(":")[0];
							
							$.ajax({
								type: "GET",
								url: "getMovieInfo",
								data: {
									movie_id : movie_id
								},
								success: function(result) {
									if(start_time == '') {
										$("#modifyEnd").val('');
									} else {
										let end_time = (start_time * 60) + parseInt(result.movie_runtime)
										
										let hours = Math.floor(end_time / 60); // 시간 계산
										let minutes = end_time % 60; // 분 계산
										
										// 시간과 분이 한 자리 수인 경우 0으로 채우기
										let formatted_hours = hours < 10 ? "0" + hours : hours;
										let formatted_minutes = minutes < 10 ? "0" + minutes : minutes;
										
										let formatted_end_time = formatted_hours + ":" + formatted_minutes; // "00:00" 형식으로 변환된 종료 시간
										
										$("#modifyEnd").val(formatted_end_time);						
									}
								},
								error: function(xhr, textStatus, errorThrown) {
									alert("종료 시간 출력 오류입니다.");
								}
							});
						});
						
						// 영화 종료 시간 자동으로 계산2
						$("#modifyMovie").blur(function() {
							let movie_id = $("#modifyMovie").val();
							let start_time = $("#modifyStart").val().split(":")[0];
							
							$.ajax({
								type: "GET",
								url: "getMovieInfo",
								data: {
									movie_id : movie_id
								},
								success: function(result) {
									if(start_time == '') {
										$("#modifyEnd").val('');
									} else {
										let end_time = (start_time * 60) + parseInt(result.movie_runtime)
										
										let hours = Math.floor(end_time / 60); // 시간 계산
										let minutes = end_time % 60; // 분 계산
										
										// 시간과 분이 한 자리 수인 경우 0으로 채우기
										let formatted_hours = hours < 10 ? "0" + hours : hours;
										let formatted_minutes = minutes < 10 ? "0" + minutes : minutes;
										
										let formatted_end_time = formatted_hours + ":" + formatted_minutes; // "00:00" 형식으로 변환된 종료 시간
										
										$("#modifyEnd").val(formatted_end_time);						
									}
								},
								error: function(xhr, textStatus, errorThrown) {
									alert("종료 시간 출력 오류입니다.");
								}
							});
						});
						
	
					},
					error: function(xhr, textStatus, errorThrown) {
						alert("상영중인 영화 로딩 오류입니다.");
					}
				});
		    	
				// 새로운 버튼 생성하고 기존 버튼 없애기
		    	$(".btnModify_" + currentTrId).after("<input type='button' value='완료' class='btnModifyComplete_" + currentTrId +"'>");
		    	$(".btnModify_" + currentTrId).remove();
				
				// 새로 만든 완료 버튼을 클릭할 경우
				$(".btnModifyComplete_" + currentTrId).on("click", function(){
						
						var room = $("#modifyRoom").val();
						var movie = $("#modifyMovie").val();
						var date = $("#modifyDate").val();
						var start = $("#modifyStart").val();
						var end = $("#modifyEnd").val();
						
						console.log(play_id + ", " + room + ", " + movie + ", " + date + ", " + start + ", " + end)
			            $.ajax({
			                type: "POST",
			                url: "modifyPlay",
			                dataType: "text",
			                data: {
			                	play_id : play_id,
			                    play_date: date,
			                    play_start_time: start,
			                    play_end_time: end,
			                    room_id: room,
			                    movie_id: movie
			                },
			                success: function(result) {
								
			                	console.log("db업데이트 성공 여부 : " + result);
								location.reload();
			                },
			                error: function(xhr, textStatus, errorThrown) {
			                    alert("ajax 요청 실패! 항목을 처음부터 순서대로 다시 선택해 수정해보세요!" + xhr + ", " + textStatus);
			                    location.reload();
			                    // ajax 요청 실패 시 화면 전환 없이 다시 선택해도 수정 가능한지 확인하기
			                    // => 일단 불가능해서 현재는 reload() 처리
			                    
			                }
			            });
					
					
				}); // 클릭 이벤트				
				
        
	
			
		
				console.log("기존 tr: " + previousTrId);
				console.log("현재 tr: " + currentTrId);
				// 이전에 선택한 <tr>의 ID를 현재 선택한 <tr>의 ID로 업데이트
				if(!previousTrId) { // 기존 tr 아이디가 없는 경우
					previousTrId = currentTrId; // 현재 tr 아이디를 기존 tr 아이디로 덮어씀
					console.log("이전tr로 변경될 id : " + previousTrId);
				} else if(previousTrId != currentTrId) { // 기존 tr 아이디와 현재 tr 아이디가 일치하지 않는 경우
		// 			console.log("무슨 작업을 하지?");
					previousTrId = currentTrId; // 현재 tr 아이디를 기존 tr 아이디로 덮어씀
					console.log("이전tr로 변경될 id : " + previousTrId);
				}
		}
				
				
	
	} // 수정버튼 클릭 이벤트 처리 끝
	

	// 삭제 버튼 클릭 시	
	function confirmDelete(play_id, play_start_time, play_date) {
		
		console.log(play_id);
		console.log(play_date);
		console.log(typeof(play_date)); 
		console.log(play_start_time);
		console.log(typeof(play_start_time));
		
		// 문자열 날짜를 정수형으로 변환
		let intPlayDate = convertStringDateToInt(play_date);
		
		// 오늘 날짜 가져오기
		let today = getToday();
		
		// 현재 시간 가져오기
		let currentTime = getCurrentTime();
		
	    // 문자열인 play_start_time을 정수형으로 변환하는 함수 호출해 변수에 저장
	    let intPlayStartTime = convertStringTimeToInt(play_start_time);
		
		// 현재 일시와 비교
		if(intPlayDate < today || (intPlayDate == today && intPlayStartTime < currentTime)) {
		// => 기준 날짜가 오늘 이전인 경우
		//    혹은 오늘과 같지만 영화 시작시간이 현재 시각 이전인 경우
			alert("이전 상영일정은 삭제할 수 없습니다!");
			
		} else {
			if(confirm("상영 일정을 삭제하시겠습니까?")) {
				console.log(play_id);
	
				// 확인 클릭 시 ajax 요청을 통해 삭제 작업 처리
		        $.ajax({
		        	type: "post",
		        	url: "deletePlay",
		        	data: {
		        		play_id: play_id
		        	},
		        	success: function(result) {
		        		console.log(result);
		        		if(result == "success") {
	        				alert("상영 일정 삭제에 성공했습니다!");
	        				location.href = location.href;
	        				
		        		} else if(result == "fail") {
	        				alert("상영 일정 삭제에 실패했습니다!");
	        				location.href = location.href;
		        		} else if(result == "invalidSession") {
	        				alert("상영 일정 삭제 권한이 없습니다!");
		        			location.href = "memberLogin";
		        		}
		        	},
		        	error: function(xhr, textStatus, errorThrown) {
		        		alert("ajax 삭제 요청 실패!");
		        	}
		        });
				
			} else {
				return;
			}
			
			
		}
		
		
		
		
	} // 삭제 버튼 클릭 시 이벤트 처리 끝
	
	
	// "yyyy-MM-dd" 형식의 문자열 날짜를 정수형으로 변환하는 함수
	function convertStringDateToInt(play_date) {
		let parts = play_date.split("-"); // -를 델리미터로 쪼갬
		
		let year = parseInt(parts[0]);
		let month = parseInt(parts[1]);
		let day = parseInt(parts[2]);
		
		let date = new Date(year, month - 1, day);
		// => JavaScript의 Date 객체에서 월(Month)은 0부터 시작하기 때문에 month - 1 처리
		
		return date.getTime();
	}
	
	// "HH:mm" 형식의 문자열 시간을 정수형으로 변환하는 함수
	function convertStringTimeToInt(play_start_time) {
		let parts = play_start_time.split(":"); // :를 델리미터로 쪼갬
		
		let hours = parseInt(parts[0]);
		let minutes = parseInt(parts[1]);
		
		return hours * 60 + minutes;
	}
	
	// 오늘 날짜를 가져오는 함수
	function getToday() {
		let today = new Date();
		today.setHours(0, 0, 0, 0);
		// => setHours() 메서드는 매개변수로 시, 분, 초, 밀리초를 갖는다
		//    시간 부분을 0으로 설정해 today 객체는 오늘 날짜의 자정을 나타내게 됨
		//    (주로 날짜를 비교하거나 특정 날짜와 시간을 비교할때 유용하게 사용)
		return today.getTime();
	}
	
	// 현재 시간을 가져오는 함수
	function getCurrentTime() {
		let currentTime = new Date();
	    return currentTime.getHours() * 60 + currentTime.getMinutes();
	}

	
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
			<h1 id="h01">상영 일정 등록</h1>
			<hr>
			
			<div id="admin_main">
				<a href="adminMovieSchedule"><input type="button" value="상영일정조회"></a>
				<br><br>
				<form action="registPlay" method="post" id="registForm">
					<table border="1">
						<tr>
							<th width="140px">지점명</th>
							<th width="140px">상영관명</th>
							<th>영화제목</th>
							<th width="140px">상영날짜</th>
							<th width="140px">상영시작시간</th>
							<th width="140px">상영종료시간</th>
							<th width="90px">등록</th>
							<th width="90px">초기화</th>
						</tr>
						<tr>
							<td>
								<select id="theater_id" name="theater_id">
									<option value="">지점 선택</option>
								</select>
							</td>
							<td>
								<select id="room_id" name="room_id">
									<option value="">상영관 선택</option>
								</select>
							</td>
							<td>
								<select id="movie_id" name="movie_id">
									<option value="">영화 선택</option>
								</select>
							</td>
							<td id="date">
								<input type="date" id="play_date" name="play_date">
							</td>
							<td>
								<select id="play_start_time" name="play_start_time">
									<option value="">시작 시간 선택</option>
									<option value="09:00">09:00</option>
									<option value="10:00">10:00</option>
									<option value="11:00">11:00</option>
									<option value="12:00">12:00</option>
									<option value="13:00">13:00</option>
									<option value="14:00">14:00</option>
									<option value="15:00">15:00</option>
									<option value="16:00">16:00</option>
									<option value="17:00">17:00</option>
									<option value="18:00">18:00</option>
									<option value="19:00">19:00</option>
									<option value="20:00">20:00</option>
									<option value="21:00">21:00</option>
								</select>
							</td>
							<td>
								<input type="text" id="play_end_time" name="play_end_time" readonly>
							</td>
							<td>
								<input type="submit" value="등록" id="regist">
							</td>
							<td>
								<input type="reset" value="초기화">
							</td>
						</tr>
					</table>
				</form>
						
				<br>
				
				<table border="1" class="modifyForm">
					<tr>
						<th width="140px">지점명</th>
						<th width="140px">상영관명</th>
						<th>영화제목</th>
						<th width="140px">상영날짜</th>
						<th width="140px">상영시작시간</th>
						<th width="140px">상영종료시간</th>
						<th width="90px">수정</th>
						<th width="90px">삭제</th>
					</tr>
					<c:forEach var="play" items="${playRegistList}">
						<tr id="${play.play_id}">
							<td id="theater_name_mod" data-theater-name="${play.theater_name}">${play.theater_name}</td>
							<td id="room_name_mod" data-room_name="${play.room_name}">${play.room_name}</td>
							<input type="hidden" value="${play.room_id}" id="room_id">
							<td id="movie_title_mod" data-movie_title="${play.movie_title}">${play.movie_title}</td>
							<input type="hidden" value="${play.movie_id}" id="movie_id">
							<td id="play_date_mod">${play.play_date}</td>
							<td id="play_start_time_mod" data-play_start_time="${fn:substring(play.play_start_time, 0, 5)}">${fn:substring(play.play_start_time, 0, 5)}</td>
							<td id="play_end_time_mod">${fn:substring(play.play_end_time, 0, 5)}</td>
							<td>
<!-- 									<input type="button" value="수정" class="btnModify"> -->
								<input type="button" value="수정" class="btnModify_${play.play_id}" onclick="CannotDuplicateModify(${play.play_id}, '${play.play_start_time }', '${play.play_date }')">
							</td>
							<td>
								<input type="hidden" value="${play.play_id}" name="play_id" id="play_id">
								<input type="button" value="삭제" id="btnDelete_${play.play_id }" onclick="confirmDelete(${play.play_id}, '${play.play_start_time }', '${play.play_date }')">
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<br><br><br><br><br>
		</section>
	</div>
</body>
</html>