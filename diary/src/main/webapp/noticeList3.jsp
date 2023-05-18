<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%
	// select 쿼리를 mariadb에 전송 후 결과셋을 받아서 출력하는 페이지
	// select notice_no, notice_title from notice order by notice_no desc
	
	// 1) mariadb 프로그램 사용가능하도록 장치드라이브를 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	// 2) mariadb에 로근인 후 접속정보 반환받아야 한다
	Connection conn = null; // 접속정보 타입
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	System.out.println("접속성공"+conn);
	
	//3) 쿼리실행
	String sql = "select notice_no, notice_title from notice order by notice_no desc";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	System.out.println("쿼리실행성공"+rs);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>notice_no</th>
			<th>notice_title</th>
		</tr>
		
		<%
			while(rs.next()) {
		%>
			<tr>
				<td><%=rs.getInt("notice_no") %></td>
				<td><a href=""><%=rs.getString("notice_title") %></a></td>
			</tr>
		<%
			}
		%>
	</table>
</body>
</html>