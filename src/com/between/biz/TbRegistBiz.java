package com.between.biz;

import com.between.dto.TbUserDto;

public interface TbRegistBiz {

	public int TbUserDto(TbUserDto dto);
	public TbUserDto selectOne(String userId);
	public TbUserDto idChk(String userId);
	 
}
