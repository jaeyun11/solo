<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int replenum = Integer.parseInt(request.getParameter("replenum"));
%>
<script>
	function fun(){
		if(document.fr.content.value.length == 0){
			alert('수정할 내용을 입력하세요');
			document.fr.content.focus();
			return false;
		}
		
		if(document.fr.passwd.value.length == 0){
			alert('패스워드를 입력하세요');
			document.fr.passwd.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<form action="reupPro.jsp?num=<%=num %>&replenum=<%=replenum %>" method="post" name="fr">
		<h2>댓글 수정</h2>
		<textarea rows="4.5" cols="30" name="content"></textarea><br><br>
		<input type="password" name="passwd">
		<input type="submit" value="수정" onclick="return fun()">
	</form>
</body>
</html>