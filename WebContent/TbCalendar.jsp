<%@page import="com.between.dao.TbCalDaoImpl"%>
<%@page import="com.between.dao.TbCalDao"%>
<%@page import="com.between.dto.TbCalDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.between.biz.TbCalBizImpl"%>
<%@page import="com.between.biz.TbCalBiz"%>
<%@page import="com.between.dto.TbGroupDto"%>
<%@page import="com.between.dto.TbUserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>Insert title here</title>
<%@ include file="./form/mainPage.jsp" %>
<script type="text/javascript">

	
	window.onload = anniversary;
	
	function anniversary() {
		//var dates = document.getElementById("dates").value;
		var year = document.getElementById("anniYear").innerHTML;
		var month = document.getElementById("anniMonth").innerHTML;
		var date = document.getElementById("anniDate").innerHTML;
		console.log(year);
		console.log(month);
		console.log(date);
		
		var now = new Date();
		var firstDay = new Date(year,month-1,date);
		
		
		var toNow = now.getTime();
		var toFirst = firstDay.getTime();
		var passedTime = toNow - toFirst;
		var passedDay = Math.ceil(passedTime/(1000*60*60*24));
		
		document.querySelector("#today").innerText = passedDay + "일";
	}
	
	function windowopenPopup(){
		window.open('windowopen.html', 'window팝업', 'width=300, height=300, menubar=no, status=no, toolbar=no');
	}
	
</script>
<link href="css/calendar.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		
		if(userInfo==null){
			pageContext.forward("index.jsp");
		}
	
		TbCalBiz biz = new TbCalBizImpl();

		int groupNum = userInfo.getGroupNum();
		

		TbGroupDto groupDto = (TbGroupDto) request.getAttribute("groupDto");

		int year = (int) request.getAttribute("year");
		int month = (int) request.getAttribute("month");
		int dayOfWeek = (int) request.getAttribute("dayOfWeek");
		int lastDay = (int) request.getAttribute("lastDay");

		TbCalDao dao = new TbCalDaoImpl();
		String yyyyMM = year + biz.isTwo(String.valueOf(month));
		List<TbCalDto> clist = dao.selectCalListView(yyyyMM, groupNum);
	%>

	<h1 class="title"><%=groupDto.getUserId()%> &
		<%=groupDto.getPartnerId()%>의 캘린더
	</h1>

	<div id="wrap">
		<div class="D-Day" id="day">
			<%
				if(biz.selectDday("사귄날", groupNum)==null){
			%>
			<form action="TbCal.do" method="post">
				<input type="hidden" name="command" value="dday">
				<input type="text" placeholder="예)2010-04-20" name="dateSince">
				<input type="submit" value="등록"> 
			</form>
			<%		
				} else {
			%>
			<div>
				<h3>
					<span id="anniYear">
						<%=biz.selectDday("사귄날", groupNum).getCalTime().substring(0, 4) %>
					</span>년  
					<span id="anniMonth">
						<%=biz.selectDday("사귄날", groupNum).getCalTime().substring(4, 6) %> 
					</span>월 
					<span id="anniDate">
						<%=biz.selectDday("사귄날", groupNum).getCalTime().substring(6, 8) %> 
					</span>일
					<a href="TbCal.do?command=ddayEdit"><img alt="edit" src="images/pen.png" id="pen"></a> 
				</h3>
				<label>사랑한지? </label><span id="today"></span><br/>
			</div>
			<%
				}
			%>
		</div>
		<div class="cal">
			<table id="calendar">
				<caption class="arrows">
					<a
						href="TbCal.do?command=minusYear&year=<%=year - 1%>&month=<%=month%>">◀︎◀︎</a>
					<a
						href="TbCal.do?command=minusMonth&year=<%=year%>&month=<%=month - 1%>">◁</a>
					<span class="y"><%=year%></span>년 <span class="m"><%=month%></span>월
					<a
						href="TbCal.do?command=addMonth&year=<%=year%>&month=<%=month + 1%>">▷</a>
					<a
						href="TbCal.do?command=addYear&year=<%=year + 1%>&month=<%=month%>">▶▶</a>
				</caption>
				<tr id="days">
					<th>SUN</th>
					<th>MON</th>
					<th>TUE</th>
					<th>WED</th>
					<th>THU</th>
					<th>FRI</th>
					<th>SAT</th>
				</tr>
				<tr>

					<%
						for (int i = 1; i < dayOfWeek; i++) {

							out.print("<td>&nbsp</td>");

						}

						int cnt = dayOfWeek;
						for (int i = 1; i <= lastDay; i++) {
					%>
					<td><a class="dateNums" onclick="window.open('TbCal.do?command=callist&year=<%=year%>&month=<%=month%>&date=<%=i%>','List','width=300, height=400, menubar=no, status=no, toolbar=no, location=no, scrollbar=no, fullscreen=no')" style="background-color: <%=biz.fontColor(i, dayOfWeek)%>; color:white;"><%=i%></a>
						<div class="preList">
							<%=biz.getCalView(i, clist)%>
						</div>
					</td>
					<%
						if (cnt % 7 == 0) {
					%>
				</tr>
				<tr>
					<%
						}
							cnt++;
						}

						int a = 7 - ((dayOfWeek - 1 + lastDay) % 7) % 7;

						if (a % 7 == 0) {
							out.print("</tr>");
						}
					%>
				</tr>
			</table>
		</div>
	</div>



</body>
</html>