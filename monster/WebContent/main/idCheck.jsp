<%@page import="dao.PoketMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("userid");
	
	PoketMemberDao pdao = new PoketMemberDao();
	
	int ck = pdao.idCheck(id);
%>
<%=ck%>