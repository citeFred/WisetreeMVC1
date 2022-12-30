package com.shop.service;

import java.util.List;

import com.shop.model.ItemVO;

public interface ShopService {

	/*상품정보*/

	public List<ItemVO> selectByOption(int op_num);
	
	public ItemVO selectByitemNum(int itemNum);
	
	int register(ItemVO Item);
//장바구니 정보

	
	
	public void delOrder(int mnum_fk, int pidx);
}