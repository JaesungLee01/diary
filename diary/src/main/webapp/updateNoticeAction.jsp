<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%
	//1.request 인코딩설정	
	request.setCharacterEncoding("utf-8");
	//2. 4개의 값을 확인(디버깅)
	System.out.println(request.getParameter("noticeNo")+"<--updateNoticeAction.jsp noticeNo");
	System.out.println(request.getParameter("noticeTitle")+"<--updateNoticeAction param noticeTitle");
	System.out.println(request.getParameter("noticeContent")+"<--updateNoticeAction param noticeContent");
	System.out.println(request.getParameter("noticePW")+"<--updateNoticeAction param noticePW");
	// 3.2번 유효성검정 -> 잘몰된결과 -> 분기 -> 
	// 리다이렉션(updateNoticeForm.jsp?noticeNo<noticeNo도 같이 넘긴다>=&msg=null or 공백은 넘길수 없다)로 돌아간다
	// 요청값 유요성검사 요청값이 null이거나 공백일때 
	// response.sendRedirect("./updateNoticeForm.jsp?noticeNo="+request.getParameter("noticeNo")+"&msg=error");
	
	String msg = null;
	if(request.getParameter("noticeNo")==null || request.getParameter("noticeNo").equals("")){
		msg = "bad request";
	} else if(request.getParameter("noticeTitle")==null || request.getParameter("noticeTitle").equals("")){
		msg = "bad request";
	} else if(request.getParameter("noticeContent")==null || request.getParameter("noticeContent").equals("")){
		msg = "bad request";
	} else if(request.getParameter("noticePW")==null || request.getParameter("noticePW").equals("")){
		msg = "bad request";
	}
	
	if(msg != null) { //위 ifelse문에 하나라도 해당된다
		response.sendRedirect("./updateNoticeForm.jsp?noticeNo="+request.getParameter("noticeNo")+"&msg"+msg);
		
	}
	
	//4.요청값달을 변수에 할당(형변환)

	//변수선언
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticePw = request.getParameter("noticePw");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	//디버깅 코드
	System.out.println(noticeNo + "<--updateNoticeAction noticeNo");
	System.out.println(noticePw + "<--updateNoticeAction noticePw");
	System.out.println(noticeTitle + "<--updateNoticeAction noticeTitle");
	System.out.println(noticeContent + "<--updateNoticeAction noticeContent");
	
	//5.mariadb RDBMS에 update문을 전송한다
	
	
	// 5번에 결과에 페에지를 분기한다
	
	//드라이버 연결
	Class.forName("org.mariadb.jdbc.Driver");
	//db서버연결
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	//db서버연결 확인
	System.out.println(conn + "< -- 서버연결");
	
	
	
	
	
	//sql 전송코드?
	String sql = "update notice set notice_title = ?, notice_content = ?, updatedate = now() where notice_no = ? and notice_pw =? " ;
	PreparedStatement stmt = conn.prepareStatement(sql);
	//
	System.out.println(stmt + "");
	
	stmt.setString(1,noticeTitle);
	stmt.setString(2,noticeContent);
	stmt.setInt(3,noticeNo);
	stmt.setString(4,noticePw);
	
	System.out.println(stmt + "<-- stmt");
	
	int row = stmt.executeUpdate(); // 적용된 행의 수
	
	//row 디버깅
	System.out.println(row + "");
	//5번에 결과에 페이지를 분기한다
	// update문 실행을 취소(rollback)해야한다
	/*
	int row = 0;
	if(row > 1){
	System.out.println("error row 값 : " +row);
	} else if(row == 1){
		response.sendRedirect("./noticeOne.jsp?noticeNo="
				+request.getParameter("noticeNo")
				+"&msg=incorrect notice");
	}else{
		//update문 실행을 취소 (rollback)해야한다
		request.getParameter("noticeNo")
	}
	*/
	if(row==0) {
		response.sendRedirect("./updateNoticeForm.jsp?noticeNo" + noticeNo);
	} else { 
		response.sendRedirect("./noticeOne.jsp?noticeNo"+noticeNo);
	}
	
	
%>