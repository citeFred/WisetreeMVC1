package com.wisetree.test;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shop.model.ItemVO;
import com.shop.service.AdminService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin")
@Log4j
public class AdminController {
	
	@Inject
	private AdminService adminService;
	
	@GetMapping("/list")
	public String list(Model m) {
		log.info("list");
		List<ItemVO> list=adminService.itemList();
		log.info(list.size());
		m.addAttribute("list",list);
		return "/admin/list";
	}
	
	@PostMapping("/list")//상품 목록
	public String itemFrame(Model m) 
	{
		return "";
	}

	@GetMapping("/register")
	public String register() {
		
		return "admin/register";
	}
	
	@PostMapping("/register")//상품 등록 
	public String register(@ModelAttribute ItemVO Item,BindingResult b)
	{	
		b.getFieldError();
		System.out.println("asdasdadasdassda");
		log.info("register: "+ Item);
		int n = adminService.register(Item);
		log.info("n((((((((((((((((((((((((((((((((((("+n);
		//rttr.addFlashAttribute("result", item.getPidx());//상품번호로 같이 전달
		return "admin/list";//response.sendredirect
	}
	
}
