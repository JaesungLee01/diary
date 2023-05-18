<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("scheduleNo")==null){
		response.sendRedirect("./scheduleList.jsp");
		return;
	}

	String scheduleNo = request.getParameter("scheduleNo");
	System.out.println(scheduleNo + "< -- deldeteScheduleForm param scheduleNo");
	
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
	<h1>스케줄 삭제</h1>
	<form action="./deleteScheduleAction.jsp" method="post">
		<table class="table table-warning">
			<tr>
				<td>스케줄번호</td>
				<td>
					<input type="text" name="scheduleNo" value="<%=scheduleNo%>" readonly="readonly"> 
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="schedulePw"> 
				</td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2">
					<button type="submit">삭제</button> 
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>