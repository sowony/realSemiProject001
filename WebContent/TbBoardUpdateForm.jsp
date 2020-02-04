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
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="resources/summernote/summernote-lite.js"></script>
<script src="resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="resources/summernote/summernote-lite.css">

<script type="text/javascript">
   $(function() {
     $('#summernote').summernote({
       height: 300,
       lang: 'ko-KR' // 언어 세팅
     });
   });
</script>

</head>
<body>




   <div>
   <form action="TbBoard.do" method="post" >
   <input type="hidden" name="command" value="boardupdateres"/>
   <input type="hidden" name="boardNum" value="${board.boardNum }" />
   <fieldset>
      <table>
         <tr>
            <th>제목</th>
            <td><input type="text" name="boardTitle" value="${board.boardTitle }"/></td>
         </tr>
         <tr>
            <th>내용</th>
            <td><textarea rows="15" cols="30" name="boardContent" id="summernote" >${board.boardContent }</textarea>
            </td>
         </tr>
         <tr>
            <td colspan="2" align="right" >
               <input type="submit" value="수정" class="btn_success"/>
               <input type="button" value="취소" class="btn_delete" onclick="history.back();" /> 
            </td>
         </tr>
      </table>
   </fieldset>
   </form>
   </div>
   <div>
   <form action="TbBoard.do" method="post" >
   <input type="hidden" name="command" value="boardupdateres"/>
   <input type="hidden" name="boardNum" value="${board.boardNum }" />
   <fieldset>
      <table>
         <tr>
            <th>제목</th>
            <td><input type="text" name="boardTitle" value="${board.boardTitle }"/></td>
         </tr>
         <tr>
            <th>내용</th>
            <td><textarea rows="15" cols="30" name="boardContent" id="summernote" >${board.boardContent }</textarea>
            </td>
         </tr>
         <tr>
            <td colspan="2" align="right" >
               <input type="submit" value="수정" style="border-right: 6px;"/>
               <input type="button" value="취소" style="border-right: 6px;" onclick="history.back();" /> 
            </td>
         </tr>
      </table>
   </fieldset>
   </form>
   </div>


</body>
</html>