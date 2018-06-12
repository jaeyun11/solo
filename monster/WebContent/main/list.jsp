<%@page import="bean.PoketMember"%>
<%@page import="java.util.List"%>
<%@page import="dao.PoketMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<link type="text/css" rel="stylesheet" href="../css/style4.css">
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
	<div id="all">
	<aside id="left">
		<ul>
			<li><a href="admin.jsp">admin</a></li>
			<li><a href="list.jsp">회원관리</a></li>
			<li><a href="commu.jsp">게시판관리</a></li>
			<li><a href="chart.jsp">차트</a></li>
		</ul>
	</aside>
	<%
		PoketMemberDao pdao = new PoketMemberDao();
		List<PoketMember>list = pdao.getMem();
	%>
	<div id="list">
		<h2>트레이너 목록</h2>
		<table>
			<tr>
				<th>아이디</th>
				<th>패스워드</th>
				<th>이름</th>
				<th>성별</th>
				<th>나이</th>
				<th>이메일</th>
				<th>연락처</th>
				<th>가입날짜</th>
				<th>관리</th>
			</tr>
			<%
				for(PoketMember bean : list){
					%>
						<tr>
							<td><%=bean.getId() %></td>
							<td><%=bean.getPasswd() %></td>
							<td><%=bean.getName() %></td>
							<td><%=bean.getGender() %></td>
							<td><%=bean.getAge() %></td>
							<td><%=bean.getEmail() %></td>
							<td><%=bean.getTel() %></td>
							<td><%=bean.getReg_date() %></td>
							<td><input type="button" value="관리" onclick="location.href='info.jsp?id=<%=bean.getId()%>'" class="btn"></td>
						</tr>
					<%
				}
			%>
		</table>
	</div>
	</div>
<footer>
	<br><br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>