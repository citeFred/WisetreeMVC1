package com.shop.model;

import lombok.Data;

@Data
public class ItemVO {

	private int up_Code;
	private String up_Name;

	private int down_Code;
	private String down_Name;

	private int ItemNo;
	private String itemName;
	private String itemImage1;
	private String itemImage2;
	private String itemImage3;

	private int price;
	private int saleprice;
	private int point;
	private int count;

	private String quality;
	private String itemInfo;
	private String itemBrand;
	private java.sql.Date itemIndate;

	private int totalPrice;
	private int totalPoint;

	private String ordernum;

	public void setCount(int count) {
		this.count = count;
		this.totalPrice = this.saleprice * this.count;
		this.totalPoint = this.point * this.count;
	}

	public int getDCPercent() {
		int dcpercent = (price - saleprice) * 100 / price;
		return dcpercent;
	}
}