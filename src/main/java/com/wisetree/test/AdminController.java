package com.wisetree.test;



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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.shop.model.ItemVO;
import com.shop.model.OptionVO;
import com.shop.service.AdminService;

import lombok.extern.slf4j.Slf4j;
import oracle.ucp.common.FailoverStats.Item;

@Controller
@RequestMapping("/admin")
@PropertySource("classpath:config/props/filed.properties")
@Slf4j
public class AdminController {
	
	@Value("${file.dir}")
	private String fileDir;
	
	@Inject
	private AdminService adminService;
	
	@GetMapping("/prodList")
	public String list(Model m) {
		log.info("list");
		List<ItemVO> list=adminService.itemList();
		log.info("size"+list);
		m.addAttribute("list",list);
		return "admin/prodList";
	}


	@GetMapping("/prodForm")
	public String newFile(Model model) {
		List<OptionVO> upoption=adminService.getUpOption();
		model.addAttribute("upoption",upoption);
		
		return "admin/prodForm";
	}
	
	@GetMapping("/getDownOption")
	@ResponseBody
	public List<OptionVO> getDownOption(Integer up_Code){
		List<OptionVO> downoption=adminService.getDownOption(up_Code);
		return downoption;
	}
	
	@PostMapping("/prodForm")//상품 등록 
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
		
		
		return "admin/prodForm";
	}
	
	
	
}
