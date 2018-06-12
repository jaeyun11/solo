<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<link type="text/css" rel="stylesheet" href="../css/style3.css">
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
					name="passwd" /><br> <input type="submit" value="로그인"
					class="btn"> <input type="button" value="회원가입" class="btn" onclick="location.href='join.jsp'">
				<%
					} else {
				%>
				포켓몬 월드에 오신걸 환영합니다 !<br><input type="button" value="로그아웃" class="btn" onclick="location.href='logout.jsp'">
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
	<div id="aaa">
	<form action="memupPro.jsp" method="post" id="join" name="frm">
		<fieldset>
			<h2>회원수정</h2>
			<label for="name">
			아이디 :</label> <input type="text" name="id"id="text1" /><br><br>
			<label for="password1">패스워드 :</label>
			<input type="password" name="passwd" /><br><br>
			<label for="password2">패스워드 확인 :</label>
			<input type="password" name="passwd2" /><br><br>
			<label for="name">
			이름 :</label> <input type="text" name="name" /><br><br>
			<label for="tel">
			휴대폰 번호 :</label> <input type="tel" name="tel" /> <br><br>
			<label for="email">
			이메일:</label> <input type="email" name="email" /> <br> <br>
			성별: <input	type="radio" name="gender" value="남"> 남성
				 <input type="radio" name="gender" value="여">여성<br>
		</fieldset>
		<input id="ddd" type="submit" name="submit" value="수정" class="btn">
		<input id="ddd"	type="reset" name="reset" value="초기화" onclick="reset" class="btn">
	</form>
	</div>
	<footer>
	<br><br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>