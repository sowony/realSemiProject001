package com.between.dao;

import com.between.dto.TbGroupDto;

public interface TbChatDao {
	
	// 커플대화에 필요한 기능들
	public TbGroupDto checkGroup(int groupNum);

}
