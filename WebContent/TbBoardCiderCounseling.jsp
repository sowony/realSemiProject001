<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-control", "no-store");
	response.setHeader("Expires", "0");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	
</script>
<style type="text/css"></style>

</head>
<body>
	<!-- 헤더 -->
	<%@ include file="./form/mainPage.jsp" %>
	
	<div id="head"></div>
										<!-- margin:auto;로 주면 가운데 위치함 -->
	<div id ="wrap_councelMain" style="width:1200px; margin:auto; background: gray">
		<!-- wrap의 헤더영역 -->														
		<div id="headarea_councelMain" style="margin: 0px auto;  top: 10px; height:50px; background:yellow;">
														
			<ul>
				<li style="background-color: red">
				  <a href="/">홈</a> 
				</li>
				<li style="background-color: green">
				</li>
			</ul>
		</div>
		
		<!-- wrap의 메인영역 -->				<!-- 헤더와 이격 -->
		<div id="mainarea_councelmain" style="margin-top: 10px;">
			
			<!-- 나의 상담내역 영역 -->
			<div id="left_mainarea_councelmain" style="height:600px; width:200px; background: orange; float: left; margin-right: 10px">
				<div style="height: 60%; width: 100%;  background-color: orange;">
				
				</div>
				<div style="height: 40%; width: 100%; background-color: white;">
				</div>
			</div>
			
			<!-- 상담사 목록 영역 -->
			<div id="center_mainarea_councelmain" style="height: 600px; width: 780px; background: blue; float:left;" >
				<div style="width: 260px; height: 250px; float: left; background-color:red;">
				
					<img id="img_trans01" alt="01_상담사 사진입니다." src="resources/img/councel_profile/상담사1.jpg" width="100%" height="100%" 
						style="cursor:pointer;" onmouseover="this.src='resources/img/councel_profile/상담사2.png'"
						onmouseout="this.src='resources/img/councel_profile/상담사1.jpg'">
				
				</div>
				<div style="width: 260px; height: 250px; background-color:orange; float:left;  margin: 0px auto;">
				</div>
				<div style="width: 260px; height: 250px; float: right; background-color:green;">
				</div>
				
				
				<div style="width: 260px; height: 250px; float: left; background-color:white; margin-top: 10px;">
				</div>
				<div style="width: 260px; height: 250px; background-color:brown; float:left;  margin: 0px auto;  margin-top: 10px;">
				</div>
				<div style="width: 260px; height: 250px; float: right; background-color:black;  margin-top: 10px;">
				</div>
				
				
			
			</div>
			
			<!-- 일단은 빈공간 -->
			<div id="right_mainarea_councelmain" style="height: 600px; width: 200px; background: brown; float: right;">
			</div>
		</div>
		
		<!-- 푸터 div가 메인 div안에 있는 float의 영향을 받지 않도록 해줍니다. -->		
		<div style="clear: both;"></div>
		<!-- wrap의 풋영역 -->
		<div id="foot_councelmain" style="height: 50px; margin-top: 10px; background: black;">
		
		</div>
		
	</div>
	
</body>
</html>