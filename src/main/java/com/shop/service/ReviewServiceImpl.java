
package com.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.mapper.ReviewMapper;
import com.shop.model.ReviewVO;
@Repository
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired(required=true)
	private ReviewMapper reviewMapper;
	
	@Override
	public int addReview(ReviewVO reviewvo) {
		return this.reviewMapper.addReview(reviewvo);
	}

	@Override
	public List<ReviewVO> reviewList(int pnum_fk) {
		return this.reviewMapper.reviewList(pnum_fk);
	}

	@Override
	public int getReviewCnt(int pnum_fk) {
		return this.reviewMapper.getReviewCnt(pnum_fk);
	}

	@Override
	public ReviewVO getReview(int num) {
		return this.reviewMapper.getReview(num);
	}

	@Override
	public int updateReview(ReviewVO reviewvo) {
		return this.reviewMapper.updateReview(reviewvo);
	}

	@Override
	public int deleteReview(int num) {
		return this.reviewMapper.deleteReview(num);
	}

}
