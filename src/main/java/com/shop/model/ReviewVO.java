package com.shop.model;

import lombok.Data;

@Data
public class ReviewVO {

	private int num;
	private String id;
	private String content;
	private int star;
	private String filename;
	private java.sql.Date wdate;
	private int pnum_fk;
}
