<%@page import="com.between.dto.TbGroupDto"%>
<%@page import="com.between.dto.TbUserDto"%>
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
<title>사이</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>


</head>
<body>

	<%
		TbUserDto userInfo = (TbUserDto) session.getAttribute("dto");
		//	System.out.println(userInfo);
		TbGroupDto groupdto = (TbGroupDto)session.getAttribute("groupdto");
		
	%>
	<header>

		<div align="right">
			<%
				if (userInfo == null ) {
					
					
			%>
			<input type="button" class="login-btn" name="btn" onclick="layer_popup('#popup-layer');" value="로그인" /> 
			<input type="button" name="btn" class="login-btn" value="회원가입" />
			<%
					
				} else {
					if(groupdto != null){
						
						if(groupdto.getPartnerId().equals(userInfo.getUserId()) && groupdto.getGroupCheck().equals("N")){
			%>	
			
		<script type="text/javascript">
		$(function (){
			if(confirm("<%=userInfo.getUserName()%>님으로 부터 온 커플 신청을 수락하시겠습니까? ") == true){
				location.href="TbUser.do?command=after2&check=yes&groupNum=<%=groupdto.getGroupNum() %>&userId=<%=userInfo.getUserId() %>";
				alert('커플 신청이 수락 되었습니다');
			}else{
				location.href="TbUser.do?command=after2&check=no&groupNum=<%=groupdto.getGroupNum() %>&userId=<%=userInfo.getUserId() %>";
				alert('커플을 거절 하였습니다 새로 신청해 주세요 ');
			}
			
		});
		</script>	
<%
			}
     }	
%>

	<input type="button" onclick="location.href='TbUser.do?command=logout'" name="btn" class="login-btn" value="로그아웃" /> 
	<input type="button" onclick="location.href='TbUser.do?command=mypage&userStatus=<%=userInfo.getUserStatus()%>'" name="btn" class="login-btn" value="마이페이지" />
			<%
				}
			%>

		</div>
		<a href="index.jsp"><img alt="" src="images/logo.gif"class="logo"></a>
	</header>

	<nav>
		<div id="menu">
			<ul>
				<li><p>우리사이</p></li>
				<li><a href="">커플테스트</a></li>
				<li><a href="TbDic.do?command=dictionaryMain">니캉내캉</a></li>
				<li><a href="TbBoardImageUploadForm.jsp">사진분석</a></li>
				<li></li>
			</ul>
			<ul>
				<li><p>커플사이</p></li>
				<li><a href="TbCal.do?command=calendar">다이어리</a></li>
				<li><a href="TbChat.do?command=enterChat">사이톡</a></li>
				<li><a href="TbBoard.do?command=boardlist">속닥속닥</a></li>
			</ul>
		</div>
	</nav>

	<div class="content">
		<img alt="couple" src="images/couple.jpg" class="couple">
	</div>
	


</body>
</html>