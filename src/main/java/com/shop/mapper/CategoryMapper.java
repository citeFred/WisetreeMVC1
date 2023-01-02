package com.shop.mapper;

import java.util.List;

import com.shop.model.OptionVO;

//datasource-context.xml에 mybatis-spring:scan설정하면 XXXMapper인터페이스를 구현한 객체(Proxy)를
//스프링이 대신 만들어준다
public interface CategoryMapper {
	
	public List<OptionVO> getUpOption();
	
	public List<OptionVO> getDownOption(Integer up_Code);
	
	public int categoryAdd(OptionVO vo);
	public int categoryDelete(OptionVO vo);
	
}
