<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONValue"%>
<%@page import="org.json.simple.parser.JSONParser"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진올리는공간</title>
</head>
<!-- index폼. 파일을 업로드할 폼 -->
<body>
<!-- jsp파일의 값을 java파일로 넘기기 위해선 input, text, textarea와 같은 기능을 사용해야한다.  -->
<!-- forEach문을 사용해 여러 개의 값이 들어가는 경우 id가 아닌 name을 사용.(id는 유일한 값을 말하므로 사용해도 무용지물) -->
<!-- upload.jsp로 보내야함 -->                        <!-- enctype속성을 사용해야 업로드가 가능하다. -->
<form action="photoupload" method="post" enctype="multipart/form-data">
      아이디 : <input type="text" name="id"><br>      
      파일첨부1 : <input type="file" name="file1"><br>
      <input type="submit" value="확인">
</form>   

</body>
</html>