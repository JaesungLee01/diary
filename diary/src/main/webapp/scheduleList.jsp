<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>

<%
	int targetYear = 0;
	int targetMonth = 0;
	
	// 년 or 월이 요청값에 넘어오지 않으면 오늘 날짜으 ㅣ년/월값으로
	if(request.getParameter("targetYear") == null 
			|| (request.getParameter("targetMonth") == null)) {
		Calendar c = Calendar.getInstance();
		targetYear = c.get(Calendar.YEAR);
		targetMonth = c.get(Calendar.MONTH);
	}else {
		targetYear = Integer.parseInt(request.getParameter("targetYear"));
		targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
	}
	System.out.println(targetYear + "<--scheduleList param targetYear");
	System.out.println(targetMonth + "<--scheduleList param targetMonth");
	
	// 오늘 날짜
	
	Calendar today = Calendar.getInstance();
	int todayDate = today.get(Calendar.DATE);
	
	// targetMonth 1일의 요일
	
	Calendar firstDay = Calendar.getInstance();	//2023 04 24
	firstDay.set(Calendar.YEAR, targetYear); 
	firstDay.set(Calendar.MONTH, targetMonth); 
	firstDay.set(Calendar.DATE, 1); //2023 04 01
	
	// 년23월12 입력 Calendar API 년24월1 변경
	// 년23월-1 입력 Calendar API 년22월12 변경
	targetYear = firstDay.get(Calendar.YEAR);
	targetMonth = firstDay.get(Calendar.MONTH);
	
	int firstYoil = firstDay.get(Calendar.DAY_OF_WEEK); // 2023 04 01 몇번쨰 요일인지, 일요일 1, 토요일 7
	
	// 1일앞의 공백칸의 수
	
	int startBlank = firstYoil - 1;
	System.out.println(startBlank + "<--startBlank");
	// targetMonth 마지막일
	
	int lastDate = firstDay.getActualMaximum(Calendar.DATE);
	System.out.println(lastDate + "<--lastDate");
	
	// 전체 TD의 7의 나머지값은 0
	// 마지막날짜 뒤 공백칸의 수
	
	int endBlank = 0;
	if((startBlank+lastDate) % 7 != 0){
		endBlank = (startBlank+lastDate)%7;
	}
	// 전체 TD의 개수
	int totalTD = startBlank + lastDate + endBlank;
	System.out.println(totalTD + "<--totalTD");
	
	// db data를 가져오는 알고리즘
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	/*
		select schedule_no scheduleNo, day(schedul_date) scheduleDate, 
		substr(schedule_memo, 1, 5) scheduleMemo, schedule-color schedulecolor
		from schedule
		where year(schedule_date) = ? and month(scedule_date) = ?
		order by month(scedule_date) asc;
	*/
	
	PreparedStatement stmt = conn.prepareStatement("select schedule_no scheduleNo, day(schedule_date) scheduleDate, substr(schedule_memo, 1, 5) scheduleMemo, schedule_color scheduleColor from schedule where year(schedule_date) = ? and month(schedule_date) = ? order by day(schedule_date) asc"); 
	stmt.setInt(1, targetYear);
	stmt.setInt(2, targetMonth+1);
	System.out.println(stmt + " <-- stmt");
	ResultSet rs = stmt.executeQuery();
	
	//ResultSet -> ArrayList<Schedule> 
	ArrayList<Schedule> scheduleList = new ArrayList<Schedule>();
	while(rs.next()){
		Schedule s = new Schedule();
		s.scheduleNo = rs.getInt("scheduleNo");
		s.scheduleDate = rs.getString("scheduleDate"); //전체날짜가 아닌 일만
		s.scheduleMemo = rs.getString("scheduleMemo"); //전체가 아닌 5글자만 출력
		s.scheduleColor = rs.getString("scheduleColor");
		scheduleList.add(s);
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
<div><!-- 메인메뉴 -->
		<a href="./home.jsp" class="btn btn-primary">홈으로</a>
		<a href="./noticeList.jsp" class="btn btn-primary">공지 리스트</a>
		<a href="./scheduleList.jsp" class="btn btn-primary">일정 리스트</a>
	</div>
	
	<h1><%=targetYear %>년 <%=targetMonth+1 %>월</h1>
	<div>
		<a href="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth-1%>" class="btn btn-default">이전달</a>
    	<a href="./scheduleList.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth+1%>" class="btn btn-default">다음달</a>

	</div>
	<table class="table table-warning">
		<tr>
			<%
				for(int i=0; i<totalTD; i++) {
					int num = i-startBlank+1;
					if(i != 0 && i%7==0) {
			%>
						</tr><tr>
			<%
					}
					String tdStyle = "";
					if(num>0 && num<=lastDate){
						//오늘날짜이면
						if(today.get(Calendar.YEAR) == targetYear
								&& today.get(Calendar.MONTH) == targetMonth
								&& today.get(Calendar.DATE) == num){
								tdStyle = "background-color:orange";
			%>
			<%
						}
			%>
					<td style="<%=tdStyle%>">
						<div><!-- 날짜 숫자 -->
						<a href="./scheduleListByDate.jsp?y=<%=targetYear%>&m=<%=targetMonth%>&d=<%=num%> "><%=num%></a>
						</div>
						<div> <!-- 일정 memo(5글자만 -->
							<%
							boolean hasSchedule = false;
								for(Schedule s : scheduleList){
									if(num == Integer.parseInt(s.scheduleDate)){
										hasSchedule = true;
							%>
									<div style="color:<%=s.scheduleColor%>"><%=s.scheduleMemo %></div>
							<%
									}
								}
								 if (!hasSchedule) {
							%>
				              <div>&nbsp;</div>
				        <%
				          }
				        %>
						</div>
						</td>
			<%
						
					}else{
			%>
						<td>&nbsp;</td>
			<%
					}
				}
			%>
		</tr>
	</table>
	</div>
</body>
</html>