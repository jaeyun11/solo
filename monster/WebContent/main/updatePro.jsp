<%@page import="dao.PoketBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	PoketBoardDao pdao = new PoketBoardDao();
	
	String pageNum = request.getParameter("pageNum");
%>
<jsp:useBean id="board" class="bean.PoketBoard"/>
<jsp:setProperty property="*" name="board"/>
<%
	int check = pdao.updateCommu(board, id);

	if(check == 1){
		%>
		<script>
			alert('수정완료');
			location.href="community.jsp";
		</script>
		<%
	}else{
		%>
			<script>
				alert('회원정보가 일치하지않습니다 .');
				location.href="community.jsp";
			</script>
		<%
	}
%>