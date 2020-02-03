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

	}

	function closelayer() {
		var isDim = $(".popup-layer").prev().hasClass('dim-background');
		isDim ? $('.background').hide() : $el.hide();
	}
</script>

<!-- 카카오톡 로그인 스크립트 -->
<script type='text/javascript'>
	function kakaologin() {
		Kakao.init('3ffc02510f976b23accd140b3077863a');
		Kakao.Auth.loginForm({

			success : function(authObj) {
				// 로그인 성공시, API를 호출합니다.
				Kakao.API.request({
					url : '/v2/user/me',
					success : function(res) {

						console.log(res);

						var userId = res.id;
						var userEmail = res.kakao_account.email;
						var userNickName = res.properties.nickname;
						var gender = res.kakao_account.gender;
						document.getElementById("userId").value = userId;
						document.getElementById("userEmail").value = userEmail;
						alert(JSON.stringify(res));
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
	};

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
	function onSignIn(googleUser) {
		// Useful data for your client-side scripts:
		var profile = googleUser.getBasicProfile();
		console.log("ID: " + profile.getId()); // Don't send this directly to your server!
		console.log('Full Name: ' + profile.getName());
		console.log('Given Name: ' + profile.getGivenName());
		console.log('Family Name: ' + profile.getFamilyName());
		console.log("Image URL: " + profile.getImageUrl());
		console.log("Email: " + profile.getEmail());

		// The ID token you need to pass to your backend:
		var id_token = googleUser.getAuthResponse().id_token;
		console.log("ID Token: " + id_token);
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
				if (userInfo == null) {
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
				<li><a href="">앨범</a></li>
				<li><a href="TbCal.do?command=calendar">다이어리</a></li>
				<li><a href="TbChat.do?command=enterChat">사이톡</a></li>
				<li><a href="">영상통화</a></li>
			</ul>
			<ul>
				<li><p>사이다</p></li>
				<li><a href="">전문상담사</a></li>
				<li><a href="TbBoard.do?command=boardlist">속닥속닥</a></li>
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
					<h1>로그인 하세요</h1>

					<!-- 구글 로그인 -->
					<div class="g-signin2" data-width="220" data-height="45"
						data-onsuccess="onSignIn" data-longtitle="true"></div>

					<!-- 카카오톡 로그인 -->
					<div>
						<a href="#" onclick="kakaologin();return false;"><img
							src="images/kakao_account_login_btn_medium_narrow.png"
							alt="카카오로그인"></a> 
					</div>

					<!-- 일반 로그인 -->
					<div>
						<form action="TbUser.do" method="post">
							<input type="hidden" name="command" value="loginres" />
							<table>
								<tr>
									<th>아이디</th>
									<td><input type="text" name="userId" id="userId"></td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td><input type="password" name="userPw" id="userPw"></td>
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