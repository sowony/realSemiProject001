package com.between.dao;

import java.util.List;

import com.between.dto.TbBoardDto;
import com.between.dto.TbGroupDto;
import com.between.dto.TbUserDto;

public interface TbUserDao {


	//회원가입 , 아이디 중복 체크 , 유효성 검사 - 여정현

	//sns회원가입
	public int snslongregister(TbUserDto dto);
	
	//sns아이디 체크하기 
	public TbUserDto snsIdCheck(String userId);
	
	//파트너 이름 혹은 닉네임 불러오기 
	public List<TbUserDto> partnerNickorName(int groupNum);
	
	//로그인 
	public  TbUserDto login(String userId,String userPw) ;
	
	//회원정보 수정
	public int userUpdate(TbUserDto dto);
	
	//회원 탈퇴 -> 활동 y으로 변경
	public int userDelete(String userId);
	
	//페이징 카운트 보드 
	public int countBoard(String userId);
	
	//회원 글목록 보기 
	public List<TbBoardDto> userBoardList(String userId,int pageNum, int pageCount );

	//글 하나 선택시 
	public TbBoardDto userBoardSelectOne(int boardNum);
	
	//회원 글 수정하기 
	public int userBoardUpdate(TbBoardDto dto);
	
	//회원 글 찾기 
	public List<TbBoardDto> userBoardSearch(String boardTitle, String userId);
	
	//회원 글 삭제하기 multi
	public int userBoardMultiDelete(String[] boardNum);
	//단일삭제 
	public int userBoardDelete(int boardNum);

	//나의 커플 확인 
	public TbGroupDto partnerIdShow(int groupNum);
	
	//커플 그룹 맺기 ->파트너아이디 입력(최초 로그인시 파트너 이름 "N")
	public int partnerIdInsert (String partnerId, String userId );
	
	//파트너를 등록했을 경우 유저테이블 - 커플 그룹번호 입력 
	public int partnerNumUpdateUT(String userId);
	
	//파트너 이름 수정 
	public int partnerIdUpdate(String partnerId, int groupNum);
	
	//마이페이지에서 : 자신이 상대방에 의하여 등록당했을 경우 알림창에서 yes눌렀을때 (확인창)
	public int partnerIdInsertCheckO(int groupNum);
	
	//마이페이지에서 : 자신이 상대방에 의하여 등록당했을 경우 알림창에서 no눌렀을때 (확인창)
	//커플 삭제하기 -->버튼 
	public int partnerIdInsertChekXnDelete (int groupNum);
	
	//커플 테이블 dto 더미 호출 
	public TbGroupDto partnerDtoDummy(String userId);
	
	//유저테이블에서 커플넘버지우기 
	public int partnerNumUpdateUTDelete(int groupNum);
	

}
