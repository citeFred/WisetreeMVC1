package com.shop.mapper;

import java.util.List;

import com.shop.model.OptionVO;

public interface OptionMapper {

	public List<OptionVO> getUpOption();
	
	public List<OptionVO> getDownOption();
	
	public int optionAdd(OptionVO optionvo);
	public int optionDelete(int op_code);
}
