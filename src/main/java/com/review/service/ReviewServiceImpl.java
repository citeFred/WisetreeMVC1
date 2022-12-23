package com.review.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.review.mapper.ReviewMapper;
import com.review.model.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	private ReviewMapper reviewMapper;
	
	@Override
	public int addReview(ReviewVO revo) {
		return this.reviewMapper.addReview(revo);
	}

	@Override
	public List<ReviewVO> listReview(int pnum_fk) {
		return this.reviewMapper.listReview(pnum_fk);
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
	public int upReview(ReviewVO revo) {
		return this.reviewMapper.upReview(revo);
	}

	@Override
	public int delReview(int num) {
		return this.reviewMapper.delReview(num);
	}

}
