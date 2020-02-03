
<%@page import="com.between.dto.TbUserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8");%>
    <% response.setContentType("text/html; charset=UTF-8");%>
   
<!DOCTYPE html>
<html>
<head>
	<%@ include file="./form/mainPage.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">


window.onload=function(){
	appendYear();
	appendMonth();
	appendDay();
}



function appendYear(){

	var date = new Date();

	var year = date.getFullYear();

	var selectValue = document.getElementById("year");

	var optionIndex = 0;



	for(var i=year-100;i<=year;i++){

			selectValue.add(new Option(i+"년",i),optionIndex++);                        

	}

}





function appendMonth(){

	var selectValue = document.getElementById("month"); 

	var optionIndex = 0;



	for(var i=1;i<=12;i++){

			selectValue.add(new Option(i+"월",i),optionIndex++);
	}

}





function appendDay(){

	var selectValue = document.getElementById("date");

	var optionIndex = 0;



	for(var i=1;i<=31;i++){

			selectValue.add(new Option(i+"일",i),optionIndex++);
	}

}

</script>

</head>
<body>
<%
//sns계정으로 로그인시 가입서버로 들어왔을때, 받는 회원 dto 카카오톡 5개 구글 2개
	TbUserDto snsdto = (TbUserDto)request.getAttribute("snsdto");
%>


<div>
<h1>필수 정보 사항 기재</h1>
	<form action="TbUser.do" method="post">
		<input type="hidden" name="command" value="snsloginregisterformres">
		<input type="hidden" name="userPw" value="<%=snsdto.getUserPw()%>">
		<table >
		<col width="100">
		<col width="400">

			<tr>
				<th>아이디</th>
<%
	if(snsdto != null){
%>
				<td><input type="text" name="userId" value="<%=snsdto.getUserId()%>"></td>
<%		
	}
%>
				
			</tr>
			<tr>
				<th>이름</th>			
				<td><input type="text" name="userName" ></td>
			</tr>
			<tr>
				<th>나의 별명</th>
				<td><input type="text" name="userNick"></td>
			</tr>
			<tr>
				<th>이메일</th>
<%
	if(snsdto.getUserEmail() != null){
%>
				<td><input type="email" name="userEmail" value="<%=snsdto.getUserEmail()%>"></td>
<%		
	}else{
%>
				<td><input type="email" name="userEmail" ></td>
<%		
	}
%>				

			</tr>
			<tr>
				<th>성별</th>
				<td>

<%
	if(snsdto.getUserGender().equals("female") ||snsdto.getUserGender().equals("male") ){
%>
				<input type="radio" name="userGender"  value="FEMALE"  <%=snsdto.getUserGender().equals("female")?"checked":"disabled"%>/> 여
				<input type="radio" name="userGender" value="MALE" <%=snsdto.getUserGender().equals("male")?"checked":"disabled"%>/> 남
<%
	
	}else if(snsdto.getUserGender() == null){
%>

					<input type="radio" name="userGender"  value="MALE" /> 남
					<input type="radio" name="userGender" value="FEMALE" />여

<% 	
	 }
%>	

				</td>
			</tr>
			<tr>
	
				<th>생년월일</th>
                <td>
<%
	if(snsdto.getUserDob() != null){
%>
                		<select name="year" id="year">
                        <option value="">---선택하세요---</option>
                    	</select> 년
                    	
                		<input type="text" name="month" style="width:20px" readonly="readonly" value="<%=snsdto.getUserDob().substring(0,2) %>"/> 월                 
                		<input type="text" name="date" style="width:20px" readonly="readonly" value="<%=snsdto.getUserDob().substring(2) %>"/> 일
<%		
	}else{
%>		
	               		<select name="year" id="year">
                        <option value="">---선택하세요---</option>
                    	</select> 년

                		
                		<select name="month" id="month">
                        <option value= "" >---선택하세요---</option>
	                    </select> 월                 

                		
                		<select name="date" id="date">
                        <option value="">---선택하세요---</option>
	                    </select> 일              
	
<%		
	}
%>	                		
                </td>
            </tr>

			<tr>

				<td colspan="3" align="right">
					<input type="submit" value="회원가입" />
					<input type="button" value="취소" onclick="location.href='index.jsp'">
				</td>
			</tr>
		</table>
	</form>
</div>


</body>


</html>