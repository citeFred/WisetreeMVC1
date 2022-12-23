package com.wisetree.test;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.model.ItemVO;
import com.shop.service.ShopService;

@Controller
public class ItemController {
	
	@Inject
	private ShopService shopService;
	
	@GetMapping("/itemDetail")
	public String ItemInform(Model m, @RequestParam(defaultValue="0") int pidx, HttpSession ses) {
		if(pidx==0) {
			return "redirect:index";
		}
		ses.setAttribute("pidx", pidx);
		ItemVO Item=this.shopService.selectByPidx(pidx);
		m.addAttribute("Items",Item);
		return "itemDetail";
	}//------------------------------------------
	

	
}
