package com.between.dao;

import org.apache.ibatis.session.SqlSession;

import com.between.common.SqlMapConfig;
import com.between.dto.TbUserDto;

public class TbRegistDaoImple extends SqlMapConfig implements TbRegistDao {

	private String namespace = "com.between.regist.mapper.";

	@Override
	public int insertUser(TbUserDto Dto) {

		SqlSession session = null;
		 
		int res = 0;

		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.insert(namespace + "insert", Dto);
		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			session.close();
		}

		return res;

	}

	public TbUserDto selectOne(String userId) {

		SqlSession session = null;
		TbUserDto res = null;

		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.selectOne(namespace + "selectOne", userId);
		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			session.close();
		}

		return res;

	}

	@Override
	public TbUserDto idChk(String userId) {

		SqlSession session = null;
		TbUserDto res = null;

		try {
			session = getSqlSessionFactory().openSession(true);
			res = session.selectOne(namespace + "selectOne", userId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

		return res;
	}

}
