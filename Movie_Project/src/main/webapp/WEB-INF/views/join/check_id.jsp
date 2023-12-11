<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 id 파라미터값이 "admin" 이면 true 값 출력하고, 아니면, false 값 출력 --%>
<%
String id = request.getParameter("id");
if(id.equals("admin")) {
	out.print(true);
} else {
	out.print(false);
}
%>