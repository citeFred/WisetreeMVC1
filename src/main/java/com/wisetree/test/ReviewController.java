package com.wisetree.test;




import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


//@RestController
@Controller
public class ReviewController {
	
	
	@GetMapping("/review")
	public String review(){
			
			return "review/reviewList";
	}
	@PostMapping("/review")
	public String reviewend(){
			
			return "review/reviewList";
	}
	

	
	@GetMapping(value = "/reviewForm")
	public String reviewWrite(){
		
		return "review/reviewForm";
	}
	
	
	
	
	
}
