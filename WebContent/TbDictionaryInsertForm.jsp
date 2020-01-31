<%@page import="com.between.dto.TbUserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8");%>
    <% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>니캉내캉 단어장</title>
<script type="text/javascript"src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<%
	TbUserDto userInfo = (TbUserDto)session.getAttribute("dto");
%>

	<form id="submit" action="TbDic.do" method="post" >
		<input type="hidden" name="command" value="insert"/>
		<input type="hidden" name="userId" value="<%=userInfo.getUserId()%>"/>
		<table>
		<tr>
			<td>
				<p>키워드</p><input type="text" name="keyword" required="required" />
			</td>
		</tr>
		<tr>
			<th>남자어</th><th>여자어</th>
		</tr>
		<tr>
			<td>
				<textarea name="male" rows="10" cols="20" required="required"></textarea>
			</td>
			<td>
				<textarea name="female" rows="10" cols="20" required="required"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="확인"/>
			</td>
		</tr>
		</table>
	</form>

</body>
</html> 