package com.wisetree.test;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.model.ItemVO;
import com.shop.model.OptionVO;
import com.shop.model.downList;
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
		List<ItemVO> list = adminService.itemList();
		log.info(list.size());
		m.addAttribute("list", list);
		return "/admin/list";
	}

	@PostMapping("/list") // 상품 목록
	public String itemFrame(Model m) {

		return "";
	}

	@GetMapping("/register")
	public List<OptionVO> getUpOption(Model m) {
		List<OptionVO> uplist = adminService.getUpOption();
		log.info("uplist==" + uplist);
		m.addAttribute("uplist", uplist);
		return uplist;
	}

	@GetMapping(value = "/getDownOption", produces = "application/json")
	@ResponseBody
	public List<OptionVO> getDownOption(@RequestParam("up_Code") Integer up_Code, Model m) {
		log.info("up_Code==" + up_Code);
		List<OptionVO> downList = adminService.getDownOption(up_Code);
		m.addAttribute("downList", downList);
		return downList;
	}
	
	@ModelAttribute("getDownOption")
	public List<downList>getDownOption(){
		List<downList>getDownOption=new ArrayList<>();
		getDownOption.add(new downList(1, "다이어리/플래너"));
		getDownOption.add(new downList(1, "캘린더"));
		getDownOption.add(new downList(2, "가방"));
		return getDownOption;
	}
	

	@PostMapping("/register") // 상품 등록
	public String register(@ModelAttribute ItemVO Item, BindingResult b) {
		b.getFieldError();
		System.out.println("asdasdadasdassda");
		log.info("register: " + Item);
		int n = adminService.register(Item);
		log.info("n(((((((((((((((((((((((((((((((((((" + n);
		// rttr.addFlashAttribute("result", item.getPidx());//상품번호로 같이 전달
		return "admin/list";// response.sendredirect
	}

}
