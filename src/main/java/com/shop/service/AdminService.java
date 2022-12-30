package com.shop.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.shop.model.ItemVO;
import com.shop.model.OptionVO;

import oracle.ucp.common.FailoverStats.Item;

public interface AdminService {

	public List<OptionVO> getUpOption();//상위 카테고리 가져오기 
	
	public List<OptionVO> getDownOption(Integer up_Code);//하위 카테고리 가져오기
	
	public int optionAdd(OptionVO optionvo);//카테고리 추가
	public int optionDelete(int op_code);//카테고리 삭제
	
	public int register(ItemVO Item);//상품 등록하기

	public List<ItemVO> itemList();//상품 목록

}
