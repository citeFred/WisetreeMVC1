package com.wisetree.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



//@RestController
@Controller
@RequestMapping("/review")
public class ReviewController {
	
	/*
	 * @Inject private ReviewService reviewService;
	 */
	
	@RequestMapping("/list")
	public String reList(){
		return "/review/reList";
	}
	
	@RequestMapping("/write")
	public String reWrite(){
		return "/review/reviewForm";
	}
	
	
	
	
	
}
