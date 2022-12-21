package com.review.mapper;

import java.util.List;

import com.review.model.ReviewVO;


public interface ReviewMapper {
	
	/* 리뷰 추가 */
	public int addReview(ReviewVO rvo);
	
	/* 리뷰 목록 */
	public List<ReviewVO> listReview(int pnum_fk);

	
	
}
