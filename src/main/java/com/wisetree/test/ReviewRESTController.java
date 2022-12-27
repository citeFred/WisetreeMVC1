package com.wisetree.test;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
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

/*  HTTP메서드          URI                설명
 *  GET                /prdreviews           모든 리뷰를 조회한다
 *  GET                /prdreviews/create    리뷰를 생성하기 위한 Form
 *  POST               /prdreviews/cre       리뷰를 생성한다
 *  GET                /prdreviews/{renum}       id에 해당하는 리뷰를 조회한다
 *  GET                /prdreviews/{renum}/edit  id에 해당하는 리뷰를 수정하기 위한 Form
 *  PUT                /prdreviews/{renum}     id에 해당하는 리뷰를 수정한다
 *  DELETE             /prdreviews/{renum}     id에 해당하는 리뷰를 삭제한다
 * */

@RestController
@Log4j
public class ReviewRESTController {
	
	@Inject
	private ReviewService reviewService;
	
	//리뷰 리스트
	@GetMapping(value = "/prdreviews", produces = "application/json")
	public List<ReviewVO> revList(HttpSession sion){
		Integer pidx=(Integer)sion.getAttribute("pidx");
		System.out.println("rrrrrrrr");
		log.info("pidx =>"+pidx);
		
		List<ReviewVO> rearr=this.reviewService.listReview(pidx);
		return rearr;
	}
	
	//리뷰 갯수
	@GetMapping(value = "/prdreviewCnt", produces = "application/json") 
	public ModelMap getrevCount(HttpSession sion) {
		Integer pidx=(Integer) sion.getAttribute("pidx");
		int cnt=this.reviewService.getReviewCnt(pidx);
		System.out.println("cccccccccc");
		log.info("cnt=>"+cnt);
		ModelMap remap=new ModelMap();
		remap.put("cnt", cnt);
		return remap;
	}

	//리뷰 글 작성
	@PostMapping(value = "/user/prdreviews",  produces = "application/xml")
	public ModelMap revInsert(@RequestParam(value = "refilename", required = false) MultipartFile mtif,
								@ModelAttribute("revo") ReviewVO revo, HttpSession sion) {
		System.out.println("vvvvvvvvvvv");
		log.info("revo=>"+revo);
		
		//업로드 절대경로
		ServletContext ser=sion.getServletContext();
		String FDir=ser.getRealPath("/resources/review_images");
		
		System.out.println("fffffffffffff");
		log.info("FDir=>"+FDir);
		
		//디렉토리 생성
		File Dir=new File(FDir);
		if (!Dir.exists()) {
			Dir.mkdirs();
			
		}
		// 업로드 처리
		try {
			mtif.transferTo(new File(FDir, mtif.getOriginalFilename()));
			revo.setRefilename(mtif.getOriginalFilename());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int re=this.reviewService.addReview(revo);
		ModelMap momap = new ModelMap();
		momap.addAttribute("result", re);
		return momap;
		
	}
	
	//특정 리뷰 조회
	@GetMapping(value = "/prdreviews/{renum}", produces = "application/json")
	public ReviewVO revGet(@PathVariable("renum") int renum) {
		System.out.println("getgetgetget");
		ReviewVO revo=this.reviewService.getReview(renum);
		return revo;
	}
	
	
	//리뷰 삭제
	@DeleteMapping(value = "/user/prdreviews/{renum}", produces = "application/json")
	public ModelMap revDelete(@PathVariable("renum") int renum) {
		System.out.println("dddddddddddddddd");
		log.info("del renum ===="+renum);
		int deln=this.reviewService.delReview(renum);
		ModelMap delmap= new ModelMap();
		delmap.addAttribute("result", deln);
		return delmap;
	}
	
	//리뷰 수정 
	@PutMapping(value = "/user/prdreviews/{renum}", produces = "application/json")
	public ModelMap revUpdate(
			@PathVariable("renum") int renum,
			@RequestBody ReviewVO revo) {
		System.out.println("upupupupup");
		log.info("Upd revo===="+revo);
		
		int Updn=this.reviewService.upReview(revo);
		
		ModelMap upmap=new ModelMap();
		upmap.put("result", Updn);
		return upmap;
		
	}
}
