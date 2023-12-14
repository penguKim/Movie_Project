<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화정보</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/movie.css" rel="stylesheet">
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
						<img alt="" src=${movie.poster } width="200" height="280">
					</div>	
					<div class="info_title">
						<span class="detail_title">${movie.title }</span>
						<ul>
							<li><span>기본 정보 : </span> 국가 | 상영시간 | 장르</li>
							<li><span>개&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;봉 : 	</span> 날짜 </li>
							<li><span>감&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;독 : </span> 감독명</li>
							<li><span>등&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;급 : </span> 상영등급</li>
						</ul>
						<div class="detail_reserve_clear">
							<a href="movie_select">
								<input type="button" value="예매하기"></a>
						</div>
					</div>
				</div>
				<hr>
				<ul class="click_link">
					<li><a href="#movie_story"><input type="button" value="줄거리"></a></li>	
					<li><a href="#movie_trailer"><input type="button" value="트레일러"></a></li>	
					<li><a href="#movie_cut"><input type="button" value="스틸컷"></a></li>	
					<li><a href="#review"><input type="button" value="리뷰"></a></li>	
				</ul>
			    <div class="movie_story" id="movie_story">
			    ${movie.plot }
<!-- 			    	<h2>줄거리</h2> -->
<!-- 				    스스로 황제가 된 영웅!<br /> -->
<!-- 					1793년 혁명의 불꽃이 프랑스 전역을 밝히기 시작한다.<br /> -->
<!-- 					코르시카 출신의 장교 &#39;나폴레옹&#39;(호아킨 피닉스)은<br /> -->
<!-- 					혼란스러운 상황 속 국가를 위해 맞서며 영웅으로 떠오른다.<br /> -->
<!-- 					<br /> -->
<!-- 					한편, 사교 파티에서 영웅 &lsquo;나폴레옹&rsquo;을 만난 &#39;조제핀&#39;(바네사 커비)은<br /> -->
<!-- 					자신의 운명을 바꾸기 위해 &lsquo;나폴레옹&rsquo;을 선택하고<br /> -->
<!-- 					&lsquo;나폴레옹&rsquo;은 마침내 스스로 황제의 자리에 오르게 된다.<br /> -->
<!-- 					<br /> -->
<!-- 					하지만, &lsquo;조제핀&rsquo;은 계속해서 &lsquo;나폴레옹&rsquo;을 흔들고,<br /> -->
<!-- 					&lsquo;나폴레옹&rsquo;의 야망은 &lsquo;조제핀&rsquo;과 끝없이 충돌하는데&hellip;<br /> -->
<!-- 					<br /> -->
<!-- 					세상을 정복한 영웅 아무것도 갖지 못한 황제,<br /> -->
<!-- 					&lsquo;나폴레옹&rsquo;의 대서사가 펼쳐진다! -->
			    </div>
			    <div class="movie_trailer" id="movie_trailer">
			    	<hr>
			    	<h2>트레일러</h2>
				    <embed width="560" height="315" src="https://www.youtube.com/embed/ROl3dZE5rk4?si=Wl2kLOlS_0HFmtDM" title="YouTube video player"></embed>
			    </div>
			    <div class="movie_cut" id="movie_cut">
			    	<hr>
			    	<h2>스틸컷</h2>
			    	<img alt="" src="https://img.cgv.co.kr/Movie/Thumbnail/StillCut/000087/87596/87596220582_727.jpg" width="600px" height="350px">
			    </div>
			    <div class="review" id="review">
			    	<hr>
			    	<h2>리뷰</h2>
			    	<input type="text" placeholder="리뷰 입력" size="50">
			    	<input type="button" value="등록">
			    	<br>
			    	<table>
			    		<tr>
			    			<td rowspan="6" width="200">
			    				평점이 들어간다면<br>
			    				넣을 자리
			    			</td>
			    			<th>아이디</h>
			    			<td>내용(한두줄 정도로 글자수 제한?)</td>
			    		</tr>
			    		<c:forEach begin="1" end="5">
						   	<tr>
				    			<th>xxxx</th>
				    			<td>재밌어요~~~~~~~~~~~~~~</td>
				    		</tr>
			    		</c:forEach>
			    	</table>
			    </div>
			</section>
		</section>	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>	
		</footer>
	</div>
</body>
</html>