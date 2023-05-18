<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% 
	// 인코딩 설정
	request.setCharacterEncoding("utf-8");
	// updateForm에서 넘어온 값을 확인
	System.out.println(request.getParameter("scheduleNo") + "");
	System.out.println(request.getParameter("schedulePw") + "");
	System.out.println(request.getParameter("scheduleDate") + "");
	System.out.println(request.getParameter("scheduleeMemo") + "");
	System.out.println(request.getParameter("scheduleTime") + "");
	System.out.println(request.getParameter("scheduleColor") + "");
	
	if(request.getParameter("scheduleNo")==null || request.getParameter("scheduleNo").equals("")){
		response.sendRedirect("./scheduleList");
		return;
	}
	String msg = null;
			
	if(request.getParameter("schedulePw")==null || request.getParameter("schedulePw").equals("")){
		msg = "schedulePw error";
				
	} else if(request.getParameter("scheduleDate")==null || request.getParameter("scheduleDate").equals("")){
		msg = "scheduleDate error";
				
	} else if(request.getParameter("scheduleMemo")==null || request.getParameter("scheduleMemo").equals("")){
		msg = "scheduleMemo error";
			
	} else if(request.getParameter("scheduleTime")==null || request.getParameter("scheduleTime").equals("")){
		msg = "scheduleTime error";
		
	} else if(request.getParameter("scheduleColor")==null || request.getParameter("scheduleColor").equals("")){
		msg = "scheduleColor error";
	}
	
	if(msg != null){
		response.sendRedirect("./updateScheduleForm.jsp?scheduleNo="+request.getParameter("scheduleNo")+"&msg"+msg);
		return;
	}
	
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	String schedulePw = request.getParameter("schedulePw");
	String scheduleDate = request.getParameter("scheduleDate");
	String scheduleMemo = request.getParameter("scheduleMemo");
	String scheduleTime = request.getParameter("scheduleTime");
	String scheduleColor = request.getParameter("scheduleColor");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	
	String sql = "update schedule set schedule_date = ?, schedule_time = ?, schedule_color = ?, schedule_memo = ?, updatedate=now() where schedule_no = ? and schedule_pw = ?";
	
	PreparedStatement stmt = conn.prepareStatement(sql);

	stmt.setString(1,scheduleDate);
	stmt.setString(2,scheduleTime);
	stmt.setString(3,scheduleColor);
	stmt.setString(4,scheduleMemo);
	stmt.setInt(5,scheduleNo);
	stmt.setString(6,schedulePw);
	
	String y = scheduleDate.substring(0,4);
	int m = Integer.parseInt(scheduleDate.substring(5,7)) - 1;
	String d = scheduleDate.substring(8);
	
	int row = stmt.executeUpdate();
	
	if(row == 0){
		response.sendRedirect("./updateScheduleForm.jsp?scheduleNo=" + scheduleNo + "&msg = schedulePw is incorrect");
		
	} else {
		response.sendRedirect("./scheduleListByDate.jsp?y=" + y + "&m=" + m + "&d=" +d);
	}

%>