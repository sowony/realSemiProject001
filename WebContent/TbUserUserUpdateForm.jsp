<%@page import="com.between.dto.TbGroupDto"%>
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
</head>
<% 
	TbUserDto dto = (TbUserDto)session.getAttribute("dto");
	String partnerId = String.valueOf(request.getAttribute("partnerId"));

    
%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){ $("#alert-success").hide(); 
	$("#alert-danger").hide();
	$("input").keyup(function(){ var pwd1=$("#pwd1").val(); 
	var pwd2=$("#pwd2").val(); 
	if(pwd1 != "" || pwd2 != ""){ 
		if(pwd1 == pwd2){ 
			$("#alert-success").show(); 
			$("#alert-danger").hide(); 
			$("#submit").removeAttr("disabled");
			}else{ 
				$("#alert-success").hide(); 
				$("#alert-danger").show(); 
				$("#submit").attr("disabled", "disabled"); 
				} 
			} 
		}); 
	});
	
		
</script>

<script type="text/javascript">

$(function(){
	$("#idcheck").click(function(){
		var partnerId = $('input[name="partnerId1"]').val();

		if($("#partneridin").val().trim() == 0){
			$("#partneridin").focus();
		}  
		else{
			$.ajax({ 
				url: 'TbUser.do?command=check1&partnerId='+partnerId,
											
				method:'post',
			
				success: function(data){
					
					if(data == 1){
						
						alert('중복된 아이디 입니다');
						
					}else if (data == -1){
						
						alert('사용가능한 아이디 입니다');
						
					}
				}
			});
		 } 
		return false;
	});
});	

</script>


<body>

<div align="center">
<h1>내 정보 수정 하기 </h1>

	<form action="TbUser.do" method="post">
	<input type="hidden" name="command" value="userupdateformres">
	<input type="hidden" name="userId" value="<%=dto.getUserId()%>">
	
		<table>	
			<tr>
				<th>우리자기</th>
<%
	if(partnerId.equals("N") ){

%>
			<td>
			<input type="hidden" name="partnerId" value="<%=partnerId %>">
			<input type="text"  placeholder="우리자기 등록하기  먼저 해주세요" readonly="readonly" style="width:210px;"></td>
<% 
	}else{
%>
			<td>
				<input type="text" id="partneridin" name="partnerId1" placeholder="<%=partnerId %>" required="required" />
				<input type="button" id="idcheck" value="아이디 중복체크"/>
			</td>
<%
	}
%>	
			
				
			</tr>
			<tr>	
				<th>새로운 비밀번호</th>
				<td> <input type="password" name="userPw" id="pwd1" class="form-control" required /> </td>
			</tr>
			<tr>	
				<th>새로운 비밀번호 확인</th>
				<td><input type="password" name="reuserPwd" id="pwd2" class="form-control" required /></td>
			</tr>
			<tr>	
				<th>이메일</th>
				<td><input type="email" name="userEmail" placeholder="<%=dto.getUserEmail()%>"  required="required" ></td>
				
			</tr>
			<tr>	
				<th>나의애칭바꾸기</th>
				<td><input type="text" name="userNick" placeholder="<%=dto.getUserNick() %>"  required="required" ></td>
				
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정완료"/>
					<input type="button" value="취소" onclick="location.href='TbUser.do?command=mypage'"/>
				</td>
			</tr>
		</table>
	</form>

<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div> 
<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
</div>

</body>
</html>