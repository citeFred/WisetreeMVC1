package com.wisetree.test;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
//import org.springframework.core.io.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.log4j.Log4j;
@Controller
@Log4j
public class FileController {
	
	@Resource(name="upDir")
	private String upDir;
	
	@GetMapping("/fileForm")
	public String fileForm() {
		return "file/fileForm";
	}
	//[1] MultipartFile을 이용하는 방법
	@PostMapping("/fileUp")
	public String fileUpload(Model m,@RequestParam("name") String name, @RequestParam("mfilename")MultipartFile mfilename) {
		log.info("upDir: "+upDir+", name: "+name+", mfilename: "+mfilename);
		//1. 첨부파일명, 파일 크기 얻어와서 Model에 저장
		if(!mfilename.isEmpty()) {
			String filename=mfilename.getOriginalFilename();//첨부파일명
			long filesize=mfilename.getSize();
			
			//2. 파일 업로드 처리 -> transferTo()메서드 이용
			try {
				mfilename.transferTo(new File(upDir, filename));			
			} catch (IOException e) {
				log.info("파일 업로드 실패: "+e);
				log.error(e);
			}
			
			m.addAttribute("fname", filename);
			m.addAttribute("fsize", filesize);			
		}//if------------
		m.addAttribute("name", name);
		return "file/fileResult";
	}//------------------------------------
	
	//[2] MulitipartHttpServletRequest를 이용하는 방법
	//==> 이 경우는 동일한 파라미터명으로 여러 개의 파일을 업로드하는 경우에 유용하다.
	@PostMapping("/fileUp2")
	public String fileUpload2(Model m, HttpServletRequest req) {
		//1. 올린이 파라미터값 받기
		String name=req.getParameter("name");
		//2. MultipartHttpServletRequest유형으로 형변환
		MultipartHttpServletRequest  mr=(MultipartHttpServletRequest)req;
		//3. 첨부파일 목록 얻기
		List<MultipartFile> mflist=mr.getFiles("mfilename");
		m.addAttribute("name",name);
		if(mflist!=null) {
			for(int i=0;i<mflist.size();i++) {
				MultipartFile mf=mflist.get(i);
				//1.파라미터명: mfilename
				String paramName=mf.getName();
				//2. 첨부파일명
				String fname=mf.getOriginalFilename();
				//3. 파일 크기
				long fsize=mf.getSize();
				//4. 파일 업로드 처리
				m.addAttribute(paramName+(i+1), fname);
				m.addAttribute("fsize"+(i+1), fsize);
				
				try {
					mf.transferTo(new File(upDir, fname));
				}catch(IOException e) {
					log.error(e);
				}
			}//-----------------
		}
		m.addAttribute("name",name);
		return "file/fileResult2";
	}
	
	/* ResponseEntity
	 * 데이터와 함께 헤더 상태 메세지를 전달하고자 할 때 사용
	 * Http Header를 다뤄야할 경우 ResponseEntity를 통해 헤어정보나 데이터 전달 가능
	 * HttpEntity를 상속받아 구현한 클래스
	 * RequestEntity : 요청 헤더정보 + 요청 데이터
	 * ResponseEntity(HttpSatus, HttpHeaders, HttpBody를 포함) : 응답 헤더정보 + 응답 데이터
	 * 
	 * 브라우저는 컨텐트타입이 보여줄 수 있는 형식이면 브라우저에 보여주고,
	 * 잘 모르는 컨텐트타입이거나 보여줄 수 있는 형식이 아니면 다운로드 창을 띄움
	*/
	@PostMapping(value="/fileDown", produces="application/octet-stream")
	@ResponseBody
	public ResponseEntity<org.springframework.core.io.Resource> fileDownload(
			HttpServletRequest req,
			@RequestHeader("User-Agent") String userAgent,
			@RequestParam("fname") String fname,
			@RequestParam("origin_fname") String origin_fname) {
//		log.info("fname == " + fname);
//		log.info("origin_fname == " + origin_fname);
		
		//1. 업르도된 디렉토리 절대경로 얻기
		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("/resources/free_board_upload");
		String filePath = upDir + File.separator+fname;
		log.info("filePath == " + filePath);
		
		org.springframework.core.io.Resource resource = new FileSystemResource(filePath);
//		/FileSystemResource 가 알아서 파일과 스트림 연결
		if(!resource.exists()) {
			//no file
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		} 

		//2. 브라우저별 인코딩 처리
		String downName = null;
		boolean checkIE=(userAgent.indexOf("MSIE")>-1 || userAgent.indexOf("Trident")>-1);
		try {
			if(checkIE)	{
				//IE의 경우
				downName = URLEncoder.encode(origin_fname, "UTF-8").replaceAll("\\+", " ");
			} else {
				//그 외 브라우저의 경우
				downName = new String(origin_fname.getBytes("UTF-8"), "ISO-8859-1");
			}
		} catch(UnsupportedEncodingException e) {
			log.error("파일 다운로드 중 에러 : " + e);
		}
		
		org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename=" + downName);
		
		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping(value="/fileDown_notice", produces="application/octet-stream")
	@ResponseBody
	public ResponseEntity<org.springframework.core.io.Resource> fileDownload2(
			HttpServletRequest req,
			@RequestHeader("User-Agent") String userAgent,
			@RequestParam("fname") String fname,
			@RequestParam("origin_fname") String origin_fname) {
//		log.info("fname == " + fname);
//		log.info("origin_fname == " + origin_fname);
		
		//1. 업르도된 디렉토리 절대경로 얻기
		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("/resources/notice_board_upload");
		String filePath = upDir + File.separator+fname;
		log.info("filePath == " + filePath);
		
		org.springframework.core.io.Resource resource = new FileSystemResource(filePath);
//		/FileSystemResource 가 알아서 파일과 스트림 연결
		if(!resource.exists()) {
			//no file
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		} 

		//2. 브라우저별 인코딩 처리
		String downName = null;
		boolean checkIE=(userAgent.indexOf("MSIE")>-1 || userAgent.indexOf("Trident")>-1);
		try {
			if(checkIE)	{
				//IE의 경우
				downName = URLEncoder.encode(origin_fname, "UTF-8").replaceAll("\\+", " ");
			} else {
				//그 외 브라우저의 경우
				downName = new String(origin_fname.getBytes("UTF-8"), "ISO-8859-1");
			}
		} catch(UnsupportedEncodingException e) {
			log.error("파일 다운로드 중 에러 : " + e);
		}
		
		org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename=" + downName);
		
		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}
	
	

}
