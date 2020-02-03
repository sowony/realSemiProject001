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
	


</style>
</head>
<body>

	<%@ include file="./form/mainPage.jsp" %>
	
	<div id="head"></div>
	
	<div id="board" >
		<div id="list">
			<table >
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
							<tr>
								<td align="center">${dto.boardNum }</td>
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
					<td colspan="4" align="right"><input type="button"
						value="글쓰기"
						onclick="location.href='TbBoard.do?command=boardwriteform'" /></td>
				</tr>
				<tr>
					<td colspan="4" align="center">
							<c:if test="${pageMaker.prev }">
								<a href="TbBoard.do?command=boardlist&page=1">처음으로</a>
								<a href="TbBoard.do?command=boardlist&page=${pageMaker.startPage-1 }">이전</a>
							</c:if>
							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
								 <a href='<c:url value="TbBoard.do?command=boardlist&page=${pageNum }"/>'>${pageNum } </a> 
							</c:forEach>
							<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
								<a href="TbBoard.do?command=boardlist&page=${pageMaker.endPage+1 }">다음</a> 
								<a href="TbBoard.do?command=boardlist&page=${pageMaker.tempEndPage }" >마지막</a>
							</c:if>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<%@ include file="./form/footer.jsp" %>
</body>
</html>