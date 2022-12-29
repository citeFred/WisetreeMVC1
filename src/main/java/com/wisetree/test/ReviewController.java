package com.wisetree.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



//@RestController
@Controller
public class ReviewController {
	
	/*
	 * @Inject private ReviewService reviewService;
	 */
	
	@RequestMapping(value = "review/list", method = {RequestMethod.GET, RequestMethod.POST})
	public String reList(){
		return "/review/reList";
	}
	
	@RequestMapping(value = "review/write", method = {RequestMethod.GET, RequestMethod.POST})
	public String reWrite(){
		return "/review/reviewForm";
	}
	
	
	
	
	
}
