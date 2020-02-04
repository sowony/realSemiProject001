<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8"); %>
<%response.setContentType("text/html; charset=UTF-8");%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<%-- <%@ include file="./form/mainPage.jsp" %> --%>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/uploadform.css">
<script type="text/javascript" src="resources/jq/jquery-3.4.1.min.js"></script>
</head>
<body>

<%@ include file="./form/mainPage.jsp" %>

<%
String imgWho = (String)request.getAttribute("imgWho");
System.out.println("같은 데이터 사본입니다. : " +imgWho);

//시작점 - 서블릿통해 데이터 보내고, 자바에서 분석- 서블릿으로 반환
//값 확인
JSONObject dto = (JSONObject)request.getAttribute("azure01");
System.out.println("TbBoardImageUploadFormCheckResult페이지입니다.");
System.out.println(dto);
System.out.println("첫 키입니다 : "+ dto.get("contempt"));
%>
<%-- <div><%=dto%></div> --%>
<script type="text/javascript">
   $(function(){
      var pay = <%=dto%>;
      var key = pay.faceRectangle;
      console.log(key + "gkgkgkgkgkgkgk");
      alert("결과를 확인해보세요~");
      
//       window.open(key,"","width=800px, height=600px");
   });
  
</script>
<fieldset style="border-color: rgb(220,142,106); width: 740px; height: 560px;">
<legend>당신의 연인은 그때...</legend>

																		<!-- 색 조금만 더 진하게 -->
<div style="width: 750px; height: 500px; border:solid 1px; border-color: rgba(235,205,213,0.5);">


<div style="width: auto; height: auto; max-width: 540px; max-height: 480px; margin:10px; float: left;">
<img alt="잘못된 사진입니다ㅠㅠ" src="<%=imgWho%>" style="max-height: 480px; max-width:500px;">
</div>


<div id="emotionText" style="width: 200px; min-height: 300px; background-color: rgba(235,205,213,0.5); float: right; padding-top: 5px; padding-left:10px; margin-top: 10px; margin-right: 10px;">
<div>
<p>경멸 : <%=(double)dto.get("contempt")*100%> %</p>
</div>
<div>
<p>놀라움 : <%=(double)dto.get("surprise")*100%> %</p>
</div>
<div>
<p>행복함 : <%=(double)dto.get("happiness")*100%> %</p>
</div>
<div>
<p>자연스러움 : <%=(double)dto.get("neutral")*100%> %</p>
</div>
<div>
<p>슬픔 : <%=(double)dto.get("sadness")*100%> %</p>
</div>
<div>
<p>역겨움 : <%=(double)dto.get("disgust")*100%> %</p>
</div>
<div>
<p>화남 : <%=(double)dto.get("anger")*100%> %</p>
</div>
<div>
<p>두려움 : <%=(double)dto.get("fear")*100%> %</p>
</div>
</div>

</div>

<!-- 다시 게임 진행하는 분들은 여기서 사진 업로드 -->
<form action="photostep1" method="post" enctype="multipart/form-data">

  <div class="uploadform_div_parent" style="margin-top: 10px;">	
  
  	<div style="float: right;">
      <input type="submit" id="uploadClick" value="사진 분석">
	</div>
  
 	<div class="file_input_div" style="width: 180px;">
 	<input type="button" value="새로운 사진을 올려주세요" class="file_input_button" style="width: 180px;"/>
	<input type="file" name="file1" id="fileupload" class="file_input_hidden" title="자기야 이번엔 무슨 생각해?"
		onchange="javascript:document.getElementById('fileName').value=this.value"/>
	</div>
 	
  </div>
</form>  
</fieldset>

<%@ include file="./form/footer.jsp" %>

</body>
</html>