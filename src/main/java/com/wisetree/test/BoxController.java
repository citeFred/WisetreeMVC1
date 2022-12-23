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

import com.shop.model.BoxVO;
import com.shop.model.MemberVO;
import com.shop.service.ShopService;



@Controller
@RequestMapping("/cart")
public class BoxController {
	
	@Inject
	ShopService shopService;
	
	@PostMapping("/add")
	public String addBox(
			Model m, HttpSession ses,
			@RequestParam(defaultValue="0") int pidx,
			@RequestParam(defaultValue="0") int count)
	{
		if(pidx==0||count==0)
		{
			return "redirect:../index";
		}
		
		MemberVO mlogin=(MemberVO)ses.getAttribute("mlogin");
		int midx_fk=mlogin.getIdx();
		
		BoxVO Box= new BoxVO();
		Box.setPnum_fk(pidx);
		Box.setCount(count);
		Box.setUnum_fk(midx_fk);
		
		int n=this.shopService.addBox(Box);
		
	return "redirect:itemList";
	}
	
	@GetMapping("/list")
	public String boxList(Model m, HttpSession ses)
	{
		MemberVO mlogin=(MemberVO)ses.getAttribute("mlogin");
		int midx_fk=mlogin.getIdx();
		
		List<BoxVO> boxArr=this.shopService.selectBoxlist(midx_fk);
		BoxVO Box=this.shopService.getTotalBoxfee(midx_fk);
		
		m.addAttribute("boxArr",boxArr);
		m.addAttribute("totalbfee",Box);
		
		return "itemList";
	}
	
	
	@PostMapping("/delete")
	public String Boxcancel(@RequestParam(defaultValue="0") int boxNum)
	{
		if(boxNum==0)
		{
			return "redirect:itemList";
		}
		int n=shopService.delBox(boxNum);
		return "redirect:itemList:";
	}//-----------------------------------------
	
	@PostMapping("/edit")
	public String BoxEdit(@ModelAttribute("Box") BoxVO Box)
	{
		shopService.editBox(Box);
		return "redirect:itemList";
	}//-----------------------------------
	

}////////////////////////
