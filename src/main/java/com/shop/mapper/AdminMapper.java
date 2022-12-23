package com.shop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.shop.model.ItemVO;

public interface AdminMapper {
	
	public int register(ItemVO Item);
	
	public List<ItemVO> itemList();
}
