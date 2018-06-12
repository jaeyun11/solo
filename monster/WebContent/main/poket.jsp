<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<link type="text/css" rel="stylesheet" href="../css/style2.css">
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
					name="passwd" /><br> <input type="submit" value="로그인" class="btn"> 
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
	<div id="a1">
		<img src="../image/피카츄.gif" width="320" height="400"><br>
		<br>
		<br>
		<h2>피카츄</h2>
	</div>
	<div id="a2">
		<img src="../image/파이리.gif" width="320" height="400"><br>
		<br>
		<br>
		<h2>파이리</h2>
	</div>
	<div id="a3">
		<img src="../image/꼬부기.gif" width="320" height="400"><br>
		<br>
		<br>
		<h2>꼬부기</h2>
	</div>
	<div id="a4">
		<img src="../image/이상해씨.gif" width="320" height="400"><br>
		<br>
		<br>
		<h2>이상해씨</h2>
	</div>
	<div id="a5">
		<img src="../image/에몽가.gif" width="320" height="400"><br>
		<br>
		<br>
		<h2>에몽가</h2>
	</div>
	<footer>
		<br> <br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>