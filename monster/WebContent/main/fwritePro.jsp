<%@page import="bean.Board"%>
<%@page import="dao.FileBoard"%>
<%@page import="dao.PoketMemberDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="bean.PoketBoard"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dao.PoketBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	
	
	FileBoard fboard = new FileBoard();
	
	String realPath = application.getRealPath("/upload");
	System.out.println(realPath);
	
	int max = 1024 * 1024 * 5;
	
	MultipartRequest multi = new MultipartRequest(request, realPath, max, "utf-8", new DefaultFileRenamePolicy());
	
	Board board = new Board();
	board.setSubject(multi.getParameter("subject"));
	board.setContent(multi.getParameter("content"));
	board.setFilename(multi.getFilesystemName("filename"));
	
	PoketMemberDao dao = new PoketMemberDao();
	String name = dao.getName(id);
	board.setReg_date(new Timestamp(System.currentTimeMillis()));
	board.setIp(request.getRemoteAddr());
	board.setReadcount(0);
	board.setName(name);
	board.setId(id);
	
	fboard.insert(board);
	
	response.sendRedirect("fileupload.jsp");
%>