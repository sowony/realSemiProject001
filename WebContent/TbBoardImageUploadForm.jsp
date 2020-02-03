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
<%-- <%@ include file="./form/mainPage.jsp" %> --%>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/uploadform.css">
</head>
<!-- index폼. 파일을 업로드할 폼 -->
<body>

<!-- jsp파일의 값을 java파일로 넘기기 위해선 input, text, textarea와 같은 기능을 사용해야한다.  -->
<!-- forEach문을 사용해 여러 개의 값이 들어가는 경우 id가 아닌 name을 사용.(id는 유일한 값을 말하므로 사용해도 무용지물) -->
<!-- upload.jsp로 보내야함 -->                        <!-- enctype속성을 사용해야 업로드가 가능하다. -->
<fieldset style="width: 750px; height: 830px; border-color: rgb(220,142,106);">
<legend>사진 속 감정 분석</legend>
<p style="font-size: 14pt;">사람은 추억을 먹고 산대요</p>
<p>이따금씩 생각나는 옛 기억들...</p>
<p>옛날 사진을 보다가. 어...? 이때 왜 이런 표정을 지었지? 하는 의문이 들었다면</p>
<p>사진 속 감정을 확인해보세요.</p>
<p>※친구의 가식도 확인 가능하답니다(소근)</p><br/>
<p>＊예시＊</p>
<div style="width: 750px; height: 500px; border:solid 1px; border-color: rgba(235,205,213,0.5);">


<div style="width: auto; height: auto; max-width: 540px; margin:10px; float: left;">
<img alt="잘못된 사진입니다ㅠㅠ" src="uploadImages/example01.jpg" width="500px" style="max-height: 740px;">
</div>


<div id="emotionText" style="width: 200px; min-height: 300px; background-color: rgba(235,205,213,0.5); float: right; padding-top: 5px; padding-left:10px; margin-top: 10px; margin-right: 10px;">
<div>
<p>경멸 : 0.0 %</p>
</div>
<div>
<p>놀라움 : 0.0 %</p>
</div>
<div>
<p>행복함 : 0.027 % </p>
</div>
<div>
<p>자연스러움 : 0.932 % </p>
</div>
<div>
<p>슬픔 : 0.035 % </p>
</div>
<div>
<p>역겨움 : 0.002 % </p>
</div>
<div>
<p>화남 : 0.001 % </p>
</div>
<div>
<p>두려움 : 0.001 % </p>
</div>
</div>

</div>
</fieldset>
<form action="photostep1" method="post" enctype="multipart/form-data">

  <div class="uploadform_div_parent">
  
 	<div class="file_upload_div">
      <input type="submit" id="uploadClick" value="분석하기">
	</div>
  	
 	<div class="file_input_div">
 	<input type="button" value="사진을 올려주세요" class="file_input_button"/>
	<input type="file" name="file1" id="fileupload" class="file_input_hidden" title="자기야 무슨 생각해?"
		onchange="javascript:document.getElementById('fileName').value=this.value"/>
	</div>
	
 	
	
  </div>
</form>   



</body>
</html>