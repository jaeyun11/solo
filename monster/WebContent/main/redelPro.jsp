<%@page import="dao.RepleDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String passwd = request.getParameter("passwd");
	int replenum = Integer.parseInt(request.getParameter("replenum"));
	String id = (String)session.getAttribute("id");
	
	RepleDao dao = new RepleDao();
	
 	int check = dao.redel(replenum, passwd);
 	
 	if(id != null && id.equals("admin")){
 		
 		dao.adDel(replenum);
 		
 		%>
		<script>
			alert('삭제완료');
			opener.location.reload();
			close();
		</script>
		<%
 	}
 	
 	if(check == 1){
		%>
		<script>
			alert('삭제완료');
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