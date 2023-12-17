<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	// 컨트롤러에서 전달받은 오류메세지를 EL 을 통해 접근하여 alert() 함수로 출력
	alert("${msg}");
	// 이전페이지로 돌아가기
	history.back();
</script>