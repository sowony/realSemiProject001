package com.between.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.between.biz.TbDictionaryBiz;
import com.between.biz.TbDictionaryBizImpl;
import com.between.dto.TbDictionaryDto;

import static com.between.controller.ServletUtil.*;

@WebServlet("/TbDictionaryServlet")
public class TbDictionaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		TbDictionaryBiz biz = new TbDictionaryBizImpl();
		
		String command = request.getParameter("command");
		
		if(command.equals("dictionaryMain")) {
			// 최초 사전페이지에 진입시
			List<TbDictionaryDto> list = biz.selectList();
			// 사전 리스트를 불러옴/좋아연 눌러진 수로 내림차순
			
			request.setAttribute("list", list);
			dispatch("TbDictionaryMain.jsp", request, response);
		} else if(command.equals("search")) {
			String keyword = request.getParameter("keyword").trim();
			//앞 뒤 공백을 다 자른 후 키워드를 받음
			
			TbDictionaryDto dto = biz.searchKeyword(keyword);
			List<TbDictionaryDto> list = biz.selectList();
			
			request.setAttribute("list", list);
			request.setAttribute("dto", dto);
			dispatch("TbDictionaryMain.jsp", request, response);
		} else if(command.equals("insert")) {
			
			String keyword = request.getParameter("keyword");
			String male = request.getParameter("male");
			String female = request.getParameter("female");
			String userId = request.getParameter("userId");
			
			TbDictionaryDto dto = new TbDictionaryDto();
			dto.setDicKeyword(keyword);
			dto.setDicMale(male);
			dto.setDicFemale(female);
			dto.setUserId(userId);
			biz.insert(dto);
			
			PrintWriter out = response.getWriter();
			String str="";
			   str = "<script type='text/javascript'>";
			   str += "opener.window.location.reload();";  //오프너 새로고침
			   str += "self.close();";
			   str += "</script>";
			   
			out.print(str);
		} else if(command.equals("like")) {
			
		}
	
	}

}
