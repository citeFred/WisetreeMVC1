package com.review.service;

import java.util.List;

import com.review.model.ReviewVO;


public interface ReviewService {
	
	/* 리뷰 추가 */
	public int  addReview(ReviewVO rvo);
	
	/* 리뷰 목록 */
	public List<ReviewVO> listReview(int pnum_fk);
	
	
}
