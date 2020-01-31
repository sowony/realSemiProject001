package com.between.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static com.between.controller.ServletUtil.*;

import com.between.biz.TbRegistBiz;
import com.between.biz.TbRegistBizImple;
import com.between.dto.TbUserDto;

@WebServlet("/TbRegistServlet.do")
public class TbRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TbRegistServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		doPost(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String command = request.getParameter("command");

		TbRegistBiz biz = new TbRegistBizImple();

		if (command.equals("regist")) {
			response.sendRedirect("RegistForm.jsp");

		} else if (command.equals("insert")) {

			String userID = request.getParameter("userid");
			String userPw = request.getParameter("userpw");
			String userName= request.getParameter("username");
			String userGender = request.getParameter("usergender");
			String userDob = request.getParameter("year")+request.getParameter("month")+request.getParameter("day");
			String userEmail = request.getParameter("useremail");
			
			System.out.println(userID);

			TbUserDto dto = new TbUserDto();

			dto.setUserId(userID);
			dto.setUserPw(userPw);
			dto.setUserName(userName);
			dto.setUserGender(userGender);
			dto.setUserDob(userDob);
			dto.setUserEmail(userEmail);
			 
			int res = biz.TbUserDto(dto);
			if (res > 0) {
				responseAlert("회원가입 완료", "RegistForm.jsp", response);

			} else {
				responseAlert("회원가입 실패", "RegistForm.jsp", response);

			}
			
		} else if (command.equals("idChk")) {
			String userId = request.getParameter("userId");
			TbUserDto res = biz.idChk(userId);

			boolean idnotused = true;

			if (res != null) {
				idnotused = false;
			}
			response.sendRedirect("idchecking.jsp?idnotused=" + idnotused);

		}  
	}
}
