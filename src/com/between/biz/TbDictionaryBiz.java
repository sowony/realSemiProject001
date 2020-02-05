package com.between.biz;

import java.util.List;

import com.between.dto.TbDictionaryDto;

public interface TbDictionaryBiz {
	
	public List<TbDictionaryDto> selectList();
	public TbDictionaryDto searchKeyword(String keyword);
	public int insert(TbDictionaryDto dto);
	public int insertLike(TbDictionaryDto dto);
	public int delete(TbDictionaryDto dto);
	
	
}
