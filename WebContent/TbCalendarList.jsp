<%@page import="com.between.dto.TbUserDto"%>
<%@page import="com.between.dto.TbCalDto"%>
<%@page import="java.util.List"%>
<%@page import="com.between.biz.TbCalBizImpl"%>
<%@page import="com.between.biz.TbCalBiz"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-control", "no-store");
	response.setHeader("Expires", "0");
%>
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
<%
		TbUserDto userInfo = (TbUserDto)session.getAttribute("dto");
	
		if (userInfo == null) {
			pageContext.forward("index.jsp");
		}

		int year = (int) request.getAttribute("year");
		int month = (int) request.getAttribute("month");
		int date = (int) request.getAttribute("date");
		
		TbCalBiz biz = new TbCalBizImpl();
		
	%>
<title><%=year %>년 <%=month %>월 <%=date %>일</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	
function allChk(bool){
	var $box = $("input[name=chk]");
	for(var i = 0; i < $box.length; i++){
		$box[i].checked = bool;
	}
}

$(function(){
	$("#muldelform").submit(function(){
		if($("#muldelform input:checked").length==0){
			alert("하나 이상 체크해주세요");
			return false;
		}
	});
	
	$("input[name=chk]").click(function(){
		if($("input[name=chk]").length==$("input[name=chk]:checked").length){
			$("input[name=all]").prop("checked", true);
		} else {
			$("input[name=all]").prop("checked", false);
		}
	});
});
function closeRefresh(){
	window.close();
	opener.location.reload();
}
	
</script>


</head>
<link href="css/calendar-list.css" rel="stylesheet" type="text/css">

<body>

	<h3>일정보기</h3>

	<form action="TbCal.do" method="post" id="muldelform">
		<input type="hidden" name="command" value="muldel"> 
		<input type="hidden" name="year" value="<%=year%>"> 
		<input type="hidden" name="month" value="<%=month%>"> 
		<input type="hidden" name="date" value="<%=date%>">		

		<table>
			<col width="30px;">
			<col width="120px;">
			<col width="150px;">
			<tr>
				<th><input type="checkbox" name="all" onclick="allChk(this.checked);"/></th>
				<th>시간</th>
				<th>일정</th>
			</tr>
				
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<th colspan="3">--------작성된 글이 없습니다--------</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list }" var="dto">
						<tr>
							<td><input type="checkbox" name="chk" value="${dto.calNum }"></td>
							<td>${dto.calTime}</td>
							<td><a href="TbCal.do?command=updateCalForm&calNum=${dto.calNum }&groupNum=${dto.groupNum}">${dto.calTitle }</a></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>	
				
			<tr>
				<td colspan="3"><input type="button" value="글쓰기"
					onclick="location.href='TbCal.do?command=insertCalForm&year=<%=year%>&month=<%=month%>&date=<%=date%>'">
					<input type="button" value="캘린더" onclick="closeRefresh();">
					<input type="submit" value="삭제">
				</td>
			</tr>

		</table>
	</form>


</body>
</html>