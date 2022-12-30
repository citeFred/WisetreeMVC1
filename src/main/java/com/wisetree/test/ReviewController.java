package com.wisetree.test;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//@RestController
@Controller
public class ReviewController {
	
	
	@RequestMapping("/review")
	public void review() {
		//"/WEB-INF/views/test.jsp				
	}
	
	/*
	 * @PostMapping("/test") public String testinsert() { return "test"; }
	 */
	
	@RequestMapping(value = "/reviewForm", method = RequestMethod.GET)
	public String reviewWrite(){
		
		return "review/reviewForm";
	}
	
	
	
	
	
}
