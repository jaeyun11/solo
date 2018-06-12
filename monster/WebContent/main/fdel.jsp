<%@page import="dao.FileBoard"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String id = (String)session.getAttribute("id");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String passwd = request.getParameter("passwd");
	
	FileBoard dao = new FileBoard();
	int check = dao.delCommu(num, id); 
	
	
	if(id != null && id.equals("admin")){
		dao.adminDelete(num);
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
			alert('삭제 성공');
			location.href = 'fileupload.jsp?pageNum=<%=pageNum%>';
		</script>
		<%
	}else{
		%>
		<script>
			alert('회원정보가 틀립니다');
			history.back();
		</script>
		<%
	}
%>