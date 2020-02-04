<%@page import="com.between.dto.TbDictionaryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>니캉 내캉</title>
<%@ include file="./form/mainPage.jsp"%>
<style type="text/css">

.dicBtn {
	outline: none;
	border: none;
	color: skyblue;
	background-color: white;
}

#like {
	cursor: pointer;
}

#all {
	width: 60%;
	margin: 10px 20%;
}

#list > table {
	width: 60%;
	margin: 10px 20%;
}

#definition{
	width: 60%;
	margin: 10px 20%;
	text-align: center;
}
#inputs{
	text-align: left;
	width: 60%;
	margin: 10px 20%;
}
textarea{
	resize: none;
 
}

</style>
<script type="text/javascript">
	function popup() {

		window.open("TbDictionaryInsertForm.jsp", "",
				"width=650px, height=400px");

	}
</script>
</head>
<body>


	<%
		if (userInfo == null) {
			pageContext.forward("index.jsp");
		}

		List<TbDictionaryDto> list = (List<TbDictionaryDto>) request.getAttribute("list");
		TbDictionaryDto dto = null;

		if (request.getAttribute("dto") != null) {
			// dto란 이름으로 받아올 값이 있다면 == 검색결과
			dto = (TbDictionaryDto) request.getAttribute("dto");
		}
	%>
	<div id="all">
		<div>
			<br />

			<div id="list">
				<table>
					<col width="300px">
					<col width="50px">
					<col width="50px">
					<tr>
						<th>키워드</th>
						<th>공감</th>
					</tr>
					<%
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr class="row">
						<td><%=list.get(i).getDicKeyword()%></td>
						<td><input class="dicBtn" type="button"
							value="<%=list.get(i).getDicLike()%>" /></td>
						<td><input class="dicBtn" id="like" type="button" value="공감"
							onclick="location.href='TbDic.do?command=like'" /></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div id="definition">
				<form action="TbDic.do">
					<input type="hidden" name="command" value="search" /> 
					<div id="inputs">
					<input type="text" name="keyword" /><input type="submit" value="검색" /><br />
					<%
						if (dto != null) {
					%>
					<input type="text" readonly="readonly"
						value="<%=dto.getDicKeyword()%>" />

					<%
						} else {
					%>
					<input type="text" readonly="readonly" value="" />
					<%
						}
					%>
					</div>
				</form>
			</div>
		</div>


		
		<div id="left">


			<table border="1">

				<col width="200px">
				<col width="200px">

				<tr>
					<td>남자어</td>
				</tr>
				<tr>
					<%
						if (dto != null) {
					%>

					<td><textarea rows="10" cols="20"><%=dto.getDicMale()%></textarea>
					</td>
					<%
						}
					%>
				</tr>
			</table>
		</div>

		<div id="right">
			<table border="1">
				<col width="200px">
				<col width="200px">
				<tr>
					<td>여자어</td>
				</tr>
				<tr>
					<%
						if (dto != null) {
					%>

					<td><textarea rows="10" cols="20"><%=dto.getDicFemale()%></textarea>
					</td>
					<%
						}
					%>
				</tr>
				<tr>
					<td><input type="button" value="글작성하기"
						onclick="popup();" /></td>
				</tr>
			</table>

		</div>
		</div>
	<%@ include file="./form/footer.jsp"%>
</body>

</html>