package com.wisetree.test;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.model.ItemVO;
import com.shop.service.ShopService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ProductController {

	@Inject
	private ShopService shopService;
	
	@GetMapping("/prodList")
	public String list(Model m) {
		log.info("list");
		List<ItemVO> list=shopService.itemList();
		log.info("size"+list);
		m.addAttribute("list",list);
		return "prodList";
	}
	
	
	@GetMapping("/prodDetail2")
	public String prodDetail(Model m, @RequestParam(defaultValue="0") int itemNo, HttpSession ses) {
		if(itemNo==0) {
			return "redirect:index";
		}
		
		ses.setAttribute("itemNo", itemNo);
		ItemVO Item=this.shopService.selectByitemNum(itemNo);
		m.addAttribute("prod",Item);
		return "prodDetail2";
	}
	
	@GetMapping("/prodPspec")
	public String productByPspec(Model m, @RequestParam(name="quality", defaultValue="HIT")String quality) {
		log.info("quality==="+quality);
		
		List<ItemVO> itemList=shopService.selectByPspec(quality);
		log.info("itemList==="+itemList);
		m.addAttribute("itemList",itemList);
		
		return "admin/mallHit";
	}
 
}
