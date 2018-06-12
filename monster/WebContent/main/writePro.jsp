<%@page import="dao.PoketMemberDao"%>
<%@page import="dao.PoketBoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");

	if(id == null){
		response.sendRedirect("main.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="pBoard" class="bean.PoketBoard"/>
<jsp:setProperty property="*" name="pBoard"/>
<%
	PoketMemberDao dao = new PoketMemberDao();
	String name = dao.getName(id);
	pBoard.setReg_date(new Timestamp(System.currentTimeMillis()));
	pBoard.setIp(request.getRemoteAddr());
	pBoard.setReadcount(0);
	pBoard.setName(name);
	pBoard.setId(id);
	
	PoketBoardDao pdao = new PoketBoardDao();
	
	pdao.insert(pBoard);
	response.sendRedirect("community.jsp");
%>