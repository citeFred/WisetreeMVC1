package com.shop.mapper;

import java.util.List;

import com.shop.model.ReviewVO;

public interface ReviewMapper {

	public int addReview(ReviewVO reviewvo);
	
	public List<ReviewVO> reviewList(int pnum_fk);
	
	public int getReviewCnt(int pnum_fk);
	
	public ReviewVO getReview(int num);
	
	public int updateReview(ReviewVO reviewvo);
	
	public int deleteReview(int num);
}
