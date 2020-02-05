<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- <%@ include file="./form/mainPage.jsp" %> --%>
</head>
<body>
<% 
Object file1= request.getAttribute("file1");
System.out.println("현재 Check.jsp, 서블릿에서 받은 폴더 경로 : " + file1);	//폴더경로

Object imgWho = request.getAttribute("imgWho");
System.out.println("현재 Check.jsp, 서블릿에서 받은 파일명 : " +imgWho);	//파일명
%>
<div style="width: 500px; height: 500px; position: absolute; top: 10px;">



<div style="float:left; clear:left; background-color: rgb(239,206,197); width: 245px; height: 245px; position: relative;; z-index: 1; border-bottom-right-radius: 120px;"></div>
<div style="float:right; clear:right; background-color: rgb(209,175,148); width: 245px; height: 245px; position: relative; z-index: 1; border-bottom-left-radius: 120px;"></div>
<div style="float:left; clear:left; background-color: rgb(202,153,123); width: 245px; height: 245px; margin-top: 10px; position: relative; z-index: 1; border-top-right-radius: 120px;"></div>
<div style="float:right; clear:right; background-color: rgb(220,142,106); width: 245px; height: 245px; margin-top: 10px; position: relative; z-index: 1; border-top-left-radius: 120px;"></div>

<div style="max-width: 500px; max-height: 480px; float:; clear:both; position: absolute; z-index: 2; padding-bottom: ">
<img alt="안나오면 뭘까요." src="http://qclass.iptime.org:8686/prj/<%=imgWho%>" style="max-width: 500px; max-height: 480px; float:; clear:both;">
</div>

</div>
<div style="position: relative; z-index: 1; top: 510px; al">
<form action="photostep2" method="post">
   
   <h1>당신이 업로드한 연인의 사진이 맞나요?</h1>
   <h3>맞다면 분석버튼을 눌러주세요</h3>
   <!-- http://192.168.110.6:8787/fileUpload/upload/ -->
   <input type="text" name="imgWho" value="http://qclass.iptime.org:8686/prj/<%=imgWho%>"> <!--form태그는 name을 보낸다 -->
      <input type="submit" value="확인">
</form>   
</div>
</body>
</html>