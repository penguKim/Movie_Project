<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	if (confirm('${msg}')) {
	  // 확인 버튼을 클릭한 경우
	  location.href ="${targetURL}";
	} else {
	  // 취소 버튼을 클릭한 경우
		history.back();
	}

</script>