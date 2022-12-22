package com.wisetree.test;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.user.model.UserVO;
import com.user.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UserController {

	@Resource(name = "userServiceImpl")
	private UserService userService;

	//회원가입 폼 보여주는 메서드
	@GetMapping("/join")
	public String joinForm() {
		// "/WEB-INF/views/member/join.jsp
		return "/member/join";
	}
	
	@PostMapping("/join")
	public String userInsert(Model m, @ModelAttribute("user") UserVO user) {
		int n=userService.createUser(user);
		
		String str=(n>0)?"회원 가입 성공":"회원 가입 실패";
		String loc=(n>0)?"index":"javascript:history.back()";
		
		m.addAttribute("message", str);
		m.addAttribute("loc", loc);
		
		//WEB-INF/views/msg.jsp로 Model 전달
		return "msg";
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
}
