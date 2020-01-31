package com.between.biz;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import com.between.dao.TbCalDao;
import com.between.dao.TbCalDaoImpl;
import com.between.dto.TbCalDto;
import com.between.dto.TbGroupDto;
import com.between.dto.TbUserDto;

public class TbCalBizImpl implements TbCalBiz {
	
	TbCalDao dao = new TbCalDaoImpl();
	
	private String todates;
	
	public String getTodates() {
		return todates;
	}
	
	@Override
	public List<TbCalDto> selectCalList(String calTime, int groupNum) {
		return dao.selectCalList(calTime, groupNum);
	}

	@Override
	public TbCalDto selectOne(int calNum, int groupNum) {
		return dao.selectOne(calNum, groupNum);
	}

	@Override
	public int insertEvent(TbCalDto dto) {
		return dao.insertEvent(dto);
	}

	@Override
	public int updateEvent(TbCalDto dto) {
		return dao.updateEvent(dto);
	}
	
	
	@Override
	public void setTodates(String calTime) {
		// yyyy-MM-dd hh:mm:ss
		String m = calTime.substring(0,4) + "-" +
				calTime.substring(4,6) + "-" +
				calTime.substring(6,8) + " " +
				calTime.substring(8,10) + ":" +
				calTime.substring(10) + ":00";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		Timestamp tm = Timestamp.valueOf(m);
		todates = sdf.format(tm);
	}

	@Override
	public String isTwo(String msg) {
		//한자리수를 두자리수로 변환
		return (msg.length()<2)?"0"+msg:msg;
	}

	@Override
	public String fontColor(int date, int dayOfWeek) {
		String color = "";
		
		if((dayOfWeek-1+date)%7==0) {
			color = "#014d8f";
		} else if((dayOfWeek-1+date)%7==1) {
			color = "#1a4b76";
		} else {
			color = "#483d8b";
		}
		return color;
	}

	@Override
	public String getCalView(int i, List<TbCalDto> clist) {
		String d = isTwo(i+"");
		String res = "";
		
		for(TbCalDto dto : clist) {
			if(dto.getCalTime().substring(6, 8).equals(d)) {
				res += "<p>"
						+ ((dto.getCalTitle().length() > 6) ?
								dto.getCalTitle().substring(0,6)+"..." :
									dto.getCalTitle())
						+"</p>";
			}
		}
		
		return res;
	}

	@Override
	public TbGroupDto findPartner(int groupNum) {
		return dao.findPartner(groupNum);
	}

	@Override
	public int deleteEvent(String[] seq) {
		
		return dao.deleteEvent(seq);
	}

	@Override
	public TbCalDto selectDday(String calTitle, int groupNum) {
		return dao.selectDday(calTitle, groupNum);
	}

	@Override
	public int deleteOne(TbCalDto dto) {
		return dao.deleteOne(dto);
	}
	
	@Override
	public String setTimeOnly(String calTime) {
		String time = calTime.substring(8, 10) + "시" + calTime.substring(10, 12) + "분";
		
		return time;
	}
	
}
