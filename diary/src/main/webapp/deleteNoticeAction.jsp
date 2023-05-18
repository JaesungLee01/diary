<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%
	
	if(request.getParameter("noticeNo")==null
		|| request.getParameter("noticePw") == null
		|| request.getParameter("noticeNo").equals("")
		|| request.getParameter("noticePw").equals("")) {
		response.sendRedirect("./noticeList.jsp");
		return; // 1) 코드진행종료 2) 반환값을 남길때

	}
		
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticePw = request.getParameter("noticePw");
	
	System.out.println(noticeNo + " <-- deleteNoticeForm param noticeNo");
	System.out.println(noticePw + " <-- deleteNoticeForm param noticePw");

	// delete from notice
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	String sql = "delete from notice where notice_no =?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setInt(1,noticeNo);
	stmt.setString(2,noticePw);
	
	System.out.println(stmt + "<-- deleteNoticeAction sql");


	int row = stmt.executeUpdate();
	System.out.println(row + "< -- deleteNoticeAction row");
	
	if(row == 0) { //비밀번호 틀려서 삭제행이 0행
		response.sendRedirect("./deleteNoticeForm.jsp?noticeNo");
		//response.sendRedirect("./.jsp?noticeNo");
	} else {
		response.sendRedirect("./noticeList.jsp");
	}

%>