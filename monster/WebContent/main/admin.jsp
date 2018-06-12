<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<link type="text/css" rel="stylesheet" href="../css/admin.css">
<script>
	function fun() {
		alert('로그인후 이용해주세요 !');
	}
	
	function time(){
		<%
		%>
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
					name="passwd" /><br> <input type="submit" value="로그인" class="btn"/> 
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
	<div id=all>
	<div id="leftup">
		<input type=button value="회원관리" onclick="location.href='list.jsp'" class="btn1">
	</div>

	<div id="rightup">
		<input type=button value="게시판관리" onclick="location.href='commu.jsp'" class="btn1">
	</div>

	<div id="leftdown">
		<input type=button value="통계보기" onclick="location.href='chart.jsp'" class="btn1">
	</div>
	</div>
	<footer>
		<br>
		<br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>