<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- --------- 사이드메뉴창 ---------- -->
<div id="my_menu">	
	<p><a href="${pageContext.request.contextPath }/login/mypage.jsp">마이페이지</a></p>
	<ul>
		<li><a href="${pageContext.request.contextPath }/login/mypage.jsp">마이페이지</a></li>
		<li><a href="${pageContext.request.contextPath }/login/editmember.jsp">나의정보수정</a></li>
		<li><a href="${pageContext.request.contextPath }/login/refund.jsp">취소내역</a></li>
		<li><a href="">나의 문의내역</a></li>
	</ul>
</div>
<!-- --------- 사이드메뉴 끝 ---------- -->