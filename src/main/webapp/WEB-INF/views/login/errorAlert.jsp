<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%-- 에러 페이지는 isErrorPage="true" 로 줘야 한다. --%>
<%
	response.setStatus(200);
%>
<script>
	alert('<%=exception.getMessage()%>')
	history.back();
</script>