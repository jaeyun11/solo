<%@page import="dao.PoketMemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
  <link type="text/css" rel="stylesheet" href="../css/style3.css">
  <%
  	PoketMemberDao dao = new PoketMemberDao();
  %>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawStuff);

      function drawStuff() {
        var data = new google.visualization.arrayToDataTable([
          ['', '남성', '여성'],
          ['10대', <%=dao.upChart(10, 20, "남")%>, <%=dao.upChart(10, 20, "여")%>],
          ['20대', <%=dao.upChart(20, 30, "남")%>, <%=dao.upChart(20, 30, "여")%>],
          ['30대', <%=dao.upChart(30, 40, "남")%>, <%=dao.upChart(30, 40, "여")%>],
          ['40대', <%=dao.upChart(40, 50, "남")%>, <%=dao.upChart(40, 50, "여")%>]
        ]);

        var options = {
          width: 800,
          bars: 'horizontal', // Required for Material Bar Charts.
          series: {
            100: { axis: 'brightness' } // Bind series 1 to an axis named 'brightness'.
          },
          axes: {
              x: {
                brightness: {side: 'top', label: '연령에 따른 성비율'} // Top x-axis.
              }
            }
        };

      var chart = new google.charts.Bar(document.getElementById('dual_x_div'));
      chart.draw(data, options);
    };
    </script>
    <%
   		String id = (String) session.getAttribute("id");
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
					class="btn"><input type="button" value="회원가입" class="btn" onclick="location.href='join.jsp'">
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
	<h2>연령에 따른 성별분포</h2>
	<br><br>
	<div id="dual_x_div" style="width: 900px; height: 400px;"></div>
	</div>
	<footer>
		<br> <br>
		<h3>(주)포켓몬스터</h3>
	</footer>
</body>
</html>