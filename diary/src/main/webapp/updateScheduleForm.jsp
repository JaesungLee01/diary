<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%
	if(request.getParameter("scheduleNo")==null){
		response.sendRedirect("./scheduleList.jsp");
		return;
	}
	
	int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
	System.out.println(scheduleNo + " <-- deleteNoticeForm param scheduleNo");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	   
	   String sql = "select schedule_no, schedule_date, schedule_time, schedule_memo, schedule_color, createdate, updatedate, schedule_pw from schedule where schedule_no = ?";
	   PreparedStatement stmt = conn.prepareStatement(sql);
	   stmt.setInt(1, scheduleNo);
	   System.out.println(stmt + " <-- stmt");
	   ResultSet rs = stmt.executeQuery();
	   
	   Schedule schedule = null;
	   
	   if(rs.next()) {
		   schedule = new Schedule();
		   schedule.scheduleNo = rs.getInt("schedule_no");
		   schedule.scheduleDate = rs.getString("schedule_date");
		   schedule.scheduleTime = rs.getString("schedule_time");
		   schedule.scheduleMemo = rs.getString("schedule_memo");
		   schedule.scheduleColor = rs.getString("schedule_color");
		   schedule.createdate = rs.getString("createdate");
		   schedule.updatedate = rs.getString("updatedate");
		   schedule.schedulePw = rs.getString("schedule_pw");
	   }
	   

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
	<form action="./updateScheduleAction.jsp" method="post">
		<table class="table table-warning">
		<%
			if(rs.next()){
		%>
			<tr>
            <td>
               스케줄 번호
            </td>
            <td>
               <input type="number" name="scheduleNo" 
                  value="<%=schedule.scheduleNo%>" readonly="readonly"> 
            </td>
         </tr>
         <tr>
            <td>
               비밀번호
            </td>
            <td>
               <input type="password" name="schedulePw"> 
            </td>
         </tr>
         <tr>
            <td>
               날짜
            </td>
            <td>
               <input type="date" name="scheduleDate" 
                  value="<%=schedule.scheduleDate%>"> 
            </td>
         </tr>
         <tr>
            <td>
               메모
            </td>
            <td>
               <textarea rows="5" cols="80" name="scheduleMemo"
                  value="<%=schedule.scheduleMemo%>">
               </textarea>
            </td>
         </tr>
         <tr>
            <td>
               시간
            </td>
            <td>
            <input type="time" name="scheduleTime"
               value="<%=schedule.scheduleTime%>">
            </td>
         </tr>
         <tr>
            <td>
               색깔
            </td>
            <td>
            <input type="color" name="scheduleColor"
               value="<%=schedule.scheduleColor%>">
            </td>
         </tr>
         <tr>
            <td>
               createdate
            </td>
            <td>
               <%=schedule.createdate%>
            </td>
         </tr>
         <tr>
            <td>
               updatedate
            </td>
            <td>
               <%=schedule.updatedate%>
            </td>
         </tr>
       <%
       }
       %>
		</table>
		<div>
			<button type="submit">수정</button>
		</div>
	</form>
	</div>
</body>
</html>