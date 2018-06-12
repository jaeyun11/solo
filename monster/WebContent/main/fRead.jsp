<%@page import="java.util.List"%>
<%@page import="dao.RepleDao"%>
<%@page import="bean.Re"%>
<%@page import="bean.Board"%>
<%@page import="dao.FileBoard"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	FileBoard fboard = new FileBoard();
	fboard.upCount(num);

	Board board = fboard.getBoard(num);

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	Timestamp time = board.getReg_date();
	Date date = new Date(time.getTime());
	String sDate = sdf.format(date);
	
	RepleDao rdao = new RepleDao();
%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<link type="text/css" rel="stylesheet" href="../css/style5.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function btnDelete() {
		var del = confirm('게시물을 삭제하시겠습니까 ?');
		if(del == true){
			location.href='fdel.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
		}
	}
	
	function up(replenum){
		window.open('reup.jsp?num=<%=num%>&replenum=' + replenum, '', 'width=400,height=200');
	}
	
	function del(replenum){
		window.open('redel.jsp?num=<%=num%>&replenum=' + replenum, '', 'width=400,height=200');
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
	<nav>
		<ul>
			<li><a href="match.jsp">상성표</a></li>
			<li><a href="poket.jsp">대표포켓몬</a></li>
			<li><a href="http://pokemonkorea.co.kr/product">상점</a></li>
			<li><a href="community.jsp">커뮤니티</a></li>
		</ul>
	</nav>
	<div id="tab">
	<table id="cell">
		<tr>
			<th class="min">글번호</th>
			<td class="min"><%=board.getNum()%></td>
		</tr>
		<tr>
			<th class="min">제목</th>
			<td class="min"><%=board.getSubject()%></td>
		</tr>
		<tr>
			<th class="min">조회수</th>
			<td class="min"><%=board.getReadcount()%></td>
		</tr>
		<tr>
			<th class="min">글쓴이</th> 
			<td class="min"><%=board.getName()%></td>
		</tr>
		<tr>		
			<th class="min">작성일</th>
			<td class="min"><%=sDate%></td>
		</tr> 
		<tr>
			
		</tr>
		<tr>
			<td id="con" colspan="2">
			<%
				 	if (board.getFilename() != null) {
				 		String fname = board.getFilename();
				 		int index = fname.lastIndexOf(".");
				 		String ext = fname.substring(index + 1);
				 		if (ext.equals("jpg") || ext.equals("png") || ext.equals("gif")) {
				 %> <img alt="<%=fname%>" src="../upload/<%=fname%>"> <%
				 	}
				 		
				 }
			 %>			
 			
			<%=board.getContent()%>
			</td>
		</tr>
	</table>
	<div id="downbt">
	<input type="button" value="수정"
		onclick="location.href='fup.jsp?num=<%=num%>&pageNum=<%=pageNum%>'"
		class="btn">
	<input type="button" value="삭제" onclick="btnDelete()" class="btn">
	<input type="button" value="글목록"
		onclick="location.href='fileupload.jsp?pageNum=<%=pageNum%>'"
		class="btn">
	</div>
	<br>
	<br>
	<br>
	<div>
		<fieldset>
			<form action="reple2.jsp?num=<%=num%>" method="post">
				<textarea name="content" rows="5" cols="100" id="cont"></textarea>
				<h3>패스워드 : </h3><input type="password" name="passwd" id="ps">
				 <input	type="submit" value="댓글달기" class="btn">
			</form>
			<div id="clear"></div>

			<%
				List<Re> myrepleList = rdao.getRe(num);
				if (myrepleList.size() > 0) {
					for (Re re : myrepleList) {
			%>
			<table id="re">
				<tr>
					<td>
						<%=re.getId()%>
						<%=re.getContent()%>
						<%=re.getReg_date()%>
						<%
						if(id == null){
							
						}else{
							if(id != null && (id.equals(re.getId()) || id.equals("admin"))){
								%>
									<input type="button" value="수정" class="btn" onclick="up(<%=re.getReplenum()%>)">
									<input type="button" value="삭제" class="btn" onclick="del(<%=re.getReplenum()%>)">
								<%
							}
						}
					 	%>
					</td>
				</tr>
			</table>
			<%
				}
				}
			%>
		</fieldset>
	</div>
	</div>
	<footer>
		<br> <br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>