package com.wisetree.test;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.user.model.UserVO;
import com.user.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UserController {

	@Resource(name = "userServiceImpl")
	private UserService userService;

	//회원가입 폼 보여주는 메서드 CREATE-직전 FORM VIEW PAGE 보여줌
	@GetMapping("/join")
	public String joinForm() {
		// "/WEB-INF/views/member/join.jsp
		return "/member/join";
	}
	
	//회원가입 실행하는 메서드 [CREATE]
	@PostMapping("/join")
	public String userInsert(Model m, @ModelAttribute("user") UserVO user) {
		int n=userService.createUser(user);
		
		String str=(n>0)?"회원 가입 성공":"회원 가입 실패";
		String loc=(n>0)?"/index":"javascript:history.back()";
		
		m.addAttribute("message", str);
		m.addAttribute("loc", loc);
		
		//WEB-INF/views/msg.jsp로 Model 전달
		return "msg";
	}
	
	
	
	//회원 목록 보여주는 메서드 [READ]
	@GetMapping("/admin/userList")
	public String userList(Model m) {
		List<UserVO> userArr=userService.listUser(null);
		
		m.addAttribute("userArr", userArr);
		return "/member/list";
	}
	
	//회정 정보 수정 폼 보여주는 메서드 UPDATE-직전 FORM VIEW PAGE 보여줌
	@PostMapping("/admin/userEdit")
	public String userEdit(Model m, @RequestParam(defaultValue="0") int idx) {
		//1. idx(회원번호) 에 대한 유효성 체크(없으면 userList redirect이동)
		if(idx==0) {
			return "redirect:userList"; //redirect 시키는
		}
		//2. 회원번호로 회원 정보 내용 가져오기
		//   없으면 "없는 글입니다"
		UserVO user=this.userService.selectUserByIdx(idx);
		
		m.addAttribute("user", user);
		return "/member/edit";
	}
	
	
	
	//회원 삭제하는 메서드 [DELETE]
	@PostMapping("/admin/userDel")
	public String userDelete(@RequestParam(defaultValue="0") int idx) {
		int n=userService.deleteUser(idx);
		return "redirect:userList";
	}
	
	
	
	
	
	
//	@PostMapping("/join")
//	public String joinEnd(Model m, @ModelAttribute("user") UserVO user) {
//		log.info("user====" + user);
//		if(user.getName()==null || user.getUserid()==null || user.getPwd()==null
//		|| user.getName().trim().isEmpty()|| user.getUserid().trim().isEmpty()|| user.getPwd().trim().isEmpty()) {
//			return "redirect:join";
//		}
//		
//		int n=userService.createUser(user);
//		String str=(n>0)?"회원 가입 완료":"가입 실패";
//		String loc=(n>0)?"admin/userList":"javascript:history.back()";
//		
//		m.addAttribute("message", str);
//		m.addAttribute("loc", loc);
//		return "msg";
//	}
//	/*
//	 * 스프링에서 JSON데이터를 생성해야 하는 경우. 
//	 * [1] pom.xml에 Jackson Databind 등이 임포트되야 한다.
//	 * 		<dependency>
//			<groupId>com.fasterxml.jackson.core</groupId>
//			<artifactId>jackson-core</artifactId>
//			<version>2.9.8</version>
//			</dependency>
//			<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.dataformat/jackson-dataformat-yaml -->
//			<dependency>
//				<groupId>com.fasterxml.jackson.dataformat</groupId>
//				<artifactId>jackson-dataformat-yaml</artifactId>
//				<version>2.9.8</version>
//			</dependency>
//			<!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
//			<dependency>
//				<groupId>com.fasterxml.jackson.core</groupId>
//				<artifactId>jackson-databind</artifactId>
//				<version>2.9.8</version>
//			</dependency>
//		 *
//	 * [2] @ResponseBody 를 붙여주고 반환 자료 유형을 Map또는 VO유형으로 하면 위 라이브러리 들이 json형태로 변환된다.
//	 *  
//	 * [3] 매핑된 idcheck .jsp를 찾아가는게 아니라 응답 유형이 json이라면 
//	 * 		@GetMapping에 produces="application/json" 기술하자. */
//	
//	/*아이디 중복체크 ajax처리 -- 별도로 관리해야되는데 적어서 일단 여기서 작성.
//	 * 응답데이터만 바놘 해야 할 때 =>@ResponseBody 기술 */
//	@ResponseBody
//	@GetMapping(value= "/idcheck", produces="application/json")
//	public Map<String, String> idCheck(@RequestParam("userid") String userid){
//		log.info("userid==="+userid);
//		boolean isUse=userService.idCheck(userid);
//		String result=(isUse)?"ok":"no";
//		
//		Map<String, String> map=new HashMap<>();
//		map.put("result", result);
//		
//		return map;
//	}
//	
//	@GetMapping("/admin/userList")
//	public String userList(Model m) {
//		List<UserVO> userArr=userService.listUser(null);
//		
//		m.addAttribute("userArr", userArr);
//		return "/member/list";
//	}
//	
//	@PostMapping("/admin/userDel")
//	public String userDelete(@RequestParam(defaultValue="0") int idx) {
//		log.info("idx===>"+idx);
//		if(idx==0) {
//			return "redirect:userList";
//		}
//		int n=userService.deleteUser(idx);
//		
//		
//		return "redirect:userList";
//	}
//	
//	
	/* 업데이트 관련 참고 코드
	 * [1] 조인폼을 카피해서 수정폼을 생성
	 * 		- 수정 폼에서는 수정안될 부분을 막는다 
	 * 		- 기존데이터를 idx에 따라 가져와서 배치시켜야 한다.
	 * 
	 *
	 * 	@RequestMapping(value="/memoEdit", method=RequestMethod.GET)
	public String memoEditForm(Model model, @RequestParam(defaultValue="0") int idx) {
		if(idx==0) {
			return "redirect:memoList"; //redirect 시키는
		}
		MemoVO memo=memoDao.getMemo(idx);
		
		model.addAttribute("memo", memo);
		return "memo/edit";
	}
	
	 수정 포스트 요청(실제 기능 구현부분)
	
	@RequestMapping(value="/memoEdit", method=RequestMethod.POST)
	public String memoEditEnd(Model model, @ModelAttribute("memo") MemoVO memo) {
		log.info("memo edit===="+memo);
		int n = memoDao.updateMemo(memo);
		String str = (n > 0) ? "수정 성공" : "수정 실패";
		String loc = (n > 0) ? "memoList" : "javascript:history.back()";

		model.addAttribute("message", str);
		model.addAttribute("loc", loc);
		return "msg";
		// /WEB-INF/views/msg.jsp 를 찾아가게 된다.
	}
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 */
	
	
}
