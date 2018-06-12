<%@page import="dao.PoketBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String id = (String)session.getAttribute("id");
	
	PoketBoardDao pdao = new PoketBoardDao();
	int check = pdao.delCommu(num, id);
	
	if(id != null && id.equals("admin")){
		pdao.adminDelete(num);
		%>
		<script>
			alert('삭제가 완료되었습니다');
			location.href="community.jsp?pageNum=<%=pageNum%>";
		</script>
		<% 
	}
	if(check == 1){
		%>
			<script>
				alert('삭제가 완료되었습니다');
				location.href="community.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
	}else{
		%>
			<script>
				alert('회원정보가 틀립니다');
				location.href="community.jsp?pageNum=<%=pageNum%>";
			</script>
		<%
	}
	%>