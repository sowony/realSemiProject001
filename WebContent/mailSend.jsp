<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function emailcheck() {

		var ch1 = document.getElementsByName("code")[0].value;
		var ch2 = document.getElementsByName("codeCheck")[0].value;
		
		if (ch1 == ch2) {

		alert("인증이 완료되었습니다");
		self.close();
		
	
		} else{
			document.getElementById("send").innerHTML = "인증번호가가 일치하지 않습니다.";
			document.getElementById("send").style.color = "red";
		}
	}
	
 
</script>

</head>
<body>

	<%@page import="java.util.Map"%>
	<%@page import="java.util.List"%>
	<%@page import="javax.mail.Transport"%>
	<%@page import="javax.mail.Message"%>
	<%@page import="javax.mail.Address"%>
	<%@page import="javax.mail.internet.InternetAddress"%>
	<%@page import="javax.mail.internet.MimeMessage"%>
	<%@page import="javax.mail.Session"%>
	<%@page import="com.between.mail.SMTPAuthenticatior"%>
	<%@page import="javax.mail.Authenticator"%>
	<%@page import="java.util.Properties"%>


	<%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		int randomNumber = (int)(Math.floor(Math.random() * (99999 - 10000 + 1)) + 10000);
		System.out.println(randomNumber);

		String from = request.getParameter("from");
		String to = request.getParameter("to");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String email = request.getParameter("email");

		Properties p = new Properties(); // 정보를 담을 객체

		p.put("mail.smtp.host", "smtp.naver.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");

		try {
			Authenticator auth = new SMTPAuthenticatior();
			Session ses = Session.getInstance(p, auth);

			ses.setDebug(true);
			MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체 

			msg.setSubject("사이 회원가입용 인증 코드 입니다."); //  제목

			StringBuffer buffer = new StringBuffer();
			buffer.append("인증코드: ");
			buffer.append(randomNumber + "<br>");
			Address fromAddr = new InternetAddress("hoyhi123@naver.com");//보내는사람
			msg.setFrom(fromAddr);

			Address toAddr = new InternetAddress(email); // 받는 사람
			msg.addRecipient(Message.RecipientType.TO, toAddr);

			msg.setContent(buffer.toString(), "text/html;charset=UTF-8"); // 내용
			Transport.send(msg); // 전송  

		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
	%>




	<div>
		<h1>이메일 인증</h1>
	</div>
	<div>
		<pre>
- 사이 사이트에서는 이메일이 아이디로 사용되기 때문에 반드시 인증이 필요합니다.
- 회원 가입시 등록된 이메일로만 인증번호를 받으실 수 있습니다.
- 메일이 도착하지 않은 경우 광고로 분류 되었는지 확인해 주세요.
</pre>
	</div>

	<input type="hidden" name="command" value="number">
	<input type="hidden" name="code" value="<%=randomNumber%>" />

	<table border="1">

		<tr>
			<td><input type="text" name="codeCheck" placeholder="인증번호를 입력해주세요" /></td>
			<td align="right">
			<input type="button" id="number" value="확인" onclick="emailcheck()" /> 
			<input type="button" value="취소" onclick="self.close()"><span id="send"></span></td>

		</tr>


	</table>



</body>
</html>