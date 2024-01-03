<%-- admin_movie_booking_modify.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 예매 상세 페이지</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<style type="text/css">
	#allCenter{
		  display: flex;
		  flex-direction: column;
		  justify-content: center;
		  align-items: center;
		  text-align: center;
		  height: 100vh;
		}
		table {
		  border-collapse: collapse;
		  border: 1px solid black;
		  margin-top: 10px;
		}
		
		td, th {
		  padding: 10px;
		  border: 1px solid black;
		}
		#btnArea input {
		  width: 70px;
		  height: 40px;
		  margin-top: 10px;
		}
</style>
<script type="text/javascript">
	function resCancle(payment_id,seat_id){
		if(confirm("결제취소하시겠습니까?")){
			$.ajax({
				url: "resCancle",
				data: {
					payment_id: payment_id
					,seat_id: seat_id
				},
				dataType: "json",
			    success: function(isResCancle) {
			    	if(isResCancle){
				    	$("#payment_status_result").html("결제취소");
				    	$("#resCanBtn").remove();
				    	window.opener.location.reload();
			    	}else{
			    		alert("결제취소 실패!");
			    	}
			    },
			    error:function(isResCancle) {
			    	alert("ajax 실패!");
	            }
			});//ajax끝
		}//confirm true 끝
	}//resCancle function 끝
</script>
</head>
<body>
	<div id="allCenter">
	<table>
		<tr>
			<td>예매이름</td>
			<td>${resList.payment_name}</td>
		</tr>
		<tr>
			<td>회원ID</td>
			<td>${resList.member_id}</td>
		</tr>
		<tr>
			<td>결제금액</td>
			<td>${resList.payment_total_price}</td>
		</tr>
		<tr>
			<td>결제일</td>
			<fmt:parseDate var="parsedDate" value="${resList.payment_datetime}" pattern="yyyy-MM-dd'T'HH:mm" type="both" />
			<td><fmt:formatDate value="${parsedDate}" pattern="MM-dd HH:mm"/> </td>
		</tr>
		<tr>
			<td>영화제목</td>
			<td>${resList.movie_title}</td>
		</tr>
		<tr>
			<td>관람일</td>
			<td>${resList.play_date}</td>
		</tr>
		<tr>
			<td>지점</td>
			<td>${resList.theater_name}</td>
		</tr>
		<tr>
			<td>상영관</td>
			<td>${resList.room_name}</td>
		</tr>
		<tr>
			<td>예매좌석</td>
			<td>${resList.seat_name}</td>
		</tr>
		<tr>
			<td>상태</td>
			<td id="payment_status_result">
				<c:choose>
					<c:when test="${resList.payment_status eq 0}">
						결제취소
					</c:when>
					<c:otherwise>
						결제완료
					</c:otherwise>
				</c:choose>			
			</td>
		</tr>
	
	</table>
	<section id="btnArea">
		<input type="button" value="창닫기" onclick="window.close()">
		<c:choose>
			<c:when test="${resList.payment_status eq 0}">
			</c:when>
			<c:otherwise>
				<input type="button" id="resCanBtn" value="결제취소" onclick="resCancle(${resList.payment_id},${resList.seat_id})">
			</c:otherwise>
		</c:choose>		
	</section>
	</div>
</body>
</html>