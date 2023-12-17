<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	// 컨트롤러에서 전달받은 메세지를 EL을 통해 접근하여 confirm() 함수로 출력
	var result = confirm("수정 : " + "${msg}" +"\n계속 하시겠습니까?");
	if(result) {
		// 수정 처리를 위한 개별 서블릿으로 이동
		location.href = "${servlet}";
	}
</script>