<%@page import="bean.PoketBoard"%>
<%@page import="dao.PoketBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<link type="text/css" rel="stylesheet" href="../css/style6.css">
<script>
	function fun() {
		alert('로그인후 이용해주세요 !');
	}
</script>
</head>
<%
	String id = (String) session.getAttribute("id");
%>
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
					name="passwd" /><br> <input type="submit" value="로그인"  class="btn"/>
					<input type="button" value="회원가입" class="btn" onclick="location.href='join.jsp'">
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
	<%
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		PoketBoardDao pdao = new PoketBoardDao();
	%>
	<div id="up">
	<form action="updatePro.jsp?num=<%=num%>" method="post" name="frm">
		<table>
			<tr>
				<th>제목</th>
				<td><textarea rows="2" cols="30" name="subject">
					<%=pdao.getBoard(num).getSubject()%></textarea>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="15" cols="40" name="content"><%=pdao.getBoard(num).getContent()%></textarea></td>
			</tr>
		</table>
		<input type="submit" value="수정완료" class="btn"> <input type="reset"
			value="초기화" class="btn"> <input type="button" value="목록으로"
			onclick="location.href='community.jsp?pageNum=<%=pageNum%>'" class="btn">
	</form>
	</div>
	<footer>
		<br>
		<br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>