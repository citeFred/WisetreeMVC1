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
			Model m, HttpSession ses,
			@RequestParam(defaultValue="0")int itemNo,
			@RequestParam(defaultValue="0")int oqty) {
		if(itemNo==0|| oqty==0) {
			System.out.println("ddddd");
//			return "redirect:../index";
		}
			UserVO loginUser=(UserVO)ses.getAttribute("loginUser");
			int idx=loginUser.getIdx();
			
			CartVO cvo=new CartVO();
			cvo.setPnum_fk(itemNo);
			cvo.setOqty(oqty);

			
			cvo.setIdx_fk(idx);
			log.info("cvo==="+cvo);
			
			int n=shopService.addCart(cvo);
			
			
			return "redirect:cartList";	
	}
	
	@GetMapping("/cartList")
	public String cartList(Model m, HttpSession ses) {
		
		UserVO loginUser=(UserVO)ses.getAttribute("loginUser");
//		log.info("user:" +loginUser);
//		if (loginUser.getIdx()==0) {
//			
//			return "redirect:/index";
//		}
		int idx=loginUser.getIdx();
		
		List<CartVO> cartArr=this.shopService.seeCartBasket(idx);
		
		int sum=this.shopService.getCartTotalSum(idx);
		
		m.addAttribute("cartArr",cartArr);
		m.addAttribute("sum",sum);
		
		return "cartList";
	}
	
	@PostMapping("/cartEdit")
	public String cartEdit(@ModelAttribute("cvo") CartVO cvo) {
		log.info("cvo==="+cvo);
		
		shopService.updateCartCount(cvo);
		
		return "redirect:cartList";
	}
	
	@PostMapping("/cartDel")
	public String cardDelete(@RequestParam(defaultValue = "0") int cartNum) {
		if (cartNum == 0) {
			return "redirect:cartList";
		}
		int n = shopService.deleteCart(cartNum);
		return "redirect:cartList";
	}

	
	@PostMapping("/orderList")
	public String orderList(Model m, HttpSession ses) {
		
		UserVO loginUser=(UserVO)ses.getAttribute("loginUser");
//		log.info("user:" +loginUser);
//		if (loginUser.getIdx()==0) {
//			
//			return "redirect:/index";
//		}
		int idx=loginUser.getIdx();
		
		List<CartVO> cartArr=this.shopService.seeCartBasket(idx);
		
		int sum=this.shopService.getCartTotalSum(idx);
		
		m.addAttribute("cartArr",cartArr);
		m.addAttribute("sum",sum);
		
		return "order";
	}
	

}
