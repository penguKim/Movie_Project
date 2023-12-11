<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<script type="text/javascript" src="js/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		var container = $('.slideshow'),
			slideGroup = container.find('.slideshow_slides'),
			slides = slideGroup.find('a'),
			nav = container.find('.slideshow_nav'),
			indicator = container.find('.indicator'),
			slideCount = slides.length,
			indicatorHtml = '',
			/* goToSlide(index)의 초기값 */
			currentIndex = 0,
			duration = 500,
			/* easeInOutExpo함수 사용하려면 "https://code.jquery.com/ui/1.12.1/jquery-ui.js" 라이브러리 추가해야함 */
			easing = 'easeInOutExpo',
			/* 자동슬라이드 시간 설정 */
			interval = 3000,
			timer;
		
		// 슬라이드를 가로로 배열
		slides.each(function(i) {
			var newLeft = i * 100 + '%';
			$(this).css({left: newLeft});
			/* 인디케이터 기능 구현 및 이미지 호출 */
			indicatorHtml += '<a href="">' + (i+1) + '</a>';
		}); // slides.each
			
		/* 인디케이터 이미지 구현 */
		indicator.html(indicatorHtml);
		// 슬라이드 이동 함수
		function goToSlide(index) {
			// index0 left:0%, index1 left:-100%
			slideGroup.animate({left: -100 * index + '%'}, duration, easing);
			currentIndex = index;
			/* 두번 사용한 함수 클릭이벤트때도 사용되도록  */
			updateNav();
		} // goToSlide
		
		function updateNav() {
			indicator.find('a').removeClass('active');
			// addClass 클래스 선택
			indicator.find('a').eq(currentIndex).addClass('active');
			// 모든 요소에서 active를 빼고, 원하는 요소에만 active 추가
		}
		
		// 인디케이터로 클릭시 이동하기
		/* 몇번째를 클릭하는 지  */
		indicator.find('a').click(function(e) {
			/* 현재 a태그는 빈링크이므로 매개변수를 줘야함 */
			/* preventDefault 기본 이벤트 작동 못하게하는 함수 */
			/* 기본 이벤트는 href="" 이므로 동작이 이상 동작할 수 있음 */
			e.preventDefault();
			/* this = indicator.find('a') */
			var idx = $(this).index();
// 				console.log(idx);
			goToSlide(idx);
		});
		
		// 좌우버튼으로 이동하기 
		// 다음버튼 클릭 currentIndex + 1 -> goToSlide();
		// 이전버튼 클릭 currentIndex - 1 -> goToSlide();
// 			nav.find('.prev').click(function(e) {
// 				/* preventDefault 기본 이벤트 작동 못하게하는 함수 */
// 				e.preventDefault();
// 				goToSlide(currentIndex - 1);
// 			});
			
// 			nav.find('.next').click(function() {
// 				e.preventDefault();
// 				goToSlide(currentIndex + 1);	
// 			});
		nav.find('a').click(function(e) {
			e.preventDefault();
			if ($(this).hasClass('prev')) {
				/* 첫번째 이미지에서 이전 버튼 클릭 시 마지막 이미지로 이동 */
				if (currentIndex == 0) {
					goToSlide(slideCount - 1);
				} else {
					/* 첫번째 이미지가 아니라면 그 전 이미지로 이동 */
					goToSlide(currentIndex - 1);
				}
			} else if ($(this).hasClass('next')) {
				/* 마지막 이미지에서 다음 버튼 클릭 시 첫번째 이미지로 이동 */
				if (currentIndex == slideCount - 1) {
					goToSlide(0);
					/* 마지막 이미지가 아니라면 다음 이미지로 이동 */
				} else {
					goToSlide(currentIndex + 1);
				}
			}
		});
		/* 함수 클릭이벤트가 아닐 때도 사용되도록 밖에도 정의 */
		updateNav();
			
		/* 자동 슬라이드 함수 */
		function startTimer() {
			// 일정시간 마다 할일
			// setInterval(할일, 시간), clearInterval(이름)
			// 할일(함수) function() {실제 할일}
			timer = setInterval(function() {
				/* 시간마다 현재 index가 바뀌어야함 */
				/* (0+1)%4 = 1, .... (3+1)%4 = 0 */
				var nextIndex = (currentIndex + 1) % slideCount;
				goToSlide(nextIndex);	
			}, interval);
		}
		/* 메인 페이지에서 자동 슬라이드 시작 */
		startTimer();
		
		/* 자동슬라이드 멈춤 함수 */
		function stopTimer() {
			clearInterval(timer);
		}		
		/* 마우스를 이미지에 올릴 경우 자동슬라이드 멈춤 */
		container.mouseenter(function() {
			stopTimer();
		});
		/* 마우스가 이미지에서 나오면 다시 자동슬라이드 시작 */
		container.mouseleave(function() {
			startTimer();
		});
	});
</script>

<div class="slideshow">
	<div class="slideshow_slides">
		<a href=""><img src="resources/img/img1.jpg" alt="slide1" width="740px" height="400px"></a>
		<a href=""><img src="resources/img/img2.jpg" alt="slide2" width="740px" height="400px"></a>
		<a href=""><img src="resources/img/img3.jpg" alt="slide3" width="740px" height="400px"></a>
		<a href=""><img src="resources/img/img4.jpg" alt="slide4" width="740px" height="400px"></a>
	</div> <!-- slides -->
	<div id="shedow"></div>
	<div class="slideshow_nav">
		<a href="" class="prev" id="a">prev</a>
		<a href="" class="next" id="a">next</a>
	</div> <!-- slideshow_nav -->
	<div class="indicator">
<!-- 			<a href="">1</a> -->
<!-- 			<a href="" class="active">2</a> -->
<!-- 			<a href="">3</a> -->
<!-- 			<a href="">4</a> -->
	</div> <!-- indicator -->
</div> <!-- slideshow -->