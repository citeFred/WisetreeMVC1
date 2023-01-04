package com.review.model;

import lombok.Data;

@Data
public class ReviewVO {
	
	/* 리뷰 번호 */
	private int renum;
	
	/* 회원 계정 */
	private String userid;
	
	/* 리뷰 내용 */
	private String content;
	
	/* 리뷰 점수 */
	private int score;
	
	/* 첨부 파일 */
	private String refilename;
	
	/* 등록 날짜 */
	private java.sql.Date wdate;
	
	/* 상품 번호 */
	private int itemno_fk;
}
