package com.wisetree.test;


import java.io.File;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.review.model.ReviewVO;
import com.review.service.ReviewService;

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
			HttpSession sion,
			HttpServletResponse response) {
		response.setContentType("application/json");
		log.info("mtif : +++++"+mtif);
		log.info("revo : +++++"+revo);
		//log.info("rvo.mtif : +++++"+revo.getRefilename());
        log.info("response : +++++"+response);

		// 업로드 절대경로
		ServletContext ser = sion.getServletContext();
		String upDir = ser.getRealPath("/resources/review_images");
		//log.info("upDir=>" + upDir);

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
		/*
		 * if(revo.getContent()==null|| revo.getItemno_fk()==0 ||revo.getScore()==0 ||
		 * revo.getUserid()==null|| revo.getContent().trim().isEmpty()||
		 * revo.getUserid().trim().isEmpty()) { return ""; }
		 */
		
		//log.info("reNum : +++++"+re);
		ModelMap momap = new ModelMap();
		momap.addAttribute("result", re);
		//log.info("momap : +++++"+momap);
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
		log.info("List =>" + rearr.get(0));//리뷰vo안에있는 정보들
		return rearr;
	}

	/**
	 * 상품번호에 따른 리뷰 갯수 카운팅
	 * 상품번호에 따른 리뷰 평균값 
	 * */
	@GetMapping(value = "/cnt", produces = "application/json")
	public ModelMap getrevCount(HttpSession sion) {
		Integer itemNo = (Integer) sion.getAttribute("itemNo");
		int cnt = this.reviewService.getReviewCnt(itemNo);
		int avg = this.reviewService.getReviewavg(itemNo);
		//System.out.println("cccccccccc");
		//log.info("cnt=>" + cnt);
		//log.info("avg=>" + avg);
		
		ModelMap remap = new ModelMap();
		remap.put("cnt", cnt);
		remap.put("avg", avg);
		log.info("remap=>" + remap);
		return remap;
	}
	
	/*
	 * @GetMapping(value = "/avg", produces = "application/json") public ModelMap
	 * getstrAvg(HttpSession sion) { Integer itemNo = (Integer)
	 * sion.getAttribute("itemNo"); int avg =
	 * this.reviewService.getReviewavg(itemNo); //System.out.println("cccccccccc");
	 * log.info("avg=>" + avg);
	 * 
	 * ModelMap reavg = new ModelMap(); reavg.put("avg", avg); return reavg; }
	 */
	
	

	/**
	 * 리뷰 수정(편집) 페이지 매핑
	 * */
	@GetMapping(value = "/user/{renum}", produces = "application/json")
	public ReviewVO revGet(@PathVariable("renum") int renum) {
		/*
		 * if(renum==0) { return "redirect:prodList"; }
		 */
		ReviewVO revo1 = this.reviewService.getReview(renum);
		System.out.println("********************");
		log.info("특정 리뷰 페이징 값 =====>"+revo1);
		System.out.println("********************");
		
		return revo1;
	}
	
	/**
	 * 리뷰 수정(편집) 처리 매핑
	 * */
	// user/{renum} --> GET
	// user/{renum} --> PUT
	// user/{renum} --> DELETE
	@PutMapping(value = "/user/{renum}", produces = "application/json")
	public ModelMap revUpdate(
			@PathVariable("renum") int renum, 
			@RequestBody ReviewVO revo1) {
		System.out.println("********************");
		log.info("PUT revo1===="+revo1);
		log.info("PUT renum===="+renum);
		System.out.println("********************");
		
		int Updn = this.reviewService.upReview(revo1);
		ModelMap upmap = new ModelMap();
		//upmap.addAttribute("result",  Updn);
		upmap.put("result", Updn);
		//log.info("upmap===="+upmap);
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
