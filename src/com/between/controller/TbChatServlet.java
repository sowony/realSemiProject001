package com.between.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.between.biz.TbChatBiz;
import com.between.biz.TbChatBizImpl;
import com.between.dto.TbGroupDto;
import com.between.dto.TbUserDto;

@WebServlet("/TbChatServlet")
public class TbChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		HttpSession session = request.getSession();
		//멘티에서 채팅 접근
    if(command.equals("enterChat")) {
       TbUserDto userInfo = (TbUserDto)session.getAttribute("dto"); 
//       String menteeId = menteeDto.getId();
//       String myRole = "mentee";
//       System.out.println(menteeId);
//       System.out.println("롤 : "+myRole);
       TbChatBiz biz = new TbChatBizImpl();
       // 이 안에서 멘토,멘티 둘을 나눠서 사용하기.
       // 1. if문으로 나눔
       // 2. 기준은 groupNum으로 가져온 dto에서 뽑아온 userId와 partnerId
       // 3. 각각 멘토, 멘티 부분에 대입하여 넣음 멘토는 userId, 멘티는 partnerId
       // 4. 방번호는 groupNum으로 대체(유니크)
       
       int groupNum = userInfo.getGroupNum(); //커플그룹번호
       TbGroupDto dto = biz.checkGroup(groupNum); //커플그룹번호에 해당하는 커플테이블DTO
       System.out.println(dto.getUserId());
       System.out.println(dto.getGroupNum());
//       String menteeId = userInfo.getUserId();
//       String myRole = userInfo.getUserStatus();
//       String myRole = "mentor";
       String myRole = "";
       String matchNo = userInfo.getGroupNum()+"";
       String mentorId = "";
       String menteeId = "";
       
       if(userInfo.getUserId().equals(dto.getUserId())) {
    	   // 그룹테이블에 userId에 들어가 있는 경우 멘티 방향으로
    	   mentorId = dto.getPartnerId();
    	   menteeId = dto.getUserId();
    	   myRole = "mentee";
    	   
    	   response.sendRedirect("http://192.168.110.5:8081/?myRole="+ myRole + "&myId="+menteeId+"&otherId="+mentorId + "&matchNo="+matchNo);

       } else if(userInfo.getUserId().equals(dto.getPartnerId())){
    	   // 그룹테이블에 partnerId에 들어가 있는 경우 멘토 방향으로
    	   mentorId = dto.getPartnerId();
    	   menteeId = dto.getUserId();
    	   myRole = "mentor";
    	   
    	   String[] menteeIdArr = new String[1];
           String[] matchNoArr = new String[1];

           String menteeId_json = menteeId;
           String No_json = dto.getGroupNum()+"";
           
           menteeIdArr[0] = menteeId;
           matchNoArr[0] = dto.getGroupNum()+"";
           
//           for(int i=0; i<1;i++) {
//              menteeIdArr[i] = menteeId;
//              matchNoArr[i] = dto.getGroupNum() + "";
//              if(i == 0) {
//                 menteeId_json += menteeIdArr[i];
//                 No_json += matchNoArr[i];        
//              } else {
//                 menteeId_json += "," + menteeIdArr[i];
//                 No_json += "," + matchNoArr[i];
//              }
//           }
              
         response.sendRedirect("http://192.168.110.5:8081/?myRole="+ myRole + "&myId="+mentorId+"&otherId_json="+ menteeId_json + "&No_json="+ No_json);
       }
    //멘토 채팅 접근   
//       LoginProfileDto mentorDto = (LoginProfileDto)session.getAttribute("mentorDto");
//       String mentorId = mentorDto.getId();
//       String myRole = "mentor";
//       System.out.println("롤 : "+myRole);
//       
//       List<MatchDto> menteeIdList = matchBiz.search_Mentor_Mentee_All(mentorId);
//       
//       String[] menteeIdArr = new String[menteeIdList.size()];
//       String[] matchNoArr = new String[menteeIdList.size()];
//
//       String menteeId_json = "";
//       String No_json = "";
//       for(int i=0; i<menteeIdList.size();i++) {
//          menteeIdArr[i] = menteeIdList.get(i).getMatchMenteeId();
//          matchNoArr[i] = menteeIdList.get(i).getMatchNo() + "";
//          if(i == 0) {
//             menteeId_json += menteeIdArr[i];
//             No_json += matchNoArr[i];        
//          } else {
//             menteeId_json += "," + menteeIdArr[i];
//             No_json += "," + matchNoArr[i];
//          }
          // String menteeIdArr = id1, id2;
          // String matchNoArr = "1", "2";
//       }
//       System.out.println("멘토 >> 체팅 멘토 아이디 : " + mentorId + ", 멘티id 정보 : " + menteeId_json + ", 메치시퀀스번호 : " + No_json);
//       response.sendRedirect("http://172.30.1.13:8010/?myRole="+ myRole + "&myId="+mentorId+"&otherId_json="+ menteeId_json + "&No_json="+ No_json);
    }
	}

}
