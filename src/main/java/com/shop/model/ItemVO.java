package com.shop.model;

import lombok.Data;

@Data
public class ItemVO {

	private int up_Code;
	private String up_Name;

	private int down_Code;
	private String down_Name;

	private int itemNo;
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
	
	private String originFilename1;
	private String originFilename2;
	private String originFilename3;
	private String old_filename1;
	private String old_filename2;
	private String old_filename3;
	
	public void setCount(int count) {
		this.count = count;
		this.totalPrice = this.saleprice * this.count;
		this.totalPoint = this.point * this.count;
	}

	/*할인율을 반환하는 메서드*/
	public int getPercent() {
		//(정가-판매가)*100/정가
		int percent=(price-saleprice)*100/price;
		return percent;
	}
}