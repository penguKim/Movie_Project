<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	function confirmLogout() {
		 let isLogout = confirm("로그아웃하시겠습니까?"); 
		 if(isLogout) {
			 location.href = "MemberLogout";
		 }
	}
</script>
<div id ="top_area_admin">
	<div id="top_button">
		<a href="Mypage"><button class="tooltip"><img src="${pageContext.request.contextPath}/resources/img/user.png"><span class="tooltiptext">마이페이지</span></button></a>
		<a href="javascript:confirmLogout()"><button class="tooltip"><img src="${pageContext.request.contextPath}/resources/img/logout.png"><span class="tooltiptext">로그아웃</span></button></a>
		<a href="./"><button class="tooltip"><img src="${pageContext.request.contextPath}/resources/img/home.png"><span class="tooltiptext">iTicket홈</span></button></a>
	</div>
</div>

