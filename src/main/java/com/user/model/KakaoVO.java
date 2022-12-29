package com.user.model;

import lombok.Data;

@Data
public class KakaoVO {

	private long k_number;
	private String k_name;
	private String k_email;
	
	private String post;
	private String addr1,addr2;
	private java.sql.Date indate;
	private int mileage ;
	private int status ; //회원상태 :0(일반회원), -1(정지회원), -2(탈퇴회원)
	private String statusStr;
}