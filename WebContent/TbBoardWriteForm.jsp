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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>속닥속닥 작성</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="resources/summernote/summernote-lite.js"></script>
<script src="resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="resources/summernote/summernote-lite.css">

<script type="text/javascript">
	$(function() {
	  $('#summernote').summernote({
	    height: 500,
	    lang: 'ko-KR' // 언어 세팅
	  });
	});
</script>
<style type="text/css">
	
</style>
</head>
<body>
<div>

</div>
<%@ include file="./form/mainPage.jsp" %>
<%
	//TbUserDto userInfo = (TbUserDto)session.getAttribute("dto");

	if(userInfo==null){
		pageContext.forward("index.jsp");
	}
%>
	
	<div>
	<form action="TbBoard.do" method="post" >
	<input type="hidden" name="command" value="boardwriteres"/>
	<input type="hidden" name="userId" value="<%=userInfo.getUserId() %>" />
	<fieldset>
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="boardTitle" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="15" cols="30" name="boardContent" id="summernote" ></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right" >
					<input type="submit" value="작성"/>
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