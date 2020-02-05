package com.between.biz;

import java.util.List;

import com.between.common.SqlMapConfig;
import com.between.dao.TbDictionaryDao;
import com.between.dao.TbDictionaryDaoImpl;
import com.between.dto.TbDictionaryDto;

public class TbDictionaryBizImpl extends SqlMapConfig implements TbDictionaryBiz {

	TbDictionaryDao dao = new TbDictionaryDaoImpl();
	
	@Override
	public List<TbDictionaryDto> selectList() {
		return dao.selectList();
	}

	@Override
	public TbDictionaryDto searchKeyword(String keyword) {
		return dao.searchKeyword(keyword);
	}

	@Override
	public int insert(TbDictionaryDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int insertLike(TbDictionaryDto dto) {
		
		int res = 0;
		
		int insertLike = dao.insertLike(dto);
		if(insertLike>0) {
			int updateLike = dao.updateLike(dto.getDicNum());
			if(updateLike>0) {
				res = updateLike;
			}
		} 
		
		return res;
	}


	@Override
	public int delete(TbDictionaryDto dto) {
		return dao.delete(dto);
	}

}
