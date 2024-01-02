<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="resources/js/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	function confirmLogout() {
		 let isLogout = confirm("로그아웃하시겠습니까?"); 
		 if(isLogout) {
			 location.href = "MemberLogout";
		 }
	}

</script>
<div id ="top_area_admin">
	<div id="member_area_admin">
		<div id="logo">
			<a href="./"><img src="${pageContext.request.contextPath }/resources/img/logo2.png" height="60" width="200"></a>
		</div>
		<div id="member">
			<c:choose>
				<c:when test="${empty sessionScope.sId }">
					<a href="memberLogin"><input type="button" value="로그인"></a>
					<a href="memberJoin"><input type="button" value="회원가입"></a>
				</c:when>
				<c:otherwise>
					<a href="Mypage"><input type="button" value="${sessionScope.sId }"></a>
					<a href="javascript:confirmLogout()"><input type="button" value="로그아웃"></a>
					<c:if test="${sessionScope.sId eq 'admin'}">
						<a href="${pageContext.request.contextPath }"><input type="button" value="메인페이지"></a><%-- 관리자페이지는 메인페이지가 없으므로 영화관리 페이지가 연결되도록 지정(임시) --%>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
</div>

