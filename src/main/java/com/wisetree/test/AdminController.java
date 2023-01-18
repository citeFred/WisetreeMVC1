package com.wisetree.test;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Collection;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StreamUtils;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.model.ItemVO;
import com.shop.model.OptionVO;
import com.shop.service.AdminService;
import com.shop.service.ShopService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/adminpage")
@PropertySource("classpath:config/props/filed.properties")
@Slf4j
public class AdminController {
	
	@Value("${file.dir}")
	private String fileDir;
	
	@Inject
	private AdminService adminService;
	
	@Inject
	private ShopService shopService;
	
	
	@GetMapping("remove")
	public String remove(@RequestParam("itemNo")int itemNo, RedirectAttributes rttr) {
		int result=shopService.removeByitemNo(itemNo);	
		rttr.addFlashAttribute("delete_result",result);
		return "redirect:/prodList";
	}
	
	@GetMapping("edit")
	public String editForm(@RequestParam("itemNo")int itemNo,Model m) {
		ItemVO itemvo=shopService.selectByitemNum(itemNo);
		List<OptionVO> upoption=adminService.getUpOption();
		m.addAttribute("upoption",upoption);
		m.addAttribute("itemvo",itemvo);
		
		return "adminpage/prodEdit";
	}
	
	@PostMapping("prodEdit")
	public String edit(Model m, HttpServletRequest req,@RequestParam("mitemImage1") List<MultipartFile> itemImage1,
			@ModelAttribute("item") ItemVO item) {
		log.info("prod edit===="+item);
		
		ServletContext app=req.getServletContext();
		String upFile=app.getRealPath("/resources/product_images");
		File d=new File(upFile);
		if(!d.exists()) d.mkdirs();
		int i=0;
		try {
			for(MultipartFile mf:itemImage1) {
				String tempname=new String(mf.getOriginalFilename().getBytes("8859_1"),"UTF-8");
				mf.transferTo(new File(upFile, tempname));
				if(i==0) {
					item.setItemImage1(tempname);
					}else if(i==1) {
						item.setItemImage2(tempname);
					}else if(i==2) {
						item.setItemImage3(tempname);
					}
				i++;
			}
			}catch(Exception e) {
				log.error("파일 업로드 에러: "+e);
			}
		
		int n=shopService.modifyItem(item);
		String str = (n > 0) ? "수정 성공" : "수정 실패";
		String loc = (n > 0) ? "../prodList" : "javascript:history.back()";

		m.addAttribute("message", str);
		m.addAttribute("loc", loc);
		return "msg";
	}

	@GetMapping("/prodForm")
	public String newFile(Model model) {
		List<OptionVO> upoption=adminService.getUpOption();
		model.addAttribute("upoption",upoption);
		
		return "adminpage/prodForm";
	}
	
	@GetMapping("getDownOption")
	@ResponseBody
	public List<OptionVO> getDownOption(Integer up_Code){
		List<OptionVO> downoption=adminService.getDownOption(up_Code);
		return downoption;
	}
	
	@PostMapping("/prodForm")//상품 등록 
	public String saveFileProduct(HttpServletRequest req, @RequestParam("mitemImage1") List<MultipartFile> itemImage1, @ModelAttribute ItemVO Item) {
		
		ServletContext app=req.getServletContext();
		String upFile=app.getRealPath("/resources/product_images");
		File d=new File(upFile);
		if(!d.exists()) d.mkdirs();
		int i=0;
		try {
		for(MultipartFile mf:itemImage1) {
			String tempname=new String(mf.getOriginalFilename().getBytes("8859_1"),"UTF-8");
			mf.transferTo(new File(upFile, tempname));
			if(i==0) {
				Item.setItemImage1(tempname);
				}else if(i==1) {
					Item.setItemImage2(tempname);
				}else if(i==2) {
					Item.setItemImage3(tempname);
				}
			i++;
		}
		}catch(Exception e) {
			log.error("파일 업로드 에러: "+e);
		}
		int n = adminService.register(Item);
		log.info("n((((((((((((((((((((((((((((((((((("+n);
		
		
		return "adminpage/prodForm";
	}
	
	
	
	public String saveFile(HttpServletRequest req,@ModelAttribute ItemVO Item,BindingResult b) throws ServletException,IOException
	{	
		ServletContext app=req.getServletContext();
		b.getFieldError();
		System.out.println("asdasdadasdassda");
		log.info("Item==",Item);


		log.info("req==",req);
		
		String upFile=req.getParameter("file1");
		log.info(upFile);
		
		Collection<Part> parts=req.getParts();
		log.info("parts=",parts);
		int i=0;
		for(Part p:parts) {
			log.info("===");
			//log.info("name={}",p.getName());
			
			
			Collection<String> headerNames=p.getHeaderNames();
			for(String headerName:headerNames) {
				log.info(headerName,p.getHeader(headerName));
			}
			//편의 메서드 
			//content-disposition, filename
			
			//데이터 읽기
			InputStream inputstream=p.getInputStream();
			String body=StreamUtils.copyToString(inputstream, StandardCharsets.UTF_8);
			log.info("body={}",body);
			
			//파일 저장하기 
			if(StringUtils.hasText(p.getSubmittedFileName())){
				 String savePath=app.getRealPath(fileDir)+p.getSubmittedFileName();
				 log.info("저장경로={}",savePath);
				 
				 String tempname=p.getSubmittedFileName();
					log.info("파일명={}",p.getSubmittedFileName());
					log.info("size",p.getSize());
					if(i==0) {
						Item.setItemImage1(tempname);
						}else if(i==1) {
							Item.setItemImage2(tempname);
						}else if(i==2) {
							Item.setItemImage3(tempname);
						}
					i++;
				 
				 p.write(savePath);
			}
		}
		
		int n = adminService.register(Item);
		log.info("n((((((((((((((((((((((((((((((((((("+n);
		
		
		return "adminpage/prodForm";
	}
	
	
	
}
