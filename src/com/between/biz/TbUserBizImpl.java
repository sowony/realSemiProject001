package com.between.biz;

import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import com.between.dao.TbUserDao;
import com.between.dao.TbUserDaoImpl;
import com.between.dto.TbBoardDto;
import com.between.dto.TbGroupDto;
import com.between.dto.TbUserDto;

public class TbUserBizImpl implements TbUserBiz{

	TbUserDao dao = new TbUserDaoImpl();

	//sns회원가입
	@Override
	public int snslongregister(TbUserDto dto) {
		// TODO Auto-generated method stub
		return dao.snslongregister(dto);
	}



	//sns아이디 체크하기 
	@Override
	public TbUserDto snsIdCheck(String userId) {
		// TODO Auto-generated method stub
		return dao.snsIdCheck(userId);
	}
	
	//파트너 아이디 혹은 이름 갖고오기 
	@Override
	public List<TbUserDto> partnerNickorName(int groupNum) {
		
		return dao.partnerNickorName(groupNum);
	}

	@Override
	//로그인 
	public TbUserDto login(String userId,String userPw) {
			return dao.login(userId, userPw) ;
		}

	//회원정보수정
	@Override
	public int userUpdate(TbUserDto dto) {
		return dao.userUpdate(dto);
	}

	//회원탈퇴
	@Override
	public int userDelete(String userId) {
		return dao.userDelete(userId);
	}

	//내 글목록 보기 
	@Override
	public List<TbBoardDto> userBoardList(String userId,int pageNum, int pageCount ) {
		return dao.userBoardList(userId,pageNum,pageCount);
	}
	
	
	//내 글 상세보기 
	@Override
	public TbBoardDto userBoardSelectOne(int boardNum) {
		return dao.userBoardSelectOne(boardNum);
	}

	//내글 수정하기 
	@Override
	public int userBoardUpdate(TbBoardDto dto) {
		return dao.userBoardUpdate(dto);
	}

	//내글 목록 찾기 
	@Override
	public List<TbBoardDto> userBoardSearch(String boardTitle, String userId) {
		
		return dao.userBoardSearch(boardTitle, userId);
	}

	//회원 글 삭제하기 multi
	@Override
	public int userBoardMultiDelete(String[] boardNum) {
		return dao.userBoardMultiDelete(boardNum);
	}

	//단일삭제 
	@Override
	public int userBoardDelete(int boardNum) {
		return dao.userBoardDelete(boardNum);
	}

	//나의 커플 확인 
	@Override
	public String partnerIdShow(int groupNum,String userId) {
		

		String bringUserId = dao.partnerIdShow(groupNum).getUserId();
		String bringPartnerId = dao.partnerIdShow(groupNum).getPartnerId();
		
		if(bringPartnerId.equals("N")) {
			return bringUserId;
		}else {

			if(userId.equals(bringUserId)) {
				return bringPartnerId;
			} else {
				return bringUserId;
			}
		}
		
	}

	//커플 그룹 맺기 ->파트너아이디 입력
	@Override
	public int partnerIdInsert(String partnerId, String userId) {
		return dao.partnerIdInsert(partnerId, userId);
	}

	//파트너 이름 수정 
	@Override
	public int partnerIdUpdate(String partnerId, int groupNum) {
		// TODO Auto-generated method stub
		return dao.partnerIdUpdate(partnerId, groupNum);
	}

	//마이페이지에서 : 자신이 상대방에 의하여 등록당했을 경우 알림창에서 yes눌렀을때 (확인창)
	@Override
	public int partnerIdInsertCheckO(int groupNum) {
		return dao.partnerIdInsertCheckO( groupNum);
	}

	//파트너를 등록했을 경우 유저테이블 - 커플 그룹번호 입력 
	@Override
	public int partnerIdInsertChekXnDelete(int groupNum) {
		return dao.partnerIdInsertChekXnDelete(groupNum);
	}
	//마이페이지에서 : 자신이 상대방에 의하여 등록당했을 경우 알림창에서 no눌렀을때 (확인창)
	//커플 삭제하기 -->버튼 
	@Override
	public int partnerNumUpdateUT(String userId) {
		// TODO Auto-generated method stub
		return dao.partnerNumUpdateUT(userId);
	}
	//커플 테이블 dto 더미 호출 
	@Override
	public TbGroupDto partnerDtoDummy(String userId) {
		// TODO Auto-generated method stub
		return dao.partnerDtoDummy(userId);
	}

	//유저테이블에서 커플넘버지우기 
	@Override
	public int partnerNumUpdateUTDelete(int groupNum) {
		// TODO Auto-generated method stub
		return dao.partnerNumUpdateUTDelete(groupNum);
	}

	//페이징 
	@Override
	public int countBoard(String userId) {
		// TODO Auto-generated method stub
		return dao.countBoard(userId);
	}







	

}
