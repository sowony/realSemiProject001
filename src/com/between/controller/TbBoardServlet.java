package com.between.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.between.biz.TbBoardBiz;
import com.between.biz.TbBoardBizImpl;
import com.between.biz.TbReBoardBiz;
import com.between.biz.TbReBoardBizImpl;
import com.between.dto.Criteria;
import com.between.dto.PageMaker;
import com.between.dto.TbBoardDto;
import com.between.dto.TbReBoardDto;
import com.between.dto.TbUserDto;

import static com.between.controller.ServletUtil.*;

@WebServlet("/test.do")
public class TbBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public TbBoardServlet() {
	}
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		TbBoardBiz biz = new TbBoardBizImpl();
		TbReBoardBiz reBiz = new TbReBoardBizImpl();
		
		String command = request.getParameter("command");
		
		if(command.equals("boardlist")) {
			// 해당 페이지 번호를 값으로 받아옴
			String paramPage = request.getParameter("page");

			Criteria cri = new Criteria();//받은 페이지번호로 페이지를 지정할 객체
			
			// 페이지 번호가 없는 경우 == 처음 게시판을 누를 경우, 1페이지
			if(paramPage==null) {
				cri.setPage(1); // 페이지 번호를 지정
				cri.setPageCount(10); // 페이지에서 보여줄 게시글 갯수를 지정
			} else { // 페이지 번호가 있는 경우
				int page = Integer.parseInt(paramPage);
				cri.setPage(page);
				cri.setPageCount(10);
			}
			
			PageMaker pageMaker = new PageMaker();// 페이지 번호를 만들어주는 객체
			pageMaker.setCri(cri);	// 위에서 만들어준 페이지 지정 객체를 저장
			pageMaker.setTotalCount(biz.countBoard()); // 해당 게시판의 총 게시글 갯수를 지정
			
			List<TbBoardDto> list = biz.selectList(cri.getPage(), cri.getPageCount());

			request.setAttribute("list", list);
			request.setAttribute("pageMaker", pageMaker);
			
			dispatch("TbBoardList.jsp", request, response);
			
			
		} else if(command.equals("boarddetail")) {
			// 게시글 번호(시퀀스)와 페이지 번호를 불러옴
			// 페이지 번호는 해당 게시글(selectOne)에서 보여질 댓글의 갯수를 보여주는 페이지 번호
			// 즉 게시글 안의 게시판
			int boardNum = Integer.parseInt(request.getParameter("boardnum"));
			String paramPage = request.getParameter("page");
			
			// 조회수 증가 +1
			biz.updateViewCount(boardNum);
			
			TbBoardDto dto = biz.selectOne(boardNum);
			
			Criteria cri = new Criteria();
			
			if(paramPage==null) {
				cri.setPage(1);
				cri.setPageCount(10);
			} else {
				int page = Integer.parseInt(paramPage);
				cri.setPage(page);
				cri.setPageCount(10);
			}
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(reBiz.countBoard(boardNum));
			
			List<TbReBoardDto> list = reBiz.selectList(cri.getPage(), cri.getPageCount(), boardNum);

			request.setAttribute("pageMaker", pageMaker);
			request.setAttribute("list", list);
			request.setAttribute("board", dto);
			dispatch("TbBoardDetail.jsp",request,response);
			
		} else if(command.equals("boardwriteform")) {
			response.sendRedirect("TbBoardWriteForm.jsp");
		} else if(command.equals("boardwriteres")) {
			String userId = request.getParameter("userId");
			String boardTitle = request.getParameter("boardTitle");
			String boardContent = request.getParameter("boardContent");
			HttpSession session = request.getSession();
			TbUserDto userInfo = (TbUserDto)session.getAttribute("dto");
			
			TbBoardDto dto = new TbBoardDto();
			dto.setUserId(userId);
			dto.setBoardTitle(boardTitle);
			dto.setBoardContent(boardContent);
			dto.setBoardGender(userInfo.getUserGender());
			dto.setBoardType(checkStatus(userInfo.getUserStatus()));
			int res = biz.insertBoard(dto);
			if(res>0) {
				response.sendRedirect("TbBoard.do?command=boardlist");
			} else {
				responseAlert("fail", "index.jsp", response);
			} 
		} else if(command.equals("boarddelete")) {
			
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			int res = biz.checkBoardDelete(boardNum);
			
			if(res>0) {
				response.sendRedirect("TbBoard.do?command=boardlist");
			} else {
				responseAlert("fail", "index.jsp", response);
			} 
		} else if(command.equals("boardupdate")) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			TbBoardDto dto = biz.selectOne(boardNum);
			request.setAttribute("board", dto);
			dispatch("TbBoardUpdateForm.jsp", request, response);
		} else if(command.equals("boardupdateres")) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String boardTitle = request.getParameter("boardTitle");
			String boardContent = request.getParameter("boardContent");
			
			TbBoardDto dto = new TbBoardDto();
			dto.setBoardNum(boardNum);
			dto.setBoardTitle(boardTitle);
			dto.setBoardContent(boardContent);
			
			int res = biz.updateBoard(dto);
			
			if(res>0) {
				response.sendRedirect("TbBoard.do?command=boardlist");
			} else {
				responseAlert("fail", "index.jsp", response);
			} 
		} else if(command.equals("boardanswer")) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			TbBoardDto board = biz.selectOne(boardNum);
			request.setAttribute("board", board);
			dispatch("TbBoardAnswerForm.jsp", request, response);
		} else if(command.equals("boardanswerres")) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String boardTitle = request.getParameter("boardTitle");
			String boardContent = request.getParameter("boardContent");
			String userId = request.getParameter("userId");
			
			HttpSession session = request.getSession();
			TbUserDto userInfo = (TbUserDto)session.getAttribute("dto");
			
			TbBoardDto dto = new TbBoardDto();
			dto.setUserId(userId);
			dto.setBoardGender(userInfo.getUserGender());
			dto.setBoardNum(boardNum);
			dto.setBoardTitle(boardTitle);
			dto.setBoardContent(boardContent);
			dto.setBoardType(checkStatus(userInfo.getUserStatus()));
			
			
			System.out.println(boardNum+"/"+boardTitle+"/"+boardContent+"/"+userId+"/"+checkStatus(userInfo.getUserStatus())+"/"+userInfo.getUserGender());
			
			int res = biz.answerProc(dto);
			
			if(res>0) {
				response.sendRedirect("TbBoard.do?command=boardlist");
			} else {
				responseAlert("fail", "index.jsp", response);
			} 
		} else if(command.equals("boardreple")) {
			//게시판 번호, 댓글작성자아이디,댓글작성내용,댓글작성자성별,댓글번호(시퀀스) 값 받아오기
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String userId = request.getParameter("userId");
			String reContent = request.getParameter("reContent");
			String reGender = request.getParameter("reGender");
			
			String reNum = request.getParameter("reNum");
			
			System.out.println(userId);
			System.out.println(reContent);
			System.out.println(reGender);
			
			int res = 0;
			
			//dto 객체에 리플관련 값들 저장
			TbReBoardDto dto = new TbReBoardDto();
			dto.setBoardNum(boardNum);
			dto.setUserId(userId);
			dto.setReContent(reContent);
			dto.setReGender(reGender);
			
			
			if(reNum.isEmpty()) {//댓글번호(시퀀스)가 없는 경우 == 답글이 아니라는 의미
				res = reBiz.insertReBoard(dto); // 일반 댓글 기능 실행
				
			} else { // 댓글번호가 있는 경우 == 답글이라는 의미

				dto.setReNum(Integer.parseInt(reNum));
				
				res = reBiz.answerProc(dto);// 답글 기능 실행
			}
			
			if(res>0) {
				response.sendRedirect("TbBoard.do?command=boarddetail&boardnum="+boardNum);
			} else {
				responseAlert("fail", "index.jsp", response);
			} 
			
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		doGet(request, response);
	}
	public String checkStatus(String userStatus) {
		String boardType ;
		if(userStatus.equals("ADMIN")) {
			boardType = "NOTICE";
		} else {
			boardType= "NORMAL";
		}
		return boardType;
	}
	
}
