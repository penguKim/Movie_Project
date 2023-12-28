<%-- admin_board_faq.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문 관리</title>
<%-- 외부 CSS 파일 연결하기 --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	$(function() {
		<%-- faq 세부항목별 보기 버튼을 눌렀을 때 세부항목별로 모아서 보여주는 기능 --%> 
		$(".faqButton").click(function() {
			<%-- 선택한 버튼의 이름값 가져와서 변수에 저장 --%>
			let buttonName = $(this).attr("name");
			
			$.ajax({
				url: "faqDetail", <%-- csController 에 있는 매핑 주소 사용 --%>
				data: { buttonName: buttonName },
				success: function(data) {
					<%-- 세부항목을 눌렀을 때 --%>
					$("table>tbody").empty();
					
					for(let faq of data) {
						let date = new Date(faq.cs_date);
						let year = date.getFullYear(); // 연도
						let month = date.getMonth() + 1; // 월 (0부터 시작하므로 1을 더해줌)
						let day = date.getDate(); // 일
	
						// 가공된 날짜 형식으로 출력
						let formattedDate = year + "-" + month + "-" + day;
						
						$("table>tbody").append (
							"<tr>"
							+	"<td>" + faq.cs_type_list_num + "</td>"
							+	"<td>" + faq.cs_type_detail + "</td>"
							+	"<td class='post_name'><a href='adminFaqView?cs_type=" + faq.cs_type + "&cs_type_list_num=" + faq.cs_type_list_num + "&pageNum=${pageNum}'>" + faq.cs_subject + "</a></td>"
							+	"<td>" + formattedDate + "</td>"
							+"</tr>"
						);
					}		
							
				},
				error: function(xhr, status, error) {
			      // 요청이 실패한 경우 처리할 로직
			      console.log("AJAX 요청 실패:", error); // 예시: 에러 메시지 출력
				}
			});
		});
	});
</script>			
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="../inc/top_admin.jsp"></jsp:include>
		</header>
	
		<jsp:include page="../inc/menu_nav_admin.jsp"></jsp:include>
		
		<section id="content">
			<h1 id="h01">자주 묻는 질문 관리</h1>
			<hr>
			<div id="admin_nav">
				<jsp:include page="admin_menubar.jsp"></jsp:include>
			</div>
			<div id="admin_main">
				<div id="admin_search">
					<%-- 검색 기능을 위한 폼 생성 --%>
					<form>
						<input type="text" name="searchKeyword" placeholder="제목을 입력하세요">
						<input type="submit" value="검색">
					</form>
				</div>
				
				<table border="1">
					<thead>
						<tr>
							<th width="50">번호</th>
							<th width="100">유형</th>
							<th>제목</th>
							<th width="120">등록일</th>
						</tr>
					</thead>					
					<tbody>	
						<c:choose>
							<c:when test="${empty faqList}">
								자주 묻는 질문 없음						
							</c:when>
							<c:otherwise>
								<%-- FQA 질문 리스트 List<CsVO> 객체(faqList) 활용하여 목록 출력 --%>
								<c:forEach var="faq" items="${faqList}">
									<tr>
										<td>${faq.cs_type_list_num}</td>
										<td>${faq.cs_type_detail}</td>
										<td class="post_name"><a href="adminFaqView?cs_type=${faq.cs_type}&cs_type_list_num=${faq.cs_type_list_num}&pageNum=${pageNum}">${faq.cs_subject}</a></td>
										<td>
											<fmt:parseDate value='${faq.cs_date}' pattern="yyyy-MM-dd" var='cs_date'/>
											<fmt:formatDate value="${cs_date}" pattern="yyyy-MM-dd"/>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div id="admin_writer">
					<a href="adminFaqWriteForm"><input type="button" value="글쓰기"></a>
				</div>
				<div class="pagination">
					<%-- '<<' 버튼 클릭 시 현체 페이지보다 한 페이지 앞선 페이지 요청 --%>
					<%-- 다만, 페이지 번호가 1일 경우 비활성화 --%>		
					<c:choose>
						<c:when test="${pageNum eq 1}">
							<a href="" >&laquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminFaq?pageNum=${pageNum-1}" >&laquo;</a>
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
								<a href="adminFaq?pageNum=${i}">${i}</a> <%-- 다른 페이지 번호 --%>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<%-- '>>' 버튼 클릭 시 현체 페이지보다 한 페이지 다음 페이지 요청 --%>
					<%-- 다만, 페이지 번호가 마지막 경우 비활성화 --%>		
					<c:choose>
						<c:when test="${pageNum eq pageInfo.endPage}">
							<a href="" >&raquo;</a>					
						</c:when>
						<c:otherwise>
							<a href="adminFaq?pageNum=${pageNum+1}" >&raquo;</a>
						</c:otherwise>				
					</c:choose>
				</div>
			</div>
			<footer>
				<jsp:include page="../inc/bottom_admin.jsp"></jsp:include>
			</footer>
		</section>
	</div>
</body>
</html>