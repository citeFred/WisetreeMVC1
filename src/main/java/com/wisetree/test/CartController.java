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
	
	@PostMapping("/add")
	public String addItem(
			Model m,
			HttpSession ses,
			@RequestParam(defaultValue="0") int itemNo,
			@RequestParam(defaultValue="0") int count) {
			log.info("itemNo==="+itemNo+",count==="+count);
			
			if(itemNo==0||count==0) {
				return "redirect:../index";
			}
			
			UserVO loginUser=(UserVO)ses.getAttribute("loginUser");
			int idx_fk=loginUser.getIdx();
			
			CartVO cvo=new CartVO();
			cvo.setItemNo(itemNo);
			cvo.setCount(count);
			cvo.setIdx(idx_fk);
			
			return "redirect:cartList";	
	}
	
	@GetMapping("/cartList")
	public String cartList(Model m, HttpSession ses) {
		
		UserVO loginUser=(UserVO)ses.getAttribute("loginUser");
		int idx_fk=loginUser.getIdx();
		
		List<CartVO> cartArr=this.shopService.seeCartBasket(idx_fk);
		
		CartVO cvo=this.shopService.getCartTotalSum(idx_fk);
		
		m.addAttribute("cartArr",cartArr);
		m.addAttribute("TotalSum",cvo);
		
		return "cartList";
	}
	
	@PostMapping("/updatecart")
	public String cartEdit(@ModelAttribute("cvo") CartVO cvo) {
		log.info("cvo==="+cvo);
		
		shopService.updateCartCount(cvo);
		
		return "redirect:/cartList";
	}
	

}
