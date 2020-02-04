package com.between.controller;
import static com.between.controller.ServletUtil.*; 

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.between.biz.TbUserBiz;
import com.between.biz.TbUserBizImpl;
import com.between.dto.Criteria;
import com.between.dto.PageMaker;
import com.between.dto.TbBoardDto;
import com.between.dto.TbGroupDto;
import com.between.dto.TbUserDto;

import net.sf.json.JSONObject;


@WebServlet("/TbUserServlet.do")
public class TbUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public TbUserServlet() {
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		doPost(request, response);
	}


	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String command = request.getParameter("command");
		TbUserBiz biz = new TbUserBizImpl();
		
		if(command.equals("login")) {
			response.sendRedirect("TbUserLogin.jsp");
			

		}else if(command.equals("registerform")) {
			 
			response.sendRedirect("RegistForm.jsp");
			
		}else if(command.equals("snslogindata")) {
			//sns아이디 시도시 디비에 자료가 있는지 검사 true ->있음 false->없음
			String userId = request.getParameter("userId");
			System.out.println("에스엔에스 처음으로 값 들어가는 곳"+userId);
			//String userPw = request.getParameter("userPw");
			TbUserDto dto = biz.snsIdCheck(userId);
			System.out.println(userId +"sns 데이터 전달 ");
			String data = "false";
			if(dto == null) {
				data = "false";
			}else if(dto != null) {
				data = "true";
			}
			System.out.println("sns 데이터 전달 값"+data);
			//결과 값 데이터 jsp로 재전송, gson -> 문자열의 값으로 전송 가능 
			response.getWriter().write(data);
			
		}else if(command.equals("googlelogin")) {
			
			//구글 아이디로 들어왔을떄
			String userId = request.getParameter("userId");
			String userPw = request.getParameter("userPw");
			System.out.println("유저 아이디유 : " + userId);
			
			TbUserDto dto = biz.login(userId, userPw);
			
			//dispatch("loginafter.jsp", request, response);
			//로그인 받은 정보에 따른 판별
			if(dto != null) {
				TbGroupDto groupdto = biz.partnerDtoDummy(userId);
				System.out.println("그룹 정보에 대한 값 "+groupdto);
				
				//만약 커플 그룹 정보가 있다면 담아서 보내주고 없으면 회원정보만 보내주기 
				if(groupdto != null) {
					HttpSession session =  request.getSession(true);
					String PartnerId = biz.partnerIdShow(groupdto.getGroupNum(), userId);
					String partnerNickOrName = biz.partnerNickorName(groupdto.getGroupNum(), PartnerId);
					
					request.setAttribute("partnerNickOrName", partnerNickOrName);
					session.setAttribute("dto", dto);
					session.setAttribute("groupdto", groupdto);
					dispatch("index.jsp", request, response);
					
				}else if(groupdto == null){
					HttpSession session =  request.getSession(true);
					session.setAttribute("dto", dto);
					System.out.println("공백 값일때 "+dto.getUserId());
					dispatch("index.jsp", request, response);
				}
				
				//session.setMaxInactiveInterval(60*10);
				} else {
					responseAlert("로그인 실패", "index.jsp", response);
				}

			
		}else if(command.equals("kakaologin")) {
			
			//카카오 아이디로 들어왔을떄
			String userId = request.getParameter("userId");
			String userPw = request.getParameter("userPw");
			System.out.println("유저 아이디유 : " + userId);
			
			TbUserDto dto = biz.login(userId, userPw);
			
			//dispatch("loginafter.jsp", request, response);
			//로그인 받은 정보에 따른 판별
			if(dto != null) {
				TbGroupDto groupdto = biz.partnerDtoDummy(userId);
				System.out.println("그룹 정보에 대한 값 "+groupdto);
				
				//만약 커플 그룹 정보가 있다면 담아서 보내주고 없으면 회원정보만 보내주기 
				if(groupdto != null) {
					HttpSession session =  request.getSession(true);
					String PartnerId = biz.partnerIdShow(groupdto.getGroupNum(), userId);
					String partnerNickOrName = biz.partnerNickorName(groupdto.getGroupNum(), PartnerId);
					
					request.setAttribute("partnerNickOrName", partnerNickOrName);
					session.setAttribute("dto", dto);
					session.setAttribute("groupdto", groupdto);
					response.sendRedirect("index.jsp");
					
				}else if(groupdto == null){
					HttpSession session =  request.getSession(true);
					session.setAttribute("dto", dto);
					System.out.println("공백 값일때 "+dto.getUserId());
					dispatch("index.jsp", request, response);
				}
				
				//session.setMaxInactiveInterval(60*10);
				} else {
					responseAlert("로그인 실패", "index.jsp", response);
				}

			
			
		}else if(command.equals("snsresgistform")) {
			String userId = request.getParameter("userId");
			String userPw = request.getParameter("userPw");
			String userEmail = request.getParameter("userEmail");
			String userGender = request.getParameter("userGender");
			//카카오는 연도는 주지않고 월일만 제공 앞부분은 고객이 직접 적도록 한다 
			String userDob = request.getParameter("userDob");
			System.out.println(userId+"userId/"+userPw+"userPw");
			System.out.println(userGender+"userGender");
			TbUserDto snsdto = new TbUserDto();
			snsdto.setUserId(userId);
			snsdto.setUserPw(userPw);
			snsdto.setUserEmail(userEmail);
			snsdto.setUserGender(userGender);
			snsdto.setUserDob(userDob);
			
			request.setAttribute("snsdto", snsdto);
			dispatch("TbUserSnsloginResgisterForm.jsp", request, response);
			
			
		}else if(command.equals("snsloginregisterformres")) {
			String userId = request.getParameter("userId");
			String userPw = request.getParameter("userPw");
			String userName = request.getParameter("userName");
			String userEmail = request.getParameter("userEmail");
			String userNick = request.getParameter("userNick");
			String userGender = request.getParameter("userGender");
			//카카오에서는 year부분만 받아서 합쳐준다, 구글에서는 따로 제공 안하기 때문에 새로작성
			String userDob = request.getParameter("year")+request.getParameter("month")+request.getParameter("date");
			System.out.println(userGender);
			
			TbUserDto snsdto = new TbUserDto();
			snsdto.setUserId(userId);
			snsdto.setUserPw(userPw);
			snsdto.setUserName(userName);
			snsdto.setUserEmail(userEmail);
			snsdto.setUserNick(userNick);
			snsdto.setUserGender(userGender);
			snsdto.setUserDob(userDob);
			
			int res = biz.snslongregister(snsdto);
			if(res>0) {
				responseAlert("가입되셨습니다. sns로그인을 해주세요", "index.jsp", response);				
			}else {
				responseAlert("가입 실패 하셨습니다. 다시 재가입 해주세요.", "index.jsp", response);
			}

			
			
		}else if(command.equals("main")) {
			//취소했을때 로그인 하지 않은 메인으로 돌아가야 함 
			response.sendRedirect("index.jsp");
			
		}else if(command.equals("loginres")) {
			String userId = request.getParameter("userId");
			String userPw = request.getParameter("userPw");
			TbUserDto dto = biz.login(userId, userPw);
			//System.out.println("유저 아이디유 : " + userId);
			//dispatch("loginafter.jsp", request, response);
			//로그인 받은 정보에 따른 판별
			if(dto != null) {
				TbGroupDto groupdto = biz.partnerDtoDummy(userId);
				System.out.println("그룹 정보에 대한 값 "+groupdto);
				if(groupdto != null) {
					HttpSession session =  request.getSession(true);
					String PartnerId = biz.partnerIdShow(groupdto.getGroupNum(), userId);
					String partnerNickOrName = biz.partnerNickorName(groupdto.getGroupNum(), PartnerId);
					
					request.setAttribute("partnerNickOrName", partnerNickOrName);
					session.setAttribute("dto", dto);
					session.setAttribute("groupdto", groupdto);
					response.sendRedirect("index.jsp");
					
				}else if(groupdto == null){
					HttpSession session =  request.getSession(true);
					session.setAttribute("dto", dto);
					System.out.println("공백 값일때 "+dto.getUserId());
					dispatch("index.jsp", request, response);
				}
				
				//session.setMaxInactiveInterval(60*10);
				} else {
					responseAlert("로그인 실패", "index.jsp", response);
				}

			
			 
			
			
		}else if(command.equals("loginafter2")) { 
			//이것 쓰는지 확인하고 삭제할것 
			HttpSession session = request.getSession();
			TbUserDto dto = (TbUserDto)session.getAttribute("dto");
			String userId = dto.getUserId();
			

			
			TbGroupDto groupdto = biz.partnerDtoDummy(userId);
			
			
			if(groupdto != null) {
				session.setAttribute("dto", dto);
				request.setAttribute("groupdto", groupdto);
				dispatch("loginafter2.jsp", request, response);
			}
			

			
		}else if(command.equals("after2")){
			//커플 신청이 들어왔을때 승낙시
			String userId = request.getParameter("userId");
			String check = request.getParameter("check");
			int groupNum = Integer.parseInt(request.getParameter("groupNum"));
			
			if(check.equals("yes")) {
				int res = biz.partnerIdInsertCheckO(groupNum);
				if(res >0) {
					int res2 = biz.partnerNumUpdateUT(userId);
					if(res2 > 0) {
						HttpSession session = request.getSession();
						TbGroupDto groupdto = biz.partnerDtoDummy(userId);
						session.setAttribute("groupdto", groupdto);

						responseAlert("커플등록 성공 하였습니다", "index.jsp", response);
					}
					
				}else {
					responseAlert("커플등록 실패 하였습니다", "index.jsp", response);
				}
			}else if(check.equals("no")){
				//커플 신청이 들어왔을때 거절시
				int res = biz.partnerIdInsertChekXnDelete(groupNum);
				if(res >0) {
					int res2 = biz.partnerNumUpdateUTDelete(groupNum);
					if(res2 >0) {			
						HttpSession session = request.getSession();
						TbGroupDto groupdto = biz.partnerDtoDummy(userId);
						session.setAttribute("groupdto", groupdto);
						responseAlert("커플등록 거절 하였습니다", "index.jsp", response);	
					}
					
				}else {
					responseAlert("커플등록을 실패하였습니다", "index.jsp", response);
				}
			}else {
				response.sendRedirect("index.jsp");
			}
				
		}else if(command.equals("logout")) {
			
			//세션 만료 
			HttpSession session = request.getSession();
			session.invalidate();
			responseAlert("로그아웃 되었습니다.", "index.jsp", response);
			//response.sendRedirect("index.jsp");
			
		}else if(command.equals("mypage")) {
			
			HttpSession session = request.getSession();
			TbUserDto loginDto = (TbUserDto)session.getAttribute("dto");

			int groupNum = loginDto.getGroupNum();
			String userId = loginDto.getUserId();
	
			//각 등급별로 마이페이지 열리기 
			if(loginDto.getUserStatus().equals("ADMIN")) {
				responseAlert("어드민님의 마이페이지 입니다. 환영합니다.", "TbUserAdminMyPage.jsp", response);
				
			}else if(loginDto.getUserStatus().equals("USER")) {
				
				//커플 그룹 번호가 유저테이블에 없을 경우 파트너의 아이디를 N으로 전송 
				if(groupNum == 0 ) {
					String partnerId = "N";

				request.setAttribute("partnerId", partnerId);
			    dispatch("TbUserUserMyPage.jsp", request, response);
				}else {
					
					String partnerId = biz.partnerIdShow(groupNum,userId);
					
					request.setAttribute("partnerId", partnerId);
					dispatch("TbUserUserMyPage.jsp", request, response);
				}
				

				
				
				//responseAlert("일반회원님의 마이페이지 입니다. 환영합니다.", "TbUserUserMyPage.jsp", response);
			}else if(loginDto.getUserStatus().equals("COUNSELOR")) {
				responseAlert("상담사님의 마이페이지 입니다.","TbUserCounselorMyPage.jsp", response);
			}
			
			
			
		}else if(command.equals("check1")) {
			
			String partnerId = request.getParameter("partnerId");
			String status = "1"; 
			TbGroupDto groupdto = biz.partnerDtoDummy(partnerId);
			
			if(groupdto==null) {
				status = "-1";
			} else {
				status = "1";
			}
			
			response.getWriter().write(status);
			
			
			/*
			 * String partnerId = request.getParameter("partnerId");
			 * System.out.println("파트너 아이디 "+partnerId); TbGroupDto groupdto2 =
			 * biz.partnerDtoDummy(partnerId); if(groupdto2 == null) {
			 * responseAlert("사용가능한 아이디 입니다", "TbUser.do?command=partnerinsert", response);
			 * }else { responseAlert("상대방 아이디가 중복 됩니다. 다시 입력하세요.",
			 * "TbUser.do?command=partnerinsert", response); }
			 */
			
		}else if(command.equals("partnerinsert")) {
			
			//유저가 새로 등록한 파트너 아이디와 로그인한 유저의 아이디를 전송 받음 
			String partnerId = request.getParameter("partnerId");
			String userId = request.getParameter("userId");
			
			//로그인 유저의 커플 테이블에 파트너의 이름을 저장 및 커플테이블 넘버 생성 
			int res = biz.partnerIdInsert(partnerId, userId);
				//저장이 성공했다면 로그인한 유저의 커플테이블의 그룹넘버를 로그인한 유저테이블 그룹넘버에 저장 
				if(res > 0) {
					
				   int afterres = biz.partnerNumUpdateUT(userId);
				
				  if(afterres>0) {
					request.setAttribute("partnerId", partnerId);
				    dispatch("TbUserUserMyPage.jsp", request, response);
				  }else {
					responseAlert("파트너 유저테이블에 입력 불가 ", "index.jsp", response);
				}
			}else {
				responseAlert("파트너 입력하는 유저테이블에서 오류", "index.jsp", response);
			}
			
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			
			
		}else if(command.equals("userupdateform")){
			
			String partnerId = request.getParameter("partnerId");
			
			request.setAttribute("partnerId", partnerId);
			dispatch("TbUserUserUpdateForm.jsp", request, response);
			
			
		}else if(command.equals("userupdateformres")) {
			//수정될 파트너 아이디 비밀번호 등을 받아서 처리하자 
			//커플 테이블에 정보를 넣고 생성된 번호를 유저테이블에 저장 
			String partnerId = request.getParameter("partnerId");
			String userId = request.getParameter("userId");
			TbGroupDto groupdto = biz.partnerDtoDummy(userId);

			
			String userPw = request.getParameter("userPw");
			String userEmail = request.getParameter("userEmail");
			String userNick = request.getParameter("userNick");
			
			TbUserDto dto = new TbUserDto();
			dto.setUserPw(userPw);
			dto.setUserEmail(userEmail);
			dto.setUserNick(userNick);
			
			int res = biz.userUpdate(dto);
			if(res > 0) {
				if(partnerId.equals("N")) {
					responseAlert("회원정보 수정이 완료되었습니다", "TbUser.do?command=mypage", response);
				}else if(!partnerId.equals("N")){
					////////////////////////////////////////////////////////////////////////////////
					
					
					/////////////////////////////////////////////////////////////////////////////////

					//기존 상대방 아이디 및 커플 번호 삭제 -> 새로 신청
					int groupNum = groupdto.getGroupNum();
					int res1 = biz.partnerIdInsertChekXnDelete(groupNum);
					if(res1 > 0) {
						//내 유저테이블에서 그룹 넘버 삭제 하기
						int res2 = biz.partnerNumUpdateUTDelete(groupNum);
						if(res2 > 0) {
	
								int res3 = biz.partnerIdInsert(partnerId, userId);
								if(res3 > 0) {
									//나의 유저 테이블에서 저장하기 
									int res4 = biz.partnerNumUpdateUT(userId);
									if(res4 > 0) {
										responseAlert("회원정보 수정이 완료 되었습니다, 새로운 상대방에게 커플신청을 했습니다", "TbUser.do?command=mypage", response);
									}
								}
	
						}
					}
					
				}
			}
			
		
		}else if(command.equals("userboardlist")) {
			
			//문제해결 : jsp파일에서 입력된 값 넘길때 form밖에 없나 ? 
			String equserPw = request.getParameter("equserPw");
			HttpSession session = request.getSession();
			TbUserDto loginDto = (TbUserDto)session.getAttribute("dto");
			//System.out.println(equserPw);
			
			if(equserPw.equals(loginDto.getUserPw())) {
				
				String paramPage = request.getParameter("page");
				//System.out.println("파람페이지이게 뭘까 "+paramPage);
				String userId = request.getParameter("userId");
				Criteria cri = new Criteria(); 
				if(paramPage == null) {
					cri.setPage(1);
					cri.setPageCount(10);
				}else {
					int page = Integer.parseInt(paramPage);
					cri.setPage(page);
					cri.setPageCount(10);
				}
				PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(biz.countBoard(userId));
				
				List<TbBoardDto> list = biz.userBoardList(userId, cri.getPage(), cri.getPageCount());
				request.setAttribute("list", list);
				request.setAttribute("pageMaker", pageMaker);
				//System.out.println("페이지메이커에 들어있는 값은 뭐지 "+pageMaker);
				dispatch("TbUserboardList.jsp", request, response);
					
			}else {
				responseAlert("비밀번호를 제대로 입력하세요 ", "TbUser.do?command=mypage", response);
			}
			
			
		}else if(command.equals("mylist")) {
			
			HttpSession session = request.getSession();
			String userId = ((TbUserDto)session.getAttribute("dto")).getUserId();
			String paramPage = request.getParameter("page");
			
			Criteria cri = new Criteria(); 
			if(paramPage == null) {
				cri.setPage(1);
				cri.setPageCount(10);
			}else {
				int page = Integer.parseInt(paramPage);
				cri.setPage(page);
				cri.setPageCount(10);
			}
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(biz.countBoard(userId));
			
			List<TbBoardDto> list = biz.userBoardList(userId, cri.getPage(), cri.getPageCount());
			
			request.setAttribute("pageMaker", pageMaker);
			request.setAttribute("list", list);
			dispatch("TbUserboardList.jsp", request, response);
			
		}else if(command.equals("search")) {
			
			String userId = request.getParameter("userId");
			String boardTitle = request.getParameter("boardTitle");
			
			List<TbBoardDto> list = new ArrayList<TbBoardDto>();
			list = biz.userBoardSearch(boardTitle, userId);
			
			String paramPage = request.getParameter("page");
			Criteria cri = new Criteria(); 

			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(biz.countBoard(userId));
			
			
				if(list.size()>0) {
					if(paramPage == null) {
						cri.setPage(1);
						cri.setPageCount(10);
					}else {
						int page = Integer.parseInt(paramPage);
						cri.setPage(page);
						cri.setPageCount(10);
					}
					request.setAttribute("pageMaker", pageMaker);
					request.setAttribute("list", list);
					dispatch("TbUserboardList.jsp", request, response);
				}else if(list.size()==0){
					if(paramPage == null) {
						cri.setPage(1);
						cri.setPageCount(10);
					}else {
						int page = Integer.parseInt(paramPage);
						cri.setPage(page);
						cri.setPageCount(10);
					}
					
					List<TbBoardDto> list2 = biz.userBoardList(userId, cri.getPage(), cri.getPageCount());
					request.setAttribute("pageMaker", pageMaker);
					request.setAttribute("list", list2);
					dispatch("TbUserboardList.jsp", request, response);
			}
			
			/*
			for(TbBoardDto bTitle : list) {
				//System.out.println("가지고 있는 자료"+bTitle+"검색하려는 글"+boardTitle);
				if(bTitle.getBoardTitle().contains(boardTitle)) {
					//System.out.println("가지고 있는 자료"+bTitle+"검색하려는 글"+boardTitle);
					dispatch("TbUserboardList.jsp", request, response);	
					
				}else {
					//이부분 실행이 안됨 ㅠㅠ 
					dispatch(url, request, response);
					
				}
			}
			*/
			
			
		}else if(command.equals("userboarddetail")) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			TbBoardDto board = biz.userBoardSelectOne(boardNum);
			request.setAttribute("board", board);
			dispatch("TbUserUserBoardDetail.jsp", request, response);
			
		}else if(command.equals("userboardupdate")) {	
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			TbBoardDto board = biz.userBoardSelectOne(boardNum);
			request.setAttribute("board", board);
			dispatch("TbUserBoardUpdateForm.jsp", request, response);
			//response.sendRedirect("TbUserBoardUpdateForm.jsp");
		
		}else if(command.equals("userboardupdateres")) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String boardTitle = request.getParameter("boardTitle");
			String boardContent = request.getParameter("boardContent");
			
			TbBoardDto dto = new TbBoardDto();
			dto.setBoardNum(boardNum);
			dto.setBoardTitle(boardTitle);
			dto.setBoardContent(boardContent);
			//System.out.println(dto);
			int res = biz.userBoardUpdate(dto);
			
			if(res >0 ) {
				String userId = request.getParameter("userId");
				request.setAttribute("userId", userId);
				dispatch("TbUser.do?command=mylist", request, response);
			}else {
				//아래문구 실행 안됨 
				responseAlert("글수정 실패 다시작성해주세요", "TbUser.do?command=userboardupdate", response);
			}
			
		}else if(command.equals("muldel")) {
			
			String[] boardNum = request.getParameterValues("chk");
			if(boardNum == null || boardNum.length == 0) {
				responseAlert("적어도 하나 이상 체크해 주세요", "TbUser.do?command=mylist", response);
		   }else {
			   int res = biz.userBoardMultiDelete(boardNum);
			   if(res>0) {
				   responseAlert("삭제 성공", "TbUser.do?command=mylist", response);
				   		   
			   }else {
				   responseAlert("삭제실패하였습니다", "TbUser.do?command=mylist", response);

			   }
		   }
		
		
		 
		}else if(command.equals("userboarddeleteone")) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			int res = biz.userBoardDelete(boardNum);
			
			//System.out.println("단일삭제 부분ㅇ 글번호 "+boardNum);
			
			if(res>0) {
				responseAlert("글을 삭제하였습니다", "TbUser.do?command=mylist", response);

			}else {
				responseAlert("삭제 실패하였습니다", "TbUser.do?command=userboarddetail&boardNum=<%=boardNum%>", response);
			
			}
	
		}else if(command.equals("userdelete")) {
			String userId = request.getParameter("userId");
			int res = biz.userDelete(userId);
			if(res>0) {
				HttpSession session = request.getSession();
				session.invalidate();
				responseAlert("탈퇴되었습니다", "index.jsp", response);
			}
			
		}
		
		
		
		
		//dopost 마지막 부분 
	}

}
