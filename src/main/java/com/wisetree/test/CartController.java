package com.wisetree.test;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.model.CartVO;
import com.shop.service.ShopService;
import com.user.model.UserVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cart")
@Log4j
public class CartController {
	
	@Inject
	ShopService shopService;
	
	@GetMapping("/add")
	public String cartList() {
		return "cartList";
	}
	@PostMapping("/add")
	public String addItem(
			Model m,
			HttpSession ses,@ModelAttribute CartVO cvo) {
			log.info("itemNo==="+cvo.getItemNo()+",count==="+cvo.getCount());
			
			if(cvo.getItemNo()==0||cvo.getCount()==0) {
				return "redirect:../index";
			}
			
			UserVO loginUser=(UserVO)ses.getAttribute("loginUser");
			int idx=loginUser.getIdx();
			
			
			cvo.setIdx(idx);
		
			
			int n=shopService.addCart(cvo);
			
			
			return "redirect:cartList";	
	}
	
	@GetMapping("/cartList")
	public String cartList(Model m, HttpSession ses) {
		
		UserVO loginUser=(UserVO)ses.getAttribute("loginUser");
		int idx=loginUser.getIdx();
		
		List<CartVO> cartArr=this.shopService.seeCartBasket(idx);
		
		int sum=this.shopService.getCartTotalSum(idx);
		
		m.addAttribute("cartArr",cartArr);
		m.addAttribute("sum",sum);
		
		return "cartList";
	}
	
	@PostMapping("/updatecart")
	public String cartEdit(@ModelAttribute("cvo") CartVO cvo) {
		log.info("cvo==="+cvo);
		
		shopService.updateCartCount(cvo);
		
		return "redirect:/cartList";
	}
	

}
