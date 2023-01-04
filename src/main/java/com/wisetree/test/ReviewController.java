package com.wisetree.test;




import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.model.ItemVO;
import com.shop.service.ShopService;



//@RestController
@Controller
public class ReviewController {
	
	/*
	 * @Inject ShopService shopService;
	 */
	
	@GetMapping("/review")
	public String review(){
			
			return "review/reviewList2";
	}
	@PostMapping("/review")
	public String reviewend(){
			
			return "review/reviewList2";
	}
	

	
	@GetMapping(value = "/reviewForm")
	public String reviewWrite(){
		
		return "review/reviewForm";
	}
	
	/*
	 * @GetMapping("/prodDetail") public String productDetail(Model
	 * m, @RequestParam(defaultValue = "0")int ItemNo, HttpSession ses) { if
	 * (ItemNo==0) { return "redirect:index"; } ses.setAttribute("ItemNo", ItemNo);
	 * ItemVO vo=this.shopService.selectByitemNum(ItemNo);
	 * m.addAttribute("prod",vo); return "review/prodDetail"; }
	 */
	
	
	
	
	
}
