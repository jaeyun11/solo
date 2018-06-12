<%@page import="dao.FileBoard"%>
<%@page import="java.io.File"%>
<%@page import="bean.Board"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String id = (String)session.getAttribute("id");
	String realPath = application.getRealPath("/upload");
	int max = 1024 * 1024 * 5; //5MB

	MultipartRequest multi = new MultipartRequest(request, realPath, max, "utf-8",
			new DefaultFileRenamePolicy());

	Board board = new Board();

	board.setContent(multi.getParameter("content"));
	board.setFilename(multi.getParameter("filename"));
	board.setId(multi.getParameter("id"));
	board.setNum(Integer.parseInt(multi.getParameter("num")));
	board.setSubject(multi.getParameter("subject"));

	if (multi.getFilesystemName("filename") != null) {
		board.setFilename(multi.getFilesystemName("filename"));

		String targetFile = multi.getParameter("oldfilename");

		File file = new File(realPath, targetFile);
		if (file.exists()) {
			file.delete();
		}
	} else {
		board.setFilename(multi.getParameter("oldfilename"));
	}

	String pageNum = multi.getParameter("pageNum");
%>

<jsp:useBean id="fboard" class="bean.Board" />
<jsp:setProperty property="*" name="fboard" />

<%
	FileBoard dao = new FileBoard();

	int check = dao.fileup(board,id);
	
	if (check == 1) {
		%>
			<script>
				alert('수정완료 !');
			</script>
		<%
		response.sendRedirect("fileupload.jsp?pageNum=" + pageNum);
	} else {
%>
<script>
	alert('패스워드틀림');
	history.back();
</script>
<%
	}
%>
