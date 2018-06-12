<%@page import="bean.PoketMember"%>
<%@page import="dao.PoketMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<link type="text/css" rel="stylesheet" href="../css/style3.css">
<%
	String userid = request.getParameter("id");
%>
<script>
	function fun() {
		alert('로그인후 이용해주세요 !');
	}
	
	function del(){
		var del = confirm('정말 회원을 삭제하시겠습니까 ?');
		if(del == true){
			location.href='memdel.jsp?id=<%=userid%>';
		}
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
	<%
		PoketMemberDao dao = new PoketMemberDao();
		PoketMember bean = dao.getmember(userid);
	%>
	<div id="aaa">
	<fieldset id="vv">
		<h2>회원관리</h2>
		아이디 :<%=bean.getId() %><br>
		패스워드 :<%=bean.getPasswd() %><br>
		이름 :<%=bean.getName() %><br>
		나이 :<%=bean.getAge() %><br>
		성별 :<%=bean.getGender() %><br>
		이메일 :<%=bean.getEmail() %><br>
		연락처 :<%=bean.getTel() %><br>
		가입날짜 :<%=bean.getReg_date() %><br>
	<input type="button" name="delete" value="삭제" onclick="del()" class="btn">
	<input type="button" value="수정" onclick="location.href='memup.jsp?id=<%=userid%>'" class="btn">
	<input type="button" value="목록으로" onclick="location.href='list.jsp'" class="btn">
	</fieldset>
	</div>
	<footer>
		<br>
		<br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>