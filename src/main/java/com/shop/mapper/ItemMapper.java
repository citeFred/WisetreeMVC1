package com.shop.mapper;

import java.util.List;

import com.shop.model.ItemVO;

public interface ItemMapper {
	
	int register(ItemVO Item);

	List<ItemVO> getItem();
	
	List<ItemVO> selectByQty(String quality);// <---------- ? 
	//List<ItemVO> selectByPspec(String pspec);// 프러덕트 컨트롤 
	List<ItemVO> selectByOption(int op_num);
	List<ItemVO> itemList();
	ItemVO selectByitemNum(int itemNo);
	
	int removeByitemNo(int itemNo);
	int modifyItem(ItemVO Item);

}
