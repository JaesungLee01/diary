<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//scheduleNo 유효성 검사
	if(request.getParameter("scheduleNo") == null
	|| request.getParameter("scheduleNo").equals("")){
		response.sendRedirect("./scheduleList.jsp");
		return;
	}
	//값 저장
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	System.out.println("deleteScheduleAction scheduleNo : " + scheduleNo);
	
	//schedulePw 유효성 검사
	if(request.getParameter("schedulePw") == null
	|| request.getParameter("schedulePw").equals("")){
		response.sendRedirect("./deleteScheduleForm.jsp?scheduleNo" + scheduleNo + "&msg=schedulePw is required");
		return;
	}
	//값 저장
	String schedulePw = request.getParameter("schedulePw");
	System.out.println("deleteScheduleAction scheduleNo : " + scheduleNo);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "select schedule_date from schedule where schedule_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,scheduleNo);
	
	ResultSet rs = stmt.executeQuery();
	String scheduleDate = null;
	if(rs.next()){
		scheduleDate = rs.getString("schedule_date");
	}
	
	String y = scheduleDate.substring(0,4);
	int m = Integer.parseInt(scheduleDate.substring(5,7)) - 1;
	String d = scheduleDate.substring(8);
	
	
	String sql2 = "delete from schedule where schedule_no =?";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	
	stmt2.setInt(1,scheduleNo);
	stmt2.setString(2,schedulePw);
	
	System.out.println(stmt + "<-- deleteScheduleAction sql");
	
	int row = stmt2.executeUpdate();
	
	if(row==0){
		response.sendRedirect("./deleteScheduleForm.jsp?scheduleNo" + scheduleNo);
	} else {
		response.sendRedirect("./scheduleListByDate.jsp?y=" + y + "&m=" + m + "&d=" + d);
	}
	
%>