package com.shop.mapper;

import java.util.List;


import com.shop.model.ItemVO;

public interface ItemMapper {
	
	int register(ItemVO Item);

	List<ItemVO> getItem();
	
	List<ItemVO>selectByQty(String quality);
	List<ItemVO> selectByOption(int op_num);
	
	public ItemVO selectByPidx(int pidx);
}
