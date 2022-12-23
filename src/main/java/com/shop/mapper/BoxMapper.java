package com.shop.mapper;

import java.util.List;
import java.util.Map;

import com.shop.model.BoxVO;

public interface BoxMapper {

	Integer selectBoxCountByPidx(BoxVO Box);
	
	int addBox(BoxVO Box);
	int updateBoxCount(BoxVO Box);
	int editBox(BoxVO Box);
	List<BoxVO> selectBoxlist(int uidx);
	
	int delBox(int boxNum);
	int delBoxClear(BoxVO Box);
	
	BoxVO getTotalBoxfee(int mnum_fk);
}
