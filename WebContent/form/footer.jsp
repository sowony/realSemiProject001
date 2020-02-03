<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8");%>
    <% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

	*{
		font-family: 'Jeju Gothic', cursive;
	}
	
	#fFoot{
		background-color:rgb(51, 85, 139);
		color: white;
		float: left;
		width: 100%;
	}
	
	#fContact{
		float: left;
		width: 20%;
		height: 50px;
		margin: 5px 70px;		
	}
	p{
		font-size: 10px;
	}
	
	#fMap{
		float: right;
		width: 20%;
		height: 150px;
		margin: 5px 70px;
		 
	}
	
	#fLogo{
		width: 100px;
		height: auto;
	}
	#fIntro{
		float: left;
		width: 20%;
		margin: 5px 70px;
	}
	footer{
		border-top: 1px solid gray;
	}
	
	footer:hover{
		color: rgb(51, 85, 139);
	}
		
</style>
</head>
<body>


<footer>
	
	<div id="fIntro">
		<img alt="logo" src="images/logo.gif" id="fLogo">
		<p>서로의 연결고리를 견고히 하기 위해서<br/> 상처있는 마음에 힐링을 주기 위한<br/> 연애 종합 플렛폼 입니다</p>
	</div>
	
	<div id="fContact">
		<h3>Contact Us</h3>
		<div>
			<p>서울특별시 강남구 테헤란로14길 6 남도빌딩 4F</p>
			<p>대표이사: 김진성</p>
			<p>전화번호: (02) 123-4567</p>
			<p>이메일: hello42@hello42.com</p>
		</div>
	</div>
	<div id="fMap"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0c002a4f48acd874ac165e4ca28a53e6"></script>
	<script>
		var mapContainer = document.getElementById("fMap"),
			mapOption = {
				center: new kakao.maps.LatLng(37.4989488,127.0327044),
				level: 3
		};
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		var markerPosition = new kakao.maps.LatLng(37.4989488,127.0327044);
		
		var marker = new kakao.maps.Marker({
			position: markerPosition 
		});
		marker.setMap(map);
	</script>
	<div id="fFoot" >kh정보교육원 &copy; all rights reserved...</div>
</footer>

</body>
</html>