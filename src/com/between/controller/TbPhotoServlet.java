package com.between.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.between.biz.TbPhotoBizImpl;
import com.between.dto.TbPhotoDto;
import com.between.view.Main;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/* Not a directory: 경로 오류
 * 일반적인 경로 오류 아니면,
 * >> server뷰에서 톰캣서버 클릭 >> serve modules without publishing 체크
 */

   //urlPattern은 소문자만 인식가능한가?
@MultipartConfig(               //서블릿 3.0이상 제공, 파일 업/다운로드 용도
location = "C:\\workspace_semi",   //저장될 디렉토리, 필수
maxFileSize = -1,               //업로드 파일의 최대 크기 값, default:-1(크기제한없음)
maxRequestSize = -1,            //HTTP 요청의 최대 크기 값, default:-1(크기제한없음)
fileSizeThreshold = 102410244)      //4mb까지, 이 크기가 넘으면 디스크의 임시디렉토리에 저장된다. 
@WebServlet(urlPatterns = {"/api","/photoupload", "/checkcheck"})
public class TbPhotoServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    public TbPhotoServlet() {
        super();
    }
//doGet으로 받으면 인코딩만 해서 만들어둔 메서드에서 처리하세요
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//      System.out.println("doGet입니다.");
      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      doPost(request, response);
   }
//doPost로 받으면 인코딩만 해서 만들어둔 메서드에서 처리하세요
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//      System.out.println("doPost입니다.");
      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");   

      String command = request.getRequestURI();   //= 프로젝트+파일경로
//      System.out.println("command 입니다.: "+command);
         
//01.jsp서 업로드할 로직으로 만들기          
      if(command.endsWith("/photoupload")) {
      //컬럼 변수 생성
         String id = "id";            //작성자, 다른테이블
//         String title = "title";         
         String title = "title";      //제목
//         String fileCloneName1 = "";      //클론
//         String photoPath1 ="";         //경로 x 경로는 request.getRealPath()로 구함
      //파일이 저장될 서버의 경로.
         String uploadPath = "\\\\192.168.10.33\\tomcat9\\prj\\";
//         System.out.println(uploadPath);
         
         String uploadPathforImg = "http://qclass.iptime.org:8686/prj/";
//         System.out.println(uploadPathforImg);
         /*
          * String uploadPath = request.getSession()
          * .getServletContext().getRealPath("upload");
          * System.out.println("uploadPath : "+ uploadPath); 
          * 
          * //용도가 달라요우, check.jsp용도
          * String uploadPathforImg =
          *             request.getSession().getServletContext().getRealPath("upload");*/
      //request.getParameter()사용이 불가능, 해당 라이브러리에서 제공하는 대체함수.
      //해당 객체가 저장까지 다 시켜줌      
         MultipartRequest multi = new MultipartRequest(
               request, 
               uploadPath, // 파일을 저장할 디렉토리 지정
               10*1024*1024, // 첨부파일 최대 용량 설정(bite) / 10KB*1024 / 용량 초과 시 예외 발생
               "utf-8" // 인코딩 방식 지정
//                new DefaultFileRenamePolicy()   //사본 만들어줄게요~
               );
      //제목   
         id = multi.getParameter(id); // form의 name="id"인 값을 구함;
         title = multi.getFilesystemName("file1"); // name=file1의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
//         fileCloneName1 = multi.getFilesystemName(fileName1);
         //패스는?
//         System.out.println("MultipartRequest작업완료 : "+ multi);
         
//         System.out.println("id : "+id);  
//         System.out.println("파일명"+ title);
//         System.out.println("사본"+fileCloneName1);
      // --------------------------아래는 전송 받은 데이터들을 DB테이블에 저장시키기 위한 작업들이다.--------------------------
      // 테이블 설계, 쿼리문, DTO, DAO, Service.. 등은 만들어져 있다고 가정한다.
         
      // MultipartRequest로 전송받은 데이터를 불러온다.
      // enctype을 "multipart/form-data"로 선언하고 submit한 데이터들은 request객체가 아닌 MultipartRequest객체로 불러와야 한다.
         
      //디비에 담겼는지 확인
/*
 USER_ID
 PHOTO_ORIGIN_TITLE
 PHOTO_CLONE_TITLE
 PHOTO_PATH
 */         
         
         
      //dto로 담아주기
         TbPhotoDto dto = new TbPhotoDto();
         dto.setUserId("who");   //id
         dto.setOriginTitle(title);
         dto.setPhotoPath(uploadPath);
         
         TbPhotoBizImpl biz = new TbPhotoBizImpl();
         int res = biz.tbPhotoInsert(dto);
         
         if(res>0) {
            //화면전환 뭔방식으로해?
//            System.out.println("저장성공");
            request.setAttribute("file1", uploadPath);
   //         dispatch("check.jsp", request, response);   
                  //CHECKING용도
                     request.setAttribute("imgWho", title);
//                     System.out.println("서블릿에서 사본 확인요요:"+uploadPathforImg+""+title);
                     dispatch("check.jsp", request, response);   
         }else {
            //화면전환 뭔방식으로해?
            
         }
         
//         //화면전환   
//         request.setAttribute("file1", fileName1);
//         dispatch("upload.jsp", request, response);   
         
//02. 저장여부 확인 및       
      }else if(command.endsWith("/checkcheck")){

         Object file2 = request.getParameter("imgWho");
//         System.out.println("checkcheck은 데이터를 자바로 보내는 공간입니다."+file2);
         
         Main main = new Main();
         //저장된 값을 sendData로
         main.setPath(file2);
         String res = main.sendData();
         
//         System.out.println(res);
         
         //필요한 데이터 구간 찾기
         String cut01 = res.substring(res.indexOf("emotion"),res.indexOf("blur"));
      //데이터 가공하기( {{{{}}}}->{"":""} )
         String cut02 = cut01.substring(9,cut01.length()-2);
         
      //JSON형식으로 파서
         JSONParser parser01 = new JSONParser();
         
         try {
            //위에서 가공한 값을 Object로 파서해서
            Object tmp = parser01.parse(cut02);
//            System.out.println("네 타입은 뭐니?");
//            System.out.println(tmp instanceof String);
//            System.out.println(tmp instanceof Object);   //true      
            
            
            //값을 "azure01"란 이름으로
            request.setAttribute("azure01", tmp);
            request.setAttribute("imgWho", file2);
            //넘길게
            dispatch("giveme.jsp", request, response);
         } catch (ParseException e) {
//            System.out.println("JsonParser Error about img at the Servlet입니다.");
            e.printStackTrace();
         }
      }
   }
   

      
   public void dispatch(String url, HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {

      RequestDispatcher dispatch = request.getRequestDispatcher(url);
      dispatch.forward(request, response);

      
   }

}