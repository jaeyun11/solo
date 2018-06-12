<%@page import="dao.PoketMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<script src="../js/jquery-3.2.1.min.js"></script>
<link type="text/css" rel="stylesheet" href="../css/style3.css">
<script>
	var ck = 0;
	
	$(document).ready(function(){
		$('#id').change(function(){
			var id = $('#id').val();
		
		$.get('idCheck.jsp',{userid: id}, function(data){
			ck = parseInt(data);
			if(ck == 1){
				$('#id1').html('사용중인 아이디입니다').css("color","red");
				$('#qqq').prop("disabled", true);
			}else{
				$('#id1').html('사용가능한 아이디입니다').css("color","green");
				$('#qqq').prop("disabled", false);
			}
		});
		});
	});

	function join() {
		if (document.frm.id.value.length == 0) {
			alert('아이디를 입력하세요.');
			document.frm.id.focus();
			return false;
		}

		if (document.frm.passwd.value.length == 0) {
			alert('암호를 입력하세요.');
			document.frm.passwd.focus();
			return false;
		}
		if (document.frm.passwd2.value.length == 0) {
			alert('암호를 입력하세요.');
			document.frm.passwd2.focus();
			return false;
		}
		if (document.frm.name.value.length == 0) {
			alert('이름를 입력하세요.');
			document.frm.name.focus();
			return false;
		}
		if (document.frm.tel.value.length == 0) {
			alert('번호를 입력하세요.');
			document.frm.tel.focus();
			return false;
		}

		if (document.frm.dob.value.length == 0) {
			alert('생년월일을 선택하세요.');
			document.frm.dob.focus();
			return false;
		}

		if (document.frm.email.value.length == 0) {
			alert('메일을 입력하세요.');
			document.frm.email.focus();
			return false;
		}
		if (document.frm.gender[0].checked == false
				&& document.frm.gender[1].checked == false) {
			alert('성별을 선택하세요.');
			document.frm.gender[0].focus();
			return false;
		}
	}
</script>
<%
	String id = request.getParameter("id");
%>
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
					class="btn"><input type="button" value="회원가입" class="btn"
					onclick="location.href='join.jsp'">
				<%
					} else {
				%>
				포켓몬 월드에 오신걸 환영합니다 !<br> <input type="button" value="로그아웃"
					class="btn" onclick="location.href='logout.jsp'">
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
			<li><a href="main.jsp">커뮤니티</a></li>
		</ul>
	</nav>
	<div id="aaa">
		<form action="joinPro.jsp" method="post" id="join" name="frm">
			<fieldset>
				<legend>회원가입</legend>
				<label for="name"> 아이디 :</label> <input type="text" name="id"
					id="id" /><span id="id1"></span> <br>
				<br> <label for="password1">패스워드 :</label> <input
					type="password" name="passwd"/><br>
				<br> <label for="password2">패스워드 확인 :</label> <input
					type="password" name="passwd2" /><br>
				<br> <label for="name">이름 :</label> <input type="text"
					name="name" /><br>
				<br> <label for="dob">나이 :</label> <input type="text"
					name="age" /> <br>
				<br> <label for="tel">휴대폰 번호 :</label> <input type="tel"
					name="tel" /> <br>
				<br> <label for="email">이메일 :</label> <input type="email"
					name="email" /> <br>
				<br> 성별: <input type="radio" name="gender" value="남">남성
				<input type="radio" name="gender" value="여">여성<br>
			</fieldset>
			<input id="qqq" type="submit" name="submit" value="회원가입"
				onclick="return join()" class="btn" disabled="disabled"> <input id="ddd"
				type="reset" name="reset" value="초기화" onclick="reset" class="btn">
		</form>
	</div>
	<footer>
		<br> <br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>
