package com.shop.service;



import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.shop.mapper.AdminMapper;
import com.shop.model.ItemVO;
import com.shop.model.OptionVO;

import lombok.extern.log4j.Log4j;
import oracle.ucp.common.FailoverStats.Item;

@Service
@Log4j
public class AdminServiceImpl implements AdminService {
	
	@Inject
	private AdminMapper adminMapper;
	
	
	@Override
	public List<OptionVO> getUpOption() {
		return adminMapper.getUpOption();
	}

	@Override
	public List<OptionVO> getDownOption(Integer up_Code) {
		return adminMapper.getDownOption(up_Code);
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


