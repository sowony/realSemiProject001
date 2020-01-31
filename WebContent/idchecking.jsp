<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function confirm(bool) {
		if (bool == "true") {
			opener.document.getElementsByName("username")[0].focus();
			opener.document.getElementsByName("userid")[0].title = "y";
		} else {
			opener.document.getElementsByName("userid")[0].focus();

		}

		self.close();
	}
</script>

</head>

<%
	String idnotused = request.getParameter("idnotused");
%>

<table border="1">


	<tr>
		<td><%=idnotused.equals("true") ? "입력하신 아이디는 사용 가능합니다. " : "다른 아이디를 입력해 주세요"%>
	</tr>


	<tr>
		<td align="right"><input type="button" value="확인"
			onclick="confirm('<%=idnotused%>');" /></td>
		<!--''(이건 값이야!! 변수아니야 라는것을 표현.싱클 쿼티에션 빠치지말자)  -->
	</tr>


</table>


<body>








</body>
</html>