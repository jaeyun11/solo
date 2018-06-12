<%@page import="dao.PoketMemberDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="bean" class="bean.PoketMember"/>
<jsp:setProperty property="*" name="bean"/>

<%
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	bean.setReg_date(reg_date);
	
	// DB접속용 Dao객체 생성
	PoketMemberDao pdao = new PoketMemberDao();
	pdao.inserMember(bean);
%>

<script>
	alert('회원가입 성공 !');
	location.href = 'main.jsp';
</script>