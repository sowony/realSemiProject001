<%@page import="com.between.dto.TbUserDto"%>
<%@page import="com.between.dto.TbCalDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-control", "no-store");
	response.setHeader("Expires", "0");
%> 
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/calendar-insert.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
	
	TbUserDto userInfo = (TbUserDto)session.getAttribute("dto");
	
	if (userInfo == null) {
		pageContext.forward("index.jsp");
	}

	int groupNum = (int) request.getAttribute("groupNum");
	int calNum = (int) request.getAttribute("calNum");
	TbCalDto calDto = (TbCalDto) request.getAttribute("calDto");
	// yyyyMMddHHmm
	int year = Integer.parseInt(calDto.getCalTime().substring(0, 4));
	int month = Integer.parseInt(calDto.getCalTime().substring(4, 6));
	int date = Integer.parseInt(calDto.getCalTime().substring(6, 8));
	int hour = Integer.parseInt(calDto.getCalTime().substring(8, 10));
	int min = Integer.parseInt(calDto.getCalTime().substring(10, 12));
%>

	<h3>일정 수정</h3>
	
	<form action="TbCal.do" method="post">
		<input type="hidden" name="command" value="updateCal">
		<table>
			<tr>
				<th class="header">그룹번호</th>
				<td><input type="text" class="box" name="groupNum" value="<%=groupNum %>" readonly="readonly"><input type="hidden" name="calNum" value="<%=calNum %>"></td>
			</tr>
			<tr>
				<th class="header">날짜/시간</th>
				<td>
					<input type="text" class="box" name="year" value="<%=year %>" readonly="readonly">년
					<input type="text" class="box" name="month" value="<%=month %>" readonly="readonly">월
					<input type="text" class="box" name="date" value="<%=date %>" readonly="readonly">일<br/>
					<select name="hour">
						<%
							for (int i = 0; i < 24; i++) {
						%>
						<option value="<%=i%>" <%=(hour == i) ? "selected" : ""%>><%=i%></option>
						<%
							}
						%>
				</select>시 <select name="min">
						<%
							for (int i = 0; i < 60; i++) {
						%>
						<option value="<%=i%>" <%=(min == i) ? "selected" : ""%>><%=i%></option>
						<%
							}
						%>
				</select>분
				</td>
			</tr>
			<tr>
				<th class="header">일정</th>
				<td><input type="text" name="title" class="title" value="<%=calDto.getCalTitle() %>"></td>
			</tr>
			<tr>
				<th class="header">내용</th>
				<td><textarea rows="10" cols="30" name="content"><%=calDto.getCalContent() %></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input class="click" type="submit" value="수정">
					<input class="click" type="button" value="취소" onclick="location.href='TbCal.do?command=callist&year=<%=year %>&month=<%=month %>&date=<%=date %>'">
				</td>
			</tr>
		</table>
		
	</form>
	
	

</body>
</html>