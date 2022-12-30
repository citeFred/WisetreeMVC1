package com.shop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.shop.model.ItemVO;
import com.shop.model.OptionVO;

public interface AdminMapper {
	
	public int register(ItemVO Item);
	
	public List<ItemVO> itemList();
	
	public List<OptionVO> getUpOption();
	
	public List<OptionVO> getDownOption(Integer up_Code);
	
	public int optionAdd(OptionVO optionvo);
	public int optionDelete(int op_code);
	
	
}
