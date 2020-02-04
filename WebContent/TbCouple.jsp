<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8");%>
    <% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커플 테스트</title>
<style type="text/css">

	.image{
		height: 300px;
		width: 300px;
		opacity: 0.7;
	}

</style>
</head>
<body>

	<%@include file = "./form/mainPage.jsp" %>
	<div>
	<table border="1" >
		<tr>
			<td>
				<a href="https://kr.vonvon.co/quiz/263" ><img class="image" alt="" src="https://lh3.googleusercontent.com/Tok7XZrz6MexU7lMG0EV2LpzPbiMlhquZsOKCO6kVMO7byhZEgv5eG1u4ehWtqBfha7FnWX01Dnu9rPsmhvzM6po0W50IswWEw=s640-l65"> </a>
				<a href="https://kr.vonvon.co/quiz/1757" ><img class="image" alt="" src="https://lh3.googleusercontent.com/HOLLmfQ7ty0bGXwsDomUQoSmz-op6ITMgE3y_jjFzEVoB_B3KsrJ9-2X804832GbNz25OwDXqmfFiL_z3QcyD2hkmqF7Pls2=s640-l65"> </a>
				<a href="https://kr.vonvon.co/quiz/14515" ><img class="image" alt="" src="https://lh3.googleusercontent.com/Xfc-nAVCzWs6k0qVHSSZ4sTowM4bERZbgIkJvHn__TOZfFpKumI4-mTdzPkiHF7HQYMlRb0ooeY4iAvKi7h8gSHtmClz9en8ig=s640-l65"> </a>
			
			</td>
		</tr>
	</table>
	</div>
	<%@include file = "./form/footer.jsp" %>
</body>
</html>