<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iTicket 예매 게시판</title>
<%-- 글씨체 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/login.css" rel="stylesheet" type="text/css">
<style type="text/css">
	#stupidButton{
		background-color: gray;
	}
	#textSmall td{
		font-size: 10px;
	}
	.CancleReservation{
		background-color: #F4E4E4!important;
	}
	.deleteline{
		color: black;
		text-decoration: none;
		cursor: pointer;
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	function openPopup(payment_id){
		var width = 700; // 팝업 창의 가로 크기
	    var height = 500; // 팝업 창의 세로 크기
	    var left = Math.ceil((window.screen.width - width) / 2); // 화면가로중앙에 위치
	    var top =  Math.ceil((window.screen.height - height) / 2); // 화면세로중앙에 위치

	    var options = "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top;

        window.open("resInfoDetailPro?payment_id="+payment_id, "예매상세정보", options);
	}
</script>
</head>
<body>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top.jsp"></jsp:include>
		</header>
		
		<jsp:include page="../inc/menu_nav.jsp"></jsp:include>
		
		<section id="content">	
			<h1 id="h01">나의 예매내역 게시판</h1>
			<hr>
			
			<div id="mypage_nav"> <%-- 사이드 메뉴바 --%>
				<jsp:include page="mypage_menubar.jsp"></jsp:include>
			</div>
			
				
			<!-- 바디부분 시작 -->
			
			<form onsubmit="openPopup()">
				<div id="my_list">
					<h2>영화 예매내역</h2>
					<table id="my_table1">
						<tr>
							<th>No.</th>
							<th>예매상품</th>
							<th>상영일</th>
							<th>결제금액</th>
							<th>상태</th>
							<th>비고</th>
						</tr>
						<c:forEach var="reslist" items="${resList}">
						<div id="textSmall">
						<c:choose>
							<c:when test="${reslist.payment_status eq 0}"><tr class="CancleReservation"></c:when>
							<c:otherwise><tr></c:otherwise>
						</c:choose>
							<td>${reslist.payment_id}</td>
							<td><a href="detail?movie_id=${reslist.movie_id}" class="deleteline">${reslist.movie_title}</a></td>
							<td>${reslist.play_date}</td>
							<td><fmt:formatNumber value="${reslist.payment_total_price}" pattern="#,##0" />원</td>
							<td>
								<c:if test="${reslist.payment_status eq 1}">결제완료</c:if>
								<c:if test="${reslist.payment_status eq 0}">취소완료</c:if>
							</td>
							<td>
								<input type="button"  onclick="openPopup(${reslist.payment_id})" value="상세정보" class="resInfoDetail">
							</td>
						</tr>
						</div>
						</c:forEach>
					</table><br>
				</div>
				<div class="pagination">
						<%-- '<<' 버튼 클릭 시 현체 페이지보다 한 페이지 앞선 페이지 요청 --%>
						<%-- 다만, 페이지 번호가 1일 경우 비활성화 --%>		
						<c:choose>
							<c:when test="${pageNum eq 1}">
								<a href="" >&laquo;</a>					
							</c:when>
							<c:otherwise>
								<a href="MypageReservboardList?pageNum=${pageNum-1}" >&laquo;</a>
							</c:otherwise>				
						</c:choose>
						<%-- 현재 페이지가 저장된 pageInfo 객체를 통해 페이지 번호 출력 --%>
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<%-- 각 페이지마다 하이퍼링크 설정(페이지번호를 pageNum 파라미터로 전달) --%>
							<%-- 단, 현재 페이지는 하이퍼링크 제거하고 굵게 표시 --%>
							<c:choose>
								<%-- 현재 페이지번호와 표시될 페이지번호가 같을 경우 판별 --%>
								<c:when test="${pageNum eq i}">
									<a class="active" href="">${i}</a> <%-- 현재 페이지 번호 --%>
								</c:when>
								<c:otherwise>
									<a href="MypageReservboardList?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<%-- '>>' 버튼 클릭 시 현체 페이지보다 한 페이지 다음 페이지 요청 --%>
						<%-- 다만, 페이지 번호가 마지막 경우 비활성화 --%>		
						<c:choose>
							<c:when test="${pageNum eq pageInfo.maxPage}">
								<a href="" >&raquo;</a>					
							</c:when>
							<c:otherwise>
								<a href="MypageReservboardList?pageNum=${pageNum+1}" >&raquo;</a>
							</c:otherwise>				
						</c:choose>
				</div>
			</form>
		</section>
	
		<footer>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
		</footer>
	</div>
	
</body>
</html>