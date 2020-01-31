package com.between.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.between.biz.TbCalBiz;
import com.between.biz.TbCalBizImpl;
import com.between.dto.TbCalDto;
import com.between.dto.TbGroupDto;
import com.between.dto.TbUserDto;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import static com.between.controller.ServletUtil.*;

@WebServlet("/TbCalServlet.do")
public class TbCalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		TbCalBiz biz = new TbCalBizImpl();
		
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		
		String paramYear = request.getParameter("year");
		String paramMonth = request.getParameter("month");
		
		if(paramYear != null){
			year = Integer.parseInt(paramYear);
		}
		
		if(paramMonth != null){
			month = Integer.parseInt(paramMonth);
		}
		
		if(month > 12){
			month = 1;
			year++;
		}
		
		if(month < 1){
			month = 12;
			year--;
		}
		
		cal.set(year, month-1, 1);
		
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		
		int lastDay = cal.getActualMaximum(Calendar.DATE);
		
		
		
		String command = request.getParameter("command");
		
		HttpSession session = request.getSession();
		TbUserDto userInfo = (TbUserDto)session.getAttribute("dto");
		
		if(userInfo==null) {
			response.sendRedirect("index.jsp");
		} else {
			
		
		TbGroupDto groupDto = biz.findPartner(userInfo.getGroupNum());
				
		
		if(command.equals("calendar")) {		
			
			//int date = Integer.parseInt(request.getParameter("date"));
			
			request.setAttribute("groupDto", groupDto);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("dayOfWeek", dayOfWeek);
			request.setAttribute("lastDay", lastDay);
			
			dispatch("TbCalendar.jsp", request, response);
			
		} else if(command.equals("minusYear")) {
			//year = year-1;
			
			request.setAttribute("groupDto", groupDto);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("dayOfWeek", dayOfWeek);
			request.setAttribute("lastDay", lastDay);
			
			dispatch("TbCalendar.jsp", request, response);
		} else if(command.equals("minusMonth")) {
			request.setAttribute("groupDto", groupDto);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("dayOfWeek", dayOfWeek);
			request.setAttribute("lastDay", lastDay);
			
			dispatch("TbCalendar.jsp", request, response);
		} else if(command.equals("addMonth")) {
			request.setAttribute("groupDto", groupDto);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("dayOfWeek", dayOfWeek);
			request.setAttribute("lastDay", lastDay);
			
			dispatch("TbCalendar.jsp", request, response);
		} else if(command.equals("addYear")) {
			request.setAttribute("groupDto", groupDto);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("dayOfWeek", dayOfWeek);
			request.setAttribute("lastDay", lastDay);
			
			dispatch("TbCalendar.jsp", request, response);
		} else if(command.equals("callist")) {
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
			int date = Integer.parseInt(request.getParameter("date"));
			
			
			String yyyyMMdd = year+biz.isTwo(Integer.toString(month))+biz.isTwo(Integer.toString(date));
			
			List<TbCalDto> list = biz.selectCalList(yyyyMMdd, userInfo.getGroupNum());
			
			request.setAttribute("list", list);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("date", date);
			
			System.out.println(list);
			System.out.println(yyyyMMdd);
			
			dispatch("TbCalendarList.jsp", request, response);
			
		} else if(command.equals("insertCalForm")) {
			
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
			int date = Integer.parseInt(request.getParameter("date"));
			
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("date", date);
			
			dispatch("TbCalendarInsert.jsp", request, response);
		} else if(command.equals("insertCal")) {
			int groupNum = Integer.parseInt(request.getParameter("groupNum"));
			
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
			
			int date = Integer.parseInt(request.getParameter("date"));
			
			String hour = request.getParameter("hour");
			String min = request.getParameter("min");
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			String calTime = year+
					biz.isTwo((Integer.toString(month)))+
					biz.isTwo(Integer.toString(date))+
					biz.isTwo(hour)+
					biz.isTwo(min);
			TbCalDto dto = new TbCalDto();
			dto.setGroupNum(groupNum);
			dto.setCalTitle(title);
			dto.setCalContent(content);
			dto.setCalTime(calTime);
			int res = biz.insertEvent(dto);
			
			String yyyyMMdd = year+biz.isTwo(Integer.toString(month))+biz.isTwo(Integer.toString(date));
			
			List<TbCalDto> list = biz.selectCalList(yyyyMMdd, userInfo.getGroupNum());
			
			request.setAttribute("list", list);
			
			request.setAttribute("groupDto", groupDto);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("dayOfWeek", dayOfWeek);
			request.setAttribute("lastDay", lastDay);
			request.setAttribute("date", date);
		
			if(res>0) {
				dispatch("TbCalendarList.jsp", request, response);
			} else {
				dispatch("TbCalendarList.jsp",request,response);
			}
			
			//dispatch("TbCalendar.jsp", request, response);
		} else if(command.equals("updateCalForm")) {
			int calNum = Integer.parseInt(request.getParameter("calNum"));
			int groupNum = Integer.parseInt(request.getParameter("groupNum"));
			TbCalDto calDto = biz.selectOne(calNum, groupNum);
			
			request.setAttribute("calNum", calNum);
			request.setAttribute("groupNum", groupNum);
			request.setAttribute("calDto", calDto);
			
			dispatch("TbCalendarUpdate.jsp", request, response);
		} else if(command.equals("updateCal")) {
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
			int date = Integer.parseInt(request.getParameter("date"));
			String hour = request.getParameter("hour");
			String min = request.getParameter("min");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			int calNum = Integer.parseInt(request.getParameter("calNum"));
			int groupNum = Integer.parseInt(request.getParameter("groupNum"));
			
			String calTime = year +
							biz.isTwo(Integer.toString(month)) +
							biz.isTwo(Integer.toString(date)) +
							biz.isTwo(hour) +
							biz.isTwo(min);
			
			TbCalDto calDto = new TbCalDto();
			calDto.setGroupNum(groupNum);
			calDto.setCalTitle(title);
			calDto.setCalContent(content);
			calDto.setCalTime(calTime);
			calDto.setCalNum(calNum);
			
			String yyyyMMdd = year+biz.isTwo(Integer.toString(month))+biz.isTwo(Integer.toString(date));
			
			List<TbCalDto> list = biz.selectCalList(yyyyMMdd, userInfo.getGroupNum());
			
			request.setAttribute("list", list);
			request.setAttribute("date", date);
			
			request.setAttribute("groupDto", groupDto);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("dayOfWeek", dayOfWeek);
			request.setAttribute("lastDay", lastDay);
			
			int res = biz.updateEvent(calDto);
			
			System.out.println("수정된 시간 : "+hour);
			System.out.println(calNum);
			
			if(res > 0) {
				
				dispatch("TbCalendarList.jsp", request, response);
			} else {
				dispatch("TbCalendarList.jsp",request,response);
			}
		} else if(command.equals("muldel")) {
			
			String[] seq = request.getParameterValues("chk");
			
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
			int date = Integer.parseInt(request.getParameter("date"));
			
			System.out.println(year);
			System.out.println(month);
			System.out.println(date);
			
			
			String yyyyMMdd = year+biz.isTwo(Integer.toString(month))+biz.isTwo(Integer.toString(date));
			int res = biz.deleteEvent(seq);
			
			List<TbCalDto> list = biz.selectCalList(yyyyMMdd, userInfo.getGroupNum());
			
			request.setAttribute("list", list);
			request.setAttribute("year", year);
			request.setAttribute("month", month);
			request.setAttribute("date", date);
			
			
			if(res > 0) {
				dispatch("TbCalendarList.jsp", request, response);
			} else {
				dispatch("TbCalendarList.jsp", request, response);
			}
		} else if(command.equals("dday")) {
			String daySince = request.getParameter("dateSince");
			String arr[] = daySince.split("-");
			int groupNum = userInfo.getGroupNum();
			
			year = Integer.parseInt(arr[0]);
			month = Integer.parseInt(arr[1]);
			int date = Integer.parseInt(arr[2]);
			int hour = 0;
			int min = 0;
			String title = "사귄날";
			String content = "오늘부터 1일~";
			
			String calTime = year+
					biz.isTwo((Integer.toString(month)))+
					biz.isTwo(Integer.toString(date))+
					biz.isTwo(Integer.toString(hour))+
					biz.isTwo(Integer.toString(min));
			TbCalDto dto = new TbCalDto();
			dto.setGroupNum(groupNum);
			dto.setCalTitle(title);
			dto.setCalContent(content);
			dto.setCalTime(calTime);
			
			
			
			if(biz.selectDday(title, groupNum)==null) {
				
				int res = biz.insertEvent(dto);
				
				request.setAttribute("groupDto", groupDto);
				request.setAttribute("year", year);
				request.setAttribute("month", month);
				request.setAttribute("dayOfWeek", dayOfWeek);
				request.setAttribute("lastDay", lastDay);
				
				if(res > 0) {
					dispatch("TbCalendar.jsp", request, response);
				} else {
					dispatch("TbCalendar.jsp", request, response);
				}
			} else {
				request.setAttribute("groupDto", groupDto);
				request.setAttribute("year", year);
				request.setAttribute("month", month);
				request.setAttribute("dayOfWeek", dayOfWeek);
				request.setAttribute("lastDay", lastDay);
				
				dispatch("TbCalendar.jsp", request, response);
			}
		} else if(command.equals("ddayEdit")) {
			String title = "사귄날";
			int groupNum = userInfo.getGroupNum();
			
			TbCalDto dto = biz.selectDday(title, groupNum);
			
			int res = biz.deleteOne(dto);
			
			if(res > 0) {
				request.setAttribute("groupDto", groupDto);
				request.setAttribute("year", year);
				request.setAttribute("month", month);
				request.setAttribute("dayOfWeek", dayOfWeek);
				request.setAttribute("lastDay", lastDay);
				
				dispatch("TbCalendar.jsp", request, response);
			} else {
				request.setAttribute("groupDto", groupDto);
				request.setAttribute("year", year);
				request.setAttribute("month", month);
				request.setAttribute("dayOfWeek", dayOfWeek);
				request.setAttribute("lastDay", lastDay);
				
				dispatch("TbCalendar.jsp", request, response);
			}
		}
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		doGet(request, response);
	}
	
	

}
