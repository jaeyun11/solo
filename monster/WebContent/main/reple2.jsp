<%@page import="javax.websocket.SendResult"%>
<%@page import="dao.PoketMemberDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="dao.RepleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	

	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
	int num = Integer.parseInt(request.getParameter("num"));
	
	if(id == null){
		%>
			<script>
				alert('로그인후 이용해주세요 !');
				location.href='community.jsp';
			</script>
		<%
		return;
	}
%>
<jsp:useBean id="reple" class="bean.Re"/>
<jsp:setProperty property="*" name="reple"/>
<%
	PoketMemberDao dao = new PoketMemberDao();
	String name = dao.getName(id);
	
	reple.setId(id);
	reple.setReg_date(new Timestamp(System.currentTimeMillis()));
	reple.setCount(0);
	
	RepleDao rdao = new RepleDao();
	rdao.insert(reple);
	
	response.sendRedirect("fRead.jsp?num=" + num);
%>