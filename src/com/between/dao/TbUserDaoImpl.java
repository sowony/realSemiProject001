package com.between.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.between.common.SqlMapConfig;
import com.between.dto.Criteria;
import com.between.dto.TbBoardDto;
import com.between.dto.TbGroupDto;
import com.between.dto.TbUserDto;

public class TbUserDaoImpl extends SqlMapConfig implements TbUserDao{
	private String usernamespace = "com.between.TbUser.mapper.";

	
	//sns회원가입
	@Override
	public int snslongregister(TbUserDto dto) {
		SqlSession session = null; 
		int res= 0 ;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.insert(usernamespace+"snslongregister",dto);
		} catch (Exception e) {
			System.out.println("sns회원가입했을때 오류 - 다오");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}



	
	//sns아이디 체크하기 
	@Override
	public TbUserDto snsIdCheck(String userId) {
		SqlSession session = null; 
		TbUserDto dto = null; 
		System.out.println("여기는 다오 sns 아이디 체크체크"+userId);
		//		Map<String, String> map = new HashMap<String, String>();
//		map.put("userId", userId);
//		System.out.println("여기는 sns아이디 체크하기 부분에 userId넘어왔나?"+map.get(userId));
//		
		try {
			session = getSqlSessionFactory().openSession(true);
			dto = session.selectOne(usernamespace+"snsIdCheck",userId);
		} catch (Exception e) {
			System.out.println("sns아디이 체크하기 오류 - 다오");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return dto;
	}
	
	//파트너 닉네임 혹은 아이디 갖고오기 
	@Override
	public List<TbUserDto> partnerNickorName(int groupNum) {
		SqlSession session =  null;
		List<TbUserDto> list = null ; 
		
		try {
			session = getSqlSessionFactory().openSession(true);
			list = session.selectList(usernamespace+"partnerNickorName",groupNum);
		} catch (Exception e) {
			System.out.println("파트너 닉네임 혹은 아이디 갖고오기 오류 - 다오");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return list;
	}

	//로그인
	@Override
	public TbUserDto login(String userId, String userPw) {
		SqlSession session = null; 
		TbUserDto dto = new TbUserDto();
		dto.setUserId(userId);
		dto.setUserPw(userPw);
		
		try {
			session = getSqlSessionFactory().openSession(true);
			dto = session.selectOne(usernamespace+"login",dto);
		} catch (Exception e) {
			System.out.println("에러 login");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return dto;
	}

	//유저정보 업데이트
	@Override
	public int userUpdate(TbUserDto dto) {
		SqlSession session = null; 
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.insert(usernamespace + "userUpdate",dto);
			
		} catch (Exception e) {
			System.out.println("에러 insert");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res ;
	}

	//유저탈퇴 
	@Override
	public int userDelete(String userId) {
		SqlSession session = null; 
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.delete(usernamespace+"userDelete",userId);
		} catch (Exception e) {
			System.out.println("에러 delete");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res; 
	}

	//내 글 목록 보기 
	@Override
	public List<TbBoardDto> userBoardList(String userId,int pageNum, int pageCount ) {
		
		SqlSession session = null; 
		List<TbBoardDto> list = null;
		
		Criteria cri = new Criteria();
		cri.setPage(pageNum);
		cri.setPageCount(pageCount);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("cri",cri);
		
		try {
			session = getSqlSessionFactory().openSession(true);
			list = session.selectList(usernamespace+"userBoardList",map);
			//System.out.println("여기는 보드리스트 "+list);
		} catch (Exception e) {
			System.out.println("에러 userBoardList ");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		
		return list;
	}
	
	

	//내 글 상세보기 
	@Override
	public TbBoardDto userBoardSelectOne(int boardNum) {
		
		SqlSession session = null; 
		TbBoardDto dto = null; 
		
		try {
			session = getSqlSessionFactory().openSession(true);
			dto = session.selectOne(usernamespace+"userBoardSelectOne",boardNum);
		} catch (Exception e) {
			System.out.println("에러 유저의 글하나 보기 ");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		
		return dto;
	}
	
	
		
	//내 글 수정  
	@Override
	public int userBoardUpdate(TbBoardDto dto) {
		SqlSession session = null; 
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.update(usernamespace+"userBoardUpdate",dto);
		} catch (Exception e) {
			System.out.println("에러 글 업데이트");
			e.printStackTrace();
		}
		
		return res;
	}

	//내 글 목록 찾기 
	@Override
	public List<TbBoardDto> userBoardSearch(String boardTitle, String userId) {
		SqlSession session = null; 
		List<TbBoardDto> list = null; 
		Map<String, String> map = new HashMap<String, String>();
		map.put("boardTitle", boardTitle);
		map.put("userId", userId);
		//System.out.println("글검색 다오"+boardTitle+"으아ㅏㅇ"+userId);
		
		try {
			session = getSqlSessionFactory().openSession(false);
			list = session.selectList(usernamespace+"userBoardSearch",map);
			//System.out.println(list+"내글목록을 에러를 잡아보자 ㄴ");
		} catch (Exception e) {
			System.out.println("글검색 에러");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return list;
	}

	//내글 다중 삭제
	@Override
	public int userBoardMultiDelete(String[] boardNum) {
		SqlSession session = null; 
		int res = 0; 
		
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("boardNums", boardNum);
		
		try {
			session = getSqlSessionFactory().openSession(false);
			res = session.delete(usernamespace+"userBoardMultiDelete",map);
			if(res == boardNum.length) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("에러 다중 삭제에서 ....");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}

	//내글 하나만 삭제
	@Override
	public int userBoardDelete(int boardNum) {
		SqlSession session = null; 
		int res =0; 
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.delete(usernamespace+"userBoardDelete",boardNum);
		} catch (Exception e) {
			System.out.println("에러 단일 삭제 ....");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}

	//나의 커플 확인
	@Override
	public TbGroupDto partnerIdShow(int groupNum) {
		SqlSession session = null; 
		TbGroupDto dto = null; 
		
		try {
			session = getSqlSessionFactory().openSession(true);
			dto = session.selectOne(usernamespace+"partnerIdShow",groupNum);
		} catch (Exception e) {
			System.out.println("나의 커플확인 에러 -다오");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return dto;
	}

	//커플 그룹 맺기 ->파트너아이디 입력(최초 로그인시 파트너 이름 "N")
	@Override
	public int partnerIdInsert(String partnerId, String userId) {
		SqlSession session = null; 
		Map<String, String> map = new HashMap<String, String>();
		map.put("partnerId", partnerId);
		map.put("userId", userId);
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.update(usernamespace+"partnerIdInsert",map);
		} catch (Exception e) {
			System.out.println("커플그룹맺기 -> 파트너아이디 입력 에러 -다오");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}
	
	//파트너를 등록했을 경우 유저테이블 - 커플 그룹번호 입력 
	
	@Override
	public int partnerNumUpdateUT(String userId) {

		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.update(usernamespace+"partnerNumUpdateUT",userId);
		} catch (Exception e) {
			System.out.println("파트너 생성뒤 자신의 유저테이블 파트너 넘버 등록 에러 -다오");
			e.printStackTrace();
		}
		
		return res;
	}

	

	////파트너 이름 수정 
	@Override
	public int partnerIdUpdate(String partnerId, int groupNum) {
		SqlSession session = null; 
		TbGroupDto dto = new TbGroupDto();
		dto.setPartnerId(partnerId);
		dto.setGroupNum(groupNum);
		int res = 0; 
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.insert(usernamespace+"partnerIdUpdate",dto);
		} catch (Exception e) {
			System.out.println("파트너이름 수정 에러 - 다오");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}


	//마이페이지에서 : 자신이 상대방에 의하여 등록당했을 경우 알림창에서 yes눌렀을때 (확인창)
	@Override
	public int partnerIdInsertCheckO( int groupNum) {
		SqlSession session = null; 
/*		TbGroupDto dto = new TbGroupDto();
		dto.setPartnerId(partnerId);
		dto.setGroupNum(groupNum);*/
		
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.update(usernamespace+"partnerIdInsertCheckO",groupNum);
		} catch (Exception e) {
			System.out.println("마이페이지에서 자신이 상대방에게 등록 당했을때, 수락했을 때 에러남 -다오");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}

	//마이페이지에서 : 자신이 상대방에 의하여 등록당했을 경우 알림창에서 no눌렀을때 (확인창)
	//커플 삭제하기 -->버튼 
	@Override
	public int partnerIdInsertChekXnDelete(int groupNum) {
		SqlSession session = null; 
		int res = 0; 
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.delete(usernamespace+"partnerIdInsertChekXnDelete",groupNum);
		} catch (Exception e) {
			System.out.println("마이페이지에서 자신이 상대방에게 등록 당했을때, 거절했을 때 에러남 -다오");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}
	

	

	//커플그룹 dto더미 만들기 
	@Override
	public TbGroupDto partnerDtoDummy(String userId) {
		SqlSession session = null; 
		TbGroupDto dto = null; 
		
		try {
			session = getSqlSessionFactory().openSession(true);
			dto = session.selectOne(usernamespace+"partnerDtoDummy",userId);
		} catch (Exception e) {
			System.out.println("커플 테이블 더미 데이터 불러오기 실패 - 다오 ");
			e.printStackTrace();
		}finally{
			session.close();
		}
		
		
		return dto;
	}

	//유저테이블에서 커플넘버 null값으로 바꾸기 
	@Override
	public int partnerNumUpdateUTDelete(int groupNum) {
		SqlSession session = null; 
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.update(usernamespace+"partnerNumUpdateUTDelete",groupNum);
		} catch (Exception e) {
			System.out.println("파트너 넘버를 유저테이블에서 null값으로 바꾸기 에러남 - 다오");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return res;
	}

	//페이징
	@Override
	public int countBoard(String userId) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.selectOne(usernamespace+"countBoard",userId);
		} catch (Exception e) {
			System.out.println("페이징 오류 - 다오 ");
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		
		return res;
	}







	


		
	
	


}
