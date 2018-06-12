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

	PoketBoardDao pboard = new PoketBoardDao();
	pboard.upCount(num);

	PoketBoard board = pboard.getBoard(num);

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	Timestamp time = board.getReg_date();
	Date date = new Date(time.getTime());
	String sDate = sdf.format(date);
%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function btnDelete() {
		var del = confirm('게시물을 삭제하시겠습니까 ?');
		if(del == true){
			location.href='delete.jsp?num=<%=num%>&pageNum=<%=pageNum%>	';
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
	<table>
		<tr>
			<td><%=board.getNum()%></td>
			<td><%=board.getSubject()%></td>
			<th>조회수</th>
			<td><%=board.getReadcount()%></td>
		</tr>
		<tr>
			<td><%=board.getName()%></td>
			<td><%=sDate%></td>
		</tr>
		<tr>
			<td><%=board.getContent()%></td>
		</tr>
	</table>
	<input type="button" value="수정"
		onclick="location.href='update.jsp?num=<%=num%>&pageNum=<%=pageNum%>'" class="btn">
	<input type="button" value="삭제" onclick="btnDelete()" class="btn">
	<input type="button" value="글목록"
		onclick="location.href='community.jsp?pageNum=<%=pageNum%>'" class="btn">
	<footer>
		<br> <br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>