package com.shop.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.shop.mapper.BoxMapper;
import com.shop.mapper.ItemMapper;
import com.shop.model.BoxVO;
import com.shop.model.ItemVO;


@Service
public class ShopServiceImpl implements ShopService {
	
	@Autowired
	private ItemMapper itemMapper;

	@Autowired
	private BoxMapper boxMapper;
	

	@Override
	public List<ItemVO> selectByOption(int op_num) {
		return this.itemMapper.selectByOption(op_num);
	}

	@Override
	public ItemVO selectByPidx(int pidx) {
		return this.itemMapper.selectByPidx(pidx);
	}

	@Override
	public int addBox(BoxVO Box) {
		return this.boxMapper.addBox(Box);
	}

	@Override
	public int updateBox(BoxVO Box) {
		return this.boxMapper.updateBoxCount(Box);
	}

	@Override
	public int editBox(BoxVO Box) {
		return this.boxMapper.editBox(Box);
	}

	@Override
	public List<BoxVO> selectBoxlist(int uidx) {
		return this.boxMapper.selectBoxlist(uidx);
	}

	@Override
	public int delBox(int boxNum) {
		return this.boxMapper.delBox(boxNum);
	}

	@Override
	public int delBoxClear(BoxVO Box) {
		return this.boxMapper.delBoxClear(Box);
	}

	@Override
	public int delBoxOrder(Map<String, Integer> map) {
		return 0;
	}

	@Override
	public int getBoxcountByIdx(BoxVO Box) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public BoxVO getTotalBoxfee(int mnum_fk) {
		return this.boxMapper.getTotalBoxfee(mnum_fk);
	}

	@Override
	public void delOrder(int mnum_fk, int pidx) {
		// TODO Auto-generated method stub

	}

}
