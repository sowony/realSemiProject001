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
<!-- 카카오 sdk -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 구글 -->
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
	content="1086121226988-79i2g3qsvsr85hmu6kh2i5jkelnofqrm.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>

<!-- 일반 로그인 팝업창  -->
<style>
.background {
	display: none;
	position: fixed;
	_position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: 100;
}

.background .dim-background {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 70);
}

.background .popup-layer {
	display: block;
}

.popup-layer {
	background-color: #f1f1f1;
	width: 300px;
	height: 500px;
	display: none;
	position: absolute;
	top: 50%;
	left: 50%;
	z-index: 10;
	color: #000;
}

.loginBtn{
	background-color: #f1f1f1;
	border: none;
	outline: none;
}

.loginBtn:hover{
	color:darkviolet;
	cursor: pointer;
}
</style>
<!-- 일반 로그인 스크립트  -->
<script type="text/javascript">
	function layer_popup(el) {
		var $el = $(el);
		var isDim = $el.prev().hasClass('dim-background');
		isDim ? $('.background').show() : $el.show();
		var $elWidth = ~~($el.outerWidth()), $elHeight = ~~($el.outerHeight()), docWidth = $(
				document).width(), docHeight = $(document).height();

		if ($elHeight < docHeight || $elWidth < docWidth) {
			$el.css({
				marginTop : -$elHeight / 2,
				marginLeft : -$elWidth / 2
			});
		} else {
			$el.css({
				top : 0,
				left : 0
			});

		}
			return false;
			
			
			
			
	}

	function closelayer() {
		var isDim = $(".popup-layer").prev().hasClass('dim-background');
		isDim ? $('.background').hide() : $el.hide();
		return false;
	}
</script>

<!-- 카카오톡 로그인 스크립트 -->
<script type='text/javascript'>
//값을 post방식으로 보내기
/*
 * path : 전송 URL
 * params : 전송 데이터 {'q':'a','s':'b','c':'d'...}으로 키:값 묶어서 사용  (name : value)
 * method : 전송 방식(생략가능)
 */
// 포스트 방식 전달

function postSend(path, params, method) {
	method = method || "post";
	var form = document.createElement("form");
	form.setAttribute("method", method);
	form.setAttribute("action", path);

	// 히든으로 값을 넣는다.
	for ( var key in params) { // {'name1':'var1','name2':'var2','name3':'var3'}
		var input_tag = document.createElement("input");
		input_tag.setAttribute("type", "hidden");
		input_tag.setAttribute("name", key) // name1, name2, name3
		input_tag.setAttribute("value", params[key]) // var1, var2, var3

		console.log("name : " + key);
		console.log("value : " + params[key]);

		form.appendChild(input_tag);
	}
	document.body.appendChild(form);
	form.submit();
}



//아이디 중복체크한 이후에 통과하면 포스트로 값 전달 
function idChk(userId, userPw, userEmail, userGender, userDob){
	
	$.ajax({
  	  url: 'TbUser.do',
  	  type:"post",
  	  async: true,
  	  data:{
 		  command: "snslogindata",
 		  userId: userId
 	  },
  	  dataType:"text",
  
  	  success:function(data){
  		console.log("1"+data);
		  //snslogindata에서 받은 정보 true? false?
 		  if(data == "true"){
 			 console.log("2"+data);
			  //로그인 시키기  - 디비에 저장된 아이디, 비번 있다면 로그인 서블릿으로 보내서 로그인 시키기 
 			 
			   let path ="TbUser.do";
			   let params = {
					   command : "kakaologin",
					   userId : userId,
					   userPw: userPw
			   }
			   // post 방식 전달 함수
			   postSend(path, params, "post");
			   console.log("3");

		  }else if(data == "false"){
			  console.log("4"+data);
			  //회원가입 시키기 - 디비에 저장된 아이디, 비번이 없다면/ 회원가입 폼으로 보내서 디비에 저장시키기 
			let path = "TbUser.do";
			let params = {
					command : "snsresgistform",
					userId : userId,
					userPw : userPw,
					userEmail : userEmail,
					userGender : userGender,
					userDob : userDob
					
			}
			 // post 방식 전달 함수
			   postSend(path, params, "post");
			console.log("5"+data);
		  }
  		  
  	  },
  	  error:function(){
  		console.log("아이고오오"+userId);
  		  alert("통신실패");
  	  }
    });
	
}




	function kakaologin() {
		Kakao.init('3ffc02510f976b23accd140b3077863a');
		
		Kakao.Auth.loginForm({
			
			success : function(authObj) {
				// 로그인 성공시, API를 호출합니다.
				Kakao.API.request({
					//persistAccessToken: false,
					//scope: "account_email,birthday,gender",
					url : '/v2/user/me',
					success : function(res) {

						console.log("aa" + res);
						var userPw = res.id;
						console.log("1"+userPw);
						var userId = res.kakao_account.email;
						console.log("2"+userId);
						var userEmail = res.kakao_account.email;
						console.log("3"+userEmail);
						//var userNickName = res.properties.nickname;
						var userGender = res.kakao_account.gender;
						console.log("4"+userGender);
						var userDob = res.kakao_account.birthday;
						console.log("5"+userDob);
						//document.getElementById("userId").value = userId;
						//document.getElementById("userEmail").value = userEmail;
						
						console.log(userId, " ", userPw, " ", userEmail, " ", userGender, " ", userDob);
						//아이디 중복 체크 하고 있으면 로그인 없으면 회원가입 
						idChk(userId, userPw, userEmail, userGender, userDob);
						
						//카카오톡 로그아웃 
						Kakao.Auth.logout();
						
						
						var userNickName = res.properties.nickname;
						var gender = res.kakao_account.gender;
						//alert(JSON.stringify(res));
						persistAccessToken: true;
					},
					fail : function(error) {
						alert(JSON.stringify(error));
					}
				});
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
	};  // 로그인, 회원가입 컨트롤 

	function kout() {
		Kakao.init('3ffc02510f976b23accd140b3077863a');
		alert("script");
		Kakao.Auth.logout(function(data) {
			alert(data)

		});
	}
</script>
<!-- 구글 로그인 스크립트  -->
<script>
//아이디 중복체크한 이후에 통과하면 포스트로 값 전달 
function idChkg(userId, userPw, userEmail){
	
	$.ajax({
  	  url: 'TbUser.do',
  	  type:"post",
  	  async: true,
  	  data:{
 		  command: "snslogindata",
 		  userId: userId
 	  },
  	  dataType:"text",
  
  	  success:function(data){
  		console.log("1"+data);
		  //snslogindata에서 받은 정보 true? false?
 		  if(data == "true"){
 			 console.log("2"+data);
			  //로그인 시키기  - 디비에 저장된 아이디, 비번 있다면 로그인 서블릿으로 보내서 로그인 시키기 
 			 
			   let path ="TbUser.do";
			   let params = {
					   command : "googlelogin",
					   userId : userId,
					   userPw: userPw
			   }
			   // post 방식 전달 함수
			   postSend(path, params, "post");
			   console.log("3");

		  }else if(data == "false"){
			  console.log("4"+data);
			  //회원가입 시키기 - 디비에 저장된 아이디, 비번이 없다면/ 회원가입 폼으로 보내서 디비에 저장시키기 
			let path = "TbUser.do";
			let params = {
					command : "snsresgistform",
					userId : userId,
					userPw : userPw,
					userEmail : userEmail,

					
			}
			 // post 방식 전달 함수
			   postSend(path, params, "post");
			console.log("5"+data);
		  }
  		  
  	  },
  	  error:function(){
  		console.log("아이고오오"+userId);
  		  alert("통신실패");
  	  }
    });
	
}


	function onSignIn(googleUser) {
		// Useful data for your client-side scripts:
		var profile = googleUser.getBasicProfile();
		console.log("ID: " + profile.getId()); // Don't send this directly to your server!
		console.log('Full Name: ' + profile.getName());
		console.log('Given Name: ' + profile.getGivenName());
		console.log('Family Name: ' + profile.getFamilyName());
		console.log("Image URL: " + profile.getImageUrl());
		console.log("Email: " + profile.getEmail());
		var userId = profile.getEmail();
		var userPw = profile.getId();
		var userEmail = profile.getEmail();
		console.log(userId+""+userPw+""+userEmail);
		idChkg(userId, userPw, userEmail);
		
		
        // 로그아웃
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.disconnect();
        
		//signOut();
		// The ID token you need to pass to your backend:
		//var id_token = googleUser.getAuthResponse().id_token;
		//console.log("ID Token: " + id_token);
	};

	function signOut() {
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.signOut().then(function() {
			console.log('user signed out');
		});
		auth2.disconnect();
	}
</script>


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
				<li><a href="TbCouple.jsp">커플테스트</a></li>
				<li><a href="TbDic.do?command=dictionaryMain">니캉내캉</a></li>
				<li><a href="TbBoardImageUploadForm.jsp">사진분석</a></li>
				<li></li>
			</ul>
			<ul><!-- 
				<li><p>사이다</p></li>
				<li><a href="">전문상담사</a></li> -->
				<li><img src="" ></li>
			</ul>
			<ul>
				<li><p>커플사이</p></li>
				<!-- <li><a href="">앨범</a></li> -->
				<li><a href="TbCal.do?command=calendar">다이어리</a></li>
				<li><a href="TbChat.do?command=enterChat">사이톡</a></li>
				<li><a href="TbBoard.do?command=boardlist">속닥속닥</a></li>
				<!-- <li><a href="">영상통화</a></li> -->
			</ul>
		</div>
	</nav>

	<div class="content">
		<img alt="couple" src="images/couple.jpg" class="couple">
	</div>
	

	<!-- 큰 div로 묶었음 -->
	<div>
		<div class="background">
			<div class="dim-background"></div>
			<div id="popup-layer" class="popup-layer">

				<!-- 로그인 팝업창 -->
				<div align="center">
					<img alt="" src="images/logo.gif"class="logo">

					<!-- 구글 로그인 -->
					<div class="g-signin2" data-width="220" data-height="45"
						data-onsuccess="onSignIn" data-longtitle="true"></div>
					<br/>
					<!-- 카카오톡 로그인 -->
					<div>
						<a href="#" onclick="kakaologin();return false;"><img
							src="images/kakao_account_login_btn_medium_narrow.png"
							alt="카카오로그인"></a> 
					</div>
					<br/>
					
					<!-- 일반 로그인 -->
					<div>
						<form action="TbUser.do" method="post">
							<input type="hidden" name="command" value="loginres" />
							<table>
								<tr>
									<th>아이디</th>
									<td><input style="width:150px;" type="text" name="userId" id="userId"></td>
								</tr>
								<tr>
								
									<th>비밀번호</th>
									<td><input style="width:150px;" type="password" name="userPw" id="userPw"></td>
								</tr>
								<tr>
									<!-- location.href='TbUser.do?command=main -->
									<td colspan="2" align="center" >
										<input class="loginBtn" type="submit" value="로그인">
										<input class="loginBtn" type="button" value="회원가입"
										onclick="location.href='TbUser.do?command=registerform'">
										<input class="loginBtn" type="button" value="취소" onClick='closelayer();'>
									</td>
								</tr>
							</table>
						</form>
					</div>

				</div>

			</div>
		</div>

	</div>
</body>
</html>