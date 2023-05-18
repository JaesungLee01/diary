<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%
   // 유효성 코드 추가 -> 분기 -> return
   if(request.getParameter("noticeNo")==null){
	   response.sendRedirect("./noticeList.jsp");
	   return;
   }
   
   int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
   
   System.out.println(noticeNo + " <-- deleteNoticeForm param noticeNo");
   
   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = DriverManager.getConnection(
         "jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
   
   /*
      select notice_no, notice_title, notice_content, notice_writer, createdate, updatedate 
      from notice 
      where notice_no = ?
   */
   
   String sql = "select notice_no, notice_title, notice_content, notice_writer, createdate, updatedate from notice where notice_no = ?";
   PreparedStatement stmt = conn.prepareStatement(sql);
   stmt.setInt(1, noticeNo);
   System.out.println(stmt + " <-- stmt");
   ResultSet rs = stmt.executeQuery();      
   /*
   if(rs.next()) {
      
   }
   */
   rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
	<h1>공지수정</h1>
	<div>
		<%
		if(request.getParameter("msg") != null) {
		%>
			<%=request.getParameter("msg") %>
		<%
		}
		%>
	</div>
   <form action="./updateNoticeAction.jsp" method="post">
      <table class="table table-info">
         <tr>
            <td>
               notice_no
            </td>
            <td>
               <input type="number" name="noticeNo" 
                  value="<%=rs.getInt("notice_no")%>" readonly="readonly"> 
            </td>
         </tr>
         <tr>
            <td>
               notice_pw
            </td>
            <td>
               <input type="password" name="noticePw"> 
            </td>
         </tr>
         <tr>
            <td>
               notice_title
            </td>
            <td>
               <input type="text" name="noticeTitle" 
                  value="<%=rs.getString("notice_title")%>"> 
            </td>
         </tr>
         <tr>
            <td>
               notice_content
            </td>
            <td>
               <textarea rows="5" cols="80" name="noticeContent">
                  <%=rs.getString("notice_content")%>
               </textarea>
            </td>
         </tr>
         <tr>
            <td>
               notice_writer
            </td>
            <td>
               <%=rs.getString("notice_writer")%>
            </td>
         </tr>
         <tr>
            <td>
               createdate
            </td>
            <td>
               <%=rs.getString("createdate")%>
            </td>
         </tr>
         <tr>
            <td>
               updatedate
            </td>
            <td>
               <%=rs.getString("updatedate")%>
            </td>
         </tr>
      </table>
      <div>
         <button type="submit">수정</button>
      </div>
   </form>
   </div>
</body>
</html>