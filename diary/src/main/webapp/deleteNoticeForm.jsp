<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 요청값 유효성 검사
	if(request.getParameter("noticeNo")==null){
		response.sendRedirect("./noticeList.jsp");
		return; // 1) 코드진행종료 2) 반환값을 남길때
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo + " <-- deleteNoticeForm param noticeNo");
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
	<h1>공지 삭제</h1>
	<form action="./deleteNoticeAction.jsp" method="post">
		<table class="table table-info">
			<tr>
				<td>notice_no</td>
				<td>
				<!-- 
				<input type="hidden" name="noticeNo value="<%=noticeNo%>">
				</td>
				 -->
				 <input type="text" name="noticeNo" value="<%=noticeNo%>" readonly="reaeonly">
			</tr>
			<tr>
				<td>motice_pw</td>
				<td>
					<input type="password" name="noticePw">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">삭제</button>
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>