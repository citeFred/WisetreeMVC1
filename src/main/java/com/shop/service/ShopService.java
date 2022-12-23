package com.shop.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.shop.model.BoxVO;
import com.shop.model.ItemVO;

public interface ShopService {

	/*상품정보*/

	public List<ItemVO> selectByOption(int op_num);
	
	public ItemVO selectByPidx(int pidx);
//장바구니 정보

	int addBox(BoxVO Box);
	int updateBox(BoxVO Box);
	int editBox(BoxVO Box);
	List<BoxVO> selectBoxlist(int uidx);
	
	int delBox(int boxNum);
	int delBoxClear(BoxVO Box);
	int delBoxOrder(Map<String,Integer>map);
	
	int getBoxcountByIdx(BoxVO Box);
	
	BoxVO getTotalBoxfee(int mnum_fk);
	
	public void delOrder(int mnum_fk, int pidx);
}