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
	
	
//-----CREATE START----------------------------------------------------------------------------------------------------
	
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
//-----CREATE END----------------------------------------------------------------------------------------------------
	
	
	
//-----READ START-------------------------------------------------------------------------------------------------
	
	
	//회원 목록 보여주는 메서드 [READ]
	@GetMapping("/admin/userList")
	public String userList(Model m) {
		List<UserVO> userArr=userService.listUser(null);
		
		m.addAttribute("userArr", userArr);
		return "/member/list";
	}
//-----READ END-------------------------------------------------------------------------------------------------
	
//-----UPDATE START----------------------------------------------------------------------------------------------------
	
	
	
	//회정 정보 수정 폼 보여주는 메서드 UPDATE-직전 FORM VIEW PAGE 보여줌
	@PostMapping("/admin/userEdit")
	public String userEdit(Model m, @RequestParam(defaultValue="0") int idx) {
		//1. idx(회원번호) 에 대한 유효성 체크(없으면 userList redirect이동)
		if(idx==0) {
			return "redirect:userList"; //redirect 시키는
		}
		//2. 회원번호로 회원 정보 내용 가져오기
		//   없으면 "없는 입니다"
		UserVO user=this.userService.selectUserByIdx(idx);
		
		m.addAttribute("user", user);
		return "/member/edit";
	}
	
	//회원 정보 수정 포스트 요청(실제 기능 구현부분)
	@PostMapping("/admin/edit")
	public String userEditEnd(Model m, @ModelAttribute("user") UserVO user) {
		log.info("user edit===="+user);
		int n = this.userService.updateUser(user);
		String str = (n > 0) ? "수정 성공" : "수정 실패";
		String loc = (n > 0) ? "userList" : "javascript:history.back()";

		m.addAttribute("message", str);
		m.addAttribute("loc", loc);
		return "msg";
		// /WEB-INF/views/msg.jsp 를 찾아가게 된다.
	}
//-----UPDATE END----------------------------------------------------------------------------------------------------
	
	
	
	
//-----DELETE START----------------------------------------------------------------------------------------------------
	
	//회원 삭제하는 메서드 [DELETE]
	@PostMapping("/admin/userDel")
	public String userDelete(@RequestParam(defaultValue="0") int idx) {
		int n=userService.deleteUser(idx);
		return "redirect:userList";
	}
	
//-----DELETE END----------------------------------------------------------------------------------------------------

}
