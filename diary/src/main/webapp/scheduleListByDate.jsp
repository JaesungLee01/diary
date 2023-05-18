<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	//y, m, d 값이 null or "" -> redirection scjeduleList.jsp
	
	int y = Integer.parseInt(request.getParameter("y"));
	// 자바API에서 12월 11, 마리아DB 12월 12
	int m = Integer.parseInt(request.getParameter("m")) + 1;
	int d = Integer.parseInt(request.getParameter("d"));
	
	System.out.println(y + " <-- scheduleListByDate param y");
	System.out.println(m + " <-- scheduleListByDate param m");
	System.out.println(d + " <-- scheduleListByDate param d");
	
	String strM = m+"";
	if(m<10){
		strM = "0"+strM;
	}
	String strD = d+"";
	if(d<10){
		strD = "0"+strD;
	}
	//일별 스케줄 리스트
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	String sql = "select * from schedule where schedule_date = ? order by schedule_time asc";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, y+"-"+strM+"-"+strD);
	System.out.println(stmt + "<-- scheduleListByDate stmt");
	ResultSet rs = stmt.executeQuery();
	
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
	<h1>스케줄 입력</h1>
	<form action="./insertScheduleAction.jsp" method="post">
		<table class="table table-warning">
			<tr>
				<th>날짜</th>
				<td><input type="date" name="scheduleDate" value="<%=y%>-<%=strM%>-<%=strD%>" readonly="readonly"></td>
			</tr>
			<tr>
				<th>시간</th>
				<td><input type="time" name="scheduleTime" value="<%=y%>-<%=strM%>-<%=strD%>"></td>
			</tr>
			<tr>
				<th>색상</th>
				<td><input type="color" name="scheduleColor" value="#000000"></td>
			</tr>
			<tr>
				<th>메모</th>
				<td><textarea cols="80" rows="3" name="scheduleMemo"></textarea><button type="submit">스케줄입력</button></td>
			</tr>
		</table>
		
	</form>
	<h1><%=y%>년 <%=m%>월 <%=d%>일 스케줄 목록</h1>
	<table class="table table-warning">
		<tr>
			<th>schedule_time</th>
			<th>schedule_memo</th>
			<th>createdate</th>
			<th>updatedate</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			while(rs.next()){
				
		%>
			<tr>
				<td><%= rs.getString("schedule_time") %></td>
				<td><%= rs.getString("schedule_memo") %></td>
				<td><%= rs.getString("createdate") %></td>
				<td><%= rs.getString("updatedate") %></td>
				<td><a href="./updateScheduleForm.jsp?scheduleNo=<%=rs.getInt("schedule_no")%>">수정</a></td>
				<td><a href="./deleteScheduleForm.jsp?scheduleNo=<%=rs.getInt("schedule_no")%>">삭제</a></td>
			</tr>
			
		<%
			}
		%>
	</table>
	</div>
</body>
</html>