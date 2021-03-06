package com.between.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.between.common.SqlMapConfig;
import com.between.dto.Criteria;
import com.between.dto.TbReBoardDto;

public class TbReBoardDaoImpl extends SqlMapConfig implements TbReBoardDao {

	String namespace = "com.between.TbReBoard.mapper.";
	// 해당 클래스는 보기에 많이 불편할 수 있음.. 함수이름을 안바꾸거나..
	
	@Override
	public List<TbReBoardDto> selectList(int pageNum, int pageCount, int boardNum) {
		//완
		SqlSession session = null;
		List<TbReBoardDto> list = new ArrayList<TbReBoardDto>();
		
		Criteria cri = new Criteria();
		cri.setPage(pageNum);
		cri.setPageCount(pageCount);
		cri.setBoardNum(boardNum);
		
		try {
			session = getSqlSessionFactory().openSession(true);
			list = session.selectList(namespace+"selectlist",cri);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return list;
	}

	@Override
	public int insertReBoard(TbReBoardDto dto) {
		//글작성
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.insert(namespace+"insertBoard",dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public int updateReBoard(TbReBoardDto dto) {
		//글수정
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.update(namespace+"updateBoard",dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}
	@Override
	public int checkGroupBoard(int boardNum) {
		//글삭제 하기 전 그룹작성글이 있는지 확인
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.selectOne(namespace+"checkGroupBoard",boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int updateBoardCheck(int boardNum) {
		//글삭제 (쿼리는 UPDATE)
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.update(namespace+"updateBoardCheck",boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}

	@Override
	public int deleteBoard(int boardGroupNum) {
		//글삭제 
		SqlSession session = null;
		int res = 0;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.delete(namespace+"deleteBoard",boardGroupNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return res;
	}
	

	@Override
	public int updateAnswer(int boardNum, int parentReNum) {
		//답글 탭번호 수정
		SqlSession session = null;
		int res = 0;
		
		TbReBoardDto dto = new TbReBoardDto();
		dto.setBoardNum(boardNum);
		dto.setReNum(parentReNum);
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.update(namespace+"updateAnswer",dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int insertAnswer(TbReBoardDto dto) {
		//답글 삽입
		SqlSession session = null;
		int res = 0;
		
		
		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.insert(namespace+"insertAnswer",dto);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int countBoard(int boardNum) {
		
		SqlSession session = null;
		int res = 0;
		
		session = getSqlSessionFactory().openSession(true);
		res = session.selectOne(namespace+"countBoard",boardNum);
		
		return res;
	}

	 
}
