package com.review.mapper; 

import java.util.List;

import com.review.model.ReviewVO;


public interface ReviewMapper {
	
	/* 리뷰 추가 */
	public int addReview(ReviewVO revo);
	
	/* 리뷰 목록 */
	public List<ReviewVO> listReview(int pidx_fk);

	/* 상품 번호 받기 */
	public int getReviewCnt(int pidx_fk);

	/* 리뷰 얻기 */
	public ReviewVO getReview(int renum);
	
	/* 리뷰 수정 */
	public int upReview(ReviewVO revo);
	
	/* 리뷰 삭제 */
	public int delReview(int renum);
	
}
