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
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;	//사본 생성용도

/* Not a directory: 경로 오류
 * 일반적인 경로 오류 아니면,
 * >> server뷰에서 톰캣서버 클릭 >> serve modules without publishing 체크
 */

@MultipartConfig( 										// 서블릿 3.0이상 제공, 파일 업/다운로드 용도
		location = "C:\\workspace_semi", 				// 저장될 디렉토리, 필수
		maxFileSize = -1, 								// 업로드 파일의 최대 크기 값, default:-1(크기제한없음)
		maxRequestSize = -1, 							// HTTP 요청의 최대 크기 값, default:-1(크기제한없음)
		fileSizeThreshold = 102410244) 					// 4mb까지, 이 크기가 넘으면 디스크의 임시디렉토리에 저장된다.
@WebServlet(urlPatterns = { "/photostep1", "/photostep2" })
public class TbPhotoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		doPost(request, response);
	}

// MultipartRequest라이브러리를 이용한 파일업로드는 POST방식으로만 가능합니다.
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String command = request.getRequestURI(); // command = 프로젝트+파일경로
//      System.out.println("photoServlet의_프로젝트경로+파일경로입니다.: "+command);

//01.jsp서 사진업로드할 로직 만들기 (Form.jsp -> FormCheck.jsp)       
		if (command.endsWith("/photostep1")) {
try {
				// 컬럼 변수 생성
				String id = "id"; 			// 작성자, 다른테이블
				String title = "title"; 	// 제목
//         String fileCloneName1 = "";   	//클론 제목
//         String photoPath1 ="";        	//경로 x 경로는 request.getRealPath()로 구함
				// 파일이 저장될 서버의 경로.
//         String uploadPath = "\\\\192.168.10.33\\tomcat9\\prj\\";	//학원 서버 경로
//         System.out.println(uploadPath);

		// 로컬경로 잡는법
				String uploadPath = request.getSession().getServletContext().getRealPath("uploadImages");
				System.out.println("uploadPath : " + uploadPath);
				
				// request.getParameter()사용이 불가능, 해당 라이브러리에서 제공하는 대체함수.
			// 해당 객체가 저장까지 다 시켜줌
				MultipartRequest multi = new MultipartRequest(
						request, 
						uploadPath, 		// 파일을 저장할 디렉토리 지정
						6 * 1024 * 1024, 	// 첨부파일 최대 용량 설정(bite) / 10KB*1024 / 용량 초과 시 예외 발생 //사진분석 최대용량 6MB
						"utf-8" 			// 인코딩 방식 지정
//                      new DefaultFileRenamePolicy()   //사본 생성
				);

//              id = multi.getParameter(id); // form의 name="id"인 값을 구함;
				title = multi.getFilesystemName("file1"); // name=file1의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
//              fileCloneName1 = multi.getFilesystemName(fileName1);


				
				// --------------------------아래는 전송 받은 데이터들을 DB테이블에 저장시키기 위한 작업들이다.--------------------------
				// 테이블 설계, 쿼리문, DTO, DAO, Service.. 등은 만들어져 있다고 가정한다.

				// MultipartRequest로 전송받은 데이터를 불러온다.
				// enctype을 "multipart/form-data"로 선언하고 submit한 데이터들은 request객체가 아닌 MultipartRequest객체로 불러와야 한다.
 
	/* TB_PHOTO 테이블 컬럼
	 * USER_ID 
	 * PHOTO_ORIGIN_TITLE (NOT_NULL) 
	 * PHOTO_PATH		  (NOT_NULL)
	 */

				// dto로 담아주기
				TbPhotoDto dto = new TbPhotoDto();
				dto.setUserId("FaB_2nd"); // id
				dto.setOriginTitle(title);
				dto.setPhotoPath(uploadPath);

				TbPhotoBizImpl biz = new TbPhotoBizImpl();
				int res = biz.tbPhotoInsert(dto);

				if (res > 0) {
//              System.out.println("저장성공");
					request.setAttribute("file1", uploadPath);	//폴더경로
					request.setAttribute("imgWho", title);		//파일명
					System.out.println("서블릿서 사진경로 확인 결과 : "+ uploadPath + ""+ title);
					dispatch("TbBoardImageUploadFormCheck.jsp", request, response);
				} else {
					System.out.println("사진 저장이 실패했습니다._오라클 또는 properties이 제대로 잡혔는지 확인하세요.");
					System.out.println("__다른 문제일 수도 있습니다.");
					dispatch("TbBoardError404.jsp", request, response);
				}
} catch (Exception e) {
	e.printStackTrace();
	dispatch("TbBoardError404.jsp", request, response);
}

			// 02. 저장여부 확인 및
		} else if (command.endsWith("/photostep2")) {

			Object file2 = request.getParameter("imgWho");
//          System.out.println("photostep2은 데이터를 자바로 보내는 공간입니다."+file2);

			Main main = new Main();
			// 저장된 값을 sendData로
			main.setPath(file2);
			String res = main.sendData();

//                    System.out.println(res);

			// 필요한 데이터 구간 찾기
			String cut01 = res.substring(res.indexOf("emotion"), res.indexOf("blur"));
			// 데이터 가공하기( {{{{}}}}->{"":""} )
			String cut02 = cut01.substring(9, cut01.length() - 2);

			// JSON형식으로 파서
			JSONParser parser01 = new JSONParser();

			try {
				// 위에서 가공한 값을 Object로 파서해서
				Object tmp = parser01.parse(cut02);
//              System.out.println(tmp instanceof Object);   //true      

	
				request.setAttribute("azure01", tmp);	//사진분석결과를 필요한 값만 가공한 변수
				request.setAttribute("imgWho", file2);  //사진 파일명
				dispatch("TbBoardImageUploadFormCheckResult.jsp", request, response);
			} catch (ParseException e) {
                System.out.println("JsonParser Error, 사진분석02.Servlet입니다.");
				e.printStackTrace();
				dispatch("TbBoardError404.jsp", request, response);
			}
		}
	}

	public void dispatch(String url, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);

	}

}