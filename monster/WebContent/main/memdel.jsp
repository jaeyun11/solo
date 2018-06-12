<%@page import="dao.PoketMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	
	PoketMemberDao dao = new PoketMemberDao();
	dao.memdelete(id);	
%>
<script>
	alert('삭제성공 !');
	location.href='list.jsp';
</script>