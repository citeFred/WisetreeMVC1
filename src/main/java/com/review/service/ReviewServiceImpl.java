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
	public List<ReviewVO> listReview(int itemno_fk) {
		return this.reviewMapper.listReview(itemno_fk);
	}

	@Override
	public int getReviewCnt(int itemno_fk) {
		return this.reviewMapper.getReviewCnt(itemno_fk);
	}

	@Override
	public ReviewVO getReview(int renum) {
		return this.reviewMapper.getReview(renum);
	}

	@Override
	public int upReview(ReviewVO revo) {
		return this.reviewMapper.upReview(revo);
	}

	@Override
	public int delReview(int renum) {
		return this.reviewMapper.delReview(renum);
	}

	@Override
	public int getReviewavg(Integer itemNo) {
		return this.reviewMapper.getReviewavg(itemNo);
	}

}
