package com.between.biz;

import com.between.dao.TbChatDao;
import com.between.dao.TbChatDaoImpl;
import com.between.dto.TbGroupDto;

public class TbChatBizImpl implements TbChatBiz {
	
	TbChatDao dao = new TbChatDaoImpl();
	
	@Override
	public TbGroupDto checkGroup(int groupNum) {
		return dao.checkGroup(groupNum);
	}

}
