<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id ="top_area">
	<div id="member_area">
		<div id="logo">
			<a href="./"><img src="${pageContext.request.contextPath }/resources/img/logo.png"></a>
		</div>
		<div id="member">
			<%-- 작업의 편리성을 위해 일반 페이지에서 관리자페이지로의 전환을 용이하게 해줄 임시 연결 버튼 --%>
			<a href="adminMovie"><input type="button" value="관리자페이지"></a><%-- 관리자페이지는 메인페이지가 없으므로 영화관리 페이지가 연결되도록 지정 --%>
			<a href="memberLogin"> <input type="button" value="로그인"></a>
			<a href="memberJoin"><input type="button" value="회원가입"></a>
		</div>
	</div>
	
</div>
