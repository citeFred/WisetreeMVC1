package com.wisetree.test;


import java.io.File;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.review.model.ReviewVO;
import com.review.service.ReviewService;
import com.shop.model.MemberVO;

import lombok.extern.log4j.Log4j;

/*  ----------RESTful API방식----------------------------
 *   - URI + 메서드 방식에 따라 처리 로직을 달리한다.
 *  /reviews/           GET  : 리뷰 목록을 조회
 *  /reviews/{num}      GET  : 특정(num번) 리뷰글을 조회
 *  /user/reviews       POST  : 리뷰 글쓰기 처리
 *  /user/reviews/{num} PUT   : 특정 리뷰글을 수정
 *  /user/reviews/{num} DELETE: 특정 리뷰글을 삭제
 *  
 *  --------------------------------------------------*/

/*  ----------------------------------------------------
 *  POST	POST를 통해 해당 URI를 요청하면 리소스를 생성합니다.
 *  GET		GET를 통해 해당 리소스를 조회합니다. 
 *  		리소스를 조회하고 해당 도큐먼트에 대한 자세한 정보를 가져온다.
 *  PUT		PUT를 통해 해당 리소스를 수정합니다.
 * 	DELETE	DELETE를 통해 리소스를 삭제합니다.
 *  ----------------------------------------------------*/

/*  HTTP메서드          URI                			설명
 *  GET                /prdreviews           		모든 리뷰를 조회한다
 *  POST               /prdreviews/user      		리뷰를 생성한다
 *  
 *  GET                /prdreviews/user/{renum}     id에 해당하는 리뷰를 조회한다
 *  PUT                /prdreviews/user/{renum}     id에 해당하는 리뷰를 수정한다
 *  DELETE             /prdreviews/user/{renum}     id에 해당하는 리뷰를 삭제한다
 * */

@RestController
@RequestMapping("/prdreviews")
@Log4j
public class ReviewRESTController {

	@Inject
	private ReviewService reviewService;
	
	/**
	 * 리뷰 글 작성
	 * */
	//@ResponseBody
	@PostMapping(value = "/user", produces = "application/json; charset=UTF-8" )
	public ModelMap revInsert(
			@RequestParam(value = "reviewFile", required = false) MultipartFile mtif,
			@ModelAttribute("revo") ReviewVO revo,
			/* @RequestBody */
			HttpSession sion,
			HttpServletResponse response) {
		response.setContentType("application/json");
		log.info("mtif : +++++"+mtif);
		log.info("rvo.mtif : +++++"+revo.getRefilename());
        log.info(response);
		log.info("revo=>" + revo);

		// 업로드 절대경로
		ServletContext ser = sion.getServletContext();
		String upDir = ser.getRealPath("/resources/review_images");
		log.info("upDir=>" + upDir);

		// 디렉토리 생성
		File fdir = new File(upDir);
		if (!fdir.exists()) {
			fdir.mkdirs();
		}
		log.info("fdir=>" + fdir);
		
		// 업로드 처리 ------->>>이부분부터 오류 해결
		try {
			mtif.transferTo(new File(upDir, mtif.getOriginalFilename()));
			revo.setRefilename(upDir);
			revo.setRefilename(mtif.getOriginalFilename());
		} catch (Exception e) {
			e.getMessage();
			//log.info("파일업로드에서 실패====>"+e);
		}
		int re = this.reviewService.addReview(revo);
		log.info("reNum%%%%%%%%%%%%%%%%%%%%%%%%"+re);
		ModelMap momap = new ModelMap();
		momap.addAttribute("result", re);
		return momap;

	}

	/**
	 * 리뷰 리스트 조회
	 * */
	@GetMapping(value = "", produces = "application/json")
	public List<ReviewVO> revList(HttpSession sion) {
		
		
		/*
		 * int itemNo = 6; sion.setAttribute("itemNo", itemNo);
		 * sion.setMaxInactiveInterval(-1);
		 */
		 
		
		Integer itemNo1 = (Integer) sion.getAttribute("itemNo");
		log.info("itemno =>" + itemNo1);
		List<ReviewVO> rearr = this.reviewService.listReview(itemNo1);
		return rearr;
	}

	/**
	 * 리뷰 갯수 카운팅
	 * */
	@GetMapping(value = "/cnt", produces = "application/json")
	public ModelMap getrevCount(HttpSession sion) {
		Integer itemNo = (Integer) sion.getAttribute("itemNo");
		int cnt = this.reviewService.getReviewCnt(itemNo);
		//System.out.println("cccccccccc");
		log.info("cnt=>" + cnt);
		
		ModelMap remap = new ModelMap();
		remap.put("cnt", cnt);
		return remap;
	}

	/**
	 * 특정 리뷰 조회
	 * */
	@GetMapping(value = "/user/{renum}", produces = "application/json")
	public ReviewVO revGet(@PathVariable("renum") int renum) {
		System.out.println("getgetgetget");
		log.info("renum=>"+renum);
		ReviewVO revo1 = this.reviewService.getReview(renum);
		
		log.info("revo=>"+revo1);
		return revo1;
	}
	
	/**
	 * 리뷰 글 수정
	 * */
	// user/{renum} --> GET
	// user/{renum} --> PUT
	// user/{renum} --> DELETE
	@PutMapping(value = "/user/{renum}", produces = "application/json")
	public ModelMap revUpdate(
			@PathVariable("renum") int renum, 
			@RequestBody ReviewVO revo1) {
		System.out.println("putputput");
		log.info("PUT revo1===="+revo1);
		log.info("PUT renum===="+renum);

		int Updn = this.reviewService.upReview(revo1);
		ModelMap upmap = new ModelMap();
		//upmap.addAttribute("result",  Updn);
		upmap.put("result", Updn);
		return upmap;

	}
	
	
	/**
	 * 리뷰 삭제
	 * */
	@DeleteMapping(value = "/user/{renum}", produces = "application/json")
	public ModelMap revDelete(@PathVariable("renum") int renum) {
		//System.out.println("dddddddddddddddd");
		log.info("del renum ====" + renum);
		int deln = this.reviewService.delReview(renum);
		ModelMap delmap = new ModelMap();
		delmap.addAttribute("result", deln);
		return delmap;
	}

}
