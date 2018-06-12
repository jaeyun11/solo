<%@page import="dao.PoketMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="poketmember" class="bean.PoketMember"/>
<jsp:setProperty property="*" name="poketmember"/>

<%
	PoketMemberDao dao = new PoketMemberDao();
	dao.memupdate(poketmember);
%>

<script>
	alert('수정 완료 !');
	location.href='list.jsp';
</script>