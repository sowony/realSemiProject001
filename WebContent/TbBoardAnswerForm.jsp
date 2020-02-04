<%@page import="com.between.dto.TbBoardDto"%>
<%
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-control","no-store");
	response.setHeader("Expires","0");
%>

<%@page import="com.between.dto.TbUserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8");%>
    <% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="./form/mainPage.jsp" %>
<%
	//TbUserDto userInfo = (TbUserDto)session.getAttribute("dto");
	TbBoardDto board = (TbBoardDto)request.getAttribute("board");

	if(userInfo==null){
		pageContext.forward("index.jsp");
	}
%>
	
	
	<div>
	<form action="TbBoard.do" method="post" >
	<input type="hidden" name="command" value="boardanswerres"/>
	<input type="hidden" name="userId" value="<%=userInfo.getUserId() %>" />
	<input type="hidden" name="boardNum" value="<%=board.getBoardNum()%>"/>
	<fieldset>
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="boardTitle" readonly="readonly" value="RE:<%=board.getBoardTitle() %>" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="15" cols="30" name="boardContent" ><%=board.getBoardContent() %></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right" >
					<input type="submit" value="답글작성"/>
					<input type="button" value="취소" onclick="history.back();" /> 
				</td>
			</tr>
		</table>
	</fieldset>
	</form>
	</div>
<%@ include file="./form/footer.jsp" %>
</body>
</html>