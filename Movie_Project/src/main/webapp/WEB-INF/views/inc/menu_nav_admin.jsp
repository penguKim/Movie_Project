<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<div class="sidenav">
<a href="adminMain" id="side_logo"><img src="${pageContext.request.contextPath}/resources/img/logo.png" height="70" width="180"></a>
<div class="admin_nav_title">MOVIE</div>
<a href="adminMovie">영화관리</a>
<a href="adminMovieSchedule">상영일정관리</a>
<a href="adminMovieBooking">영화예매관리</a>

<div class="admin_nav_title">STORE</div>
<a href="adminProduct">스토어상품관리</a>
<a href="adminPayment">스토어결제관리</a>

<div class="admin_nav_title">MEMBER</div>
<a href="adminMember">회원정보관리</a>

<div class="admin_nav_title">BOARD</div>
<a href="adminFaq">자주묻는질문관리</a>
<a href="adminNotice">공지사항관리</a>
<a href="adminOneOnOne">1대1문의관리</a>
<a href="adminLostNFound">분실물문의관리</a>
<a href="adminReview">리뷰관리</a><%-- 뷰 아직 X --%>
</div>