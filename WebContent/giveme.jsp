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
<script type="text/javascript" src="resources/jq/jquery-3.4.1.min.js"></script>
</head>
<body>
<%
String imgWho = (String)request.getAttribute("imgWho");
System.out.println("같은 데이터 사본입니다. : " +imgWho);

//시작점 - 서블릿통해 데이터 보내고, 자바에서 분석- 서블릿으로 반환
//값 확인
JSONObject dto = (JSONObject)request.getAttribute("azure01");
System.out.println("giveme파일입니다.");
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
<h3>당신의 연인은 그때...</h3>

<div style="width: 750px; height: 500px;">
<div style="width: auto; height: auto; max-height: 500px;">
<img alt="잘못된 사진입니다ㅠㅠ" src="<%=imgWho%>">
</div>

<div id="emotionText" style="width: 200px; height: 500px; background-color: rgba(235,205,213,0.5)">
<div>
<p>경멸 : <%=dto.get("contempt")%></p>
</div>
<div>
<p>놀라움 : <%=dto.get("surprise")%></p>
</div>
<div>
<p>행복함 : <%=dto.get("happiness")%></p>
</div>
<div>
<p>자연스러움 : <%=dto.get("neutral")%></p>
</div>
<div>
<p>슬픔 : <%=dto.get("sadness")%></p>
</div>
<div>
<p>역겨움 : <%=dto.get("disgust")%></p>
</div>
<div>
<p>화남 : <%=dto.get("anger")%></p>
</div>
<div>
<p>두려움 : <%=dto.get("fear")%></p>
</div>
</div>

</div>


</body>
</html>