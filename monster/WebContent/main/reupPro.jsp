<%@page import="bean.Re"%>
<%@page import="dao.RepleDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String passwd = request.getParameter("passwd");
	String id = (String)session.getAttribute("id");
	request.setCharacterEncoding("utf-8");
	
	RepleDao dao = new RepleDao();
	
	int replenum = Integer.parseInt(request.getParameter("replenum"));
	int num = Integer.parseInt(request.getParameter("num"));
%> 
<jsp:useBean id="re" class="bean.Re"/>
<jsp:setProperty property="*" name="re"/>
<%
	int check = dao.reup(re, passwd);
	
	if(id != null && id.equals("admin")){
		
		dao.adUp(re);
		
		%>
		<script>
			alert('수정완료');
			opener.location.reload();
			close();
		</script>
		<%
	}

	if(check == 1){
		%>
		<script>
			alert('수정완료');
			opener.location.reload();
			close();
		</script>
		<%
	}else{
		%>
		<script>
			alert('패스워드를 확인하세요 .');
			history.back();
		</script>
		<%
	}
%>