package com.shop.model;

import lombok.Data;

@Data
public class CartVO {
	
	private int cartNum; //장바구니 번호
	private int idx_fk; //회원 번호
	private int pnum_fk; //상품 번호 
	private int oqty; //수량 
	private java.sql.Date indate;
	
	//장바구니안 상품 정보 
	private String itemName;
	private String itemImage1;
	
	private int price;
	private int saleprice;
	
	private int totalPrice; //saleprice*count =>상품 당 총가격합계 
	
	private int carttotalPrice; //장바구니 총액 합계 

}
