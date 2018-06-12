<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="bean.PoketBoard"%>
<%@page import="java.util.List"%>
<%@page import="dao.PoketBoardDao"%>
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

	function fun1() {
		var input = document.frm.search.value;
		if (input.length == 0) {
			document.frm.action = 'community.jsp';
		}
		document.frm.submit();
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
	<nav>
		<ul>
			<li><a href="match.jsp">상성표</a></li>
			<li><a href="poket.jsp">대표포켓몬</a></li>
			<li><a href="http://pokemonkorea.co.kr/product">상점</a></li>
			<li><a href="community.jsp">커뮤니티</a></li>
		</ul>
	</nav>
	<div id="all">
	<aside id="left">
		<ul>
			<li><a href="community.jsp">자유게시판</a></li>
			<li><a href="fileupload.jsp">자료실</a></li>
			<%
				if(id != null && id.equals("admin")){
					%>
						<li><a href="admin.jsp">admin</a></li>
					<%
				}
			%>
		</ul>
	</aside>
	<%
		String search = request.getParameter("search");
		PoketBoardDao bdao = new PoketBoardDao();
		int totalPage = bdao.allPage(search);

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
			list = bdao.getBoard(search, enNum, staNum);
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	%>
	<article>
		<table>
			<tr>
				<th id="aa">No</th>
				<th id="bb">제목</th>
				<th id="cc">작성자</th>
				<th id="dd">조회수</th>
			</tr>
			<%
				if (totalPage > 0) {
					for (PoketBoard pboard : list) {
						Timestamp timestamp = pboard.getReg_date();
			%>
			<tr>
				<td><%=pboard.getNum()%></td>
				<td><a
					href="read.jsp?num=<%=pboard.getNum()%>&pageNum=<%=pageNum%>"><%=pboard.getSubject()%></a></td>
				<td><%=pboard.getName()%></td>
				<td><%=pboard.getReadcount()%></td>
			</tr>
			<%
				}
				} else {
			%>
			<tr>
				<td>글을 등록하세요 !</td>
			</tr>
			<%
				}
			%>
		</table>
		<div id="search">
			<form action="search.jsp" id="frm">
				<input type="text" name="search" onfocus="this.select()" id="text"> <input
					type="submit" value="검색" class="btn">
			</form>
			<input type="button" value="글쓰기" class="btn"
				<%if (id == null) {%> onclick="fun()" <%} else {%>
				onclick="location.href='write.jsp'">
			<%
				}
			%>
		</div>
		<span id="clear"></span>
		<div id="page">
	<%
		if (totalPage > 0) {
			int count = totalPage / pageSize + (totalPage % pageSize == 0 ? 0 : 1);

			int pageBlock = 3;

			int start = (pageNum / pageBlock - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;

			int end = start + pageBlock - 1;
			if (end > count) {
				end = count;
			}
			if (start > pageBlock) {
	%>
	<input type="button" value="이전"
		onclick="location.href='community.jsp?pageNum=<%=start - pageBlock%>'">
	<%
		}
			for (int i = start; i <= end; i++) {
				if (i == pageNum) {
	%>
	<a href="community.jsp?pageNum=<%=i%>"><b><%=i%></b></a>
	<%
		} else {
	%>
	<a href="community.jsp?pageNum=<%=i%>"><%=i%></a>
	<%
		}
			}
			if (end < count) {
	%>
	<input type="button" value="다음"
		onclick="location.href='community.jsp?pageNum=<%=start + pageBlock%>'">
	<%
		}
		}
	%>
	</div>
	</article>
	</div>
	<footer>
		<br> <br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>