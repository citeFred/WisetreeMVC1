package com.wisetree.test;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/upload/file1")
public class UploadController {
	
	@Value("${file.dir}")
	private String fileDir;
	
	@GetMapping("/addfile")
	public String newFile() {
		return "admin/register";
	}
	
	@PostMapping("/addfile")
	public String saveFile(HttpServletRequest req) throws ServletException,IOException{
		log.info("req=="+req);
		
		String upFile=req.getParameter("file1");
		log.info("올라온 파일=" + upFile);
		
		Collection<Part> parts=req.getParts();
		log.info("parts=="+parts);
		
		for(Part p:parts) {
			log.info("===");
			log.info("submittedFilename=="+p.getSubmittedFileName());
		
		//파일 저장하기 
		if(StringUtils.hasText(p.getSubmittedFileName())){
			 String savePath=fileDir+p.getSubmittedFileName();
			 log.info("파일저장 경로="+savePath);
			 p.write(savePath);
		}
		}
		return "admin/register";
		
	}
	

}
