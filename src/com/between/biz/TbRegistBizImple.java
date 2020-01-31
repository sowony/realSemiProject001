package com.between.biz;

import com.between.dao.TbRegistDao;
import com.between.dao.TbRegistDaoImple;
import com.between.dto.TbUserDto;

public class TbRegistBizImple implements TbRegistBiz {

	TbRegistDao dao = new TbRegistDaoImple();

	@Override
	public int TbUserDto(TbUserDto dto) {

		return dao.insertUser(dto);
	}

	@Override
	public TbUserDto selectOne(String userId) {

		return dao.selectOne(userId);
	}

	@Override
	public TbUserDto idChk(String userId) {

		return dao.idChk(userId);
	}

}
