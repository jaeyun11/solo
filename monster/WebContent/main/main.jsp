<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="dao.PoketBoardDao"%>
<%@page import="bean.PoketBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<link type="text/css" rel="stylesheet" href="../css/style.css">
</head>
<%
	String id = (String) session.getAttribute("id");

	PoketBoardDao bdao = new PoketBoardDao();
	int totalPage = bdao.allPage();
	
	// 한페이지에 보여줄 글목록 갯수
	int pageSize = 10;
	
	// 입력한 페이지 값이 없을때 1페이지를 보여준다
	String strPageNum = request.getParameter("pageNum");
	if (strPageNum == null || strPageNum.equals("")) {
		strPageNum = "1";
	}
	
	int pageNum = Integer.parseInt(strPageNum); // 페이지 번호
	
	// 시작페이지
	int staNum = (pageNum - 1) * pageSize + 1;
	
	// 끝 페이지
	int enNum = pageNum * pageSize;
	
	List<PoketBoard> list = null;
	if (totalPage > 0) {
		list = bdao.getBoard(staNum, enNum);
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	
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
	<aside id="left">
		<h1 id="aaa">애니메이션 보러가기</h1>
		<video width="600" height="500" controls>
			<source src="../video/피카츄.webm" type="video/webm">
		</video>
	</aside>
	<section>
		<article>
			<h1 id="aaa">포켓몬 게임하러가기</h1>
			<video width="600" height="500" controls>
				<source src="../video/동영상.mp4" type="video/webm">
		</article>
	</section>
		<div id="main">
		<h1 id="aaa">커뮤니티</h1>
		<br>
		<br>
		<br>
		<table>
			<%
			for (PoketBoard pboard : list) {
						Timestamp timestamp = pboard.getReg_date();
			%>
			<tr>
				<td><%=pboard.getNum()%></td>
				<td><a href="read.jsp?num=<%=pboard.getNum()%>&pageNum=<%=pageNum%>"><%=pboard.getSubject()%></a></td>
				<td><%=pboard.getName()%></td>
				<td><%=pboard.getReadcount()%></td>
			</tr>
			<%
				}
			%>
		</table>
		</div>
	<footer>
		<br> <br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>
