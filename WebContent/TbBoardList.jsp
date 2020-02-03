<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   response.setHeader("Pragma", "no-cache");
   response.setHeader("Cache-control", "no-store");
   response.setHeader("Expires", "0");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
   request.setCharacterEncoding("UTF-8");
%>
<%
   response.setContentType("text/html; charset=UTF-8");
%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>속닥속닥</title>
<style type="text/css">
   #board{
      background-color: rgb(240,240,240);
      width:100%;
      margin: 0 auto;
   }
   
   #list{
      width: 700px;
      margin: 0 auto;
      background-color: white;
      color: black;
   }
   
   .title{
      text-decoration: none;
      color: black;
   }
   .title:hover {
      color: rgb(132, 141, 197);
   }
   
   
   #list >table > tbody > tr > td:nth-child(1){ 
   background-color : rgb(209,175,148);
   border-right: 1px solid black;
   }
   #list >table > tbody > tr > td:nth-child(5){
   
   }
   #list >table > tbody > tr:nth-child(12)>td{   /*글쓰기버튼td에 전이된 css지우기*/
   background-color: white;
   border-right: 0px solid white;
   }
   
   #list >table > tbody > tr:nth-child(13)>td{   /*글쓰기버튼td에 전이된 css지우기*/
   background-color: rgb(197,143,105);
   border-right: 0px solid white;
   }
   #list > table >tbody > tr:nth-child(1)>th{
   background-color: rgb(197,143,105);
   font-weight: bold;
   }
   #tag_write_btn{
   border-radius: 6px;
   }
    .page{
      margin: 0 5px;
      color: black;
      text-decoration: none;
   }
   .page:hover{
      color: rgb(132, 141, 197);
   }
</style>
</head>
<body>

   <%@ include file="./form/mainPage.jsp" %>
   
   <!-- head를 잡아는 두되 쓰지는 않고있다. -->
<div>
   <div style="text-align: center; width: 100%; margin-top: 10px; margin-bottom: 20px; height:40px; line-height: 10px;">
   <div id="head" style=" display: inline-block; width: 76%; margin-top: 10px; margin-bottom: 20px; height:40px; background-color: rgb(209,175,148);">
   <h3 style="color: rgb(239,206,197);  ">속닥속닥... 여러분의 사연을 속삭여보세요</h3>
   </div>
   
   </div>
   <div id="board" style="margin-top: 10px;">
      <div id="list" style="margin-top: 10px; width: 700px;">
         <table style="width: 700px;">
            <col width="100px">
            <col width="200px">
            <col width="150px">
            <col width="100px">
            <col width="100px">
            <tr>
               <th>글번호</th>
               <th>제목</th>
               <th>작성자</th>
               <th>조회수</th>
               <th>작성일</th>
            </tr>
            <c:choose>
               <c:when test="${empty list }">
                  <tr>
                     <th colspan="4">-------작성된 글이 없습니다.-------</th>
                  </tr>
               </c:when>
               <c:otherwise>
                  <c:forEach items="${list }" var="dto">
                     <tr id="fortheborder">
                        <td align="center" style="">${dto.boardNum }</td>
                        <c:choose>
                           <c:when test="${dto.boardDeleteCheck =='Y' }">
                              <td colspan="4" align="center" class="delete">삭제된 글입니다.</td>
                           </c:when>
                           <c:otherwise>
                              <td><c:forEach begin="1" end="${dto.boardTab }">
                         &nbsp;
                        </c:forEach> <a
                                 href="TbBoard.do?command=boarddetail&boardnum=${dto.boardNum }" class="title">${dto.boardTitle }</a>
                              </td>
                              <td align="center">${dto.boardGender }</td>
                              <td align="center">${dto.boardViewCount}</td>
                              <td align="center">${dto.boardDate }</td>
                           </c:otherwise>
                        </c:choose>
                     </tr>
                  </c:forEach>
               </c:otherwise>
            </c:choose>
            <tr>
               <td colspan="5" align="right">
               <input type="button" value="글쓰기" id="tag_write_btn"
                  onclick="location.href='TbBoard.do?command=boardwriteform'" />
               </td>
            </tr>
            <tr>
               <td colspan="5" align="center">
                     <c:if test="${pageMaker.prev }">
                        <a class="pageNum" href="TbBoard.do?command=boardlist&page=1">처음으로</a>
                        <a class="pageNum" href="TbBoard.do?command=boardlist&page=${pageMaker.startPage-1 }">이전</a>
                     </c:if>
                     <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
                         <a class="page" href='<c:url value="TbBoard.do?command=boardlist&page=${pageNum }"/>'>${pageNum } </a> 
                     </c:forEach>
                     <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
                        <a class="pageNum" href="TbBoard.do?command=boardlist&page=${pageMaker.endPage+1 }">다음</a> 
                        <a class="pageNum" href="TbBoard.do?command=boardlist&page=${pageMaker.tempEndPage }" >마지막</a>
                     </c:if>
               </td>
            </tr>
         </table>
      </div>
   </div>
</div>
   <%@ include file="./form/footer.jsp" %>
</body>
</html>