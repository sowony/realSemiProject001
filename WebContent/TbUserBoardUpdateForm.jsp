<%@page import="com.between.dto.TbBoardDto"%>
<%@page import="com.between.dto.TbUserDto"%>
<%
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-control","no-store");
	response.setHeader("Expires","0");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8");%>
    <% response.setContentType("text/html; charset=UTF-8");%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<!DOCTYPE html>
<html>
<head>
<%@ include file="./form/mainPage.jsp" %>
<meta charset="UTF-8">
<title>속닥속닥</title>
<style type="text/css">
	#hideButton{
		display:none;
	}
</style>
</head>
<body>
<%
	TbUserDto userDto = (TbUserDto)session.getAttribute("dto");
	TbBoardDto board = (TbBoardDto)request.getAttribute("board");

	if(userDto==null){
		pageContext.forward("index.jsp");
	}
%>

	<div>
<h1>내글 수정하기 </h1>


	<form action="TbUser.do" method="post" >
	<input type="hidden" name="command" value="userboardupdateres"/>
	<input type="hidden" name="boardNum" value="<%=board.getBoardNum() %>" />
	<input type="hidden" name="userId" value="<%=userDto.getUserId()%>">
	<fieldset>
		<table>
			<tr>
				<th>작성자</th>
				<td><%=board.getBoardGender() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="boardTitle" value="<%=board.getBoardTitle() %>">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="15" cols="30" name="boardContent" ><%=board.getBoardContent() %></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right"  >
					<input type="submit" value="수정완료"/>
					<input type="button" value="삭제" onclick="location.href='TbUser.do?command=userboarddeleteone&boardNum=<%=board.getBoardNum()%>'"/>
					<input type="button" value="목록" onclick="location.href='TbUser.do?command=mylist&userId=<%=userDto.getUserId() %>'"/>
				</td>
			</tr>
		</table>
	</fieldset>
	</form>
	</div>
	
</body>
</html>