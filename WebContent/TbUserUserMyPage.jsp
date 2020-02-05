<%@page import="com.between.dto.TbGroupDto"%>
<%@page import="com.between.dto.TbUserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8");%>
    <% response.setContentType("text/html; charset=UTF-8");%>
   
<!DOCTYPE html>
<html>
<head>
	<%@ include file="./form/mainPageforMypage.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
<% 
	TbUserDto dto = (TbUserDto)session.getAttribute("dto"); 
	String partnerId = String.valueOf(request.getAttribute("partnerId"));
	//메인 페이지에 담겨 있는 정보라서 쓰지 않음
	//TbGroupDto groupdto = (TbGroupDto)session.getAttribute("groupdto");
	//System.out.println(partnerId+"나의 유저페이지에서 보는....");
	
%>
<link href="css/mypage.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!-- 일반 로그인 팝업창  -->
<style type="text/css">	

	.background{
	display:none; 
	position:fixed; 
	_position:absolute; 
	top:0; 
	left:0; 
	width:100%;  
	height:100%; 
	z-index:100;
	}
.background .dimBackground {
	position:absolute; 
	top:0; 
	left:0; 
	width:100%; 
	height:100%;
	 background:#000; 
	 opacity: .5; 
	 filter:alpha(opacity=70);
	 }
.background .popuplayer1{
	display:block;
	}
.popuplayer1 {
	background-color:#f1f1f1;
	width:300px;
	height:200px;
	display:none;
	position:absolute;
	top:50%;
	left:50%;
	z-index:10;
	color:#000;
	}
	
	
</style>
<!-- 일반 로그인 스크립트  -->
<script type="text/javascript">
function layer_popup1(el){
	var $el = $(el); 
	var isDim = $el.prev().hasClass('dimBackground');
	isDim ? $('.background').show() : $el.show();
	var $elWidth = ~~($el.outerWidth()),
		$elHeight = ~~($el.outerHeight()),
		docWidth = $(document).width(),
		docHeight = $(document).height();
	

	if ($elHeight < docHeight || $elWidth < docWidth) {
		$el.css({
			marginTop: -$elHeight /2,
			marginLeft: -$elWidth/2
		});
	}
	else{
		$el.css({top: 0, left: 0});

	}
	return false;
}
function closelayer1(){
	var isDim = $(".popuplayer1").prev().hasClass('dimBackground'); 
	isDim ? $('.background').hide() : $el.hide(); 
	return false;
}

</script>
<script type="text/javascript">

alert('유저님의 마이페이지입니다. 환영합니다.');


$(function () {
	$('#pjoin').attr("disabled",true);
});	

$(function(){
	$("#idcheck").click(function(){
		var partnerId = $('input[name="partnerId"]').val();

		//console.log(partnerId);
		if($("#partneridin").val().trim() == 0){
			$("#partneridin").focus();
		}  
		else{
			$.ajax({ 
				url: 'TbUser.do?command=check1&partnerId='+partnerId,
											
				method:'post',
			
				success: function(data){
					
					if(data == 1){
						$('#pjoin').attr("disabled",true);
						alert('중복된 아이디 입니다');
						
					}else if (data == -1){
						$('#pjoin').removeAttr("disabled");
						alert('사용가능한 아이디 입니다');
						
					}
				}
			});
		 } 
		return false;
	});
});	

</script>

</head>
<body>

<div id="Umypage"  >
	<div id="Umynick" >
		<div><h1 id="Uh1" >나의 애칭 : </h1><h1 id="Up"><%=dto.getUserNick() %></h1></div>
				<form action="TbUser.do" method="post">
				<input type="hidden" name="command" value="userboardlist">
				<input type="hidden" name="userId" value="<%=dto.getUserId()%>">
					<table id="Utable1">
					<tr>
					 <th>내글보기</th>
					 <td>
						<input type="password" name = "equserPw" style="float: center;">
						<input type="submit" id="partneridin1"class="Umypage-btn" placeholder="비밀번호를 입력하세요" value="확인">
					</td>
					</tr>
		
					</table>
		</form>
	
	
	</div>
	
	<div id="Ucouple">
	<table id="Utable2">
		<tr>
			<th>우리자기</th>
			
			<td>
			<form action="TbUser.do" method="post"> 
				<input type="hidden" name="command" value="partnerinsert">
				<input type="hidden" name="userId" value="<%=dto.getUserId() %>">	
					

<%
				if(partnerId.equals("N")){
					
%>


				<input type="text" id="partneridin" name="partnerId" placeholder="상대의 아이디  입력" >	
						
				<input type="button" id="idcheck" value="아이디 중복 체크" class="Umypage-btn"/>
                <input type="submit" id="pjoin" value="상대등록하기" class="Umypage-btn" />


<%
				}else{
%>
				<input type="text" name="partnerId" value="<%=partnerId %>" readonly="readonly" >
<%					
				}
%>
			 </form>
			</td>

		</tr>
		<tr>
			<th>email</th>
			<td><%=dto.getUserEmail() %></td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				<%=dto.getUserDob() %>
			</td>
		</tr>		
		<tr>
			<th>이름</th>
			<td>
				<%=dto.getUserName() %>
			</td>
		</tr>				
		
		<tr>
			<th>회원정보 수정하기 </th>
			<td>
				<input type="button" onclick="location.href='TbUser.do?command=userupdateform&partnerId=<%=partnerId %>'" value="수정" class="Umypage-btn"/>
				
			</td>
		</tr>

	</table>
			<div id="Udelete" >
				<p id="tal">탈퇴를 원하시면 버튼을 눌러주세요 ㅠㅠ<p>
				<input id="tal-but" type="button" value="탈퇴하기" onclick="layer_popup1('#popuplayer1');" class="Umypage-btn" />
			</div>
				
		</div>
		

		
		
</div>
<div>
	 <!-- 탈퇴팝업창 배경 -->
	<div class="background">
	<div class="dimBackground"></div>
	<div id="popuplayer1" class="popuplayer1">
	
	<!-- 탈퇴 팝업창  -->    
	<div  align="center">	
	<br/><br/>
		정말 탈퇴 하시겠습니까? <br/>
		탈퇴하시면 같은 아이디로<br/>
		 가입 불가합니다.<br/>
		<br/><br/>
		<input type="button" value="탈퇴하기" class="Umypage-btn1" onclick="location.href='TbUser.do?command=userdelete&userId=<%=dto.getUserId()%>'"/>
		<input type="button" value="취소" class="Umypage-btn1" onclick="closelayer1();"/>
	</div>
	
	</div>
	</div>
</div>

</body>
	<%@ include file="./form/footer.jsp"%>
</html>