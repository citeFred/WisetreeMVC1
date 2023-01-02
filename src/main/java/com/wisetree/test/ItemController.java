package com.wisetree.test;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.model.ItemVO;
import com.shop.service.ShopService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ItemController {
	
	@Inject
	private ShopService shopService;
	
	@GetMapping("/prodPspec")
	public String productByPspec(Model m, @RequestParam(name="pspec", defaultValue="HIT")String pspec) {
		log.info("pspec==="+pspec);
		
		List<ItemVO> itemList=shopService.selectByPspec(pspec);
		log.info("itemList==="+itemList);
		m.addAttribute("itemList",itemList);
		
		return "admin/mallHit";
	}

	@GetMapping("admin/prodDetail2")
	public String prodDetai(Model m, @RequestParam(defaultValue="0") int itemNo, HttpSession ses) {
		if(itemNo==0) {
			return "redirect:index";
		}
		log.info("))))))))))))))))))");
		ses.setAttribute("itemNo", itemNo);
		ItemVO Item=this.shopService.selectByitemNum(itemNo);
		m.addAttribute("prod",Item);
		return "admin/prodDetail2";
	}
}
