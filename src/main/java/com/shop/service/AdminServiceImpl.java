package com.shop.service;



import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.shop.mapper.AdminMapper;
import com.shop.mapper.CategoryMapper;
import com.shop.model.ItemVO;
import com.shop.model.OptionVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminServiceImpl implements AdminService {
	
	@Inject
	private AdminMapper adminMapper;
	
	@Inject
	private CategoryMapper categoryMapper;
	
	
	@Override
	public List<OptionVO> getUpOption() {
		return categoryMapper.getUpOption();
	}

	@Override
	public List<OptionVO> getDownOption(Integer up_Code) {
		return categoryMapper.getDownOption(up_Code);
	}

	@Override
	public int optionAdd(OptionVO optionvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int optionDelete(int op_code) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int register(ItemVO Item) {
		
		log.info("register....."+Item);
		return adminMapper.register(Item);
	}

	@Override
	public List<ItemVO> itemList() {
		log.info("itemList.......");
		return adminMapper.itemList();
	}



	
}


