package com.user.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserVO {
	private int idx;
	private String name;
	private String userid;
	private String pwd;
	private String hp1,hp2,hp3;
	private String post;
	private String addr1,addr2;
	private java.sql.Date indate;
	private int mileage ;
	private int status ; //회원상태 :0(일반회원), -1(정지회원), -2(탈퇴회원)
	private String statusStr;
	private String email;
	
	public String getAllHp() {
		return hp1+"-"+hp2+"-"+hp3;
	}
	public String getAllAddr() {
		return "["+post+"] "+addr1+" "+addr2;
	}
}
