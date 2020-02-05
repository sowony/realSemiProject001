<%@page import="com.between.dto.PageMaker"%>
<%@page import="com.between.biz.TbUserBizImpl"%>
<%@page import="com.between.biz.TbBoardBizImpl"%>
<%@page import="com.between.biz.TbUserBiz"%>
<%@page import="com.between.dto.TbBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.between.dto.TbUserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8");%>
    <% response.setContentType("text/html; charset=UTF-8");%>
   
<!DOCTYPE html>
<html>
<head>
<%@ include file="./form/mainPage.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
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
   .title:hover{
		color: skyblue;
   }
   
   
   #list >table > tbody > tr > td:nth-child(1){ /*글번호 세로 라인*/
   }
   #list >table > tbody > tr > td:nth-child(5){ }
   
   #list >table > tbody > tr:nth-child(12)>td{   /*글쓰기버튼td에 전이된 css지우기*/
   background-color: white;
   border-right: 0px solid white;
   }

   #list >table > tbody > tr:nth-child(13)>td{   /*글쓰기버튼td에 전이된 css지우기*/
   background-color: rgb(85,135,162);   /* 글번호 */
   border-right: 0px solid white;
   }
   #list > table >tbody > tr:nth-child(1)>th{
   background-color: rgb(85,135,162);   /* 목록 */
   color : white;
   font-weight: bold;
   }
   #tag_write_btn{
   		border-radius: 6px;
   }
   .BoardBtn{
   		color:black;
   		text-decoration: none;
   }
   .BoardBtn:hover{
   		color: skyblue;
   }
</style>
</head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% TbUserDto dto = (TbUserDto) session.getAttribute("dto");
	PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");
	
	List<TbBoardDto> list = (List<TbBoardDto>)request.getAttribute("list");
	
	
%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	
	function allchk(bool) {
		$("input[name=chk]").each(function () {
			$(this).prop("checked",bool);
		});
		
		
	}

	//유효성 검사 (체크를 하나도 안하면 submit이벤트 취소 )
	$(function () {
		$("#muldelform").submit(function () {
			if($("#muldelform input:checked").length == 0){
				alert("하나이상 체크해 주세요");
			    return false;//이벤트 전파 막음 
		    }
		});
		
		$("input[name=chk]").click(function () {
			if($("input[name=chk]").length == $("input[name=chk]:checked").length){
				$("input[name=all]").prop("checked",true);
				
			}else{
				$("input[name=all]").prop("checked",false);
			}
		}); // chk 전체를 선택하게되면 all의 체크박스에 체크가 되고, 하나라도 없을 경우 all체크박스가 해제됨
		
		
	});

	
	
	
</script>




<body>

<div>

	<div align="right" >
		<form action="TbUser.do" method="post">
			<input type="hidden" name="command" value="search">
			<input type="hidden" name="userId" value="<%=dto.getUserId()%>">
			<input type="text" name="boardTitle">
			<input type="submit" value="검색">
			<input type="button" value="모든 글 보기 " onclick="location.href='TbUser.do?command=mylist&userId=<%=dto.getUserId() %>'">
		</form>	
	</div>
	
	<div align="center" >
	<form action="TbUser.do" method="post" id="muldelform">
	<input type="hidden" name="command" value="muldel">
	<input type="hidden" name="userId" value="<%=dto.getUserId() %>">

		<table>
			<col width="20px" >
			<col width="100px" >
			<col width="200px" >
			<col width="150px" >
			<col width="100px" >
			<tr>
				<th><input type="checkbox" name="all" onclick="allchk(this.checked);"/></th>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
<%
	if(list.size() == 0){
%>
					<tr>
						<th colspan="5">-------작성된 글이 없습니다.-------</th>
					</tr>

<% 		
	}else{
		for(int i =0; i<list.size(); i++){
			
%>
						<tr>
							<td><input type="checkbox" name="chk" value="<%=list.get(i).getBoardNum() %> " ></td>
							<td align="center" ><%=list.get(i).getBoardNum() %></td>
							<td>
								<a href="TbUser.do?command=userboarddetail&boardNum=<%=list.get(i).getBoardNum() %>" ><%=list.get(i).getBoardTitle() %></a>
							</td>
							<td align="center"><%=list.get(i).getBoardGender() %></td>
							<td align="center"><%=list.get(i).getBoardDate() %></td>
						</tr>

<%		
		}
	}
%>			
			<tr>
				<td colspan="5" align="right" >
					<input type="submit" value="글삭제">
					<input type="button" value="마이페이지로" onclick="location.href='TbUser.do?command=mypage'">
				</td>
			</tr>

	<tr>
		<td colspan="5" align="center">
			<c:if test="${pageMaker.prev}">
				<a href="TbUser.do?command=mylist&page=1">처음으로</a>
				<a href="TbUser.do?command=mylist&page=${pageMaker.startPage-1 }">이전</a>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
				<a href='<c:url value="TbUser.do?command=mylist&page=${pageNum }"/>'>${pageNum }</a>
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				<a href="TbUser.do?command=mylist&page=<%=pageMaker.getEndPage()+1%>">다음</a>
				<a href="TbUser.do?command=mylist&page=<%=pageMaker.getTempEndPage()%>">마지막페이지</a>
			</c:if>
	</td>	
 </tr>
			
		</table>
	</form>
	</div>
</div>

<%@ include file="./form/footer.jsp" %>
</body>
</html>