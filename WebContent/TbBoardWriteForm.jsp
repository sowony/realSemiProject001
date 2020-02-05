<%@page import="com.between.dto.TbUserDto"%>
<%
   response.setHeader("Pragma","no-cache");
   response.setHeader("Cache-control","no-store");
   response.setHeader("Expires","0");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8");%>
    <% response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>속닥속닥 작성</title>
<%@ include file="./form/mainPage.jsp" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="resources/summernote/summernote-lite.js"></script>
<script src="resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="resources/summernote/summernote-lite.css">
<link rel="stylesheet" href="css/btn_hover.css">
<script type="text/javascript">
   $(function() {
     $('#summernote').summernote({
       height: 300,
       lang: 'ko-KR' // 언어 세팅
     });
   });
</script>
<style type="text/css">

#write_fail:hover{
cursor: pointer;
}
#write_success:hover{
cursor: pointer;
}
.board{
	
}
</style>
</head>
<body>
<%
  // TbUserDto userInfo = (TbUserDto)session.getAttribute("dto");

   if(userInfo==null){
      pageContext.forward("index.jsp");
   }
%>
   
   
   <div  align="center" class="board" >
   <form action="TbBoard.do" method="post" >
   <input type="hidden" name="command" value="boardwriteres"/>
   <input type="hidden" name="userId" value="<%=userInfo.getUserId() %>" />
      <table>
         <tr>
<!--             <th>제목</th> -->
            <td align="center" ><input style="height:30px;width:250px;" type="text" name="boardTitle" placeholder="제목을 작성해주세요" /></td>
         </tr>
         <tr>
<!--             <th>내용</th> -->
            <td><textarea rows="15" cols="30" name="boardContent" id="summernote" ></textarea>
            </td>
         </tr>
         <tr>
            <td colspan="2" align="center" >
               
               <input type="button" value="작성취소" class="btn_delete" onclick="history.back();" style="margin-right: 10px;" /> 
               <input type="submit" value="작성완료" class="btn_success"/>
            </td>
         </tr>
      </table>
   </form>
   </div>
   
   
   <%@ include file="./form/footer.jsp" %>

</body>
</html>