package com.wisetree.test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.review.service.ReviewService;

/* RESTful API방식
 * - URI + 메서드 방식에 따라 처리 로직을 달리한다.
 *  /reviews/           GET  : 리뷰 목록을 조회
 *  /reviews/{num}      GET  : 특정(num번) 리뷰글을 조회
 *  /user/reviews       POST  : 리뷰 글쓰기 처리
 *  /user/reviews/{num} PUT   : 특정 리뷰글을 수정
 *  /user/reviews/{num} DELETE: 특정 리뷰글을 삭제
 *  
 *  --------------------------------------------------*/


@RestController
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	
	
}
