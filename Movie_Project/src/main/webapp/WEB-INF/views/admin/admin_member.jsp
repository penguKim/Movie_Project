<%-- admin_member.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	//무한스크롤 기능에 활용될 페이지번호 변수 선언(초기값 1)
	let pageNum = "1";
	let maxPage = "";
	
	$(function() {
		
		load_list();
		
		$(window).scroll(function() {
			// 1. window 객체와 document 객체를 활용하여 스크롤 관련 값 가져오기
			let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
			let windowHeight = $(window).height(); // 브라우저 창 높이
			let documentHeight = $(document).height(); // 문서 높이
			// 2. 스크롤바 위치값 + 창 높이 + x 값이 문서 전체 높이 이상일 경우
			//    다음 페이지 게시물 목록 로딩하여 화면에 추가
			if(scrollTop + windowHeight + 100 >= documentHeight) {
				pageNum++; // 다음 목록 조회를 위해 현재 페이지번호 1증가
				if(maxPage != "" && pageNum <= maxPage) {
					load_list(); // 다음 페이지 로딩을 위해 load_list() 함수 호출
				}
			}
		});
	});
	
	function load_list() {
		let searchType = $("#searchType").val();
		let searchKeyword = $("#searchKeyword").val();
		
		$.ajax({
			type: "GET",
			url: "adminMemberList",
			data: {
				searchType: searchType,
				searchKeyword: searchKeyword,
				pageNum: pageNum
			},
			dataType: "json",
			success: function(data) {
				for(let member of data.memberList) {
					$("table").append(function() {
						var html = '<tr>'
						  + '<td>' + member.member_name + '</td>'
						  + '<td>' + member.member_id + '</td>'
						  + '<td>' + member.member_email + '</td>'
						  + '<td class="member_status">';
						
						if (member.member_status === 0) {
						  html += '<span id="admin_Bmember">관리자</span>';
						} else if (member.member_status === 1) {
						  html += '<span id="admin_member">회원</span>';
						} else if (member.member_status === 2) {
						  html += '<span id="admin_Cmember">탈퇴</span>';
						}
						
						html += '</td>'
						  + '<td>'
						  + '<a href="adminMemberMod?member_id=' + member.member_id + '" id="ok">'
						  + '<input type="button" value="수정" id="ok">'
						  + '</a>'
						  + '</td>'
						  + '</tr>';
						
						return html;
					});
				}
				// 끝페이지 번호(maxPage) 값을 변수에 저장
				maxPage = data.maxPage;
			},
			error: function() {
				alert("게시물 요청 실패!");
			}
		});
	}

</script>
</head>
<body>
	<%-- pageNum 파라미터 가져와서 저장(없을 경우 기본값 1 로 저장) --%>
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	<div id="wrapper">
		<nav id="navbar">
            <jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
        </nav>
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
		<section id="content">
			<h1 id="h01">회원정보관리</h1>
			<hr>
			<div id="admin_main">
					<div id="member_Search">
						<%-- 검색 기능을 위한 폼 생성 --%>
						<form action="adminMember">
							<select name="searchType" id="searchType">
								<option value="member" <c:if test="${param.searchType eq 'member' }">selected</c:if>>아이디</option>
								<option value="name" <c:if test="${param.searchType eq 'name' }">selected</c:if>>이름</option>
							</select>
							<input type="text" name="searchKeyword" id="searchKeyword" value="${param.searchKeyword }">
							<input type="submit" value="검색">
						</form>
					</div>
				<table border="1" width="1000">
					<tr>
						<th width="120">이름</th>
						<th width="120">아이디</th>
						<th>이메일</th>
						<th width="100">회원상태</th>
						<th width="100">계정종류 및 변경</th>
					</tr>
				</table>
			</div>
		</section>
	</div>
</body>
</html>