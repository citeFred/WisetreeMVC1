package com.wisetree.test;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.review.service.ReviewService;



//@RestController
@Controller
public class ReviewController {
	
	@Inject
	private ReviewService reviewService;
	
	@RequestMapping(value = "/reviewList", method = {RequestMethod.GET, RequestMethod.POST})
	public String reList(){
		System.out.println("lissssssssttttttt");
		return "review/reList";
	}
	
	@RequestMapping(value = "/reviewForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String reWrite(){
		System.out.println("wirttttttttt");
		return "review/reviewForm";
	}
	
	
	
	
	
}
