package com.between.dao;

import org.apache.ibatis.session.SqlSession;

import com.between.common.SqlMapConfig;
import com.between.dto.TbGroupDto;

public class TbChatDaoImpl extends SqlMapConfig implements TbChatDao {

		static String namespace = "com.between.TbChat.mapper.";
	@Override
	public TbGroupDto checkGroup(int groupNum) {
		SqlSession session = null;
		TbGroupDto dto = null;
		
		try {
			session = getSqlSessionFactory().openSession(true);
			dto = session.selectOne(namespace+"checkGroup",groupNum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return dto;
	}

}
