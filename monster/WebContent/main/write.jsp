<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
 <link type="text/css" rel="stylesheet" href="../css/write.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
	<div id="wt">
	<form action="writePro.jsp" method="post" name="frm">
		<table>
			<tr>
				<th>제목</th>
				<td><textarea rows="2" cols="50" name="subject"></textarea></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="13" cols="50" name="content"></textarea></td>
			</tr>
		</table>
		<div id="clear"></div>
		<input type="submit" value="작성하기" class="btn"> <input type="reset"
			value="지우기" class="btn"> <input type="button" value="목록으로"
			onclick="location.href='community.jsp'" class="btn">
	</form>
	</div>
	<footer>
		<br> <br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>