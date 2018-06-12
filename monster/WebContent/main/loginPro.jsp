<%@page import="dao.PoketMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	PoketMemberDao pdao = new PoketMemberDao();
	int check = pdao.userCheck(id, passwd);
	
	if(check == 1){
		session.setAttribute("id", id);
		response.sendRedirect("main.jsp");
	}else if(check == 0){
		%>
		<script>
			alert('패스워드를 확인하세요.')
			history.back();
		</script>
		<%
	}else{
		%>
		<script>
			alert('존재하지 않는 아이디입니다.');
			history.back();
		</script>
		<%
	}

%>