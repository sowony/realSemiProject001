package com.between.dao;

import com.between.dto.TbUserDto;

public interface TbRegistDao {

	public int insertUser(TbUserDto Dto);
	public TbUserDto selectOne(String userId);
	public TbUserDto idChk(String userId);
 
 
}
