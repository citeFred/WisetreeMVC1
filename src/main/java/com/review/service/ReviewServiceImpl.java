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
	public int addReview(ReviewVO rvo) {
		return this.reviewMapper.addReview(rvo);
	}

	@Override
	public List<ReviewVO> listReview(int pnum_fk) {
		return this.reviewMapper.listReview(pnum_fk);
	}

	

}
