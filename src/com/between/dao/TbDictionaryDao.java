package com.between.dao;

import java.util.List;

import com.between.dto.TbDictionaryDto;

public interface TbDictionaryDao {
	
	public List<TbDictionaryDto> selectList();
	public TbDictionaryDto searchKeyword(String keyword);
	public int insert(TbDictionaryDto dto);
	public int insertLike(TbDictionaryDto dto);
	public int updateLike(int dickNum);
	public int delete(TbDictionaryDto dto);
}
