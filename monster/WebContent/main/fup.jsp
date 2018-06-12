<%@page import="bean.Board"%>
<%@page import="dao.FileBoard"%>
<%@page import="bean.Re"%>
<%@page import="java.util.List"%>
<%@page import="dao.RepleDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="bean.PoketBoard"%>
<%@page import="dao.PoketBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	FileBoard fboard = new FileBoard();
	
	Board board = fboard.getBoard(num);
%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<link type="text/css" rel="stylesheet" href="../css/style6.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function btnDelete() {
		var del = confirm('게시물을 삭제하시겠습니까 ?');
		if(del == true){
			location.href='delete.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
		}
	}
</script>
</head>

<body>
	<header>
		<a href="main.jsp"> <img src="../image/title.png" width="700"
			height="150"></a>
		<div id=sss>
			<form action="loginPro.jsp" method="post" id="login">
				<%
					if (id == null) {
				%>
				아이디 : <input type="text" name="id" /> 비번 : <input type="password"
					name="passwd" /><br> <input type="submit" value="로그인"
					class="btn" /> <input type="button" value="회원가입" class="btn" onclick="location.href='join.jsp'">
				<%
					} else {
				%>
				포켓몬 월드에 오신걸 환영합니다 !<br> <input type="button" value="로그아웃" class="btn" onclick="location.href='logout.jsp'">
				<%
					}
					if (id != null && id.equals("admin")) {
				%>
				<input type="button" value="admin"
					onclick="location.href='admin.jsp'" class="btn">
				<%
					}
				%>
			</form>
		</div>
	</header>
	<nav>
		<ul>
			<li><a href="match.jsp">상성표</a></li>
			<li><a href="poket.jsp">대표포켓몬</a></li>
			<li><a href="http://pokemonkorea.co.kr/product">상점</a></li>
			<li><a href="community.jsp">커뮤니티</a></li>
		</ul>
	</nav>
	<div id="up">
	<form action="fupPro.jsp?pageNum=<%=pageNum %>&num=<%=num %>" method="post" enctype="multipart/form-data">
	<div id="tab">
		<table id="cell">
			<tr>
				<th>제목</th>
				<td>
					<textarea rows="2" cols="30" name="subject"><%=fboard.getBoard(num).getSubject()%></textarea></td>
			</tr>
			<tr>
				<th>파일</th>
				<td><input type="file" name="filename"> <%=board.getFilename()%>
					<input type="hidden" name="oldfilename"
					value="<%=board.getFilename()%>"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="15" cols="40" name="content"><%=fboard.getBoard(num).getContent()%></textarea></td>
			</tr>
		</table>

		<div id="downbt">
			<input type="submit" value="수정" class="btn">
			<input type="reset" value="초기화" class="btn"> 
			<input type="button" value="글목록" onclick="location.href='fileupload.jsp?pageNum=<%=pageNum%>'" class="btn">
		</div>
		</div>
	</div>
	</form>
	<footer>
		<br> <br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>