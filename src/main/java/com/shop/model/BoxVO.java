package com.shop.model;

import lombok.Data;

@Data
public class BoxVO {

	private int boxNum;
	private int unum_fk;
	private int pnum_fk;
	private int count;
	private java.sql.Date indate;
	
	private String ptname;
	private String ptimage1;
	private int price;
	private int saleprice;
	private int point;
	
	private int totalPrice;
	private int totalPoint;
	
	private int boxTotalPrice;
	private int boxTotalPoint;
	
	
}
