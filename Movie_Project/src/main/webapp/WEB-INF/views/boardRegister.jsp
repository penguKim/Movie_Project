<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	// 컨트롤러에서 전달받은 메세지를 EL을 통해 접근하여 alert() 함수로 출력
	alert("${msg}" + "를 등록하시겠습니까?");
	// 등록 서블릿으로 이동
	location.href = "${servlet}";
</script>