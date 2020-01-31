<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
Object file1= request.getAttribute("file1");
System.out.println("check.jsp입니다, 받은 데이터 : " + file1);

String imgWho = (String)request.getAttribute("imgWho");
System.out.println("check.jsp의,같은 데이터 사본입니다. : " +imgWho);
%>
<div style="width: 500px; height: 500px">
<img alt="안나오면 뭘까요." src="http://qclass.iptime.org:8686/prj/<%=imgWho%>">

</div>
<form action="checkcheck" method="post">
   
   <h1>마을사람들 여기는 사진 들어왔는지 확인하는 공간입니다.</h1>
   <!-- http://192.168.110.6:8787/fileUpload/upload/ -->
   <input type="text" name="imgWho" value="http://qclass.iptime.org:8686/prj/<%=imgWho%>"> <!--form태그는 name을 보낸다 -->
      <input type="submit" value="확인">
</form>   

</body>
</html>