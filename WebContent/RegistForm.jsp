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
<title>회원가입</title>


<script type="text/javascript" src="resources/js/jquery-3.4.1.min.js"></script>

<script type="text/javascript">
	function emailsend() {
		var email = document.getElementById("email").value;

		if (email == "") {
			alert("이메일을 입력해주세요");

		}

		else {
			alert(email + "로 전송 되었습니다");
			window.open("mailSend.jsp?email=" + email, "",
					"width=600px, height=400px");

		}
	}

	function idChk() {
		var doc = document.getElementsByName("userid")[0];
		if (doc.value.trim() == "" || doc.value == null
				|| doc.value == "indefined") {
			alert("아이디를 먼저 입력해주세요");

		} else {
			window.open("TbRegist.do?command=idChk&userId=" + doc.value, "",
					"width=500,height=300");
		}

	}

	function pwChk() {

		var pw = document.getElementById("pw");

		var confirmPW = document.getElementsByName("uwerpwch")[0];

		if (pw.value.length< 5 || pw.value.length >18) {
			alert("비밀번호를 5~17자리로 입력해주세요");
			pw.focus();
			document.getElementById("pw").value = document
					.getElementById("pwch").value = "";
			document.getElementById("same").innerHTML = "비밀번호는 5~17자리입니다";
			document.getElementById("same").style.color = "red";

		}

		if (document.getElementById("pw").value != ""
				&& document.getElementById("pwch").value != "") {
			if (document.getElementById("pw").value == document
					.getElementById("pwch").value) {
				document.getElementById("same").innerHTML = "비밀번호가 일치합니다.";
				document.getElementById("same").style.color = "blue";

			} else {
				document.getElementById("same").innerHTML = "비밀번호가 일치하지 않습니다.";
				document.getElementById("same").style.color = "red";
			}

		}
	}

	function validate() {
		var pw = document.getElementById("pw");
		var pwch = document.getElementById("pwch");
		var pw = document.getElementsByName("userpw")[0];
		var name = document.getElementById("username");
		var year = document.getElementById("year");
		var month = document.getElementById("month");
		var date = document.getElementById("date");

		if (regist.pw.value != regist.pwch.value) {
			alert("비밀번호가 틀립니다. 다시 한번 확인해 주세요");

			regist.pwch.value = "";
			regist.pwch.focus();
			return false;

		} else if (email.value == "") {
			alert("이메일을 입력해 주세요");

			email.focus();
			return false;

		} else if (name.value == "") {
			alert("이름을 입력해 주세요");

			name.focus();
			return false;

		} else if (year.value = "") {
			alert("연도을 선택해 주세요");

			year.focus();
			return false;

		} else if (month.value = "") {
			alert("월을 선택해 주세요")

			month.focus();
			return false;

		} else if (date.value = "") {
			alert("일을 선택해 주세요");

			date.focus();
			return false;
		}
	}

	window.onload = function() {
		appendYear();
		appendMonth();
		appendDate();
	}
	function appendYear() {
		var date = new Date();
		var year = date.getFullYear();
		var selectValue = document.getElementById("year");
		var optionIndex = 0;
		for (var i = year - 100; i <= year; i++) {
			selectValue.add(new Option(i, i), optionIndex++);
		}
	}
	function appendMonth() {

		var selectValue = document.getElementById("month");

		var optionIndex = 0;

		for (var i = 1; i <= 12; i++) {
			if (i < 10) {
				i = "0" + i;
			}
			selectValue.add(new Option(i, i), optionIndex++);
		}

	}

	function appendDate() {

		var selectValue = document.getElementById("date");

		var optionIndex = 0;

		for (var i = 1; i <= 31; i++) {
			if (i < 10) {
				i = "0" + i;
			}
			selectValue.add(new Option(i, i), optionIndex++);

		}

	}

	$(function() {
		$("#mailsend").click(function() {
			if ($("#email").val().length == 0) {
				$("#mailsend").show();
			} else {
				$("#mailsend").hide();
			}
		});
	});
</script>
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

* {
	font-family: 'Jeju Gothic', cursive;
}

table {
	width: 50%;
	height: auto;
	margin: 50px 25%;
	align-self: center;
}
.button:hover{
	cursor: pointer;
}

</style>
</head>
<body>

	<%@ include file="./form/mainPage.jsp"%>

	<%
		String useremail = request.getParameter("useremail");
	%>

	<form action="TbRegist.do" method="post" name="regist"
		onsubmit="return validate()">
		<input type="hidden" name="command" value="insert">
		<table>


			<tr>
				<th>아이디</th>
				<td><input type="email" placeholder="ID는 이메일 형식입니다"
					name="userid" required="required"> <input type="button"
					value="ID중복확인" onclick="idChk()" class="button"></td>
			</tr>

			<tr>
				<th>이름</th>
				<td><input type="text" id="username" name="username"
					required="required" maxlength="4"></input>
			</tr>

			<tr>
				<th>비밀번호</th>
				<td><input type="password" id="pw" name="userpw"
					required="required" onChange="pwChk()" maxlength="19" /></td>
			</tr>
			<tr>
				<th>비빌번호확인</th>
				<td><input type="password" id="pwch" name="userpwch"
					required="required" onChange="pwChk()" maxlength="19" />&nbsp;&nbsp;
					<span id="same"></span></td>
			</tr>

			<tr>
				<th>Email</th>
				<td><input type="email" name="useremail" id="email"
					placeholder="'사이'의 소식을 받는 이메일"> <input type="hidden"
					name="to" value="hoyhi123@naver.com"> <input type="hidden"
					name="from" value="hoyhi123@naver.com"> <input
					type="button" id="mailsend" title="n" value="인증코드전송"
					onclick="emailsend()" class="button"></td>
			</tr>
			<tr>
				<th>성별</th>
				<td><input type="radio" name="usergender" checked="checked"
					value="MALE" class="button" /> MALE <input type="radio" name="usergender"
					value="FEMALE" class="button" />FEMALE</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><select name="year"  id="year">
						<option value=""></option></select> 년
					<select name="month" id="month">
						<option value=""></option></select> 월 
					<select name="date" id="date">
						<option value=""></option></select>일
						
				</td>

			</tr>
			<tr>

				<td colspan="3" align="right"><input type="submit" value="회원가입"
					style="border-radius: 5px;" class="button "/> <input type="button" value="취소"
					onclick="location.href='index.html'" style="border-radius: 5px;" class="button"></td>

			</tr>
		</table>
	</form>

	<%@ include file="./form/footer.jsp"%>



</body>
</html>